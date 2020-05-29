/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.my.common;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 *
 * @author vivtory
 */
public class Common {
   private Connection con = null;    
    private String url = "jdbc:mysql://localhost:3306/fashionstore";
//    private  String dbName = "fashionstore";
    private String driver ="com.mysql.cj.jdbc.Driver";
    private  String userName = "root";
    private  String password = "root";
    public Common() {}
    public Connection getDBConnection(){
//        url += dbName;
        try {
            Class.forName(driver).newInstance();
            con = DriverManager.getConnection(url, userName, password);
        } catch (Exception e) {
            e.printStackTrace();
        }  
        return con;
    }
    public static void main(String[] args) {
        Common db=new Common();
        if(db.getDBConnection()!=null){
            System.out.println("thanh cong");
        }else{
            System.out.println("that bai");
        }
    }
}
