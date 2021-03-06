
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, com.my.bean.*, com.my.dao.*" %>
<%
    Customer cus = (Customer) session.getAttribute("customer");
    ProductDAO productDAO = new ProductDAO();
    CategoryDAO catDAO = new CategoryDAO();
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="style.css" rel="stylesheet" type="text/css" />
        <title>Giới thiệu</title>
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
                                    <div class="top-content-box"><div class="top-content-box-icon"></div>THE WORLD-Sống phong cách!</div>
                                    <div class="middle-content-box">
                                        Chào mừng bạn đến với FASHIONISTA, nguồn số một của bạn cho tất cả các nguồn thời trang. Chúng tôi dành riêng để cung cấp cho bạn những bộ quần áo mới tốt nhất, chú trọng vào trang phục nam, quần áo nữ và phong cách trẻ em.


<br> <br> <br> Được thành lập vào năm 2020 bởi những người sáng tạo, FASHIONISTA đã đi một chặng đường dài từ khi bắt đầu ở thành phố Hồ Chí Minh. Khi Người sáng tạo lần đầu tiên bắt đầu, niềm đam mê của họ đối với [thông điệp thương hiệu - ví dụ: "Sản phẩm làm sạch thân thiện với môi trường"] đã thúc đẩy họ bắt đầu kinh doanh riêng.


<br> <br> <br> Chúng tôi hy vọng bạn thích sản phẩm của chúng tôi nhiều như chúng tôi thích cung cấp chúng cho bạn. Nếu bạn có bất kỳ câu hỏi hoặc ý kiến, xin vui lòng liên hệ với chúng tôi.


<br> <br> Trân trọng,

<br> <br> Admins
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
