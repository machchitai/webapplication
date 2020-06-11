<%-- 
    Document   : search_box
    Created on : Jul 2, 2014, 2:26:11 PM
    Author     : KVH
--%>

<%@page import="java.util.Enumeration"%>
<%@page import="java.util.Hashtable"%>
<%@page import="com.my.bean.Category"%>
<%@page import="com.my.dao.CategoryDAO"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<script type="text/javascript">
    $(document).ready(function(){
        $('#search_tenhang').autocomplete({
            source: function(require,response){
                $.ajax({
                    url:'search_ajax.jsp',
                    dataType:"json",
                    data:{
                        name_startsWith:request.term,
                        type:'name'
                    },
                    success:function(data){
                        response($.map(data,function(item){
                            return {
                                label:item,
                                value:item
                            };
                        }));
                    }
                });
            },
            autoFocus:true,
            minLength:0
        });
    });
</script>
<div class="top-right-content-box">Tìm kiếm</div>
                        <div class="middle-right-content-box">
                            <form id="search_tenhang" name="searchproduct" action="SearchProductServlet" method="post">
                                <table>
                                    <tr><td colspan="2"><input class="textfield_search" type="text" name="searchkey" placeholder="Tìm tên sản phẩm"></td></tr>
                                    <tr>
                                        <td colspan="2">
                                            <select name="category_name">
                                            <%
                                            CategoryDAO dao=new CategoryDAO();
                                           Hashtable list=dao.selectAll();
                                           Enumeration listcat=list.elements();
                                           while(listcat.hasMoreElements()){
                                               Category cat=(Category)listcat.nextElement();
                                           
                                            %>
                                            
                                            <option value="<%=cat.getId()%>"><%=cat.getName()%></option>
                                                <%}%>
                                            </select>
                                        </td>
                                    </tr>
                                    <tr><td>
                                            <select name="price_from">
                                                <option value="100">100</option>
                                                <option value="300">300</option>
                                                <option value="500">500</option>
                                                <option value="700">700</option>
                                                
                                                
                                            </select> &ShortRightArrow;
                                        </td>
                                        <td>
                                            <select name="price_to">
                                                <option value="300">300</option>
                                                <option value="500">500</option>
                                                <option value="700">700</option>
                                                <option value="900">900</option>
                                                
                                            </select>,000 VND
                                        </td>
                                    </tr>
                                    <tr><td colspan="2"><center><input class="btn_active_search" type="submit" name="btnsearch" value="Tìm kiếm"></center></td></tr>
                                </table>
                            </form>
                        </div>
                        <div class="bottom-right-content-box"></div>