/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.my.bean;


public class Product {
    private String id;
    private String catID;
    private String name;
    private String describes;
    private int price;
    private String image;
    private int quantity;
    private String article;
    public Product() {
    }

    public Product(String id, String catID, String name, String describes, int price, String image, int quantity) {
        this.id = id;
        this.catID = catID;
        this.name = name;
        this.describes = describes;
        this.price = price;
        this.image = image;
        this.quantity=quantity;
        this.article=article;
    }
    public Product(String id, String catID, String name, String describes, int price, String image, int quantity, String article) {
        this.id = id;
        this.catID = catID;
        this.name = name;
        this.describes = describes;
        this.price = price;
        this.image = image;
        this.quantity=quantity;
        this.article=article;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public Product(String catID, String name, String describes, int price, String image, int quantity) {
        this.catID = catID;
        this.name = name;
        this.describes = describes;
        this.price = price;
        this.image = image;
        this.quantity=quantity;
       
    }
    public Product(String catID, String name, String describes, int price, String image, int quantity, String article) {
        this.catID = catID;
        this.name = name;
        this.describes = describes;
        this.price = price;
        this.image = image;
        this.quantity=quantity;
        this.article=article;
    }

    public Product(String id, int price) {
        this.id = id;
        this.price = price;
    }

    public String getArticle() {
        return article;
    }

    public void setArticle(String article) {
        this.article = article;
    }

    
    public String getCatID() {
        return catID;
    }

    public void setId(String id) {
        this.id = id;
    }

    public void setCatID(String catID) {
        this.catID = catID;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setDescribes(String describes) {
        this.describes = describes;
    }

    public void setPrice(int price) {
        this.price = price;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getId() {
        return id;
    }

    
    public String getName() {
        return name;
    }

    public String getDescribes() {
        return describes;
    }

    public int getPrice() {
        return price;
    }
    public String getPriceToString(){
        return price+",000";
    }

    public String getImage() {
        return image;
    }
    
    public void setAllAttributes(String catID, String name, String describes, int price, String image, int quantity, String article){
        this.catID = catID;
        this.name = name;
        this.describes = describes;
        this.price = price;
        this.image = image;
        this.quantity=quantity;
        this.article=article;
    }
}
