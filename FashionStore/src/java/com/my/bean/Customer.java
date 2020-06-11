/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.my.bean;

import java.text.SimpleDateFormat;
import java.util.Date;


public class Customer extends User{
    private String id;
    private String username;
    private String fullname;
    private Date birthday;
    private String address;
    private String phonenumber;
    private long balance;
    
    public Customer( String username, String pword, String role, String email, String fullname, Date birthday, String address, String phonenumber, long balance) {
        super(username, pword, role, email);
        this.fullname = fullname;
        this.birthday = birthday;
        this.address = address;
        this.phonenumber = phonenumber;
        this.balance = balance;
    }

    public Customer(String id, String username, String fullname, Date birthday, String address, String phonenumber, long balance, String email) {
        super(username,email);
        this.id = id;
        this.fullname = fullname;
        this.birthday = birthday;
        this.address = address;
        this.phonenumber = phonenumber;
        this.balance = balance;
    }

    public Customer(String username, String pword, String role, String email, String id, String fullname, Date birthday, String address, String phonenumber, long balance) {
        super(username, pword, role, email);
        this.id = id;
        this.fullname = fullname;
        this.birthday = birthday;
        this.address = address;
        this.phonenumber = phonenumber;
        this.balance = balance;
    }

    public void setUsername(String username) {
        this.username = username;
    }

   
    
    
    public Customer(String username, String pword, String role, String email) {
        super(username, pword, role, email);
    }

    public Customer(String id) {
        super();
        this.id = id;
    }

    
    public String getId() {
        return id;
    }

    

    
    public String getFullname() {
        return fullname;
    }

    public Date getBirthday() {
        return birthday;
    }
    
    public String getBirthdayToString(){
        return new SimpleDateFormat("yyyy-MM-dd").format(birthday);
    }

    public String getAddress() {
        return address;
    }

    public String getPhonenumber() {
        return phonenumber;
    }

    public long getBalance() {
        return balance;
    }

    public void setBalance(long balance) {
        this.balance = balance;
    }

    public void updateInfo(String pword, String email, String address, String phonenumber) {
        setPword(pword);
        setEmail(email);
        this.address = address;
        this.phonenumber = phonenumber;
    }
    
    public boolean isEnoughToPay(long fee){
        return balance>=fee;
    }
    
    public void pay(long fee){
        balance -= fee;
    }
    public void receiveMoney(long bonus){
        balance += bonus;
    }
}
