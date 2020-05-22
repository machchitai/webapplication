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
   private Connection conn = null;
//    private String url = "jdbc:mysql://mysql55.metawerx.net:3509/hungtqno1?autoReconnect=true";
//    //private String dbName = "fashionstore";
//    private String driver ="com.mysql.jdbc.Driver";
//    private String userName = "hungtqno1";
//    private String password = "H@37hb3a7n";
    
    private String url = "jdbc:mysql://localhost/";
    private String dbName = "fashionstore";
    private String driver ="com.mysql.jdbc.Driver";
    private String userName = "root";
    private String password = "root";
    public Common() {}
    public Connection getDBConnection(){
        url += dbName;
        try {
            Class.forName(driver).newInstance();
            conn = DriverManager.getConnection(url, userName, password);
        } catch (Exception e) {
            e.printStackTrace();
        }  
        return conn;
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
