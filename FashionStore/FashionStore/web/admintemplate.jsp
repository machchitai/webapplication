
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, com.my.bean.*, com.my.dao.*" %>
<%
    OrderDAO orderDAO = new OrderDAO();
    Hashtable orders = orderDAO.selectAllOrder();
    Enumeration enumorders = enumorders = orders.elements();
%>
<%@include file="admin_includes/admin_header.jsp" %>
<div id="wrapper">
    <div class="admin-left-content">
        <div class="admin-left-content-box">
            <div class="admin-top-left-content-box">Khách hàng</div>
            <div class="admin-middle-left-content-box">

            </div>
            <div class="admin-bottom-left-content-box"></div>
        </div>

    </div>
    <div align="center" class="content">

        <div class="content-box">
            <div class="top-content-box"><div class="top-content-box-icon"></div>Danh sách Khách hàng</div>
            <div class="middle-content-box">
                <table border="1" cellspacing="2">
                    <tr>
                        <td>ID</td>
                        <td>Mã khách hàng</td>
                        <td>Ngày đặt hàng</td>
                        <td>Tổng tiền (VNĐ)</td>
                        <td>Chi tiết</td>
                    </tr>
                    <%
                        while (enumorders.hasMoreElements()) {
                            OrderCart cart = (OrderCart) enumorders.nextElement();
                    %>
                    <tr>
                        <td> <%=cart.getId()%> </td>
                        <td> <%=cart.getCustomer().getId()%> </td>
                        <td> <%=cart.getShiptimeString()%> </td>
                        <td> <%=cart.getTotalpriceToString()%> </td>
                        <td>
                            <a href="orderdetail.jsp?orderid=<%=cart.getId()%>">chi tiết</a>
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
