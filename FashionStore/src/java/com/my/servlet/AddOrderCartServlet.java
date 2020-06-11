/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.my.servlet;

import com.my.bean.Product;
import com.my.bean.ProductOrder;
import com.my.bean.OrderCart;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class AddOrderCartServlet extends HttpServlet {

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
        
        String url = "/ordercart.jsp";
        Product product = (Product)session.getAttribute("product");
        OrderCart cart = (OrderCart)session.getAttribute("ordercart");
        
        if(cart==null||product==null){
            url = "/login.jsp";
        }
        else{
            int quantity = Integer.parseInt((String)request.getParameter("quantity"));
            ProductOrder fo = new ProductOrder(product, quantity);
            int hangcon=Integer.parseInt((String)request.getParameter("hangcon"));
            if(cart.isAddable(fo)&& (quantity<=hangcon)){
                cart.addFoodOrders(fo);
                request.setAttribute("message", "Đã thêm vào giỏ hàng");
                session.setAttribute("customer", cart.getCustomer());
            }
            else{
                request.setAttribute("message", "Bạn không đủ tiền để thực hiện giao dịch này!Xin vui lòng nạp thêm tiền");
                request.setAttribute("error", "Số hàng bạn mua vượt quá số hàng chúng tôi hiện có!");
            }
        
            session.setAttribute("ordercart", cart);
        }
        RequestDispatcher dispatcher = request.getRequestDispatcher(url);
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
