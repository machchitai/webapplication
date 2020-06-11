<%-- 
    Document   : index
    Created on : Nov 15, 2012, 11:41:30 PM
    Author     : vivtory
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, com.my.bean.*, com.my.dao.*" %>
<%
    String message = (String)request.getAttribute("message");
    if(message==null)   message = "";
    String productID = (String)request.getParameter("productid");
    OrderCart cart = (OrderCart)session.getAttribute("ordercart");
    
    ProductDAO productDAO = new ProductDAO();                
    CategoryDAO catDAO = new CategoryDAO();
        
    Product productview = productDAO.selectByID(productID);
    session.setAttribute("product", productview);
    Category catview = catDAO.selectCategoryByID(productview.getCatID());
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="style.css" rel="stylesheet" type="text/css" />
        <title>JSP Page</title>
        <!-- Include jQuery. -->
        <script type="text/javascript" src="http://itstudent.net/images/html/js/jquery-1.8.2.js"></script>

        <!-- Include Cloud Zoom CSS. -->
       <link rel="stylesheet" type="text/css" href="http://itstudent.net/images/html/css/cloudzoom.css" />

        <!-- Include Cloud Zoom script. -->
       <script type="text/javascript" src="http://itstudent.net/images/html/js/cloudzoom.js"></script>

        <!-- Call quick start function. -->
        <script type="text/javascript" src="js/jquery-1.10.2.min.js"></script>
        <script type="text/javascript" src="js/jquery-ui.js"></script>
        <link rel="stylesheet" href="css/jquery-ui.css" type="text/css"/>
        <script type="text/javascript">
            CloudZoom.quickStart();
        </script> 
        <script type="text/javascript" src="js/jquery-1.10.2.min.js"></script>
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
    </head>
    <body>
        <div id="fb-root"></div>
<script>(function(d, s, id) {
  var js, fjs = d.getElementsByTagName(s)[0];
  if (d.getElementById(id)) return;
  js = d.createElement(s); js.id = id;
  js.src = "//connect.facebook.net/vi_VN/sdk.js#xfbml=1&appId=266459763505486&version=v2.0";
  fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk'));</script>
        
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
                         <li><a href="login.jsp?log=out">Đăng xuất</a></li>
                <% } %>
            </ul>
        </div>
    </div>
	<div id="wrapper">
		<div class="left-content">
                    <%@include file="includes/sidebar_left.jsp" %>
                    <%@include file="includes/menu_today.jsp" %>
        
		<div align="center" class="content">
                    <div class="message">
                        <p><%=message %></p>
                    </div>
			<div class="content-box">
				<div class="top-content-box"><div class="top-content-box-icon"></div>Chi tiết sản phẩm</div>
				<div class="middle-content-box">
                    
            <div id="show_image">  
                                    <!-- class cloud-zoom phải có , các tùy chỉnh đều nằm trong thẻ rel -->
                                    <img style="border:2px solid #999;" class = "cloudzoom" src = "images_data/thoitrangbegai_thumb/<%=productview.getImage()%>"
                                         data-cloudzoom = "zoomImage: 'images_data/thoitrangbegai_full/<%=productview.getImage()%>'" width="200" height="230" />
                   
                                    <div class="fb-like" data-href="https://www.facebook.com/pages/250954735077559" data-width="200" data-layout="standard" data-action="like" data-show-faces="true" data-share="true"></div>
            </div>
                                                            
                                    
                                    <div id="form">  
                                        
            <form name="orderform" action="AddOrderCartServlet" method="post">
                <table cellspacing="2" class="productdetail">
                    <tr>
                        <td>Số lượng còn: &nbsp;</td>
                        <td><input style="border:none" type="text" size="5" readonly="true" name="hangcon" value="<%=productview.getQuantity()%>">SP</td>
                    </tr>
                    <tr>
                        <td>Mã sản phẩm: &nbsp;</td>
                        <td><b><%=productview.getId()%></b></td>
                    </tr>
                    <tr>
                        <td>Tên: &nbsp;</td>
                        <td><b><%=productview.getName()%></b></td>
                    </tr>
                    <tr>
                        <td>Phân loại: &nbsp;</td>
                        <td><b><%=catview.getName()%></b></td>
                    </tr>
                    <tr>
                        <td>Mô tả: &nbsp;</td>
                        <td><b><%=productview.getDescribes()%></b></td>
                    </tr>
                    <tr>
                        <td>Đơn giá: &nbsp;</td>
                        <td><b><%=productview.getPriceToString()+" VNĐ/cái"%></b></td>
                    </tr><br><br>
                    <tr>
                        <td><b>Đặt hàng</b></td>
                    </tr>
                    <tr>
                        <td>Số lượng: &nbsp;</td>
                        <td><input type="number" name="quantity" size="2" style="width:30px;" value="1"/>&nbsp; cái</td>
                    </tr>
                    <tr>
                        <td><input class="btn_active" type="submit" name="submitorder" value="Thêm vào giỏ hàng"></td>
                    </tr>
                    
                            
                     
                </table>
            </form>
                                    </div>
                    <fieldset id="article">
                                <legend>Bài viết</legend>
                                <p class="article"><%if(productview.getArticle()!=null){
                                out.print(productview.getArticle());
                        }else{out.print("Sản phẩm giá tốt");}%></p>
                            </fieldset>
                    <div class="classfix"></div>
                    <div class="fb-comments" data-href="http://dodep.tk" data-numposts="5" data-colorscheme="light"></div>
				</div>
                    
				<div class="bottom-content-box">
                                    
                                </div>
                               
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