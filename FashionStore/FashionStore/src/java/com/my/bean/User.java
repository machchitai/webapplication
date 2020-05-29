/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.my.bean;

/**
 *
 * @author vivtory
 */
public class User {
    private String username;
    private String pword;
    private String role;
    private String email;

    public User(){}
    
    public User(String username, String pword, String role, String email) {
        this.username = username;
        this.pword = pword;
        this.role = role;
        this.email = email;
    }

    public User(String username, String pword) {
        this.username = username;
        this.pword = pword;
        this.role = null;
        this.email = null;
    }

    public User(String username) {
        this.username = username;
        this.pword = null;
        this.role = null;
        this.email = null;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public String getUsername() {
        return username;
    }

    public String getPword() {
        return pword;
    }

    public String getRole() {
        return role;
    }

    public String getEmail() {
        return email;
    }

    public void setPword(String pword) {
        this.pword = pword;
    }

    public void setEmail(String email) {
        this.email = email;
    }
    
}
