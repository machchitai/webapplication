<%-- 
    Document   : index
    Created on : Nov 15, 2012, 11:41:30 PM
    Author     : vivtory
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, com.my.bean.*, com.my.dao.*" %>
<%
    String message = (String)request.getAttribute("message");
    String bSource = (String)request.getParameter("bsource");
        
    if(message==null)   message="";
    if(bSource!=null)     session.setAttribute("bSource", bSource);
    
    BalanceSourceDAO bsDAO = new BalanceSourceDAO();
     %>
    <script type="text/javascript">
    function confirm_decision(bsource_id){
    if(confirm("you want to delete the balance source?")) // this will pop up confirmation box and if yes is clicked it call servlet else return to page
     {
       window.location="balancesource.jsp?delbsource="+bsource_id;
     }else{
       return false;
    }
 }
    
</script>
        <%
    String delbSource = request.getParameter("delbsource");
    if(delbSource!=null&&bsDAO.deleteBalanceSource(delbSource))
        message = "Delete completed!";
    else  if(delbSource!=null)  message = "Failed ! Try again";
       
    Hashtable balances = bsDAO.selectAll();
    Enumeration enumbalances = balances.elements();
        
    BalanceSource editbalance = null;
    if(bSource!=null) 
        editbalance = (BalanceSource)balances.get(bSource);
            
    
%>
<%@include file="admin_includes/admin_header.jsp" %>
	<div id="wrapper">
		<div class="admin-left-content">
			<div class="admin-left-content-box">
				<div class="admin-top-left-content-box">Thêm Thẻ nạp tiền</div>
				<div class="admin-middle-left-content-box">
                  <form action="UpdateBalanceSourceServlet" name="updateBalanceSource" method="post">
                    <table>
                        
                        <tr>
                            <td>Mã: &nbsp;</td>
                            <td>
                       <% if(bSource!=null) { %>
                                <b><%=bSource %></b>
                        <% } else { %>
                                <input class="textfield" required="true" type="text" name="bSource">
                        <% } %>
                            </td>
                        </tr>
                        <tr>
                            <td>Giá trị: &nbsp;</td>
                            <td><input required="true" class="textfield" type="text" name="price" value="<% if(bSource!=null) out.print(editbalance.getPrice()); %>"/>&nbsp;,000 VNĐ</td>
                        </tr>
                        <tr>
                            <td>Mô tả: &nbsp;</td>
                            <td><input class="textfield" type="textarea" name="describes" rows="5" cols="20" value="<% if(bSource!=null) out.print(editbalance.getDescribes()); %>"/></td>
                        </tr>
                        <tr>
                            <td>Sử dụng: &nbsp;</td>
                            <td>
                                <select required="true" name="available" class="textfield">
                                    <option value="0" <% if(bSource!=null && editbalance.getAvailable()==0) out.print("selected"); %> >0</option>
                                    <option value="1" <% if(bSource!=null && editbalance.getAvailable()==1) out.print("selected"); %>>1</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
           <% 
                                if(bSource!=null) {
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
                            <p><%=message %></p>
                        </div>
                </div>
		<div align="center" class="content">
                    
			<div class="content-box">
				<div class="top-content-box"><div class="top-content-box-icon"></div>Danh sách Thẻ nạp</div>
				<div class="middle-content-box">
                <table class="admin_table" border="1" cellspacing="2">
                    <tr class="admin_table_header">
                        <td>Mã</td>
                        <td>Giá trị (VNĐ)</td>
                        <td>Mô tả</td>
                        <td>Sử dụng</td>
                        <td>Chức năng</td>
                    </tr>
                    <%
                        while(enumbalances.hasMoreElements()) {
                            BalanceSource balance = (BalanceSource)enumbalances.nextElement();
                    %>
                    <tr class="tr_hover">
                        <td> <%=balance.getSource() %> </td>
                        <td> <%=balance.getPrice()+",000" %> </td>
                        <td> <%=balance.getDescribes() %> </td>
                        <td> <%=balance.getAvailable() %> </td>
                        <td>
                            <a href="balancesource.jsp?bsource=<%=balance.getSource() %>"title="chỉnh sửa"><img src="images/icon/Modify.png" alt="Edit"/></a>&nbsp;&nbsp;
                            <a onclick="confirm_decision('<%=balance.getSource() %>');" title="xóa bản ghi"><img src="images/icon/Delete.png" alt="Delete"/></a>
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