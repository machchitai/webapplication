/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.my.dao;

import com.my.bean.Product;
import com.my.common.Common;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Hashtable;
import java.util.List;
import java.util.StringTokenizer;

public class ProductDAO {
    private Connection conn;
    private int noOfRecords;
    public ProductDAO() {}
    
    public Hashtable selectAll(){
        Hashtable products = new Hashtable();
        String query = "Select * From product order by id asc";
        conn = new Common().getDBConnection();
        try{
            Statement st = conn.createStatement();
            ResultSet rs = st.executeQuery(query);
            while(rs.next()){
                Product product = new Product(rs.getString(1), rs.getString(2), 
                        rs.getString(3), rs.getString(4), rs.getInt(5), rs.getString(6),rs.getInt(7),rs.getString(8));
                products.put(product.getId(), product);
            }
            conn.close();
        }catch(Exception e){
            e.printStackTrace();
        }
        return products;
    }
    public Hashtable selectAllCatID(String catID){
        Hashtable products = new Hashtable();
        String query = "Select * From product WHERE categoryid=?";
        conn = new Common().getDBConnection();
        try{
            CallableStatement cs = conn.prepareCall(query);
            cs.setString(1, catID);
            ResultSet rs = cs.executeQuery();
            while(rs.next()){
                Product product = new Product(rs.getString(1), rs.getString(2), 
                        rs.getString(3), rs.getString(4), rs.getInt(5), rs.getString(6),rs.getInt(7),rs.getString(8));
                products.put(product.getId(), product);
            }
            conn.close();
        }catch(Exception e){
            e.printStackTrace();
        }
        return products;
    }
    public ArrayList<Product> getRelatedProducts(String catName){
        ArrayList<Product> list=new ArrayList<Product>();
        
        return list;
    }
    public Hashtable selectSixHotFood(){
        Hashtable products = new Hashtable();
        String query = "Select * From product WHERE id IN "
                + "(SELECT productid FROM orderdetail GROUP BY productid ORDER BY SUM(quantity) DESC)";
        conn = new Common().getDBConnection();
        try{
            Statement st = conn.createStatement();
            ResultSet rs = st.executeQuery(query);
            while(rs.next() && products.size()<6){
                Product product = new Product(rs.getString(1), rs.getString(2), 
                        rs.getString(3), rs.getString(4), rs.getInt(5), rs.getString(6),rs.getInt(7),rs.getString(8));
                products.put(product.getId(), product);
            }
            conn.close();
        }catch(Exception e){
            e.printStackTrace();
        }
        return products;
    }
    
