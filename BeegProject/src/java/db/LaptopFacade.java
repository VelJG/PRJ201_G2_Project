/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author AN KHUONG
 */
public class LaptopFacade {

    public List<Laptop> select() throws SQLException {
        List<Laptop> list = null;
        try ( 
                Connection con = DBContext.getConnection()) {
            Statement stm = con.createStatement();
            ResultSet rs = stm.executeQuery("select * from Laptop");
            list = new ArrayList<>();
            while (rs.next()) {
                Laptop laptop = new Laptop();
                laptop.setId(rs.getInt("id"));
                laptop.setDescription(rs.getString("description"));
                laptop.setPrice(rs.getDouble("price"));
                laptop.setBrand(rs.getString("brand"));
                list.add(laptop);
            }
            con.close();
            return list;
        }
    }

    public List<Laptop> select(int page, int pageSize) throws SQLException {
        List<Laptop> list = null;
        try ( 
                Connection con = DBContext.getConnection()) {
            PreparedStatement stm = con.prepareStatement("select * from Laptop order by id offset ? rows fetch next ? rows only ");
            stm.setInt(1, (page - 1) * pageSize);
            stm.setInt(2, pageSize);
            ResultSet rs = stm.executeQuery();
            list = new ArrayList<>();
            while (rs.next()) {
                Laptop laptop = new Laptop();
                laptop.setId(rs.getInt("id"));
                laptop.setDescription(rs.getString("description"));
                laptop.setPrice(rs.getDouble("price"));
                laptop.setBrand(rs.getString("brand"));
                list.add(laptop);
            }
            con.close();
            return list;
        }
    }

    public Laptop select(int id) throws SQLException {
        
        try (
            Connection con = DBContext.getConnection()) {
            PreparedStatement stm = con.prepareStatement("select * from Laptop where id=?");
            stm.setInt(1, id);
            ResultSet rs = stm.executeQuery();
            Laptop laptop = new Laptop();
            if (rs.next()) {
                laptop.setId(rs.getInt("id"));
                laptop.setDescription(rs.getString("description"));
                laptop.setPrice(rs.getDouble("price"));
                laptop.setBrand(rs.getString("brand"));
            }
            con.close();
            return laptop;
        }
    }

    public int count() throws SQLException {
        int row_count = 0;
        Connection con = DBContext.getConnection();
        PreparedStatement stm = con.prepareStatement("select count(*) as row_count from Laptop");
        ResultSet rs = stm.executeQuery();
        while (rs.next()) {
            row_count = rs.getInt("row_count");
        }
        con.close();
        return row_count;
    }

   
    public void edit(Laptop laptop) throws SQLException {

        Connection con = DBContext.getConnection();
        PreparedStatement ps = con.prepareStatement("update Laptop set description=?, price=?, brand=? where id=?");
        ps.setString(1, laptop.getDescription());
        ps.setDouble(2, laptop.getPrice());
        ps.setString(3, laptop.getBrand());
        ps.setInt(4, laptop.getId());
        int count = ps.executeUpdate();
        con.close();

    }
}
