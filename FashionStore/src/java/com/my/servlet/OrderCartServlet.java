/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.my.servlet;

import com.my.bean.*;
import com.my.dao.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Date;
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
public class OrderCartServlet extends HttpServlet {

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
        
        OrderCart cart = (OrderCart)session.getAttribute("ordercart");
        cart.setShiptime(new Date());
        
        OrderDAO orderDAO = new OrderDAO();
       
        CustomerDAO cusDAO = new CustomerDAO();
        
        if(orderDAO.checkoutOrder(cart)&& cusDAO.payOrder(cart.getCustomer().getId(), cart.getTotalprice())){
            
            cart.removeAllFoodOrder();
            request.setAttribute("message", "Đã thanh toán giỏ hàng");
            session.setAttribute("ordercart", cart);
            session.setAttribute("customer", cart.getCustomer());
        }
        else{
            request.setAttribute("message", "Thất bại, hãy thử lại");
        }
        RequestDispatcher dispatcher = request.getRequestDispatcher("/ordercart.jsp");
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
