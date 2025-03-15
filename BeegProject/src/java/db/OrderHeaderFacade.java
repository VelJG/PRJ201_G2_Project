package db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

public class OrderHeaderFacade {
    
    public void insert(OrderHeader orderHeader) throws ClassNotFoundException, SQLException {
        Connection con = DBContext.getConnection();
        try {
            con.setAutoCommit(false);
            String insertOrderHeaderSQL = "INSERT OrderHeader VALUES (?, ?, ?, ?)";
            try (PreparedStatement stm = con.prepareStatement(insertOrderHeaderSQL, Statement.RETURN_GENERATED_KEYS)) {
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                stm.setInt(1, orderHeader.getAccountId());
                stm.setString(2, sdf.format(orderHeader.getOrderDate()));
                stm.setDouble(3, orderHeader.getCalculatedPrice());
                stm.setString(4, orderHeader.getStatus());
                int count = stm.executeUpdate();
                try (ResultSet rs = stm.getGeneratedKeys()) {
                    if (rs.next()) {
                        orderHeader.setId(rs.getInt(1));
                    } else {
                        throw new SQLException("Inserting order failed, no ID obtained.");
                    }
                }
            }
            String insertOrderDetailSQL = "INSERT OrderDetail VALUES (?, ?, ?, ?)";
            try (PreparedStatement stm = con.prepareStatement(insertOrderDetailSQL)) {
                for (OrderDetail orderDetail : orderHeader.getDetails()) {
                    stm.setInt(1, orderHeader.getId());
                    stm.setInt(2, orderDetail.getLaptopId());
                    stm.setInt(3, orderDetail.getQuantity());
                    stm.setDouble(4, orderDetail.getPrice());
                    stm.executeUpdate();
                }
            }
            con.commit();
        } catch (SQLException ex) {
            try {
                con.rollback();
            } catch (SQLException ex1) {
                throw ex1;
            }
            throw ex;
        } finally {
            con.close(); // Ensure connection is closed
        }
    }
    
    public List<OrderDetail> getDetailById(int orderHeaderId) throws SQLException, ClassNotFoundException {
        Connection con = DBContext.getConnection();
        List<OrderDetail> details = new ArrayList<>();
        PreparedStatement stm = con.prepareStatement("SELECT * FROM OrderDetail WHERE orderHeaderId = ?");
        stm.setInt(1, orderHeaderId);
        ResultSet rs = stm.executeQuery();
        while (rs.next()) {
            OrderDetail detail = new OrderDetail(
                    rs.getString("id"),
                    rs.getString("orderHeaderId"),
                    rs.getInt("laptopId"),
                    rs.getInt("quantity"),
                    rs.getDouble("price")
            );
            details.add(detail);
        }
        return details;
    }
    
    public List<OrderHeader> getOrders(int accountId) throws SQLException, ClassNotFoundException {
        List<OrderHeader> orders = new ArrayList<>();
        Connection con = DBContext.getConnection();
        PreparedStatement stm = null;
        if (accountId == 1) {
            stm = con.prepareStatement("SELECT * FROM OrderHeader");
        } else {
            stm = con.prepareStatement("SELECT * FROM OrderHeader where accountId=?");
            stm.setInt(1, accountId);
        }
        ResultSet rs = stm.executeQuery();
        while (rs.next()) {
            OrderHeader order = new OrderHeader();
            order.setId(rs.getInt("id"));
            order.setAccountId(rs.getInt("accountId"));
            order.setOrderDate(rs.getDate("orderDate"));
            order.setTotalPrice(rs.getDouble("totalPrice"));
            order.setStatus(rs.getString("status"));
            orders.add(order);
        }
        return orders;
    }
    
    public void remove(int orderHeaderId) throws SQLException {
        Connection con = DBContext.getConnection();
        PreparedStatement stm = con.prepareStatement("delete from OrderDetail where orderHeaderId=?");
        stm.setInt(1, orderHeaderId);
        stm.executeUpdate();
        stm.close();
        
        stm = con.prepareStatement("delete from OrderHeader where id=?");
        stm.setInt(1, orderHeaderId);
        stm.executeUpdate();
        stm.close();
    }
    
}
