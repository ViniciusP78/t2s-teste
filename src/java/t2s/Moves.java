/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package t2s;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

/**
 *
 * @author Vinic
 */
public class Moves {
    public long rowid;
    public String container;
    public int moveType;
    public String start;
    public String end;

    public Moves(long rowid, String container, int moveType, String start, String end) {
        this.rowid = rowid;
        this.container = container;
        this.moveType = moveType;
        this.start = start;
        this.end = end;
    }
    
    public static ArrayList<Moves> getList(){
    ArrayList<Moves> list = new ArrayList<>();
    Connection conn = null;
    Statement stmt = null;
    ResultSet rs = null;
    
    try {
        conn = DBListener.getConnection();
        stmt = conn.createStatement();
        rs = stmt.executeQuery("SELECT rowid, * from moves");
        while(rs.next()){
            list.add(new Moves(
                    rs.getLong("rowid"),
                    rs.getString("container"),
                    rs.getInt("moveType"),
                    rs.getString("start"),
                    rs.getString("end")
            ));
        }
    } catch(Exception ex){
        System.out.println(ex);
    }
    
    return list;
    }
    
    public static void insert(String container, int moveType, String start, String end) throws Exception {
        Connection conn = null;
        PreparedStatement stmt = null;
        
        conn = DBListener.getConnection();
        stmt = conn.prepareStatement("INSERT INTO moves VALUES(?,?,?,?);");
        stmt.setString(1, container);
        stmt.setInt(2, moveType);
        stmt.setString(3, start);
        stmt.setString(4, end);
        stmt.execute();
    }
    
    public static void delete(long rowid) throws Exception {
        Connection conn = null;
        PreparedStatement stmt = null;
        conn = DBListener.getConnection();
        stmt = conn.prepareStatement("DELETE FROM moves WHERE rowid = ?");
        stmt.setLong(1, rowid);
        stmt.execute();
    }

}