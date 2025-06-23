/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package db;

import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 *
 * @author PHT
 */
public class OrderHeader {

    private int id;
    private int accountId;
    private Date orderDate;
    private double totalPrice;
    private String status;
    private List<OrderDetail> details = null;

    public OrderHeader(int accountId, Date orderDate, double totalPrice, String status) {
        this.accountId = accountId;
        this.orderDate = orderDate;
        this.totalPrice = totalPrice;
        this.status = status;
    }

    public OrderHeader() {
        this.details = new ArrayList<>();
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getAccountId() {
        return accountId;
    }

    public void setAccountId(int accountId) {
        this.accountId = accountId;
    }

    public Date getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(Date orderDate) {
        this.orderDate = orderDate;
    }

    public double getCalculatedPrice() {
        double total = 0;
        for (OrderDetail detail : details) {
            total += detail.getTotalPrice();
        }
        return total;
    }

    public double getTotalPrice() {
        return totalPrice;
    }
    
    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public List<OrderDetail> getDetails() {
        return details;
    }

    public void setTotalPrice(double totalPrice) {
        this.totalPrice = totalPrice;
    }

    public void setDetails(List<OrderDetail> details) {
        this.details = details;
    }
   public String getFormattedPrice() {
        DecimalFormat df = new DecimalFormat("#0.00"); 
        return df.format(totalPrice);
    }

}
