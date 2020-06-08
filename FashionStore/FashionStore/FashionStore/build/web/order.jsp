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
    OrderDAO orderDAO = new OrderDAO();
    Hashtable orders = orderDAO.selectAllOrder();
    Enumeration enumorders = orders.elements();
    Hashtable productOrders = new Hashtable();
    Enumeration enumfos = productOrders.elements();
        
    String delorderID = (String)request.getParameter("delorderid");
    String orderID = (String)request.getParameter("orderid");
    if(delorderID!=null){
       if( orderDAO.deleteOrder(delorderID)) message = "Delete completed!";
        else message = "Failed ! Try again";
    }
    if(orderID!=null){
        productOrders = orderDAO.selectOrderDetailByOrderID(orderID);
        enumfos = productOrders.elements();
    }
%>
<%@include file="admin_includes/admin_header.jsp" %>
<style>
            *{
                font-family:"Open Sans",Arial,sans-serif!important;
            }
        </style>
	<div id="wrapper">
		<div class="admin-left-content">
			<div class="admin-left-content-box">
				<div class="admin-top-left-content-box">Thông tin đơn hàng</div>
				<div class="admin-middle-left-content-box">
                      <% if(orderID!=null) {  %>
               <table width="380">
                   <tr class="admin_table_header">
                        <td>ID</td>
                        <td>Mã sản phẩm</td>
                        <td>Số lượng</td>
                        <td>Đơn giá (VNĐ)</td>
                        <td>Tổng tiền (VNĐ)</td>
                    </tr>
                    <%
                        while(enumfos.hasMoreElements()) {
                            ProductOrder fo = (ProductOrder)enumfos.nextElement();
                    %>
                    <tr class="tr_hover">
                        <td> <%=fo.getFoID() %> </td>
                        <td> <%=fo.getId() %> </td>
                        <td> <%=fo.getQuantity() %> </td>
                        <td> <%=fo.getPriceToString() %> </td>
                        <td> <%=fo.getTotalPriceToString() %> </td>
                    </tr>
      <%
    }
%>
                </table>
                      <% } %>
                                </div>
				<div class="admin-bottom-left-content-box"></div>
			</div>
			
                </div>
		<div align="center" class="content">
                    
			<div class="content-box">
				<div class="top-content-box"><div class="top-content-box-icon"></div>Danh sách Đơn hàng</div>
				<div class="middle-content-box">
                <table class="admin_table" border="1" cellspacing="2">
                    <tr class="admin_table_header">
                        <td>ID</td>
                        <td>Mã khách hàng</td>
                        <td>Ngày đặt hàng</td>
                        <td>Tổng tiền (VNĐ)</td>
                        <td>Chi tiết</td>
                    </tr>
                    <%
                        while(enumorders.hasMoreElements()) {
                            OrderCart cart = (OrderCart)enumorders.nextElement();
                    %>
                    <tr class="tr_hover">
                        <td> <%=cart.getId() %> </td>
                        <td> <%=cart.getCustomer().getId() %> </td>
                        <td> <%=cart.getShiptimeString() %> </td>
                        <td> <%=cart.getTotalpriceToString() %> </td>
                        <td>
                            <a title="Xem chi tiết" href="order.jsp?orderid=<%=cart.getId() %>"><img src="images/icon/Actions-view-pim-tasks-icon.png"/></a>
                            <a title="Xóa bản ghi" href="order.jsp?delorderid=<%=cart.getId()%>"><img src="images/icon/Delete.png" alt="Delete"/></a>
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
<%@include file="includes/footer.jsp" %>
