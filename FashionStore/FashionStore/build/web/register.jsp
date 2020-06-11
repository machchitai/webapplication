

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="includes/header.jsp" %>

<%    String message = (String) request.getAttribute("message");
    if (message == null) {
        message = "";
    }

%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="style.css" rel="stylesheet" type="text/css" />
        <title>JSP Page</title>
        <style>
            *{
                font-family:"Open Sans",Arial,sans-serif!important;
            }
        </style>
        <link rel="stylesheet" href="//code.jquery.com/ui/1.11.0/themes/smoothness/jquery-ui.css">
        <script src="//code.jquery.com/jquery-1.10.2.js"></script>
        <script src="//code.jquery.com/ui/1.11.0/jquery-ui.js"></script>
        <script>
            $(function () {
                $(document).tooltip();
            });

        </script>

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
            }(document, 'script', 'facebook-jssdk'));</script>
        <div align="center" id="main">
            <div align="center" id="container">
                <div id="header">
                    <div class="top-header"></div>
                    <div align="center" class="menu">
                        <ul style="margin-left: 150px;">
                            <li><a href="index.jsp">Trang chủ</a></li>
                            <li><a href="intro.jsp">Giới thiệu</a></li>
                            <li><a href="login.jsp">Đăng nhập</a></li>
                            <li><a href="register.jsp" class="current">Đăng ký</a></li>
                        </ul>
                    </div>
                </div>
                <div id="wrapper">
                    <div class="left-content">
                        <%@include file="includes/sidebar_left.jsp" %>
                    </div>

                </div>
                <div align="center" class="content">
                    <div class="message">
                        <p><%=message%></p>
                    </div>
                    <div class="content-box">
                        <div class="top-content-box"><div class="top-content-box-icon"></div>Thông tin đăng ký</div>
                        <div class="middle-content-box">

                            <form name="registerform" action="CustomerRegisterServlet" method="post">
                                <table>
                                    <tr>
                                        <td>Username: &nbsp;</td>
                                        <td><input class="textfield" title="Nhập tài khoản bạn muốn sử dụng" type="text" name="username" autofocus="true" required="true"></td>
                                    </tr>
                                    <tr>
                                        <td>Password: &nbsp;</td>
                                        <td><input class="textfield" title="Nhập mật khẩu" type="password" name="pword" id="pword1" required="true" ></td>
                                    </tr>
                                    <tr>
                                        <td>Confirm Password: &nbsp;</td>
                                        <td><input class="textfield" title="Nhập lại mật khẩu" type="password"  id="pword2" required="true" ></td>
                                    </tr>
                                    <tr>
                                        <td>Fullname: &nbsp;</td>
                                        <td><input class="textfield" title="Nhập tên đầy đủ của bạn" type="text" name="fullname" required="true" ></td>
                                    </tr>
                                    <tr>
                                        <td>Birthday: &nbsp;</td>
                                        <td><input class="textfield" title="Nhập ngày tháng năm sinh" type="text" name="birthday" required="true" >&nbsp;yyyy/mm/dd</td>
                                    </tr>
                                    <tr>
                                        <td>Email: &nbsp;</td>
                                        <td><input class="textfield" title="Nhập địa chỉ email của bạn" type="email" name="email" required="true"></td>
                                    </tr>
                                    <tr>
                                        <td>Address: &nbsp;</td>
                                        <td><input class="textfield" title="Nhập địa chỉ nhà của bạn" type="textarea" name="address" rows="5" cols="20"></td>
                                    </tr>
                                    <tr>
                                        <td>Phone Number: &nbsp;</td>
                                        <td><input class="textfield" title="Nhập số điện thoại của bạn" type="number" name="phonenumber"></td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td><input class="btn_active" type="submit" name="register" value="Đăng ký" style="margin-right:20px;"/><input class="btn_active" type="reset" name="reset" value="Reset"/></td>
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
            </div>
            <%@include  file="includes/footer.jsp" %>
        </div>
    </body>
</html>
