
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, com.my.bean.*, com.my.dao.*" %>
<%
    String message = (String) request.getAttribute("message");
    String productID = (String) request.getParameter("productid");
    String npage = (String) request.getParameter("page");
    int pagenumb = 1;

    if (message == null) {
        message = "";
    }
    if (productID != null) {
        session.setAttribute("productid", productID);
    }
    if (npage != null) {
        pagenumb = Integer.parseInt(npage);
    }

    ProductDAO productDAO = new ProductDAO();

    String delproductID = request.getParameter("delproductid");
    if (delproductID != null) {
        if (productDAO.deleteFood(delproductID)) {
            message = "Delete completed!";
        } else {
            message = "Failed ! Try again";
        }
    }

    Hashtable products = productDAO.selectAll();
    Enumeration enumproducts = products.elements();

    CategoryDAO catDAO = new CategoryDAO();
    Hashtable cats = catDAO.selectAll();
    Enumeration enumcats = cats.elements();

    Product editproduct = null;
    if (productID != null) {
        editproduct = (Product) products.get(productID);
    }
%>
<%@include file="admin_includes/admin_header.jsp" %>
<script src="tinymce/tinymce.min.js"></script>
<style>
    *{
        font-family:"Open Sans",Arial,sans-serif!important;
    }
</style>
<script type="text/javascript">
    tinymce.init({
        fontsize_formats: "8pt 9pt 10pt 11pt 12pt 26pt 36pt",

        selector: "textarea",
        theme: "modern",
        width: 350,
        height: 300,
        plugins: [
            "advlist autolink link image lists charmap print preview hr anchor pagebreak spellchecker",
            "searchreplace wordcount visualblocks visualchars code fullscreen insertdatetime media nonbreaking",
            "save table contextmenu directionality emoticons template paste textcolor"
        ],
        content_css: "css/content.css",
        toolbar: "insertfile undo redo | styleselect | bold italic | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | l      ink image | print preview media fullpage | forecolor backcolor emoticons| undo redo pastetext | styleselect | fontselect | fontsizeselect",
        style_formats: [
            {title: 'Bold text', inline: 'b'},
            {title: 'Red text', inline: 'span', styles: {color: '#ff0000'}},
            {title: 'Red header', block: 'h1', styles: {color: '#ff0000'}},
            {title: 'Example 1', inline: 'span', classes: 'example1'},
            {title: 'Example 2', inline: 'span', classes: 'example2'},
            {title: 'Table styles'},
            {title: 'Table row 1', selector: 'tr', classes: 'tablerow1'}
        ]
    });
</script>
<script type="text/javascript">
    function confirm_decision(prod_id) {
        if (confirm("you want to delete the user?")) // this will pop up confirmation box and if yes is clicked it call servlet else return to page
        {
            window.location = "product.jsp?delproductid=" + prod_id;
        } else {
            return false;
        }
    }

</script>

<script type="text/javascript">
    $(document).ready(function () {
        checkAndUncheck();
    });
    function checkAndUncheck() {
        var checked = $(this).attr("checked");
        if (!checked)
            checked = "";
        $(".admin_table.admin_table_header td input:checkbox").attr("checked", checked);
    }

