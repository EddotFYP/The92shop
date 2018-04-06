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
            PreparedStatement stmt = conn.prepareStatement("INSERT INTO user VALUES (?,?,?)");
            
            stmt.setString(1, user.getUsername());
            stmt.setString(2, user.getPassword());
            stmt.setInt(3, user.getIsOnline());
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
    
    public User retrieveUserAcc(String currPassword) {
        DatabaseConnection db = new DatabaseConnection();
        
        User result = null;
        
        try {

            Connection conn = db.getConn();

            PreparedStatement stmt = conn.prepareStatement("select * from user where password like ?");
            stmt.setString(1, currPassword + '%');
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
     
    public int editUser(User user, String passwordChange) {
        int updateQuery = 0;
        try {
            DatabaseConnection db = new DatabaseConnection();
            Connection conn = db.getConn();
            PreparedStatement stmt = conn.prepareStatement("UPDATE user SET Password = '" + passwordChange + "' where Name = ?");

            stmt.setString(1, user.getUsername());

            updateQuery = stmt.executeUpdate();
            System.out.println("return value is " + updateQuery);
            
            db.closeConn();


        } catch (Exception e) {
            e.printStackTrace();
        }
        return updateQuery;

    }
    
    public boolean isOnline(String username) {
        boolean isOnline = false;
        try {
            DatabaseConnection db = new DatabaseConnection();
            Connection conn = db.getConn();
            PreparedStatement stmt = conn.prepareStatement("select isOnline from `user` where Name = ?");

            stmt.setString(1, username);

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                int status = rs.getInt(1);
                
                if(status == 1){
                    isOnline = true;
                }
                
            }
            
            db.closeConn();


        } catch (Exception e) {
            e.printStackTrace();
        }
        return isOnline;

    }
    
    public void editUserLoginStatus(String username, int status) {
        
        try {
            DatabaseConnection db = new DatabaseConnection();
            Connection conn = db.getConn();
            PreparedStatement stmt = conn.prepareStatement("UPDATE user SET isOnline = '" + status + "' where Name = ?");

            stmt.setString(1, username);

            stmt.executeUpdate();
            
            
            db.closeConn();


        } catch (Exception e) {
            e.printStackTrace();
        }
        

    }
      
}
