<%-- 
    Document   : index
    Created on : Nov 15, 2012, 11:41:30 PM
    Author     : vivtory
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, com.my.bean.*, com.my.dao.*" %>
<%@include file="includes/header.jsp" %>
<%
    String log = (String) request.getAttribute("log");
    String message = (String) request.getAttribute("message");
    String token = (String) request.getAttribute("token");
    if (message == null) {
        message = "";
    }
    if (log != null && log.equals("out")) {
        session.removeAttribute("customer");
        session.removeAttribute("ordercart");
        session.invalidate();
    }

%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="style.css" rel="stylesheet" type="text/css" />
        <title>JSP Page</title>
    </head>
    <body>
        <div id="fb-root"></div>
<script>(function(d, s, id) {
  var js, fjs = d.getElementsByTagName(s)[0];
  if (d.getElementById(id)) return;
  js = d.createElement(s); js.id = id;
  js.src = "//connect.facebook.net/vi_VN/sdk.js#xfbml=1&appId=266459763505486&version=v2.0";
  fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk'));</script>
        <div align="center" id="main">
           <div align="center" id="container"> 
                <div id="header">
                    <div class="top-header"></div>
                    <div align="center" class="menu">
                        <ul style="margin-left: 150px;">
                            <li><a href="index.jsp">Trang chủ</a></li>
                            <li><a href="intro.jsp">Giới thiệu</a></li>
                            <li><a href="login.jsp" class="current">Đăng nhập</a></li>
                            <li><a href="register.jsp">Đăng ký</a></li>
                        </ul>
                    </div>
                </div>
                <div id="wrapper">
                    <div class="left-content">
                        <%@include file="includes/sidebar_left.jsp" %>
                    </div>
                    <div class="left-content-box">
                        <%@include file="includes/menu_today.jsp" %>
                    </div>
                
                <div align="center" class="content">
                    <div class="message">
                        <p><%=message%></p>
                    </div>
                    <div class="content-box">
                        <div class="top-content-box"><div class="top-content-box-icon"></div>Reset password</div>
                        <div class="middle-content-box">
                            <form name="Reset_confirm" action="LoginServlet" method="post">
                                <table>
                                    <tr>
                                        <td>Enter new password: &nbsp;</td>
                                        <td><input class="textfield" type="password" name="newpassword" autofocus="true"></td>
                                    </tr>
                                    <tr>
                                        <td>Confirm new password: &nbsp;</td>
                                        <td><input class="textfield" type="password" name="confirmpassword" autofocus="true"></td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                    <center>
                                        <input type="hidden" name="token" value="<%=token%>">
                                        <input class="btn_active" type="submit" name="do_reset" value="Tạo mật khẩu mới"/>&nbsp;&nbsp;&nbsp;
                                    </center>
                                        </td>
                                        
                                    </tr>
                                </table>
                            </form>

                        </div>
                        <div class="bottom-content-box"></div>
                    </div>
                </div>
                <div class="right-content">
                    <div class="right-content-box">
                        <%@include file="includes/search_box.jsp" %>
                    </div>
                    <div class="right-content-box">
                        <%@include file="includes/new_product.jsp" %>
                    </div>
                </div>
             
                <%@include file="includes/footer.jsp" %>
                           
