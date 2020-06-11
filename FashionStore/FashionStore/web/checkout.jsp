<%-- 
    Document   : index
    Created on : Nov 15, 2012, 11:41:30 PM
    Author     : vivtory
--%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, com.my.bean.*, com.my.dao.*" %>
<%
    String delFoodOrderID = (String)request.getParameter("delFoodOrderID");
    String message = (String)request.getAttribute("message");
    String error=(String)request.getAttribute("error");
    if(message==null)   message="";
    if(error==null) error="";
    OrderCart cart = (OrderCart)session.getAttribute("ordercart");
    if(delFoodOrderID!=null){
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
                    <div class="message">
                        
                    </div>
			<div class="content-box">
				<div class="top-content-box"><div class="top-content-box-icon"></div>Thông tin đơn hàng</div>
				<div class="middle-content-box">
                    
            <div class="middle">
    <form action="OrderCartServlet" method="post" enctype="multipart/form-data">
        <b style="margin-bottom: 2px; display: block;">Thông tin đơn hàng</b>
        <div style="background: #F7F7F7; border: 1px solid #DDDDDD; padding: 10px; margin-bottom: 10px;">
            <%
            if(cart != null && cart.getTotalprice()!=0){
                %>
                <table style="width: 450px;" cell-padding="10">
                    <tr>
                        <td>Họ và tên:</td>
                        <td><%=cart.getCustomer().getFullname()%></td>
                    </tr>
                    <tr>
                        <td>Tên sản phẩm:</td>
                        <td><%
                        while(enumproductorder.hasMoreElements()){
                             ProductOrder productorder = (ProductOrder)enumproductorder.nextElement();
                             out.print("<p>"+productorder.getName()+" "+"<b>Số lượng: </b>"+productorder.getQuantity()+"</p>");
                        }
                        
                    %></td>
                        
                    </tr>
                 
                    <tr>
                        <td>Tổng tiền:</td>
                        <td><span style="color: #cc3300"><%=cart.getTotalpriceToString()%></span></td>
                    </tr>
                    <tr>
                        <td>Địa chỉ :</td>
                        <td><%=cart.getCustomer().getAddress()%></td>
                    </tr>
                    
                    <tr>
                        <td>Email :</td>
                        <td><%=cart.getCustomer().getEmail()%></td>
                    </tr>
                    <tr>
                        <td>Số điện thoại :</td>
                        <td><%=cart.getCustomer().getPhonenumber()%></td>
                    </tr>
                </table>
            <%
            }
            %>
        </div>
      <b style="margin-bottom: 2px; display: block;">Thông tin bổ sung</b>
      <div style="background: #F7F7F7; border: 1px solid #DDDDDD; padding: 10px; margin-bottom: 10px;">
          <table style="width: 450px;" cell-padding="10">
                    <tr>
                        <td>Địa chỉ nhận :</td>
                        <td><input type="text" class="textfield" name="dcnhan"/></td>
                    </tr>
                    <tr>
                        <td>Yêu cầu:</td>
                        <td>
                            <textarea rows="5" cols="40" name="require_deliver" placeholder="Nhập yêu cầu ship hàng"></textarea>
                        </td>
                        
                    </tr>
                    
                </table>
      </div>
          <table cellspacing="20">
                        <tr>
                            
                            <td>
                    <form action="<c:url value='OrderCartServlet'/>" method="post">
                        <input class="btn_active" type="submit" value='Thanh toán'/>
                    </form>
                        </td>
                            <td>
                    <form action="<c:url value='/ordercart.jsp'/>" method="post">
                        <input class="btn_active" type="submit" value='Quay lại'/>
                    </form> 
                        </td>
                        
                        </tr>
                    </table>
      
    </form>
  </div>
                               
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