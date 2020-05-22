/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.my.servlet;

import com.my.bean.Product;
import com.my.dao.ProductDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Hashtable;
import java.util.StringTokenizer;
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
public class SearchProductServlet extends HttpServlet {

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
        String cat_id=(String)request.getParameter("category_name");
        System.out.println("cat_id:"+cat_id);
        String key = (String)request.getParameter("searchkey");
        //StringTokenizer keys = new StringTokenizer(key);
        int price_from=Integer.parseInt(request.getParameter("price_from"));
        int price_to=Integer.parseInt(request.getParameter("price_to"));
        ProductDAO productDAO = new ProductDAO();
        ArrayList<Product> products = productDAO.searchAdvanced(cat_id,key,price_from,price_to);
        
        session.setAttribute("foundproducts", products);
        System.out.println("search:"+products.toString());
        RequestDispatcher dispatcher = request.getRequestDispatcher("/search.jsp?page=1");
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
