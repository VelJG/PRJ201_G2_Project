/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package db;

import java.text.DecimalFormat;

/**
 *
 * @author AN KHUONG
 */
public class Laptop {
   private int id;
   private String brand;
   private double price;
   private String description;

    public Laptop() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getBrand() {
        return brand;
    }

    public void setBrand(String brand) {
        this.brand = brand;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
    public String getFormattedPrice() {
        DecimalFormat df = new DecimalFormat("#0.00"); 
        return df.format(price);
    }
   
           
}
