/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package t2s;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import java.sql.*;
/**
 * Web application lifecycle listener.
 *
 * @author Vinic
 */
public class DBListener implements ServletContextListener {
    private static final String CLASS_NAME = "org.sqlite.JDBC";
    private static final String DB_URL = "jdbc:sqlite:C:\\t2s.db";
    
    public static Connection getConnection() throws Exception {
        return DriverManager.getConnection(DB_URL);
    }
    
    @Override
    public void contextInitialized(ServletContextEvent sce) {
        Connection con = null;
        Statement stmt = null;
        
        try {
            Class.forName(CLASS_NAME);
            con = getConnection();
            stmt = con.createStatement();
            String sql1 = "CREATE TABLE IF NOT EXISTS containers ("
                    + "container VARCHAR(255) UNIQUE PRIMARY KEY,"
                    + "client VARCHAR(255) NOT NULL,"
                    + "type int NOT NULL,"
                    + "status int NOT NULL,"
                    + "category int NOT NULL"
                    + ");";
            String sql2 = "CREATE TABLE IF NOT EXISTS moves ("
                    + "container VARCHAR(255) NOT NULL,"
                    + "moveType int NOT NULL,"
                    + "start DATETIME NOT NULL,"
                    + "end DATETIME NOT NULL"
                    + ");";
            stmt.addBatch(sql1);
            stmt.addBatch(sql2);
            stmt.executeBatch();
                    
        } catch (Exception ex) {
            System.out.println(ex.getMessage());
        }
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
    }
}
