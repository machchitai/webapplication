/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.my.servlet;

import com.my.bean.*;
import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.my.dao.CustomerDAO;
import com.my.recaptcha.VerifyUtils;
import java.security.NoSuchAlgorithmException;
import java.util.logging.Level;
import java.util.logging.Logger;

public class LoginServlet extends HttpServlet {

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
            throws ServletException, IOException, NoSuchAlgorithmException {
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession(true);
        if(request.getParameter("reset_password") != null){
            String username = request.getParameter("username");            
            CustomerDAO customer = new CustomerDAO();
            if(customer.checkUsername(username)){                
                if(customer.generateToken(username)){
                    //send email
                    String token = customer.getToken(username);
                    String mail_content = "Dear "+username+","
                            +"\n\nPlease access to the following link to reset your password: "+request.getRequestURL()+"?token_reset="+token;
                    String email = customer.getEmail(username);
                    customer.sendMail(email,mail_content);
                   request.setAttribute("message", "Nếu username bạn nhập là chính xác, một email kèm hướng dẫn khôi phục mật khẩu sẽ được gởi đến địa chỉ email của bạn."); 
                }
            }
            
            RequestDispatcher rd = request.getRequestDispatcher("/login.jsp");
            rd.forward(request, response);
        }
        else if(request.getParameter("login") != null){
        String url = "/index.jsp";
        CustomerDAO cusDAO = new CustomerDAO();
        String username = (String)request.getParameter("username");
        String pword = (String)request.getParameter("pword");
        
        User user = new User(username, pword);
        
        try {
            Customer cus = cusDAO.checkLogin(user);
            if(cus!=null){
                boolean valid = true;
                if(session.getAttribute("show_captcha")!= null && session.getAttribute("show_captcha").equals("yes")){
                    String gRecaptchaResponse = request.getParameter("g-recaptcha-response");
 
         System.out.println("gRecaptchaResponse=" + gRecaptchaResponse);
 
         // Verify CAPTCHA.
                valid = VerifyUtils.verify(gRecaptchaResponse);
                }
                
                if(valid){
                        synchronized(session){
                            session.setAttribute("login_tried",0);
                            session.setAttribute("show_captcha","");
                    session.setAttribute("customer", cus);
                    }
                    request.setAttribute("message", "Đăng nhập thành công");

                    if(cus.getRole().equals("1")){
                        url = "/category.jsp";
                    }
                    else{
                        OrderCart cart = new OrderCart(cus);
                        synchronized(session){
                        session.setAttribute("ordercart", cart);
                        }
                    }
                }
                else{
                    request.setAttribute("message", "Google recapthcha không đúng ");                
                    url = "/login.jsp";
                }                      
                
            }
            else{
                int time = 0;
                if(session.getAttribute("login_tried")!=null){
                    time = (Integer) session.getAttribute("login_tried");
                    time = time+1;
                    session.setAttribute("login_tried",time);
                    if(time>3){
                        session.setAttribute("show_captcha","yes");
                    }
                }
                else {
                    session.setAttribute("login_tried",1);
                }
                request.setAttribute("message", "Sai tài khoản hoặc mật khẩu "+(String) session.getAttribute("show_captcha"));                
                url = "/login.jsp";
            }
        } catch(Exception e){
            e.printStackTrace();
        }
        RequestDispatcher dispatcher = request.getRequestDispatcher(url);
        if (dispatcher != null) {
            dispatcher.forward(request, response);
        }            
        }
        else if (request.getParameter("token_reset")!= null){
            String token = request.getParameter("token_reset");
            request.setAttribute("token", token);
            CustomerDAO customer = new CustomerDAO();
            if(customer.validateToken(token)){
                RequestDispatcher rd = request.getRequestDispatcher("/resetpassword.jsp");
            rd.forward(request, response);
            }
            else{
                request.setAttribute("message", "Invalid token");
                RequestDispatcher rd = request.getRequestDispatcher("/login.jsp");
                rd.forward(request, response);
            }
        }
        else if (request.getParameter("do_reset")!= null){
            String token = request.getParameter("token");
            String password = request.getParameter("newpassword");
            String confirmpassword = request.getParameter("confirmpassword");
            CustomerDAO customer = new CustomerDAO();
            if(!customer.validateToken(token)){
                request.setAttribute("message", "Yêu cầu tạo lại mật khẩu quá hạn. Vui lòng thực hiện lại.");
                RequestDispatcher rd = request.getRequestDispatcher("/login.jsp");
                rd.forward(request, response);
            }
            else if(!password.equals(confirmpassword)){
                request.setAttribute("token", token);
                request.setAttribute("message", "Mật khẩu mới không trùng nhau. Vui lòng thử lại.");
                RequestDispatcher rd = request.getRequestDispatcher("/resetpassword.jsp");
                rd.forward(request, response);
            }            
            else{
                String username = customer.getUsernameFromToken(token);
                if(!username.equals("")){
                    customer.updatePassword(username, password);
                    customer.deleteToken(username);                   
                    request.setAttribute("message", "Mật khẩu đã được đặt lại.");
                RequestDispatcher rd = request.getRequestDispatcher("/login.jsp");
                rd.forward(request, response);
                }
                else {
                    request.setAttribute("message", "Đã có lỗi trong quá trình tạo lại mật khẩu.");
                RequestDispatcher rd = request.getRequestDispatcher("/login.jsp");
                rd.forward(request, response);
                }
            }
            
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
        try {
            processRequest(request, response);
        } catch (NoSuchAlgorithmException ex) {
            Logger.getLogger(LoginServlet.class.getName()).log(Level.SEVERE, null, ex);
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
        try {
            processRequest(request, response);
        } catch (NoSuchAlgorithmException ex) {
            Logger.getLogger(LoginServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
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
