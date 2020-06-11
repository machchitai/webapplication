

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, com.my.bean.*, com.my.dao.*" %>
<%
    Customer cus = (Customer) session.getAttribute("customer");
    String message = (String) request.getAttribute("message");
    if (message == null) {
        message = "";
    }
    ProductDAO productDAO = new ProductDAO();
    CategoryDAO catDAO = new CategoryDAO();
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="style.css" rel="stylesheet" type="text/css" />
        <title>JSP Page</title>
        <script type="text/javascript" src="js/jquery-1.10.2.min.js"></script>
    </head>
    <body>
        <div align="center" id="main">
            <div align="center" id="container">
                <div id="header">
                    <div class="top-header"></div>
                    <div align="center" class="menu">
                        <ul style="margin-left: 80px;">
                            <li><a href="index.jsp">Trang chủ</a></li>
                            <li><a href="customerinfo.jsp">Khách hàng</a></li>
                            <li><a href="buybalance.jsp" class="current">Nạp tiền</a></li>
                            <li><a href="ordercart.jsp">Giỏ hàng</a></li>
                            <li><a href="login.jsp?log=out">Đăng xuất</a></li>

                        </ul>
                    </div>
                </div>
                <div id="wrapper">
                    <div class="left-content">
                        <div class="left-content-box">
                            <div class="top-left-content-box">Danh mục</div>
                            <div class="menu-middle-left-content-box">
                                <table>
                                    <%
                                        Hashtable cats = catDAO.selectAll();
                                        Enumeration enumcats = cats.elements();
                                        while (enumcats.hasMoreElements()) {
                                            Category cat = (Category) enumcats.nextElement();
                                    %>
                                    <tr><td><a href="categoryproduct.jsp?catID=<%=cat.getId()%>"><%=cat.getName()%></a></td></tr>
                                            <% }%>
                                </table>
                            </div>
                            <div class="bottom-left-content-box"></div>
                        </div>
                        <div class="left-content-box">
                            <%@include file="includes/menu_today.jsp" %>
                            <div align="center" class="content">

                                <div class="content-box">
                                    <div class="top-content-box"><div class="top-content-box-icon"></div>Nạp tiền vào tài khoản</div>
                                    <div class="middle-content-box">
                                        <div class="message">
                                            <p><%=message%></p>
                                        </div>
                                        <form name="balanceform" action="BuyBalanceServlet" method="post">
                                            <table>
                                                <tr>
                                                    <td>Nhập mã nạp tiền: &nbsp;</td>
                                                    <td><input class="textfield" type="text" name="source" autofocus="true"></td>
                                                </tr>
                                                <tr>
                                                    <td><input class="btn_active" type="submit" name="buybalance" value="Nạp tiền"/></td>
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
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>