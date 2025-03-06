/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 *
 * @author AN KHUONG
 */
public class DBContext {

    //Create a connection from the application to the database server
    public static Connection getConnection() throws SQLException {
        String url = "jdbc:sqlserver://localhost;databaseName=LaptopManagement;user=sa;password=12345";
        Connection con = null;
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            con = DriverManager.getConnection(url);
        } catch (Exception ex) {
            ex.printStackTrace();
            throw new SQLException(ex.getMessage());
        }
        return con;
    }
}
