/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.my.bean;

public class Category {
    private String id;
    private String name;
    private String describes;
    private Product[] foods;

    public Category() {
    }

    public Category(String name, String describes, Product[] foods) {
        this.name = name;
        this.describes = describes;
        this.foods = foods;
    }

    public Category(String name, String describes) {
        this.name = name;
        this.describes = describes;
    }

    public Category(String id, String name, String describes) {
        this.id = id;
        this.name = name;
        this.describes = describes;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getTitle(){
        return id + "." + name;
    }
    
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescribes() {
        return describes;
    }

    public void setDescribes(String describes) {
        this.describes = describes;
    }

    public Product[] getFoods() {
        return foods;
    }

    public void setFoods(Product[] foods) {
        this.foods = foods;
    }
    
}
