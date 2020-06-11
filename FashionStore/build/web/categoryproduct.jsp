

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, com.my.bean.*, com.my.dao.*" %>
<%
    String message = (String) request.getAttribute("message");
    if (message == null) {
        message = "";
    }
    Customer cus = (Customer) session.getAttribute("customer");

    String catID = (String) request.getParameter("catID");

    ProductDAO productDAO = new ProductDAO();
    Hashtable products = productDAO.selectAllCatID(catID);
    Enumeration enumproducts = products.elements();

    CategoryDAO catDAO = new CategoryDAO();
    Category catview = catDAO.selectCategoryByID(catID);
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="style.css" rel="stylesheet" type="text/css" />
        <title>JSP Page</title>
        <script type="text/javascript" src="js/jquery-1.10.2.min.js"></script>
        <style>
            *{
                font-family:"Open Sans",Arial,sans-serif!important;
            }
        </style>
        <style >
            #top{
                width:50px;
                height:50px;
                position:fixed;/*giu co dinh*/
                text-indent:-9999px;
                cursor:pointer;/*tao bieu tuong cho biet co the tac dong*/
                background: url(images/icon/top.png) no-repeat 0 0;
                bottom:10px; right:10px;
            }
        </style>

        <script>
            $(document).ready(function () {
                $('#main').append('<div id="top" title="Trở về đầu trang">back to top</div>');
                $(window).scroll(function () {
                    if ($(window).scrollTop() !== 0) {
                        $('#top').fadeIn();
                    } else
                        $('#top').fadeOut();
                });
                $('#top').click(function () {
                    $('html, body').animate({scrollTop: 0}, 500);
                });
            });
        </script>
    </head>
    <body>
        <div align="center" id="main">
            <div align="center" id="container">

                <%@include file="includes/top_menu.jsp" %>

                <div id="wrapper">
                    <div class="left-content">
                        <%@include file="includes/sidebar_left.jsp" %>

                        <%@include file="includes/menu_today.jsp" %>
                        <!--noi dung hien thi san pham-->
                        <div align="center" class="content">
                            <div class="content-box">
                                <div class="top-content-box">
                                    <div class="top-content-box-icon"></div><%=catview.getName()%></div>
                                <div class="middle-content-box">
                                    <!--<table cellspacing="25" style="border-collapse: collapse;" class="listproduct">-->
                                    <ul id="show_product">
                                        <%
                                            int count = 0;
                                            while (enumproducts.hasMoreElements()) {
                                                Product product = (Product) enumproducts.nextElement();
                                                if (count % 3 == 0) {
                                                    out.print("<tr>");
                                                }
                                        %>
                                        <li>
                                            <a href="productdetail.jsp?productid=<%=product.getId()%>">
                                                <img src="images_data/thoitrangbegai_thumb/<%=product.getImage()%>" width="150" height="100"/>
                                            </a><br>
                                            <a href="productdetail.jsp?productid=<%=product.getId()%>"><b><%=product.getName()%></b></a>
                                            <a href="productdetail.jsp?productid=<%=product.getId()%>" style="color:#009688;"><b><%=product.getPriceToString() + " VNĐ"%></b>&nbsp;<img src="images/icon/cart-11-24.png" alt=""/></a>
                                        </li>
                                        <%        count++;
                                                if (count % 3 == 0 || !enumproducts.hasMoreElements()) {
                                                    out.print("</tr>");
                                                }
                                            }
                                        %>
                                    </ul>
                                    <!--</table>-->
                                </div>
                                <div class="bottom-content-box"></div>
                            </div>

                            <div class="content-box">
                                <div class="top-content-box">
                                    <div class="top-content-box-icon"></div>Sản phẩm bán chạy</div>
                                <div class="middle-content-box">
                                    <ul id="show_product">
                                        <%
                                            Hashtable hotproducts = productDAO.selectSixHotFood();
                                            Enumeration enumhotproducts = hotproducts.elements();

                                            while (enumhotproducts.hasMoreElements()) {
                                                Product product = (Product) enumhotproducts.nextElement();
                                                if (count % 3 == 0) {
                                                    out.print("<tr>");
                                                }
                                        %>
                                        <li>
                                            <a href="productdetail.jsp?productid=<%=product.getId()%>">
                                                <img src="images_data/thoitrangbegai_thumb/<%=product.getImage()%>" width="150" height="100"/>
                                            </a><br>
                                            <p><b><%=product.getPriceToString() + " VNĐ"%></b></p>
                                        </li>
                                        <%        count++;
                                                if (count % 3 == 0 || !enumhotproducts.hasMoreElements()) {
                                                    out.print("</tr>");
                                                }
                                            }
                                        %>
                                    </ul>
                                </div>
                                <div class="bottom-content-box"></div>
                            </div>

                        </div><!--end noi dung-->




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