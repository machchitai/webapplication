/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.my.bean;

import java.text.SimpleDateFormat;
import java.util.Date;


public class BalanceSource {
    private String source;
    private int price;
    private String describes;
    private int available;

    public BalanceSource(String source, int price, String describes, int available) {
        this.source = source;
        this.price = price;
        this.describes = describes;
        this.available = available;
    }

    public String getSource() {
        return source;
    }

    public int getPrice() {
        return price;
    }

    public String getDescribes() {
        return describes;
    }

    public int getAvailable() {
        return available;
    }
    
}
