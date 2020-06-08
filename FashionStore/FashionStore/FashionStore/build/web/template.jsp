<%-- 
    Document   : index
    Created on : Nov 15, 2012, 11:41:30 PM
    Author     : vivtory
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, com.my.bean.*, com.my.dao.*" %>
<%
    String message = (String)request.getAttribute("message");
    if(message==null)   message="";
        
    FoodDAO foodDAO = new FoodDAO();
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
            <ul style="margin-left: 150px;">
                <% if(cart==null) { %>
            	<li><a href="index.jsp" class="current">Trang chủ</a></li>
                <li><a href="intro.jsp">Giới thiệu</a></li>
                <li><a href="login.jsp">Đăng nhập</a></li>
                <li><a href="register.jsp">Đăng ký</a></li>
                <% } else { %>
                         <li><a href="index.jsp" class="current">Trang chủ</a></li>
                         <li><a href="customerinfo.jsp">Khách hàng</a></li>
                         <li><a href="buybalance.jsp">Nạp tiền</a></li>
                         <li><a href="ordercart.jsp">Giỏ hàng</a></li>
                         <li><a href="logout.jsp">Đăng xuất</a></li>
                <% } %>
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
                    while(enumcats.hasMoreElements()){
                         Category cat = (Category)enumcats.nextElement();
%>
                            <tr><td><a href="categoryfood.jsp?catID=<%=cat.getId()%>"><%=cat.getName()%></a></td></tr>
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
                    
                    Hashtable todayfoods = foodDAO.selectTodayFood();
                    Enumeration enumtodayfoods = todayfoods.elements();
                    while(enumtodayfoods.hasMoreElements()){
                         Food food = (Food)enumtodayfoods.nextElement();
%>
                        <tr><td><a href="fooddetail.jsp?foodid=<%=food.getId()%>">
                                <img src="images_data/<%=food.getImage() %>" width="150" height="100"/>
                        </a></td></tr>
                    <% } %>
                                    </table>
                                </div>
				<div class="bottom-left-content-box"></div>
			</div>
        </div>
		<div align="center" class="content">
                    <div class="message">
                        <p><%=message %></p>
                    </div>
			<div class="content-box">
				<div class="top-content-box"><div class="top-content-box-icon"></div>Chi tiết món ăn</div>
				<div class="middle-content-box">
                    
             <form name="registerform" action="CustomerRegisterServlet" method="post">
                <table>
                    <tr>
                        <td>Username: &nbsp;</td>
                        <td><input type="text" name="username"></td>
                    </tr>
                    <tr>
                        <td>Password: &nbsp;</td>
                        <td><input type="password" name="pword" id="pword1"></td>
                    </tr>
                    <tr>
                        <td>Confirm Password: &nbsp;</td>
                        <td><input type="password"  id="pword2"></td>
                    </tr>
                    <tr>
                        <td>Fullname: &nbsp;</td>
                        <td><input type="text" name="fullname"></td>
                    </tr>
                    <tr>
                        <td>Birthday: &nbsp;</td>
                        <td><input type="text" name="birthday">&nbsp;yyyy/mm/dd</td>
                    </tr>
                    <tr>
                        <td>Email: &nbsp;</td>
                        <td><input type="email" name="email"></td>
                    </tr>
                    <tr>
                        <td>Address: &nbsp;</td>
                        <td><input type="textarea" name="address" rows="5" cols="20"></td>
                    </tr>
                    <tr>
                        <td>Phone Number: &nbsp;</td>
                        <td><input type="text" name="phonenumber"></td>
                    </tr>
                    <tr>
                        <td><input type="submit" name="register" value="Đăng ký"/></td>
                        <td><input type="reset" name="reset" value="Xóa"/></td>
                    </tr>
                </table>
            </form>
                                    
				</div>
				<div class="bottom-content-box"></div>
			</div>
		</div>
		<div class="right-content">
			<div class="right-content-box">
				<div class="top-right-content-box">Tìm kiếm</div>
				<div class="middle-right-content-box">
                                    <form name="searchfood" action="SearchFoodServlet" method="post">
                                        <table>
                                            <tr><td><input type="text" name="searchkey" value="Tìm tên món ăn"></td></tr>
                                            <tr><td><input type="submit" name="btnsearch" value="Tìm kiếm"></td></tr>
                                        </table>
                                    </form>
				</div>
				<div class="bottom-right-content-box"></div>
			</div>
			<div class="right-content-box">
				<div class="top-right-content-box">Món ăn mới</div>
				<div class="middle-right-content-box">
                                    <table>
           <%
                    
                    Hashtable newfoods = foodDAO.selectNewFood();
                    Enumeration enumnewfoods = newfoods.elements();
                    while(enumnewfoods.hasMoreElements()){
                         Food food = (Food)enumnewfoods.nextElement();
%>
                        <tr><td><a href="fooddetail.jsp?foodid=<%=food.getId()%>">
                                <img src="images_data/<%=food.getImage() %>" width="150" height="100"/>
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
			<strong style="margin-left:20px; text-transform:uppercase; font-weight:bold">Copyright 2014 © THỜI TRANG Dodep.vn</strong><br>

			<span class="chu_tieude">Địa chỉ : 15 Nguyễn Khuyến – phường Văn Quán – Quận Hà Đông – Tp.Hà Nội </span><br>

			<span class="chu_tieude">Điện thoại : 04.626766181 -  04.39787238 - 04.39787239 - 04.39735247 </span><br>

			<span class="chu_tieude">Hotline : 0913806277 - 0907284209</span><br>

			<span class="chu_tieude">Email : dodep@yahoo.com.vn</span>
			<span class="chu_tieude">Fax : 04 973 5247</span><br>
                           
		</div>

		<div class="foot_right">

			<strong>Thiết kế xây dựng : </strong> 
			<span class="tencty_lm">Trần Thanh Lam</span><br>
			<strong>Điện thoại : 0982.77.99.70 - 0986.517.936.</strong><br>
			<strong>Email : thanhlam2502@yahoo.com - babyrabbits_1992@yahoo.com</strong><br>

		</div>
		<div class="foot_ke"></div>
	</div>
    </div>
    </body>
</html>
