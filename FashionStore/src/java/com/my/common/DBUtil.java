/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.my.common;

import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class DBUtil {
    public static void closePreparedStatement(PreparedStatement ps){
        try {
            if (ps!=null) {
               ps.close(); 
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    public static void closeResultSet(ResultSet rs){
        try {
            if (rs!=null) {
               rs.close(); 
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    public static void closeCallableStatement(CallableStatement cs){
        try {
            if (cs!=null) {
                cs.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
