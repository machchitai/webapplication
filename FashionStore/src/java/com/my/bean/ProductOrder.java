/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.my.bean;

/**
 *
 * @author vivtory
 */
public class ProductOrder extends Product{
    private String foID;
    private int quantity;
    private long totalprice;

    public ProductOrder(Product food, int quantity) {
        super(food.getId(),food.getCatID(), food.getName(), food.getDescribes(), food.getPrice(), food.getImage(),food.getQuantity(),
                food.getArticle());
        this.quantity = quantity;
        this.totalprice = quantity*getPrice();
    }

    public ProductOrder( String id,String foID, int quantity, int price, long totalprice) {
        super(id, price);
        this.foID = foID;
        this.quantity = quantity;
        this.totalprice = totalprice;
    }

    public String getFoID() {
        return foID;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
        this.totalprice = quantity*getPrice();
    }

    public void addQuantity(int quantity) {
        this.quantity += quantity;
        this.totalprice += quantity*getPrice();
    }

    public long getTotalprice() {
        return totalprice;
    }
    public String getTotalPriceToString(){
        return totalprice+",000";
    }
}
