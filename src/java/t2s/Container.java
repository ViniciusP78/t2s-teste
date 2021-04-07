/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package t2s;

import java.sql.*;
import java.util.ArrayList;
import t2s.DBListener;

/**
 *
 * @author Vinic
 */
public class Container {
    public String container;
    public String client;
    public int type;
    public int status;
    public int category;

    public Container(String container, String client, int type, int status, int category) {
        this.container = container;
        this.client = client;
        this.type = type;
        this.status = status;
        this.category = category;
    }
    
    public static ArrayList<Container> getList(){
    ArrayList<Container> list = new ArrayList<>();
    Connection conn = null;
    Statement stmt = null;
    ResultSet rs = null;
    
    try {
        conn = DBListener.getConnection();
        stmt = conn.createStatement();
        rs = stmt.executeQuery("SELECT * from containers");
        while(rs.next()){
            list.add(new Container(
                    rs.getString("container"),
                    rs.getString("client"),
                    rs.getInt("type"),
                    rs.getInt("status"),
                    rs.getInt("category")
            ));
        }
    } catch(Exception ex){
        System.out.println(ex);
    }
    
    return list;
    }
    
    public static void insert(String container, String client, int type, int status, int category) throws Exception {
        Connection conn = null;
        PreparedStatement stmt = null;
        
        conn = DBListener.getConnection();
        stmt = conn.prepareStatement("INSERT INTO containers VALUES(?,?,?,?,?);");
        stmt.setString(1, container);
        stmt.setString(2, client);
        stmt.setInt(3, type);
        stmt.setInt(4, status);
        stmt.setInt(5, category);
        stmt.execute();
        
    }
    
    public static void delete(String container) throws Exception {
        Connection conn = null;
        PreparedStatement stmt = null;
        conn = DBListener.getConnection();
        stmt = conn.prepareStatement("DELETE FROM containers WHERE container = ?");
        stmt.setString(1, container);
        stmt.execute();
    }
}
