<%-- 
    Document   : index
    Created on : Nov 15, 2012, 11:41:30 PM
    Author     : vivtory
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, com.my.bean.*, com.my.dao.*" %>
<%
    int pagenumb = Integer.parseInt((String)request.getParameter("page"));
    Customer cus = (Customer)session.getAttribute("customer");
   // Hashtable products = (Hashtable)session.getAttribute("foundproducts");
    ArrayList<Product> products = (ArrayList<Product>)session.getAttribute("foundproducts");
   // Enumeration enumproducts = products.elements();
    int productnumb = products.size();
    String message = "Có " + productnumb + " kết quả được tìm thấy";
    
    ProductDAO productDAO = new ProductDAO();                
    CategoryDAO catDAO = new CategoryDAO();
        
    
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="style.css" rel="stylesheet" type="text/css" />
        <title>JSP Page</title>
        
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
<script type="text/javascript" src="js/jquery-1.10.2.min.js"></script>
<script>
	$(document).ready(function(){
		$('#main').append('<div id="top" title="Trở về đầu trang">back to top</div>');
		$(window).scroll(function(){
			if($(window).scrollTop() !==0){
				$('#top').fadeIn();
			}
			else $('#top').fadeOut();
		});
		$('#top').click(function(){
			$('html, body').animate({scrollTop:0},500);
		});
	});
</script>
        <style>
            *{
                font-family:"Open Sans",Arial,sans-serif!important;
            }
        </style>
    </head>
    <body>
        <div align="center" id="main">
            <div align="center" id="container">
	<div id="header">
    	<div class="top-header"></div>
        <div align="center" class="menu">
            <ul style="margin-left: 150px;">
                <% if(cus==null || cus.getRole().equals("1")) { %>
            	<li><a href="index.jsp" class="current">Trang chủ</a></li>
                <li><a href="intro.jsp">Giới thiệu</a></li>
                <li><a href="login.jsp">Đăng nhập</a></li>
                <li><a href="register.jsp">Đăng ký</a></li>
                <% } else { %>
                         <li><a href="index.jsp" class="current">Trang chủ</a></li>
                         <li><a href="customerinfo.jsp">Khách hàng</a></li>
                         <li><a href="buybalance.jsp">Nạp tiền</a></li>
                         <li><a href="ordercart.jsp">Giỏ hàng</a></li>
                         <li><a href="login.jsp?log=out">Đăng xuất</a></li>
                <% } %>
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
				<div class="top-content-box"><div class="top-content-box-icon"></div>Kết quả tìm kiếm</div>
				<div class="middle-content-box">
                         <div class="message">
                            <p><%=message%></p>
			</div>
                        <ul id="show_product">
     <%for(int i=0;i<productnumb;i++){%>
           <li>
               <a href="productdetail.jsp?productid=<%=products.get(i).getId()%>">
                   <img src="images_data/thoitrangbegai_thumb/<%=products.get(i).getImage() %>" width="150" height="100"/>
               </a><br>
               <a href="productdetail.jsp?productid=<%=products.get(i).getId()%>"><b><%=products.get(i).getName()%></b><br/>
               <b><%=products.get(i).getPriceToString()+" VNĐ" %></b>
               </a>
           </li>
      <%}%>
            </ul>
                
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
                    <%@include file="includes/footer.jsp" %>