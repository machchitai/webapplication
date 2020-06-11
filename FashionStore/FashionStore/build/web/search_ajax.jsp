<%-- 
    Document   : search_ajax
    Created on : Jul 4, 2014, 10:28:16 AM
    Author     : KVH
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="com.my.bean.Product"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.my.common.Common"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
        Connection conn=new Common().getDBConnection();
        String sql="select name from food";
        PreparedStatement ps=conn.prepareStatement(sql);
        ResultSet rs=ps.executeQuery();
        
        ArrayList<Product> list=new ArrayList<Product>();
        Gson gson=new Gson();
        String json=null;
        while(rs.next()){
            Product prod=new Product();
            prod.setName(rs.getString("name"));
            list.add(prod);
            json=gson.toJson(list);
        }
        out.print(""+json);
        %>
        
    </body>
</html>
