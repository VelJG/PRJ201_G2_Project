/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cart;

import db.OrderDetail;
import db.OrderHeader;
import db.OrderHeaderFacade;
import db.Laptop;
import java.sql.SQLException;
import java.util.Collection;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

/**
 *
 * @author AN KHUONG
 */
public class Cart {

    private Map<Integer, Item> map = null;

    public Cart() {
        this.map = new HashMap<>();
    }

    public void add(Laptop laptop, int quantity) {
        int id = laptop.getId();
        if (this.map.keySet().contains(id)) {
            Item item = this.map.get(id);
            item.setQuantity(item.getQuantity() + quantity);
        } else {
            Item item = new Item();
            item.setId(id);
            item.setLaptop(laptop);
            item.setQuantity(quantity);
            this.map.put(id, item);
        }
    }

    public Collection<Item> getItems() {
        return this.map.values();
    }

    public double getTotal() {
        double total = 0;
        for (Item item : this.map.values()) {
            total += item.getCost();
        }
        return total;
    }

    public void remove(int id) {
        this.map.remove(id);
    }

    public void empty() {
        this.map.clear();
    }
    public void update(int id, int quantity){
        Item item=this.map.get(id);
        item.setQuantity(quantity);
        if(item.getQuantity()<1)
            remove(id);
    }
    
    public void checkout(int accountId) throws ClassNotFoundException, SQLException {
    Date date = new Date();
    String status = "NEW"; 
    OrderHeader orderHeader = new OrderHeader();
    orderHeader.setOrderDate(date);
    orderHeader.setStatus(status);
    orderHeader.setAccountId(accountId);
    
    for (Item item : this.getItems()) {
        OrderDetail orderDetail = new OrderDetail(
            null, // OrderDetail ID (assumed to be auto-generated in the DB)
            null, // OrderHeader ID (will be set after insertion)
            item.getLaptop().getId(), 
            item.getQuantity(), 
            item.getLaptop().getPrice() 
        );
        orderHeader.getDetails().add(orderDetail);
    }
    
  
    OrderHeaderFacade orderHeaderFacade = new OrderHeaderFacade();
    orderHeaderFacade.insert(orderHeader);
    
 
    this.empty();
}
  

}
