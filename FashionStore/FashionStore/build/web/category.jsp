<%-- 
    Document   : index
    Created on : Nov 15, 2012, 11:41:30 PM
    Author     : vivtory
--%>


<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, com.my.bean.*, com.my.dao.*" %>

<%
    String message = (String)request.getAttribute("message");
    String catID = (String)request.getParameter("catid");
        
    if(message==null)   message="";
    if(catID!=null)     session.setAttribute("catid", catID);
    
    CategoryDAO catDAO = new CategoryDAO();
     %>
    <script type="text/javascript">
    function confirm_decision(cat_id){
    if(confirm("you want to delete the category?")) // this will pop up confirmation box and if yes is clicked it call servlet else return to page
     {
       window.location="category.jsp?delcatid="+cat_id;
     }else{
       return false;
    }
 }
    
</script>
        <%
    String delcatID = request.getParameter("delcatid");
    if(delcatID!=null){
        if(catDAO.deleteCategory(delcatID))
            message = "Delete completed!";
        else message = "Failed ! Try again";
    }
        
    Hashtable cats = catDAO.selectAll();
    Enumeration enumcats = cats.elements();
        
    Category editcat = null;
    if(catID!=null) 
        editcat = (Category)cats.get(catID);
%>
<%@include file="admin_includes/admin_header.jsp" %>

	<div id="wrapper">
		<div class="admin-left-content">
			<div class="admin-left-content-box">
				<div class="admin-top-left-content-box">Thêm Category</div>
				<div class="admin-middle-left-content-box">
                  <form action="UpdateCategoryServlet" name="addcat" method="post">
                    <table>
                        <% if(catID!=null) { %>
                        <tr>
                            <td>Category ID: &nbsp;</td>
                            <td><b><%=catID %></b></td>
                        </tr>
                        <% } %>
                        <tr>
                            <td>Category: &nbsp;</td>
                            <td><input class="textfield" type="text" name="catname" value="<% if(catID!=null) out.print(editcat.getName()); %>"/></td>
                        </tr>
                        <tr>
                            <td>Mô tả: &nbsp;</td>
                            <td><input class="textfield" type="textarea" name="catdescribes" rows="5" cols="20" value="<% if(catID!=null) out.print(editcat.getDescribes()); %>"/></td>
                        </tr>
                        <tr>
           <% 
                                if(catID!=null) {
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
				<div class="top-content-box"><div class="top-content-box-icon"></div>Danh sách Category</div>
				<div class="middle-content-box">
                <table class="admin_table" border="1" cellspacing="2">
                    <tr class="admin_table_header">
                        <td>id</td>
                        <td>Tên</td>
                        <td>Mô tả</td>
                        <td>Chức năng</td>
                    </tr>
                    <%
                        while(enumcats.hasMoreElements()) {
                            Category cat = (Category)enumcats.nextElement();
                    %>
                    <tr class="tr_hover">
                        <td> <%=cat.getId() %> </td>
                        <td> <%=cat.getName() %> </td>
                        <td> <%=cat.getDescribes() %> </td>
                        <td>
                            <a href="category.jsp?catid=<%=cat.getId() %>" title="chỉnh sửa"><img src="images/icon/Modify.png" alt="Edit"/></a>&nbsp;&nbsp;&nbsp;
                            <a onclick="confirm_decision('<%=cat.getId() %>');" title="xóa bản ghi"><img src="images/icon/Delete.png" alt="Delete"/></a>
                        </td>
                    </tr>
      <%
    }
%>
                </table>
				</div>
                
                
				<div class="bottom-content-box"></div>
			</div>
		</div>
		
	</div>
<%@include file="admin_includes/admin_footer.jsp" %>