    public ArrayList<Product> searchAdvanced(String prod_cat,String prod_name,int prod_pricefrom,int prod_priceto){
        ArrayList<Product> products=new ArrayList<Product>();
        conn=new Common().getDBConnection();
        
        try {
            
            CallableStatement cs=conn.prepareCall("{call search_advanced(?,?,?,?)}");
            cs.setString(1, prod_cat);
           cs.setString(2, "%"+prod_name+"%");
            cs.setInt(3, prod_pricefrom);
           cs.setInt(4, prod_priceto);
            ResultSet rs=cs.executeQuery();
            while (rs.next()) {                
                Product product=new Product(rs.getString("id"),rs.getString("categoryid"), rs.getString("name"), rs.getString("describes"), rs.getInt("price"),
                        rs.getString("image"),rs.getInt("quantity"));
                products.add(product);
            }
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return products;
    }
    public Hashtable searchForName(StringTokenizer keys){
        Hashtable products = new Hashtable();
        String query = "Select * From product WHERE LOWER(describes) LIKE ?";
        for(int i=1;i<=keys.countTokens();i++){
            query += " OR LOWER(describes) LIKE ?";
        }
        conn = new Common().getDBConnection();
        try{
            CallableStatement cs = conn.prepareCall(query);
            int i=1;
            while(keys.hasMoreTokens()){
                cs.setString(i, "%"+keys.nextToken().toLowerCase()+"%");
                i++;
            }
            ResultSet rs = cs.executeQuery();
            while(rs.next()){
                Product product = new Product(rs.getString(1), rs.getString(2), rs.getString(3), rs.getInt(4), rs.getString(5), rs.getInt(6));
                products.put(product.getId(), product);
            }
            conn.close();
        }catch(Exception e){
            e.printStackTrace();
        }
        return products;
    }
    public Hashtable selectNewFood(){
        Hashtable products = new Hashtable();
        String query = "Select * From product WHERE LOWER(describes) LIKE '%new%'";
        conn = new Common().getDBConnection();
        try{
            Statement st = conn.createStatement();
            ResultSet rs = st.executeQuery(query);
            while(rs.next() && products.size()<4){
                Product product = new Product(rs.getString(1), rs.getString(2), 
                        rs.getString(3), rs.getString(4), rs.getInt(5), rs.getString(6),rs.getInt(7),rs.getString(8));
                products.put(product.getId(), product);
            }
            conn.close();
        }catch(Exception e){
            e.printStackTrace();
        }
        return products;
    }
    public Hashtable selectTodayFood(){
        Hashtable products = new Hashtable();
        String query = "Select * From product WHERE id IN "
                + "(SELECT productid FROM orderdetail WHERE orderid IN "
                + "(SELECT id FROM `order` WHERE date(shiptime)=curdate()))";
        conn = new Common().getDBConnection();
        try{
            Statement st = conn.createStatement();
            ResultSet rs = st.executeQuery(query);
            while(rs.next() && products.size()<4){
                Product product = new Product(rs.getString(1), rs.getString(2), 
                        rs.getString(3), rs.getString(4), rs.getInt(5), rs.getString(6),rs.getInt(7),rs.getString(8));
                products.put(product.getId(), product);
            }
            conn.close();
        }catch(Exception e){
            e.printStackTrace();
        }
        return products;
    }
    public Product selectByID(String productID){
        Product product = null;
        String query = "SELECT * FROM product WHERE id=?";
        conn = new Common().getDBConnection();
        try{
            CallableStatement cs = conn.prepareCall(query);
            cs.setString(1, productID);
            ResultSet rs = cs.executeQuery();
            if(rs.next()){
                product = new Product(rs.getString(1), rs.getString(2),
                        rs.getString(3), rs.getString(4), rs.getInt(5), rs.getString(6),rs.getInt(7),rs.getString(8));
            }
            conn.close();
        }catch(Exception e){
            e.printStackTrace();
        }
        return product;
    }
    
    public boolean addFood(Product product){
        String query = "Insert Into product(categoryid,name,describes,price,image,quantity,article) VALUES(?,?,?,?,?,?,?)";
        conn = new Common().getDBConnection();
        try{
            CallableStatement cs = conn.prepareCall(query);
            cs.setString(1, product.getCatID());
            cs.setString(2, product.getName());
            cs.setString(3, product.getDescribes());
            cs.setInt(4, product.getPrice());
            cs.setString(5, product.getImage());
            cs.setInt(6, product.getQuantity());
            cs.setString(7, product.getArticle());
            int result = cs.executeUpdate();
            conn.close();
            if(result==1) return true;
        }catch(Exception e){
            e.printStackTrace();
            return false;
        }
        return false;
    }
    
    public boolean editFood(Product product){
        String query = "UPDATE product SET categoryid=?, name=?, describes=?, price=?, image=?,quantity=? ,article=? WHERE id=?";
        conn = new Common().getDBConnection();
        try{
            CallableStatement cs = conn.prepareCall(query);
            cs.setString(1, product.getCatID());
            cs.setString(2, product.getName());
            cs.setString(3, product.getDescribes());
            cs.setInt(4, product.getPrice());
            cs.setString(5, product.getImage());
            cs.setString(8, product.getId());
            cs.setInt(6, product.getQuantity());
            cs.setString(7, product.getArticle());
            int result = cs.executeUpdate();
            conn.close();
            if(result==1) return true;
        }catch(Exception e){
            e.printStackTrace();
            return false;
        }
        return false;
    }
    public boolean deleteFood(String productID){
        String query = "DELETE FROM product WHERE id=?";
        conn = new Common().getDBConnection();
        try{
            CallableStatement cs = conn.prepareCall(query);
            cs.setString(1, productID);
            int result = cs.executeUpdate();
            conn.close();
            if(result==1) return true;
        }catch(Exception e){
            e.printStackTrace();
            return false;
        }
        return false;
    }
    
    public java.util.List<Product> viewAllProduct(
                int offset,
                int noOfRecords)
    {
        String query = "select * from product limit "
                 + offset + ", " + noOfRecords;
        java.util.List<Product> list = new ArrayList<Product>();
        Product prod = null;
        Statement stmt=null;
        try {
            conn = new Common().getDBConnection();
            stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(query);
            while (rs.next()) {
                prod = new Product();
                prod.setAllAttributes(rs.getString("id"),rs.getString("name"),rs.getString("describes"),rs.getShort("price"),rs.getString("image"),rs.getInt("quantity"),
                        rs.getString("article"));
                
                list.add(prod);
            }
            rs.close();
             
            rs = stmt.executeQuery("SELECT count(*)");
            if(rs.next())
                this.noOfRecords = rs.getInt(1);
        } catch (SQLException e) {
            e.printStackTrace();
        
        }
        return list;
    }
    public int getNoOfRecords() {
        return noOfRecords;
    }
    
    public static void main(String[] args) {
        ProductDAO dao=new ProductDAO();
        Hashtable<Product, String> products=new Hashtable<Product, String>();
       
        products=dao.selectAll();
        
       System.out.println(products.keySet());
    }
}
