
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, com.my.bean.*, com.my.dao.*" %>
<%
    String delFoodOrderID = (String) request.getParameter("delFoodOrderID");
    String message = (String) request.getAttribute("message");
    String error = (String) request.getAttribute("error");

    if (message == null) {
        message = "";
    }
    if (error == null) {
        error = "";
    }
    OrderCart cart = (OrderCart) session.getAttribute("ordercart");
    if (delFoodOrderID != null) {
        cart.removeFoodOrders(delFoodOrderID);
        session.setAttribute("customer", cart.getCustomer());
    }
    Hashtable productOrders = cart.getFoodorders();
    Enumeration enumproductorder = productOrders.elements();

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
                            <li><a href="buybalance.jsp">Nạp tiền</a></li>
                            <li><a href="ordercart.jsp" class="current">Giỏ hàng</a></li>
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
                                <div class="message">
                                    <p><%=message%></p>
                                    <p><%=error%></p>
                                </div>
                                <div class="content-box">
                                    <div class="top-content-box"><div class="top-content-box-icon"></div>Giỏ hàng</div>
                                    <div class="middle-content-box">

                                        <form name="ordercart" action="OrderCartServlet" method="post">
                                            <table border="1" class="admin_table">
                                                <tr class="admin_table_header">
                                                    <td>ID</td>
                                                    <td>Sản phẩm</td>
                                                    <td>Đơn giá (VNĐ)</td>
                                                    <td>Số lượng</td>
                                                    <td>Giá (VNĐ)</td>
                                                    <td>Chức năng</td>
                                                </tr>
                                                <%
                                                    while (enumproductorder.hasMoreElements()) {
                                                        ProductOrder productorder = (ProductOrder) enumproductorder.nextElement();

                                                %>
                                                <tr>
                                                    <td><%=productorder.getId()%></td>
                                                    <td><%=productorder.getName()%></td>
                                                    <td><%=productorder.getPriceToString()%></td>
                                                    <td><input type="text" name="qty" value="<%=productorder.getQuantity()%>" size="10"/></td>
                                                    <td><%=productorder.getTotalPriceToString()%></td>
                                                    <td><a href="ordercart.jsp?delFoodOrderID=<%=productorder.getId()%>"><img src="images/icon/tango_edit_delete.png" width="24px" height="24px"/><br/></a>Hủy</td>
                                                </tr>
                                                <%   }%>
                                                <tr align="center">
                                                    <td><b>Tổng giá trị: <%=cart.getTotalpriceToString()%></b></td>
                                                </tr>

                                            </table>

                                        </form>

                                        <table cellspacing="20">
                                            <tr>
                                                <td>
                                                    <form action="<c:url value='/checkout.jsp'/>" method="post">
                                                        <input class="btn_active" type="submit" value='Checkout'/>
                                                    </form> 
                                                </td>
                                                <td>
                                                    <form action="<c:url value='/index.jsp'/>" method="post">
                                                        <input class="btn_active" type="submit" value='Tiếp tục mua sắm'/>
                                                    </form>
                                                </td>
                                            </tr>
                                        </table>

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