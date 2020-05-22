/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.my.servlet;

import com.my.bean.Category;
import com.my.dao.CategoryDAO;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author vivtory
 */
public class UpdateCategoryServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP
     * <code>GET</code> and
     * <code>POST</code> methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession(true);
        
        String catID = (String)session.getAttribute("catid");
        String catname = (String)request.getParameter("catname");
        String catdes = (String)request.getParameter("catdescribes");
        Category cat = new Category(catID ,catname, catdes);
        CategoryDAO catDAO = new CategoryDAO();
        try {
            if(request.getParameter("btnadd")!=null) {
                if(catDAO.addCategory(cat))
                    request.setAttribute("message", "Đã thêm vào csdl");
                else    request.setAttribute("message", "Thất bại. hãy thử lại");
            }
            if(request.getParameter("btnedit")!=null) {
                if(catDAO.editCategory(cat))
                    request.setAttribute("message", "Update completed");
                else    request.setAttribute("message", "Failed. Try again");
                session.setAttribute("catID", null);
            }
            if(request.getParameter("btncancel")!=null) {
                session.setAttribute("catID", null);
            }
            
        } catch(Exception e){
            e.printStackTrace();
        }
        RequestDispatcher dispatcher = request.getRequestDispatcher("/category.jsp");
        if (dispatcher != null) {
            dispatcher.forward(request, response);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP
     * <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP
     * <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
}
