/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.my.dao;

import com.my.bean.BalanceSource;
import com.my.common.Common;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.Hashtable;

/**
 *
 * @author vivtory
 */
public class BalanceSourceDAO {
    Connection conn = null;
    public BalanceSourceDAO() {}
    
    public Hashtable selectAll(){
        Hashtable balances = new Hashtable();
        String query = "Select * From balancesource";
        conn = new Common().getDBConnection();
        try{
            Statement st = conn.createStatement();
            ResultSet rs = st.executeQuery(query);
            while(rs.next()){
                BalanceSource bs = new BalanceSource(rs.getString(1), rs.getInt(2), rs.getString(3),rs.getInt(4));
                balances.put(bs.getSource(), bs);
            }
            conn.close();
        }catch(Exception e){
            e.printStackTrace();
        }
        return balances;
    }
    
    public boolean addBalanceSource(BalanceSource bs){
        String query = "Insert Into balancesource(source,price,describes,available) VALUES(?,?,?,?)";
        conn = new Common().getDBConnection();
        try{
            CallableStatement cs = conn.prepareCall(query);
            cs.setString(1, bs.getSource());
            cs.setInt(2, bs.getPrice());
            cs.setString(3, bs.getDescribes());
            cs.setInt(4, bs.getAvailable());
            int result = cs.executeUpdate();
            conn.close();
            if(result==1) return true;
        }catch(Exception e){
            e.printStackTrace();
            return false;
        }
        return false;
    }
    
    public boolean editBalanceSource(BalanceSource bs){
        String query = "UPDATE balancesource SET price=?, describes=?, available=? WHERE source=?";
        conn = new Common().getDBConnection();
        try{
            CallableStatement cs = conn.prepareCall(query);
            cs.setInt(1, bs.getPrice());
            cs.setString(2, bs.getDescribes());
            cs.setInt(3, bs.getAvailable());
            cs.setString(4, bs.getSource());
            int result = cs.executeUpdate();
            conn.close();
            if(result==1) return true;
        }catch(Exception e){
            e.printStackTrace();
            return false;
        }
        return false;
    }
    public boolean deleteBalanceSource(String bsSource){
        String query = "DELETE FROM balancesource WHERE source=?";
        conn = new Common().getDBConnection();
        try{
            CallableStatement cs = conn.prepareCall(query);
            cs.setString(1, bsSource);
            int result = cs.executeUpdate();
            conn.close();
            if(result==1) return true;
        }catch(Exception e){
            e.printStackTrace();
            return false;
        }
        return false;
    }
    
    public int getBalance(String bSource){
        int balance = 0;
        String query = "SELECT price,available FROM balancesource WHERE source=?";
        conn = new Common().getDBConnection();
        try{
            CallableStatement cs = conn.prepareCall(query);
            cs.setString(1, bSource);
            ResultSet rs = cs.executeQuery();
            if(rs.next() && rs.getInt(2)==1)   balance = rs.getInt(1);
        }catch(Exception e){
            e.printStackTrace();
        }
        return balance;
    }
    public void disableBalanceSourcce(String bSource){
        String query = "UPDATE balancesource SET available=0 WHERE source=?";
        conn = new Common().getDBConnection();
        try{
            CallableStatement cs = conn.prepareCall(query);
            cs.setString(1, bSource);
            int result = cs.executeUpdate();
            conn.close();
        }catch(Exception e){
            e.printStackTrace();
        }
    }
}
