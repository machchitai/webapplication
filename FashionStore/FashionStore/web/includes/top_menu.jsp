

<%@page contentType="text/html" pageEncoding="UTF-8"%>

          <div id="header">
                <div class="top-header"></div>
                <div align="center" class="menu">
                    <% if (cus == null || cus.getRole().equals("1")) { %>
                    <ul style="margin-left: 150px;">
                        <li><a href="index.jsp">Trang chủ</a></li>
                        <li><a href="intro.jsp">Giới thiệu</a></li>
                        <li><a href="login.jsp">Đăng nhập</a></li>
                        <li><a href="register.jsp">Đăng ký</a></li>
                    </ul>
                    <% } else { %>
                    <ul style="margin-left: 80px;">
                        <li><a href="index.jsp">Trang chủ</a></li>
                        <li><a href="customerinfo.jsp">Khách hàng</a></li>
                        <li><a href="buybalance.jsp">Nạp tiền</a></li>
                        <li><a href="ordercart.jsp">Giỏ hàng</a></li>
                        <li><a href="login.jsp?log=out">Đăng xuất</a></li>
                    </ul>
                    <% } %>
                </div>
            </div>