

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, com.my.bean.*, com.my.dao.*" %>
<%
    String message = (String) request.getAttribute("message");
    if (message == null) {
        message = "";
    }
    Customer cus = (Customer) session.getAttribute("customer");
    ProductDAO productDAO = new ProductDAO();
    CategoryDAO catDAO = new CategoryDAO();
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="style.css" rel="stylesheet" type="text/css" />
        <title>JSP Page</title>
    </head>
    <body>
        <div align="center" id="main">
            <div align="center" id="container">
                <div id="header">
                    <div class="top-header"></div>
                    <div align="center" class="menu">
                        <ul style="margin-left: 80px;">
                            <li><a href="index.jsp">Trang chủ</a></li>
                            <li><a href="customerinfo.jsp" class="current">Khách hàng</a></li>
                            <li><a href="buybalance.jsp">Nạp tiền</a></li>
                            <li><a href="ordercart.jsp">Giỏ hàng</a></li>
                            <li><a href="login.jsp?log=out">Đăng xuất</a></li>
                        </ul>
                    </div>
                </div>
                <div id="wrapper">
                    <div class="left-content">
                        <div class="left-content-box">
                            <div class="top-left-content-box">Category</div>
                            <div class="menu-middle-left-content-box">
                                <table>
                                    <%
                                        Hashtable cats = catDAO.selectAll();
                                        Enumeration enumcats = cats.elements();
                                        while (enumcats.hasMoreElements()) {
                                            Category cat = (Category) enumcats.nextElement();
                                    %>
                                    <tr><td><a href="categoryproduct.jsp?catID=<%=cat.getId()%>"><%=cat.getName()%></a></td></tr>
                                            <% } %>
                                </table>
                            </div>
                            <div class="bottom-left-content-box"></div>
                        </div>
                        <div class="left-content-box">
                            <div class="top-left-content-box">Hôm nay</div>
                            <div class="middle-left-content-box">
                                <table>
                                    <%

                                        Hashtable todayproducts = productDAO.selectTodayFood();
                                        Enumeration enumtodayproducts = todayproducts.elements();
                                        while (enumtodayproducts.hasMoreElements()) {
                                            Product product = (Product) enumtodayproducts.nextElement();
                                    %>
                                    <tr><td><a href="productdetail.jsp?productid=<%=product.getId()%>">
                                                <img src="images_data/thoitrangbegai_thumb/<%=product.getImage()%>" width="150" height="100"/>
                                            </a></td></tr>
                                            <% }%>
                                </table>
                            </div>
                            <div class="bottom-left-content-box"></div>
                        </div>
                    </div>
                    <div align="center" class="content">
                        <div class="message">
                            <p><%=message%></p>
                        </div>
                        <div class="content-box">
                            <div class="top-content-box"><div class="top-content-box-icon"></div>Thông tin Khách hàng</div>
                            <div class="middle-content-box">
                                <script type="text/javascript">
                                    function check_pass() {
                                        var new_pass = document.getElementById('new_pass').value;
                                        var re_new_pass = document.getElementById('re_new_pass').value;
                                        if (new_pass !== re_new_pass) {
                                            alert("Mật khẩu không trùng khớp");
                                        }
                                    }
                                </script>     
                                <form name="registerform" action="UpdateCustomerInfoServlet" method="post">
                                    <table>
                                        <tr>
                                            <td>Username: &nbsp;</td>
                                            <td><b><%=cus.getUsername()%></b></td>
                                        </tr>
                                        <tr>
                                            <td>Fullname: &nbsp;</td>
                                            <td><b><%=cus.getFullname()%></b></td>
                                        </tr>
                                        <tr>
                                            <td>Birthday: &nbsp;</td>
                                            <td><b><%=cus.getBirthdayToString()%></b></td>
                                        </tr>
                                        <tr>
                                            <td>Balance: &nbsp;</td>
                                            <td><b><%=cus.getBalance() + ",000 VNĐ"%></b></td>
                                        </tr>
                                        <tr>
                                            <td>New Password: &nbsp;</td>
                                            <td><input id="new_pass" class="textfield" type="password" name="pword" id="pword1" value="<%=cus.getPword()%>"></td>
                                        </tr>
                                        <tr>
                                            <td>Confirm New Password: &nbsp;</td>
                                            <td><input id="re_new_pass" class="textfield" type="password"  id="pword2" value="<%=cus.getPword()%>"></td>
                                        </tr>
                                        <tr>
                                            <td>Email: &nbsp;</td>
                                            <td><input class="textfield" type="email" name="email" value="<%=cus.getEmail()%>"></td>
                                        </tr>
                                        <tr>
                                            <td>Address: &nbsp;</td>
                                            <td><input class="textfield" type="textarea" name="address" rows="5" cols="20" value="<%=cus.getAddress()%>"></td>
                                        </tr>
                                        <tr>
                                            <td>Phone Number: &nbsp;</td>
                                            <td><input class="textfield" type="text" name="phonenumber" value="<%=cus.getPhonenumber()%>"></td>
                                        </tr>
                                        <tr>
                                            <td><input class="btn_active" type="submit" name="register" value="Cập nhật" onclick="check_pass()"/></td>
                                            <td><input class="btn_active" type="reset" name="reset" value="Xóa"/></td>
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
                            <div class="top-right-content-box">Sản phẩm mới</div>
                            <div class="middle-right-content-box">
                                <table>
                                    <%
                                        Hashtable newproducts = productDAO.selectNewFood();
                                        Enumeration enumnewproducts = newproducts.elements();
                                        while (enumnewproducts.hasMoreElements()) {
                                            Product product = (Product) enumnewproducts.nextElement();
                                    %>
                                    <tr><td><a href="productdetail.jsp?productid=<%=product.getId()%>">
                                                <img src="images_data/thoitrangbegai_thumb/<%=product.getImage()%>" width="150" height="100"/>
                                            </a></td></tr>
                                            <% }%>
                                </table>
                            </div>
                            <div class="bottom-right-content-box"></div>
                        </div>
                    </div>
                </div>
                <%@include file="includes/footer.jsp" %>