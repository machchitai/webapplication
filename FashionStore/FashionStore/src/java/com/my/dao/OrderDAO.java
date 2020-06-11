/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.my.dao;

import com.my.bean.ProductOrder;
import com.my.bean.OrderCart;
import com.my.common.Common;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Enumeration;
import java.util.Hashtable;

/**
 *
 * @author vivtory
 */
public class OrderDAO {
    private Connection conn;
    public OrderDAO() {}
    
    public Hashtable selectAllOrder(){
        Hashtable orders=new Hashtable();
        String query = "SELECT * FROM `order`";
        conn = new Common().getDBConnection();
        try{
            Statement st = conn.createStatement();
            ResultSet rs = st.executeQuery(query);
            while(rs.next()){
                OrderCart order = new OrderCart(rs.getString(1), 
                        rs.getString(2), rs.getDate(3), rs.getLong(4));
                orders.put(order.getId(), order);
            }
            conn.close();
        }catch(Exception e){
            e.printStackTrace();
        }
        return orders;
    }
    public Hashtable selectOrderDetailByOrderID(String orderID){
        Hashtable orderDetails=new Hashtable();
        String query = "SELECT a.*, b.price FROM orderdetail a, product b WHERE orderid=? AND a.productid=b.id";
        conn = new Common().getDBConnection();
        try{
            CallableStatement cs = conn.prepareCall(query);
            cs.setString(1, orderID);
            ResultSet rs = cs.executeQuery();
            while(rs.next()){
                ProductOrder fo = new ProductOrder(rs.getString(1), rs.getString(2), rs.getInt(3), rs.getInt(6), rs.getLong(4));
                orderDetails.put(fo.getFoID(), fo);
            }
            conn.close();
        }catch(Exception e){
            e.printStackTrace();
        }
        return orderDetails;
    }
    public boolean checkoutOrder(OrderCart oc){
        int result;
        String query = "INSERT INTO `order`(customerid,shiptime,totalprice) VALUES(?,?,?)";
        conn = new Common().getDBConnection();
        try{
            CallableStatement cs = conn.prepareCall(query);
            cs.setString(1, oc.getCustomer().getId());
            cs.setString(2, oc.getShiptimeString());
            cs.setLong(3, oc.getTotalprice());
            result = cs.executeUpdate();
            conn.close();
            
            String orderid = selectOrderID(oc.getCustomer().getId(), oc.getShiptimeString());
            
            result = addOrderDetail(oc.getFoodOrderEnum(), orderid);
            
            if(result==1)   return true;
        }catch(Exception e){
            e.printStackTrace();
            return false;
        }
        return false;
    }
    private int addOrderDetail(Enumeration productorders, String orderid){
        int result=0;
        String query = "INSERT INTO orderdetail(productid,quantity,price,orderid) VALUES(?,?,?,?)";
        conn = new Common().getDBConnection();
        try{
            while(productorders.hasMoreElements()){
                ProductOrder fo = (ProductOrder)productorders.nextElement();
                CallableStatement cs = conn.prepareCall(query);
                cs.setString(1, fo.getId());
                cs.setInt(2, fo.getQuantity());
                cs.setLong(3, fo.getTotalprice());
                cs.setString(4, orderid);
            
                result = cs.executeUpdate();
            }
        }catch(Exception e){
            e.printStackTrace();
            return result;
        }
        return result;
    }
    
    public boolean deleteOrderDetail(String orderdetailID){
        String query = "DELETE FROM orderdetail WHERE id=?";
        conn = new Common().getDBConnection();
        try{
            CallableStatement cs = conn.prepareCall(query);
            cs.setString(1, orderdetailID);
            int result = cs.executeUpdate();
            conn.close();
            if(result==1) return true;
        }catch(Exception e){
            e.printStackTrace();
            return false;
        }
        return false;
    }
    
    public boolean deleteOrder(String orderID){
        String query = "DELETE FROM fashionstore.order WHERE id=?";
        conn = new Common().getDBConnection();
        try{
            CallableStatement cs = conn.prepareCall(query);
            cs.setString(1, orderID);
            int result = cs.executeUpdate();
            conn.close();
            if(result==1) return true;
        }catch(Exception e){
            e.printStackTrace();
            return false;
        }
        return false;
    }
    private String selectOrderID(String cusID, String shiptime){
        String orderid = null;
        String query = "SELECT id FROM `order` WHERE customerid=? AND shiptime=?";
        conn = new Common().getDBConnection();
        try{
            CallableStatement cs = conn.prepareCall(query);
            cs.setString(1, cusID);
            cs.setString(2, shiptime);
            ResultSet rs = cs.executeQuery();
            if(rs.next())
                orderid = rs.getString(1);
            conn.close();
        }catch(Exception e){
            e.printStackTrace();
        }
        return orderid;
    }
    
}
