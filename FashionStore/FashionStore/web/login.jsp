

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, com.my.bean.*, com.my.dao.*" %>
<%@include file="includes/header.jsp" %>
<%    String log = (String) request.getAttribute("log");
    String message = (String) request.getAttribute("message");
    String isCaptcha = ((String) session.getAttribute("show_captcha") != null) ? (String) session.getAttribute("show_captcha") : "";
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
        <script src='https://www.google.com/recaptcha/api.js?hl=vi'></script>
        <style>
            *{
                font-family:"Open Sans",Arial,sans-serif!important;
            }
        </style>
    </head>
    <body>
        <div id="fb-root"></div>
        <script>(function (d, s, id) {
                var js, fjs = d.getElementsByTagName(s)[0];
                if (d.getElementById(id))
                    return;
                js = d.createElement(s);
                js.id = id;
                js.src = "//connect.facebook.net/vi_VN/sdk.js#xfbml=1&appId=266459763505486&version=v2.0";
                fjs.parentNode.insertBefore(js, fjs);
            }(document, 'script', 'facebook-jssdk'));
        </script>
        
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
                            <div class="top-content-box"><div class="top-content-box-icon"></div>Đăng nhập</div>
                            <div class="middle-content-box">

                                <form name="loginform" action="LoginServlet" method="post">
                                    <table>
                                        <tr>
                                            <td>Username: &nbsp;</td>
                                            <td><input class="textfield" type="text" name="username" autofocus="true"></td>
                                        </tr>
                                        <tr>
                                            <td>Password: &nbsp;</td>
                                            <td><input class="textfield" type="password" name="pword"></td>
                                        </tr>
                                        <%if (!isCaptcha.equals("")) {%>
                                        <tr>
                                            <td colspan="2">    
                                                <div class="g-recaptcha" data-sitekey="6Ld8fA4UAAAAAIado7jIQ2I93hmSPj78Z_CruEds"></div>
                                            </td>
                                        </tr>
                                        <%}

                                        %>
                                        <tr>
                                            <td colspan="2">
                                        <center>
                                            <input class="btn_active" type="submit" name="login" value="Đăng nhập"/>&nbsp;&nbsp;&nbsp;
                                            <input class="btn_active" type="reset" name="reset" value="Reset"/>
                                        </center>
                                        </td>

                                        </tr>
                                    </table>
                                </form>
                                <form name="Resetform" action="LoginServlet" method="post">
                                    <table>
                                        <tr>
                                            <td>Username: &nbsp;</td>
                                            <td><input class="textfield" type="text" name="username" autofocus="true"></td>
                                        </tr>


                                        <td colspan="2">
                                        <center>
                                            <input class="btn_active" type="submit" name="reset_password" value="Reset Password"/>&nbsp;&nbsp;&nbsp;
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

