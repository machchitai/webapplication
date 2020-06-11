/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.my.dao;

import java.sql.Connection;
import com.my.bean.Category;
import com.my.bean.News;
import com.my.common.Common;
import java.awt.List;
import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Hashtable;

public class NewsDAO {
    private Connection conn;
    private int noOfRecords;
    public NewsDAO() {}
    
    public Hashtable selectAll(){
        Hashtable listNew = new Hashtable();
        String query = "Select * From news";
        conn = new Common().getDBConnection();
        try{
            Statement st = conn.createStatement();
            ResultSet rs = st.executeQuery(query);
            while(rs.next()){
                News news = new News(rs.getString(2), rs.getString(3), rs.getString(4));
                listNew.put(news.getId(), news);
            }
            conn.close();
        }catch(Exception e){
            e.printStackTrace();
        }
        return listNew;
    }
    public News selectNewsByID(String newID){
        News news=null;
        String query = "SELECT * FROM news WHERE id=?";
        conn = new Common().getDBConnection();
        try{
            CallableStatement cs = conn.prepareCall(query);
            cs.setString(1, newID);
            ResultSet rs = cs.executeQuery();
            if(rs.next()){
                news = new News(rs.getString(2), rs.getString(3), rs.getString(4));
            }
            conn.close();
        }catch(Exception e){
            e.printStackTrace();
        }
        return news;
    }
    public boolean addNews(News news){
        String query = "Insert Into News(title,content,createddate) VALUES(?,?,?)";
        conn = new Common().getDBConnection();
        try{
            CallableStatement cs = conn.prepareCall(query);
            cs.setString(1, news.getTitle());
            cs.setString(2, news.getContent());
            cs.setString(3, news.getCreateddate());
            int result = cs.executeUpdate();
            conn.close();
            if(result==1) return true;
        }catch(Exception e){
            e.printStackTrace();
            return false;
        }
        return false;
    }
    
    public boolean editNews(News news){
        String query = "UPDATE category SET title=?, content=?, createddate=? WHERE id=?";
        conn = new Common().getDBConnection();
        try{
            CallableStatement cs = conn.prepareCall(query);
            cs.setString(1, news.getTitle());
            cs.setString(2, news.getContent());
            cs.setString(3, news.getCreateddate());
            int result = cs.executeUpdate();
            conn.close();
            if(result==1) return true;
        }catch(Exception e){
            e.printStackTrace();
            return false;
        }
        return false;
    }
    public boolean deleteNews(String newID){
        String query = "DELETE FROM news WHERE id=?";
        conn = new Common().getDBConnection();
        try{
            CallableStatement cs = conn.prepareCall(query);
            cs.setString(1, newID);
            int result = cs.executeUpdate();
            conn.close();
            if(result==1) return true;
        }catch(Exception e){
            e.printStackTrace();
            return false;
        }
        return false;
    }
    
    public java.util.List<News> viewAllCategory(
                int offset,
                int noOfRecords)
    {
        String query = "select * from news limit "
                 + offset + ", " + noOfRecords;
        java.util.List<News> list = new ArrayList<News>();
        News news = null;
        Statement stmt=null;
        try {
            conn = new Common().getDBConnection();
            stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(query);
            while (rs.next()) {
                news = new News();
                news.setId(rs.getInt("id"));
                news.setTitle(rs.getString("title"));
                news.setContent(rs.getString("content"));
                news.setCreateddate(rs.getString("createddate"));
                list.add(news);
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
        String sql="select count(title) from news";
        int count=0;
        PreparedStatement ps=conn.prepareStatement(sql);
        ResultSet rs=ps.executeQuery();
        while(rs.next()){
            count++;
        }
        return count;
    }
   
}
