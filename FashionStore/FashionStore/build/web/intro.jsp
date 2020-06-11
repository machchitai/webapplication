<%-- 
    Document   : index
    Created on : Nov 15, 2012, 11:41:30 PM
    Author     : vivtory
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, com.my.bean.*, com.my.dao.*" %>
<%
    Customer cus = (Customer)session.getAttribute("customer");
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
        <style>
            *{
                font-family:"Open Sans",Arial,sans-serif!important;
            }
        </style>
    </head>
    <body>
        <div align="center" id="main">
            <div align="center" id="container">
            <%@include file="includes/top_menu.jsp" %>
	<div id="wrapper">
		<div class="left-content">
			<div class="left-content-box">
				<div class="top-left-content-box">Danh mục</div>
				<div class="menu-middle-left-content-box">
                                    <table>
           <%
                    
                    Hashtable cats = catDAO.selectAll();
                    Enumeration enumcats = cats.elements();
                    while(enumcats.hasMoreElements()){
                         Category cat = (Category)enumcats.nextElement();
%>
                            <tr><td><a href="categoryproduct.jsp?catID=<%=cat.getId()%>"><%=cat.getName()%></a></td></tr>
                    <% } %>
                                    </table>
                                </div>
				<div class="bottom-left-content-box"></div>
			</div>
			<div class="left-content-box">
                            <%@include file="includes/menu_today.jsp" %>
		<div align="center" class="content">
			<div class="content-box">
				<div class="top-content-box"><div class="top-content-box-icon"></div>THE WORLD-Sống phong cách!</div>
				<div class="middle-content-box">
                    
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
                    while(enumnewproducts.hasMoreElements()){
                         Product product = (Product)enumnewproducts.nextElement();
%>
                        <tr><td><a href="productdetail.jsp?productid=<%=product.getId()%>">
                                    <img src="images_data/thoitrangbegai_thumb/<%=product.getImage() %>" width="150" height="100"/>
                        </a></td></tr>
                    <% } %>
                                    </table>
                                </div>
				<div class="bottom-right-content-box"></div>
			</div>
        </div>
	</div>
	<div id="footer">
		<div class="foot_ke"></div>
		<div class="foot_left">
			<strong style="margin-left:20px; font-weight:bold">Copyright 2014 © THỜI TRANG Dodep.vn </strong><br>

			<span class="chu_tieude">Địa chỉ :  15 Nguyễn Khuyến – phường Văn Quán – Quận Hà Đông – Tp.Hà Nội </span><br>

			<span class="chu_tieude">Điện thoại : 04.626766181 -  04.39787238 - 04.39787239 - 04.39735247 </span><br>

			<span class="chu_tieude">Hotline : 0913806277 - 0907284209</span><br>

			<span class="chu_tieude">Email : dodep.vn</span>
			<span class="chu_tieude">Fax : 04 973 5247</span><br>
                           
		</div>

		<div class="foot_right">

			<strong>Thiết kế xây dựng : </strong> 
			<span class="tencty_lm">Trần Thanh Lam</span><br>
			<strong>Điện thoại : 0982.77.99.70 </strong><br>
			<strong>Email : thanhlam2502@yahoo.com</strong><br>

		</div>

		<div class="foot_ke"></div>
	</div>
    </div>
    </body>
</html>
