<%-- 
    Document   : sidebar_left
    Created on : Jun 29, 2014, 10:18:04 PM
    Author     : thanhlam
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>


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