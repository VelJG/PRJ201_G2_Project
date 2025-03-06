/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package db;

import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;

/**
 *
 * @author PHT
 */
public class OrderHeaderFacade {

    public void insert(OrderHeader orderHeader) throws ClassNotFoundException, SQLException {
        //Tao ket noi database
        Connection con = DBContext.getConnection();

        try {
            //Bắt đầu transaction
            con.setAutoCommit(false);
            //Insert data vào table OrderHeader
            PreparedStatement stm = con.prepareStatement("insert into OrderHeader values(?, ?, ?, ?)",
                    Statement.RETURN_GENERATED_KEYS);
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            stm.setString(1, sdf.format(orderHeader.getDate()));
            stm.setString(2, orderHeader.getStatus());
            stm.setInt(3, orderHeader.getCustomerId());
            stm.setInt(4, orderHeader.getEmployeeId());
            int count = stm.executeUpdate();

            //Lấy account id được phát sinh tự động
            try (ResultSet rs = stm.getGeneratedKeys()) {
                if (rs.next()) {
                    orderHeader.setId(rs.getInt(1));
                } else {
                    throw new SQLException("Inserting order failed.");
                }
            }

            //Insert data vào table OrderDetail
            stm = con.prepareStatement("insert into OrderDetail values(?, ?, ?, ?, ?)");
            for (OrderDetail orderDetail : orderHeader.getDetails()) {
                stm.setInt(1, orderHeader.getId());
                stm.setInt(2, orderDetail.getProductId());
                stm.setInt(3, orderDetail.getQuantity());
                stm.setDouble(4, orderDetail.getPrice());
                stm.setDouble(5, orderDetail.getDiscount());
                count = stm.executeUpdate();
            }
            //Kết thúc transaction
            con.commit();
        } catch (SQLException ex) {
            try {
                //Undo transaction
                con.rollback();
            } catch (SQLException ex1) {
                throw ex1;
            }
            throw ex;
        }

        //Dong ket noi database
        con.close();
    }
}