</script>
<div id="wrapper">
    <div class="admin-left-content">
        <div class="admin-left-content-box">
            <div class="admin-top-left-content-box">Thông tin sản phẩm</div>
            <div class="admin-middle-left-content-box">
                <form action="UpdateProductServlet" name="addproduct" method="post">
                    <table >
                        <% if (productID != null) {%>
                        <tr>
                            <td>Product ID: &nbsp;</td>
                            <td><b><%=productID%></b></td>
                        </tr>
                        <% } %>
                        <tr>
                            <td>Category: &nbsp;</td>
                            <td>
                                <select name="catselect" class="textfield">
                                    <%
                                        while (enumcats.hasMoreElements()) {
                                            Category cat = (Category) enumcats.nextElement();
                                            out.print("<option value='" + cat.getId() + "'");
                                            if (productID != null && editproduct.getCatID().equals(cat.getId())) {
                                                out.print(" selected");
                                            }
                                            out.println(">" + cat.getName() + "</option>");
                                        }
                                    %>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td>Tên: &nbsp;</td>
                            <td><input required="true" class="textfield" type="text" name="productname" value="<% if (productID != null) {
                                    out.print(editproduct.getName());
                                } %>"/></td>
                        </tr>
                        <tr>
                            <td>Mô tả: &nbsp;</td>
                            <td><input class="textfield" type="textarea" name="productdes" rows="3" cols="40" value="<% if (productID != null) {
                                    out.print(editproduct.getDescribes());
                                } %>"/></td>
                        </tr>
                        <tr>
                            <td>Đơn giá: &nbsp;</td>
                            <td><input required="true" class="textfield" type="number" name="productprice" value="<% if (productID != null) {
                                    out.print(editproduct.getPrice());
                                } %>"/>,000 VNĐ</td>
                        </tr>
                        <tr>
                            <td>Số lượng: &nbsp;</td>
                            <td><input required="true" class="textfield" type="number" name="prodQuantity" value="<% if (productID != null) {
                                    out.print(editproduct.getQuantity());
                                } %>"/> cái</td>
                        </tr>
                        <tr>
                            <td>Hình ảnh: &nbsp;</td>
                            <td>
                                <input class="textfield" type="text" name="productimage" id="filename" value="<% if (productID != null) {
                                        out.print(editproduct.getImage());
                                    } %>"/>
                                <input type="file" accept="image" name="imagefile" onchange="updateFilename(this.value)"/>
                            </td>
                        </tr>
                        <tr>

                            <td colspan="2">
                                <textarea class="textview" name="prodArticle" placeholder="Nhập nội dung bài viết ở đây"><%if (productID != null)
                                        out.print(editproduct.getArticle());%></textarea>
                            </td>
                        </tr>

                        <tr>
                            <%
                                if (productID != null) {
                                    out.print("<td><input class='btn_active' type='submit' name='btnedit' value='Cập nhật'/></td>");
                                    out.print("<td><input class='btn_active' type='submit' name='btncancel' value='Hủy'/></td>");
                                } else {
                                    out.print("<td><input class='btn_active' type='submit' name='btnadd' value='Thêm'/></td>");
                                    out.print("<td><input class='btn_active' type='reset' name='btnreset' value='Reset'/></td>");
                                }
                            %>
                        </tr>
                    </table>
                </form>
            </div>
            <div class="admin-bottom-left-content-box"></div>
        </div>
        <div class="message">
            <p><%=message%></p>
        </div>
    </div>
    <div align="center" class="content">

        <div class="content-box">
            <div class="top-content-box"><div class="top-content-box-icon"></div>Danh sách sản phẩm</div>
            <div class="middle-content-box">
                <table class="admin_table" border="1" cellspacing="2">
                    <tr class="admin_table_header">
                        <td><input type="checkbox" name="check_all" id="checkAll" title="select all"/></td>
                        <td>ID</td>
                        <td>Tên</td>
                        <td>Category</td>
                        <td>Mô tả</td>
                        <td>Giá(VNĐ)</td>
                        <td>Hình ảnh</td>
                        <td>Số lượng</td>
                        <td>Chức năng</td>
                    </tr>

                    <!--phan trang-->
                    <%
                        for (int i = 1; i <= (pagenumb - 1) * 5; i++) {
                            enumproducts.nextElement();
                        }
                        int productcount = 0;
                        while (enumproducts.hasMoreElements() && productcount < 5) {
                            Product product = (Product) enumproducts.nextElement();
                            Category cat = (Category) cats.get(product.getCatID());
                    %>


                    <tr class="tr_hover">
                        <td><input type="checkbox" name="check[]" id="check[]"/></td>
                        <td> <%=product.getId()%></td>
                        <td> <%=product.getName()%> </td>
                        <td> <%=cat.getName()%> </td>
                        <td> <%=product.getDescribes()%> </td>
                        <td> <%=product.getPriceToString()%> </td>
                        <td><img src="images_data/thoitrangbegai_thumb/<%=product.getImage()%>" height="100" width="100"/></td>
                        <td><%=product.getQuantity()%></td>
                        <td>
                            <a href="product.jsp?productid=<%=product.getId()%>" title="chỉnh sửa"><img src="images/icon/Modify.png" alt="Edit"/></a>&nbsp;
                            <a onclick="confirm_decision('<%=product.getId()%>');" title="xóa bản ghi"><img src="images/icon/Delete.png" alt="Delete"/></a>
                        </td>
                    </tr>

                    <%
                            productcount++;

                        }
                    %>
                    <% if (products.size() > 5) {  %>
                    <p>
                        <a style="border-radius: 2px;text-decoration: none;background-color: #dccfc6" href="<% if (pagenumb > 1) {
                            out.print("product.jsp?page=" + (pagenumb - 1));%>">Trang trước</a>&nbsp;
                        <% for (int i = 1; i <= products.size() / 6 + 1; i++) { %>
                        <a style="border-radius: 2px;text-decoration: none;background-color: #dccfc6;" href="<% if (pagenumb != i) {
                                    out.print("product.jsp?page=" + i);%>">
                            <% if (pagenumb == i)
                                    out.print("<strong>" + i + "</strong>");
                                else
                                    out.print(i);
                            %>
                        </a>&nbsp;
                        <% } %>
                        <a style="border-radius: 2px;text-decoration: none;background-color: #dccfc6" href="<% if (pagenumb < products.size() / 10 + 1) {
                            out.print("product.jsp?page=" + (pagenumb + 1));%>">Trang sau</a>&nbsp;
                    </p>
                    <% }%>
                </table>
            </div>
            <div class="bottom-content-box"></div>
        </div>
    </div>

</div>
<%@include file="admin_includes/admin_footer.jsp" %>


