/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.my.bean;

/**
 *
 * @author KVH
 */
public class News {
    private int id;
    private String title;
    private String content;
    private String createddate;

    public News() {
    }

    public News(int id, String title, String content, String createddate) {
        this.id = id;
        this.title = title;
        this.content = content;
        this.createddate = createddate;
    }

    public News(String title, String content, String createddate) {
        this.title = title;
        this.content = content;
        this.createddate = createddate;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getCreateddate() {
        return createddate;
    }

    public void setCreateddate(String createddate) {
        this.createddate = createddate;
    }
    
    
}
