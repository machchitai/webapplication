/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.my.servlet;

import com.my.bean.Product;
import com.my.dao.ProductDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class UpdateProductServlet extends HttpServlet {

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
        
        String productID = (String)session.getAttribute("productid");
        String catID = (String)request.getParameter("catselect");
        String productname = (String)request.getParameter("productname");
        String productdes = (String)request.getParameter("productdes");
        int productprice = Integer.parseInt((String)request.getParameter("productprice"));
        String productimage = (String)request.getParameter("productimage");
        int productQuantity=Integer.parseInt(request.getParameter("prodQuantity"));
        String prodArticle=(String)request.getParameter("prodArticle");
        Product product = new Product( productID,catID, productname, productdes, productprice, productimage,productQuantity,prodArticle);
        ProductDAO productDAO = new ProductDAO();
        try {
            if(request.getParameter("btnadd")!=null) {
                if(productDAO.addFood(product))
                    request.setAttribute("message", "Đã thêm vào csdl");
                else    request.setAttribute("message", "Thất bại. hãy thử lại");
            }
            if(request.getParameter("btnedit")!=null) {
                if(productDAO.editFood(product))
                    request.setAttribute("message", "Update completed");
                else    request.setAttribute("message", "Failed. Try again");
                session.setAttribute("productid", null);
            }
            if(request.getParameter("btncancel")!=null) {
                session.setAttribute("productid", null);
            }
            
        } catch(Exception e){
            e.printStackTrace();
        }
        RequestDispatcher dispatcher = request.getRequestDispatcher("/product.jsp");
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
        
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
            int page = 1;
        int recordsPerPage = 5;
        if(request.getParameter("page") != null)
        {
            page = Integer.parseInt(request.getParameter("page"));
            ProductDAO dao = new ProductDAO();
        List<Product> list = dao.viewAllProduct((page-1)*recordsPerPage,
                                 recordsPerPage);
        int noOfRecords = dao.getNoOfRecords();
        int noOfPages = (int) Math.ceil(noOfRecords * 1.0 / recordsPerPage);
        request.setAttribute("categoryList", list);
        request.setAttribute("noOfPages", noOfPages);
        request.setAttribute("currentPage", page);
        RequestDispatcher view = request.getRequestDispatcher("product.jsp");
        view.forward(request, response);
        }
        } finally {            
            out.close();
        }
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
