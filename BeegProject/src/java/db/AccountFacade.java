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
import utils.Hasher;

/**
 *
 * @author AN KHUONG
 */
public class AccountFacade {

    public Account read(String id) throws SQLException {
        Account account = new Account();
        Connection con = DBContext.getConnection();
        PreparedStatement stm = con.prepareStatement("select * from Account where id=?");
        stm.setString(1, id);
        ResultSet rs = stm.executeQuery();

        while (rs.next()) {
            account.setId(rs.getInt("id"));
            account.setEmail(rs.getString("email"));
            account.setPassword(rs.getString("password"));
            account.setFullName(rs.getString("fullname"));
            account.setRole(rs.getString("role"));

        }
        return account;
    }

    public Account login(String email, String password) throws SQLException, NoSuchAlgorithmException {

        Connection con = DBContext.getConnection();
        Account account = null;
        String hashed = Hasher.hash(password);
        PreparedStatement stm = con.prepareStatement("select * from Account where email= ? and password=?");
        stm.setString(1, email);
        stm.setString(2, hashed);
        ResultSet rs = stm.executeQuery();
        while (rs.next()) {
            account = new Account();
            account.setId(rs.getInt("id"));
            account.setEmail(rs.getString("email"));
            account.setPassword(rs.getString("password"));
            account.setFullName(rs.getString("fullname"));
            account.setRole(rs.getString("role"));
        }
        return account;

    }

    public void register(String email, String password, String fullName, String role)
            throws SQLException, NoSuchAlgorithmException {
        Connection con = null;
        PreparedStatement checkStmt = null;
        PreparedStatement insertStmt = null;

        try {
            con = DBContext.getConnection();

            // Kiểm tra xem email đã tồn tại chưa
            checkStmt = con.prepareStatement("SELECT COUNT(*) FROM Account WHERE email = ?");
            checkStmt.setString(1, email);
            ResultSet rs = checkStmt.executeQuery();
            if (rs.next() && rs.getInt(1) > 0) {
                throw new RuntimeException("Email already exists");
            }

            // Hash mật khẩu trước khi lưu vào cơ sở dữ liệu
            String hashedPassword = Hasher.hash(password);

            // Thêm tài khoản mới
            insertStmt = con.prepareStatement(
                    "INSERT INTO Account (email, password, fullname, role) VALUES (?, ?, ?, ?)");
            insertStmt.setString(1, email);
            insertStmt.setString(2, hashedPassword);
            insertStmt.setString(3, fullName);
            insertStmt.setString(4, role);
            insertStmt.executeUpdate();
        } finally {
            // Đảm bảo đóng kết nối và tài nguyên
            if (checkStmt != null) {
                checkStmt.close();
            }
            if (insertStmt != null) {
                insertStmt.close();
            }
            if (con != null) {
                con.close();
            }
        }
    }
}
