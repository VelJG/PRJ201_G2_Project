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
            account=new Account();
            account.setId(rs.getInt("id"));
            account.setEmail(rs.getString("email"));
            account.setPassword(rs.getString("password"));
            account.setFullName(rs.getString("fullname"));
            account.setRole(rs.getString("role"));
        }
        return account;

    }
}
