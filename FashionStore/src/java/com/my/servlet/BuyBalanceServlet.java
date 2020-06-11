/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.my.servlet;

import com.my.bean.*;
import com.my.bean.User;
import com.my.dao.BalanceSourceDAO;
import com.my.dao.CustomerDAO;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class BuyBalanceServlet extends HttpServlet {

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
        
        String bSource = (String)request.getParameter("source");
        Customer cus = (Customer)session.getAttribute("customer");
        OrderCart cart = (OrderCart)session.getAttribute("ordercart");
        
        BalanceSourceDAO bsDAO = new BalanceSourceDAO();
        CustomerDAO cusDAO = new CustomerDAO();
        
        try {
            int balance = bsDAO.getBalance(bSource);
            if(cusDAO.buyBalance(cus.getId(), balance) && balance>0){
                long newBalance = cusDAO.getBalance(cus.getId());
                bsDAO.disableBalanceSourcce(bSource);
                request.setAttribute("message", "Số dư hiện tại: "+newBalance);
                cus.setBalance(newBalance);
                cart.setCustomer(cus);
                session.setAttribute("customer", cus);
                session.setAttribute("ordercart", cart);
            }
            else{
                request.setAttribute("message", "Thao tác thất bại. hãy thử lại");
            }
        } catch(Exception e){
            request.setAttribute("message", "Thao tác thất bại. hãy thử lại");
            e.printStackTrace();
        }
        RequestDispatcher dispatcher = request.getRequestDispatcher("/buybalance.jsp");
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
