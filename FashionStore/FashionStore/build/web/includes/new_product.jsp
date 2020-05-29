

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!--<link rel="stylesheet" href="css/tinycarousel.css" type="text/css">
<script type="text/javascript" src="js/jquery.tinycarousel.js"></script>-->
	<script type="text/javascript">
		$(document).ready(function()
		{
			$('#slider2').tinycarousel({ interval: true });
                        var slider2 = $("#slider2").data("plugin_tinycarousel");
                         slider2.start();
		});
	</script>
        
<div class="right-content-box">
   <div class="top-right-content-box">Sản phẩm mới</div>
                        <div class="middle-right-content-box">
                                               <div id="slider2">
		<!--<a class="buttons prev" href="#">&#60;</a>-->
		<div class="viewport">
			<ul class="overview">
                           
                                <%
                                    Hashtable newproducts = productDAO.selectNewFood();
                                    Enumeration enumnewproducts = newproducts.elements();
                                    while (enumnewproducts.hasMoreElements()) {
                                        Product product = (Product) enumnewproducts.nextElement();
                                %>
                                <li><a href="productdetail.jsp?productid=<%=product.getId()%>">
                                            <img src="images_data/thoitrangbegai_thumb/<%=product.getImage()%>" width="120" height="150"/>
                                        </a></li>
                                        <% }%>
                            </ul>
                  </div>
		<!--<a class="buttons next" href="#">&#62;</a>-->
	</div>
                        </div>
                        <div class="bottom-right-content-box"></div>
   </div>

                            
    