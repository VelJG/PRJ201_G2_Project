/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package db;

import java.io.File;
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
                laptop.setModel(rs.getString("model"));
                laptop.setName(rs.getString("name"));
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
                laptop.setModel(rs.getString("model"));
                laptop.setName(rs.getString("name"));
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
                laptop.setModel(rs.getString("model"));
                laptop.setName(rs.getString("name"));
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
        PreparedStatement stm = con.prepareStatement(
                "update Laptop " +
                        "set description=?, price=?, brand=?, model=?, name=? " +
                        "where id=?");
        stm.setString(1, laptop.getDescription());
        stm.setDouble(2, laptop.getPrice());
        stm.setString(3, laptop.getBrand());
        stm.setString(4, laptop.getModel());
        stm.setString(5, laptop.getName());
        stm.setInt(6, laptop.getId());
        int count = stm.executeUpdate();
        con.close();

    }

    public void delete(int id, String uploadPath) throws SQLException {

        File file = new File(uploadPath + File.separator + id + ".png");
        if (file.exists()) {
            file.delete();
        }

        Connection con = DBContext.getConnection();

        PreparedStatement stm = con.prepareStatement("delete from OrderDetail where laptopId=?");
        stm.setInt(1, id);
        stm.executeUpdate();
        stm.close();

        stm = con.prepareStatement("delete from Laptop where id=?");
        stm.setInt(1, id);
        int count = stm.executeUpdate();
        con.close();
    }

    public void create(Laptop laptop) throws SQLException {
        Connection con = DBContext.getConnection();
        PreparedStatement stm = con.prepareStatement("insert Laptop values (?,?,?,?,?)");
        stm.setString(1, laptop.getName());
        stm.setString(2, laptop.getBrand());
        stm.setString(3, laptop.getModel());
        stm.setDouble(4, laptop.getPrice());
        stm.setString(5, laptop.getDescription());
        int count = stm.executeUpdate();
        con.close();
    }

    public List<Laptop> search(String search) throws SQLException {
        List<Laptop> list = new ArrayList<>();
        Connection con = DBContext.getConnection();
        PreparedStatement stm = con.prepareStatement(
                "select * " +
                        "from Laptop " +
                        "where model " +
                        "like ? or brand like ? or name like ?");
        stm.setString(1, "%" + search + "%");
        stm.setString(2, "%" + search + "%");
        stm.setString(3, "%" + search + "%");
        ResultSet rs = stm.executeQuery();
        while (rs.next()) {
            Laptop laptop = new Laptop();
            laptop.setId(rs.getInt("id"));
            laptop.setBrand(rs.getString("brand"));
            laptop.setModel(rs.getString("model"));
            laptop.setPrice(rs.getDouble("price"));
            laptop.setName(rs.getString("name"));
            list.add(laptop);
        }

        return list;
    }

    public List<Laptop> priceDesc(int page, int pageSize) throws SQLException {
        List<Laptop> list = new ArrayList<>();
        Connection con = DBContext.getConnection();
        PreparedStatement stm = con.prepareStatement(
                "select * " +
                "from Laptop " +
                "order by price desc " +
                "offset ? rows fetch next ? rows only");
        stm.setInt(1, (page - 1) * pageSize);
        stm.setInt(2, pageSize);
        ResultSet rs = stm.executeQuery();
        while (rs.next()) {
            Laptop laptop = new Laptop();
            laptop.setId(rs.getInt("id"));
            laptop.setBrand(rs.getString("brand"));
            laptop.setModel(rs.getString("model"));
            laptop.setPrice(rs.getDouble("price"));
            laptop.setName(rs.getString("name"));
            list.add(laptop);
        }
        return list;
    }

    public List<Laptop> priceAsc(int page, int pageSize) throws SQLException {
        List<Laptop> list = new ArrayList<>();
        Connection con = DBContext.getConnection();
        PreparedStatement stm = con.prepareStatement("select * " +
                "from Laptop " +
                "order by price asc " +
                "offset ? rows fetch next ? rows only");
        stm.setInt(1, (page - 1) * pageSize);
        stm.setInt(2, pageSize);
        ResultSet rs = stm.executeQuery();
        while (rs.next()) {
            Laptop laptop = new Laptop();
            laptop.setId(rs.getInt("id"));
            laptop.setBrand(rs.getString("brand"));
            laptop.setModel(rs.getString("model"));
            laptop.setPrice(rs.getDouble("price"));
            laptop.setName(rs.getString("name"));
            list.add(laptop);
        }
        return list;
    }

    public int getNextId() throws SQLException {
        int id = -1;
        Connection con = DBContext.getConnection();
        PreparedStatement stm = con.prepareStatement("select max(id) from Laptop");
        ResultSet rs = stm.executeQuery();
        if (rs.next()) {
            id = rs.getInt(1);
        }
        return id;
    }
}
