

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, com.my.bean.*, com.my.dao.*" %>
<%
    String message = (String)request.getAttribute("message");
    
    String cusID = (String)request.getParameter("cusid");
    String npage = (String)request.getParameter("page");
    int pagenumb = 1;
    
    if(message==null)   message="";
    if(cusID!=null)     session.setAttribute("cusid", cusID);
    if(npage!=null)     pagenumb = Integer.parseInt(npage);
    
    CustomerDAO cusDAO = new CustomerDAO();
   %>     
    <script type="text/javascript">
    function confirm_decision(cus_id){
    if(confirm("you want to delete the user?")) // this will pop up confirmation box and if yes is clicked it call servlet else return to page
     {
       window.location="customer.jsp?delcusid="+cus_id;
     }else{
       return false;
    }
 }
    
</script>
  <%  
    String delcusID = request.getParameter("delcusid");
    if(delcusID!=null){
        if(cusDAO.deleteCustomer(delcusID))
            message = "Delete completed!";
        else message = "Failed ! Try again";
    }
        
    Hashtable customers = cusDAO.selectAll();
    Enumeration enumcus = customers.elements();
%>
<style>
            *{
                font-family:"Open Sans",Arial,sans-serif!important;
            }
        </style>
<%@include file="admin_includes/admin_header.jsp" %>
	<div id="wrapper">
		<div class="admin-left-content">
			<div class="admin-left-content-box">
				<div class="admin-top-left-content-box">Khách hàng</div>
				<div class="admin-middle-left-content-box">
                                    
                                     
                                    
                                </div>
				<div class="admin-bottom-left-content-box"></div>
			</div>
                    
                   
                    
                    <div class="message">
                        <p><%=message %></p>
                    </div>
                    <a href="intropage.jsp">Thêm phần giới thiệu</a>
                </div>
                  <!--thanh viên-->  
                    
                  <!--end-->  
		<div align="center" class="content">
                    
			<div class="content-box">
				<div class="top-content-box"><div class="top-content-box-icon"></div>Danh sách Khách hàng</div>
				<div class="middle-content-box">
                <table border="1" class="admin_table" rowspacing="2">
                    <tr class="admin_table_header">
                        <td>ID</td>
                        <td>Tài Khoản</td>
                        <td>Họ Tên</td>
                        <td>Ngày Sinh</td>
                        <td>Địa chỉ</td>
                        <td>Số điện thoại</td>
                        <td>Số dư tài khoản (VNĐ)</td>
                        
                        <td>Chức năng</td>
                    </tr>
                    <%
                        while(enumcus.hasMoreElements()) {
                            Customer cus = (Customer)enumcus.nextElement();
                            
                    %>
                    <tr class="tr_hover">
                        <td> <%=cus.getId() %> </td>
                        <td> <%=cus.getUsername() %> </td>
                        <td> <%=cus.getFullname() %> </td>
                        <td> <%=cus.getBirthdayToString() %> </td>
                        <td> <%=cus.getAddress() %> </td>
                        <td> <%=cus.getPhonenumber() %> </td>
                        <td> <%=cus.getBalance()+",000" %> </td>
                         
                        
                        <td>
                            <a href="customer.jsp?cusid=<%=cus.getUsername() %>" title="Sửa bản ghi"><img src="images/icon/Modify.png" alt="Edit"/></a>
                            <a onclick="confirm_decision('<%=cus.getUsername()%>');" title="Xóa bản ghi"><img src="images/icon/Delete.png" alt="Delete"/></a>
                        </td>
                    </tr>
      <%
    }
%>
                </table>
				</div>
				<div class="bottom-content-box"></div>
			</div>
                <!--box thanh vien-->
                
		</div>
		
	</div>
	<%@include file="admin_includes/admin_footer.jsp" %>