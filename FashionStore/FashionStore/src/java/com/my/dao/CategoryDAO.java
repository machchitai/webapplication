/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.my.dao;

import java.sql.Connection;
import com.my.bean.Category;
import com.my.common.Common;
import java.awt.List;
import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Hashtable;

/**
 *
 * @author vivtory
 */
public class CategoryDAO {
    private Connection conn;
    private int noOfRecords;
    public CategoryDAO() {}
    
    public Hashtable selectAll(){
        Hashtable cats = new Hashtable();
        String query = "Select * From category";
        conn = new Common().getDBConnection();
        try{
            Statement st = conn.createStatement();
            ResultSet rs = st.executeQuery(query);
            while(rs.next()){
                Category cat = new Category(rs.getString(1), rs.getString(2), rs.getString(3));
                cats.put(cat.getId(), cat);
            }
            conn.close();
        }catch(Exception e){
            e.printStackTrace();
        }
        return cats;
    }
    public Category selectCategoryByID(String catID){
        Category cat=null;
        String query = "SELECT * FROM category WHERE id=?";
        conn = new Common().getDBConnection();
        try{
            CallableStatement cs = conn.prepareCall(query);
            cs.setString(1, catID);
            ResultSet rs = cs.executeQuery();
            if(rs.next()){
                cat = new Category(rs.getString(1), rs.getString(2), rs.getString(3));
            }
            conn.close();
        }catch(Exception e){
            e.printStackTrace();
        }
        return cat;
    }
    public boolean addCategory(Category cat){
        String query = "Insert Into category(name,describes) VALUES(?,?)";
        conn = new Common().getDBConnection();
        try{
            CallableStatement cs = conn.prepareCall(query);
            cs.setString(1, cat.getName());
            cs.setString(2, cat.getDescribes());
            int result = cs.executeUpdate();
            conn.close();
            if(result==1) return true;
        }catch(Exception e){
            e.printStackTrace();
            return false;
        }
        return false;
    }
    
    public boolean editCategory(Category cat){
        String query = "UPDATE category SET name=?, describes=? WHERE id=?";
        conn = new Common().getDBConnection();
        try{
            CallableStatement cs = conn.prepareCall(query);
            cs.setString(1, cat.getName());
            cs.setString(2, cat.getDescribes());
            cs.setString(3, cat.getId());
            int result = cs.executeUpdate();
            conn.close();
            if(result==1) return true;
        }catch(Exception e){
            e.printStackTrace();
            return false;
        }
        return false;
    }
    public boolean deleteCategory(String catID){
        String query = "DELETE FROM category WHERE id=?";
        conn = new Common().getDBConnection();
        try{
            CallableStatement cs = conn.prepareCall(query);
            cs.setString(1, catID);
            int result = cs.executeUpdate();
            conn.close();
            if(result==1) return true;
        }catch(Exception e){
            e.printStackTrace();
            return false;
        }
        return false;
    }
    
    public java.util.List<Category> viewAllCategory(
                int offset,
                int noOfRecords)
    {
        String query = "select * from category limit "
                 + offset + ", " + noOfRecords;
        java.util.List<Category> list = new ArrayList<Category>();
        Category cat = null;
        Statement stmt=null;
        try {
            conn = new Common().getDBConnection();
            stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(query);
            while (rs.next()) {
                cat = new Category();
                cat.setId(rs.getString("id"));
                cat.setName(rs.getString("name"));
                cat.setDescribes(rs.getString("describes"));
                
                list.add(cat);
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
    public int getTotalRows() throws SQLException{
        String sql="select count(name) from category";
        int count=0;
        PreparedStatement ps=conn.prepareStatement(sql);
        ResultSet rs=ps.executeQuery();
        while(rs.next()){
            count++;
        }
        return count;
    }
   
}
