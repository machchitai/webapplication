
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<div class="top-content-box"><div class="top-content-box-icon"></div>Sản phẩm được yêu thích</div>
                        <div class="middle-content-box">
                            <ul id="show_product">
                                <%
                                    Hashtable hotproducts = productDAO.selectSixHotFood();
                                    Enumeration enumhotproducts = hotproducts.elements();
                                    int count = 0;
                                    while (enumhotproducts.hasMoreElements()) {
                                        Product product = (Product) enumhotproducts.nextElement();
                                        if (count % 3 == 0) {
                                            out.print("<tr>");
                                        }
                                %>
                                <li>
                                    <a href="productdetail.jsp?productid=<%=product.getId()%>">
                                        <img src="images_data/thoitrangbegai_thumb/<%=product.getImage()%>" width="150" height="100"/>
                                    </a><br>
                                    <p><b><%=product.getPriceToString() + " VNĐ"%></b></p>
                                </li>
                                <%        count++;
                                        if (count % 3 == 0 || !enumhotproducts.hasMoreElements()) {
                                            out.print("</tr>");
                                        }
                                    }
                                %>
                            </ul>
                        </div>
                        <div class="bottom-content-box"></div>
