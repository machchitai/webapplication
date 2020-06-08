/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.my.bean;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Enumeration;
import java.util.Hashtable;

/**
 *
 * @author vivtory
 */
public class OrderCart {
    private String id;
    private Customer customer;
    private Hashtable productorders;
    private Date shiptime;
    private long totalprice;

    public OrderCart(){
        
    }

    public OrderCart(Customer customer) {
        this.customer = customer;
        productorders = new Hashtable(100);
        totalprice = 0;
    }

    public OrderCart(String id, String cusID, Date shiptime, long totalprice){
        this.id = id;
        this.customer = new Customer(cusID);
        this.shiptime = shiptime;
        this.totalprice = totalprice;
    }
    public OrderCart(String id, Customer customer, Hashtable productorders, Date shiptime, long totalprice) {
        this.id = id;
        this.customer = customer;
        this.productorders = productorders;
        this.shiptime = shiptime;
        this.totalprice = totalprice;
    }

    public void setId(String id) {
        this.id = id;
    }

    public void setShiptime(Date shiptime) {
        this.shiptime = shiptime;
    }

    public String getId() {
        return id;
    }

    public Date getShiptime() {
        return shiptime;
    }
    
    public String getShiptimeString(){
        return new SimpleDateFormat("yyyy-MM-dd HH:mm").format(shiptime);
    }

    public Customer getCustomer() {
        return customer;
    }

    public void setCustomer(Customer customer) {
        this.customer = customer;
    }

    public Hashtable getFoodorders() {
        return productorders;
    }

    public Enumeration getFoodOrderEnum(){
        return productorders.elements();
    }
    public long getTotalprice() {
        return totalprice;
    }
    public String getTotalpriceToString() {
        return totalprice + ",000";
    }
    public boolean isAddable(ProductOrder fo){
        return customer.isEnoughToPay(fo.getTotalprice());
    }
    public void addFoodOrders(ProductOrder fo){
        if(productorders.containsKey(fo.getId())) {
            ProductOrder f = (ProductOrder)productorders.get(fo.getId());
            f.addQuantity(fo.getQuantity());
            totalprice += fo.getTotalprice();
        }
        else{
            productorders.put(fo.getId(),fo);
            totalprice += fo.getTotalprice();
        }
        customer.pay(fo.getTotalprice());
    }
    public void removeFoodOrders(String FoodOrderId){
        if(productorders.containsKey(FoodOrderId)) {
            ProductOrder fo = (ProductOrder)productorders.get(FoodOrderId);
            productorders.remove(FoodOrderId);
            totalprice -= fo.getTotalprice();
            customer.receiveMoney(fo.getTotalprice());
        }
    }
    public void removeAllFoodOrder(){
        productorders.clear();
        totalprice = 0;
    }
}
