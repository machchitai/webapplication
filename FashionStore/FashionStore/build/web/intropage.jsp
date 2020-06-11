<%-- 
    Document   : index
    Created on : Nov 15, 2012, 11:41:30 PM
    Author     : vivtory
--%>


<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, com.my.bean.*, com.my.dao.*" %>
<script src="tinymce/tinymce.min.js"></script>
<script type="text/javascript">
	tinymce.init({
    selector: "textarea",
    theme: "modern",
    width: 350,
    height: 150,
    plugins: [
         "advlist autolink link image lists charmap print preview hr anchor pagebreak spellchecker",
         "searchreplace wordcount visualblocks visualchars code fullscreen insertdatetime media nonbreaking",
         "save table contextmenu directionality emoticons template paste textcolor"
   ],
   content_css: "css/content.css",
   toolbar: "insertfile undo redo | styleselect | bold italic | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | l      ink image | print preview media fullpage | forecolor backcolor emoticons", 
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
<%
    String message = (String)request.getAttribute("message");
    String newID = (String)request.getParameter("newsid");
        
    if(message==null)   message="";
    if(newID!=null)     session.setAttribute("newsid", newID);
    
    NewsDAO newDAO = new NewsDAO();
        
    String delnewID = request.getParameter("delnewsid");
    if(delnewID!=null){
        if(newDAO.deleteNews(delnewID))
            message = "Delete completed!";
        else message = "Failed ! Try again";
    }
        
    Hashtable news =newDAO.selectAll();
    Enumeration enumcats = news.elements();
        
    News editnew = null;
    if(newID!=null) 
        editnew = (News)news.get(newID);
%>



<%@include file="admin_includes/admin_header.jsp" %>
<script src="js/jquery-ui.js"></script>
<link rel="stylesheet" href="css/jquery-ui.css">

 <script>
$(function() {
$( "#datepicker" ).datepicker();
});
</script>
	<div id="wrapper">
		<div class="admin-left-content">
			<div class="admin-left-content-box">
				<div class="admin-top-left-content-box">Thêm Bài viết</div>
				<div class="admin-middle-left-content-box">
                  <form action="UpdateNewsServlet" name="addNews" method="post">
                    <table>
                        <% if(newID!=null) { %>
                        <tr>
                            <td>News ID: &nbsp;</td>
                            <td><b><%=newID %></b></td>
                        </tr>
                        <% } %>
                        <tr>
                            <td>Title: &nbsp;</td>
                            <td><input class="textfield" type="text" name="newsTitle" value="<% if(newID!=null) out.print(editnew.getTitle()); %>"/></td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <textarea class="textview" name="newsContent" placeholder="Nhập nội dung bài viết ở đây"><% if(newID!=null) out.print(editnew.getContent()); %></textarea>
                            </td>
                        </tr>
                        <tr>
                            <td>publicDate: &nbsp;</td>
                            <td><input id="datepicker" class="textfield" type="text" name="newsDate" value="<% if(newID!=null) out.print(editnew.getCreateddate()); %>"/></td>
                        </tr>
                        
                         
                        <tr>
           <% 
                                if(newID!=null) {
                                    out.print("<td><input class='btn_active' type='submit' name='btnedit' value='Cập nhật'/></td>");
                                    out.print("<td><input class='btn_active' type='submit' name='btncancel' value='Hủy'/></td>");
                                }
                                else {
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
                            <p style="color: #04cf61;font-size: 16px;"><%=message %></p>
                        </div>
                </div>
		<div align="center" class="content">
                    
			<div class="content-box">
				<div class="top-content-box"><div class="top-content-box-icon"></div>Danh sách bài viết</div>
				<div class="middle-content-box">
                <table class="admin_table" border="1" cellspacing="2">
                    <tr class="admin_table_header">
                        <td>id</td>
                        <td>Tiêu đề</td>
                        <td>Nội dung</td>
                        <td>Ngày viết</td>
                        <td>Chức năng</td>
                        
                    </tr>
  
        <%
                        while(enumcats.hasMoreElements()) {
                            News listnew = (News)enumcats.nextElement();
                    %>
            <tr class="tr_hover">
                <td><%=listnew.getId()%></td>
                <td><%=listnew.getTitle()%></td>
                <td><%=listnew.getContent()%></td>
                <td><%=listnew.getCreateddate()%></td>
                        <td>
                            <a href="intropage.jsp?newsid=<%=listnew.getId()%>" title="chỉnh sửa"><img src="images/icon/Modify.png" alt="Edit"/></a>&nbsp;&nbsp;&nbsp;
                            <a href="intropage.jsp?delnewsid=<%=listnew.getId()%>" title="xóa bản ghi"><img src="images/icon/Delete.png" alt="Delete"/></a>
                        </td>
            </tr>     
    <%}%>
                </table>
				</div>
                
                
				<div class="bottom-content-box"></div>
                                <div id="phan_trang">
                                    <ul id="phan_trang">
                    <c:if test="${currentPage !=1}">
                        <li> <a href="category_1?page=${currentPage-1}"><img src="images/icon/Back.png" alt="previous"/></a></li>
                    </c:if>
                        <c:forEach begin="1" end="${noOfPages}" var="i">
                            <c:choose>
                                <c:when test="${currentPage eq i}">
                            <li> <a><img src="images/icon/${i}.png"/></a></li>
                                </c:when>
                                <c:otherwise>
                                
                                <li> <a href="category_1?page=${i}"><img src="images/icon/${i}.png"/></a></li>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>
                                <c:if test="${currentPage==1}">
                                <li> <a href="category_1?page=${currentPage+1}"><img src="images/icon/Next.png" alt="next"/></a></li>
                                </c:if>
                    
                                    </ul>
                </div>
			</div>
		</div>
		
	</div>
<%@include file="admin_includes/admin_footer.jsp" %>