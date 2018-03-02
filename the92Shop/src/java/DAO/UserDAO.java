/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import db.DatabaseConnection;
import entity.User;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

/**
 *
 * @author Clarey Liow JX
 */
public class UserDAO {
    private ArrayList<User> users;
    
    public UserDAO() {

    }
    
     public User retrieve(String username) {
        DatabaseConnection db = new DatabaseConnection();
        
        User result = null;
        
        try {

            Connection conn = db.getConn();

            PreparedStatement stmt = conn.prepareStatement("select * from user where name like ?");
            stmt.setString(1, username + '%');
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                String name = rs.getString(1);
                String password = rs.getString(2);
                result = new User(name, password);
            }
            db.closeConn();
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        
        return result;
    }
     
    public int addUser(User user) {
        int updateQuery = 0;
        try {
            DatabaseConnection db = new DatabaseConnection();
            Connection conn = db.getConn();
            PreparedStatement stmt = conn.prepareStatement("INSERT INTO user VALUES (?,?)");
            
            stmt.setString(1, user.getUsername());
            stmt.setString(2, user.getPassword());

            updateQuery = stmt.executeUpdate();

            db.closeConn();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return updateQuery;

    }
    
    public ArrayList<User> retrieveAllUsers() {
        ArrayList<User> userList = new ArrayList<>();
        DatabaseConnection db = new DatabaseConnection();
        Connection conn = db.getConn();

        try {
            PreparedStatement stmt = conn.prepareStatement("select * from user");
            ResultSet rs = stmt.executeQuery();
            
            while(rs.next()){
                String name = rs.getString(1);
                String password = rs.getString(2);
                userList.add(new User(name,password));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        db.closeConn();
        return userList;
    }

}
