<%-- 
    Document   : admin_header
    Created on : Jul 2, 2014, 4:10:58 PM
    Author     : KVH
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="style.css" rel="stylesheet" type="text/css" />
        <title>JSP Page</title>
        <script type="text/javascript" src="js/jquery-1.10.2.min.js"></script>
        <script>
            function extractFilename(path) { 
                var name;
                var x;
                x = path.lastIndexOf('\\');
                if (x >= 0) // Windows-based path
                    return path.substr(x+1);
                x = path.lastIndexOf('/');
                if (x >= 0) // Unix-based path
                    return path.substr(x+1);
                return path; // just the filename
            }
            function updateFilename(path) {
                var name = extractFilename(path);
                document.getElementById('filename').value = name;
            }
        </script>
        <script type="text/javascript" src="js/jquery.carouFredSel-6.2.1-packed.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		$('#foo1').carouFredSel({
					auto: {
						pauseOnHover: 'resume',
						progress: '#timer1'
					}
				}, {
					transition: true
				});
	});
		
	</script>
        <script type="text/javascript">
            $(document).ready(function(){
                checkAndUncheck();
            });
            function checkAndUncheck(){
                var checked=$(this).attr("checked");
                if(!checked) checked="";
                $(".admin_table.tr_hover td input:checkbox").attr("checked",checked);
            }
            
        </script>
    </head>
    <body>
        <div align="center" id="main">
            <div align="center" id="container">
	<div id="header">
    	<div class="top-header"></div>
        <div align="center" class="menu">
            <ul style="margin-left: 0px;">
                <li><a href="category.jsp">Category</a></li>
                <li><a href="product.jsp">Product</a></li>
                <li><a href="customer.jsp">Customer</a></li>
                
                <li><a href="balancesource.jsp">Balance Source</a></li>
                <li><a href="order.jsp">Order</a></li>
                <li><a href="login.jsp?log=out">Logout</a></li>
            </ul>
        </div>
    </div>