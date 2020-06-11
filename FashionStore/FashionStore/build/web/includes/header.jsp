<%-- 
    Document   : header
    Created on : Jun 29, 2014, 10:27:03 PM
    Author     : thanhlam
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, com.my.bean.*, com.my.dao.*" %>
<%
    Customer cus = (Customer)session.getAttribute("customer");
    ProductDAO productDAO = new ProductDAO();                
    CategoryDAO catDAO = new CategoryDAO();
%>
