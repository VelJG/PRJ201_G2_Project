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
                stm.setDouble(3, orderHeader.getTotalPrice());
                stm.setString(4, orderHeader.getStatus());
                int count = stm.executeUpdate();
                // Retrieve the generated ID
                try (ResultSet rs = stm.getGeneratedKeys()) {
                    if (rs.next()) {
                        orderHeader.setId(rs.getInt(1)); // Set the auto-generated ID
                    } else {
                        throw new SQLException("Inserting order failed, no ID obtained.");
                    }
                }
            }

            // Insert into OrderDetail using the generated orderHeaderId
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

            // Commit the transaction
            con.commit();
        } catch (SQLException ex) {
            try {
                con.rollback(); // Rollback on error
            } catch (SQLException ex1) {
                throw ex1;
            }
            throw ex;
        } finally {
            con.close(); // Ensure connection is closed
        }
    }

    public OrderHeader getOrderById(int orderId) throws SQLException, ClassNotFoundException {
        OrderHeader orderHeader = null;
        Connection con = DBContext.getConnection();

        try {
            // Fetch OrderHeader
            String sql = "SELECT * FROM OrderHeader WHERE id = ?";
            try (PreparedStatement ps = con.prepareStatement(sql)) {
                ps.setInt(1, orderId);
                ResultSet rs = ps.executeQuery();
                if (rs.next()) {
                    orderHeader = new OrderHeader();
                    orderHeader.setId(rs.getInt("id"));
                    orderHeader.setAccountId(rs.getInt("accountId"));
                    orderHeader.setOrderDate(rs.getDate("orderDate"));
                    orderHeader.setTotalPrice(rs.getDouble("totalPrice"));
                    orderHeader.setStatus(rs.getString("status"));
                }
            }

            if (orderHeader != null) {
                // Fetch OrderDetails
                String detailSql = "SELECT * FROM OrderDetail WHERE orderHeaderId = ?";
                List<OrderDetail> details = new ArrayList<>();
                try (PreparedStatement ps = con.prepareStatement(detailSql)) {
                    ps.setInt(1, orderId);
                    ResultSet rs = ps.executeQuery();
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
                }
                orderHeader.setDetails(details);
            }

        } finally {
            con.close();
        }

        return orderHeader;
    }

    public List<OrderHeader> getOrders() throws SQLException, ClassNotFoundException {
        List<OrderHeader> orders = new ArrayList<>();
        Connection con = DBContext.getConnection();
        PreparedStatement ps = con.prepareStatement("SELECT * FROM OrderHeader");
                ResultSet rs = ps.executeQuery();
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

}
