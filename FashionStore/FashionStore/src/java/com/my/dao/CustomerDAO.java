/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.my.dao;

import com.my.bean.Customer;
import com.my.bean.User;
import com.my.common.Common;
import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.Hashtable;
import java.util.Random;
import java.util.Calendar;
import java.util.Date;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;


public class CustomerDAO {

    private Connection conn;
    private static String hashString = "a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3";

    public CustomerDAO() {
    }

    public Hashtable selectAll() {
        Hashtable customers = new Hashtable();
        //String query = "Select a.*, b.email From customer a, user b WHERE b.username=a.username AND b.role=2";
        String query = "Select a.*, b.email, b.role From customer a, user b WHERE b.username=a.username";
        conn = new Common().getDBConnection();
        try {
            Statement st = conn.createStatement();
            ResultSet rs = st.executeQuery(query);
            while (rs.next()) {
                Customer cus = new Customer(rs.getString(1), rs.getString(2), rs.getString(3),
                        rs.getDate(4), rs.getString(5), rs.getString(6), rs.getLong(7), rs.getString(8));
                customers.put(cus.getId(), cus);
            }
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return customers;
    }

    public Hashtable selectAll_1() {
        Hashtable customers = new Hashtable();
        String query = "Select a.*, b.email From customer a, user b WHERE b.username=a.username AND b.role=2";
        // String query = "Select a.*, b.email, b.role From customer a, user b WHERE b.username=a.username";
        conn = new Common().getDBConnection();
        try {
            Statement st = conn.createStatement();
            ResultSet rs = st.executeQuery(query);
            while (rs.next()) {
                Customer cus = new Customer(rs.getString(1), rs.getString(2), rs.getString(3),
                        rs.getDate(4), rs.getString(5), rs.getString(6), rs.getLong(7), rs.getString(8));
                customers.put(cus.getId(), cus);
            }
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return customers;
    }

    public boolean addCustomer(Customer cus) {
        String query = "Insert Into customer(username,fullname,birthday,address,phonenumber,balance) VALUES(?,?,?,?,?,?)";
        String query2 = "INSERT INTO user(username,pword,role,email) VALUES(?,?,?,?)";
        conn = new Common().getDBConnection();
        try {
            CallableStatement cs = conn.prepareCall(query);
            cs.setString(1, cus.getUsername());
            cs.setString(2, cus.getFullname());
            cs.setString(3, cus.getBirthdayToString());
            cs.setString(4, cus.getAddress());
            cs.setString(5, cus.getPhonenumber());
            cs.setLong(6, cus.getBalance());
            int result = cs.executeUpdate();

            CallableStatement cs2 = conn.prepareCall(query2);
            cs2.setString(1, cus.getUsername());
            cs2.setString(2, hash(cus.getPword()));
            cs2.setString(3, cus.getRole());
            cs2.setString(4, cus.getEmail());
            result = cs2.executeUpdate();

            conn.close();
            if (result == 1) {
                return true;
            }
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
        return false;
    }

    public boolean editCustomer(Customer cus) {
        String query = "UPDATE customer a,user b SET pword=?, address=?, phonenumber=?, email=? "  + "WHERE a.username=? AND a.username=b.username";
        conn = new Common().getDBConnection();
        try {
            CallableStatement cs = conn.prepareCall(query);
            cs.setString(1, cus.getPword());
            cs.setString(2, cus.getAddress());
            cs.setString(3, cus.getPhonenumber());
            cs.setString(4, cus.getEmail());
            cs.setString(5, cus.getUsername());
            int result = cs.executeUpdate();
            System.out.println(result);
            conn.close();
            if (result >= 1) {
                return true;
            }
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
        return false;
    }

    public boolean deleteCustomer(String cusName) {
        String query = "DELETE FROM customer WHERE username=?";
        conn = new Common().getDBConnection();
        try {
            CallableStatement cs = conn.prepareCall(query);
            cs.setString(1, cusName);
            int result = cs.executeUpdate();
            conn.close();
            if (result == 1) {
                return true;
            }
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
        return false;
    }

    public boolean buyBalance(String cusID, int balance) {
        long bl = getBalance(cusID);
        balance += bl;
        String query = "UPDATE customer SET balance=? WHERE id=?";
        conn = new Common().getDBConnection();
        try {
            CallableStatement cs = conn.prepareCall(query);
            cs.setInt(1, balance);
            cs.setString(2, cusID);
            int result = cs.executeUpdate();
            conn.close();
            if (result == 1) {
                return true;
            }
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
        return false;
    }

    public long getBalance(String cusID) {
        int balance = 0;
        String query = "SELECT balance FROM customer WHERE id=" + cusID;
        conn = new Common().getDBConnection();
        try {
            Statement st = conn.createStatement();
            ResultSet rs = st.executeQuery(query);
            if (rs.next()) {
                balance = rs.getInt(1);
            }
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            return balance;
        }
        return balance;
    }

    public Customer checkLogin(User user) {
        Customer cus = null;
        String query = "SELECT a.*, b.* FROM user a, customer b "+ "WHERE a.username=? AND a.pword=? AND a.username=b.username";
        conn = new Common().getDBConnection();
        try {
            CallableStatement cs = conn.prepareCall(query);
            cs.setString(1, user.getUsername());
            cs.setString(2, user.getPword());

            ResultSet rs = cs.executeQuery();
            if (rs.next()) {
                cus = new Customer(rs.getString(1), rs.getString(2), rs.getString(3),
                        rs.getString(4), rs.getString(5), rs.getString(7),
                        rs.getDate(8), rs.getString(9), rs.getString(10), rs.getLong(11));
            }
        } catch (Exception e) {
            e.printStackTrace();
            return cus;
        }
        return cus;
    }

    public boolean payOrder(String cusID, long fee) {
        long balance = getBalance(cusID);
        balance -= fee;
        String query = "UPDATE customer SET balance=? WHERE id=?";
        conn = new Common().getDBConnection();
        try {
            CallableStatement cs = conn.prepareCall(query);
            cs.setLong(1, balance);
            cs.setString(2, cusID);
            int result = cs.executeUpdate();
            conn.close();
            if (result == 1) {
                return true;
            }
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
        return false;
    }

    public boolean checkUsername(String username) {
        String query = "select * from user where user.username = ?";
        conn = new Common().getDBConnection();
        boolean rs = false;
        try {
            CallableStatement cs = conn.prepareCall(query);
            cs.setString(1, username);
            ResultSet result = cs.executeQuery();
            if (result.next()) {
                rs = true;
            }
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            rs = false;
        }

        return rs;
    }

    public boolean updatePassword(String username, String password) {
        String query = "UPDATE user SET pword=? WHERE username=?";
        conn = new Common().getDBConnection();
        try {
            CallableStatement cs = conn.prepareCall(query);
            cs.setString(1, hash(password));
            cs.setString(2, username);
            int result = cs.executeUpdate();
            conn.close();
            if (result == 1) {
                return true;
            }
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
        return false;
    }

    public boolean deleteToken(String username) {
        String query = "Delete from resetpassword WHERE username=?";
        conn = new Common().getDBConnection();
        try {
            CallableStatement cs = conn.prepareCall(query);
            cs.setString(1, username);
            int result = cs.executeUpdate();
            conn.close();
            if (result == 1) {
                return true;
            }
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
        return false;
    }

    public String getToken(String username) {
        String query = "select * from resetpassword where username = ?";
        conn = new Common().getDBConnection();
        try {
            CallableStatement cs = conn.prepareCall(query);
            cs.setString(1, username);
            ResultSet result = cs.executeQuery();
            if (result.next()) {
                return result.getString("token");
            }
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "";
    }

    public String getUsernameFromToken(String token) {
        String query = "select username from resetpassword where token = ?";
        conn = new Common().getDBConnection();
        try {
            CallableStatement cs = conn.prepareCall(query);
            cs.setString(1, token);
            ResultSet result = cs.executeQuery();
            if (result.next()) {
                return result.getString("username");
            }
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "";
    }

    public boolean updateToken(String username) {
        String query = "UPDATE resetpassword SET token= ?,date_expired=? WHERE username=?";
        conn = new Common().getDBConnection();
        try {
            Random rand = new Random();
            int n = rand.nextInt(99999) + 1;
            Date today = new Date();
            Date tomorrow = new Date(today.getTime() + (1000 * 60 * 60 * 24));
            java.sql.Date sqlDate = new java.sql.Date(tomorrow.getTime());
            CallableStatement cs = conn.prepareCall(query);
            cs.setString(1, hash(username + Integer.toString(n)));
            cs.setDate(2, sqlDate);
            cs.setString(3, username);
            int result = cs.executeUpdate();
            conn.close();
            if (result == 1) {
                return true;
            }
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
        return false;
    }

    public boolean createToken(String username) {
        String query = "INSERT INTO resetpassword(username,token,date_expired) value(?,?,?)";
        conn = new Common().getDBConnection();
        try {
            Random rand = new Random();
            int n = rand.nextInt(99999) + 1;
            Date today = new Date();
            Date tomorrow = new Date(today.getTime() + (1000 * 60 * 60 * 24));
            java.sql.Date sqlDate = new java.sql.Date(tomorrow.getTime());
            CallableStatement cs = conn.prepareCall(query);
            cs.setString(2, hash(username + Integer.toString(n)));
            cs.setDate(3, sqlDate);
            cs.setString(1, username);
            int result = cs.executeUpdate();
            conn.close();
            if (result == 1) {
                return true;
            }
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
        return false;
    }

    public boolean checkToken(String username) {
        String query = "select * from resetpassword where username = ?";
        conn = new Common().getDBConnection();
        try {
            CallableStatement cs = conn.prepareCall(query);
            cs.setString(1, username);
            ResultSet result = cs.executeQuery();

            if (result.next()) {
                return true;
            }
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
        return false;
    }

    public boolean validateToken(String token) {
        String query = "select * from resetpassword where resetpassword.token = ?";
        conn = new Common().getDBConnection();
        try {
            CallableStatement cs = conn.prepareCall(query);
            cs.setString(1, token);
            ResultSet result = cs.executeQuery();

            if (result.next()) {
                if (result.getDate("date_expired").getTime() < System.currentTimeMillis()) {
                    return false;
                } else {
                    return true;
                }
            }
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
        return false;
    }

    public boolean generateToken(String username) {
        if (checkToken(username)) {
            return updateToken(username);
        } else {
            return createToken(username);
        }
    }

    public static String hash(String input) throws NoSuchAlgorithmException, UnsupportedEncodingException {

        String raw = input + hashString;
        MessageDigest md = null;
        md = MessageDigest.getInstance("SHA-256");
        md.update(raw.getBytes("UTF-8")); // Change this to "UTF-16" if needed
        byte[] digest = md.digest();
        StringBuffer hexString = new StringBuffer();
        for (int i = 0; i < digest.length; i++) {
            if ((0xff & digest[i]) < 0x10) {
                hexString.append("0"
                        + Integer.toHexString((0xFF & digest[i])));
            } else {
                hexString.append(Integer.toHexString(0xFF & digest[i]));
            }
        }
        return hexString.toString();
    }

    public String getEmail(String username) {
        String query = "select email from user where username = ?";
        conn = new Common().getDBConnection();
        try {
            CallableStatement cs = conn.prepareCall(query);
            cs.setString(1, username);
            ResultSet result = cs.executeQuery();
            if (result.next()) {
                return result.getString("email");
            }
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "";
    }

    public static boolean sendMail(String email, String content) {
        final String username = "levuminhkhang@gmail.com";
        final String password = "dyrdvaxwlvghdjdq";

        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");

        Session session = Session.getInstance(props,
                new javax.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(username, password);
            }
        });

        try {

            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress("thebrazzers@gmail.com"));
            message.setRecipients(Message.RecipientType.TO,
                    InternetAddress.parse(email));
            message.setSubject("Reset password");
            message.setText(content);

            Transport.send(message);

            System.out.println("Done");
            return true;

        } catch (MessagingException e) {
            throw new RuntimeException(e);

        }
    }
}
