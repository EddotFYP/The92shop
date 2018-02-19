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
 * @author admin
 */
public class DatabaseConnection {

    private Connection conn;

    public DatabaseConnection() {

        initialiseConnection();

    }

    private void initialiseConnection() {
        try {
            Class.forName("com.mysql.jdbc.Driver");
             // grab environment variable to check if we are on production environment
            String osName = System.getProperty("os.name");
            if (osName.equals("Linux")) {
                // in production environment, use aws.db.password
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/the92shop?rewriteBatchedStatements=true", "root", "4LYqG1BZLLcr");
            } else {
                // in local environment, use db.password
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/the92shop?rewriteBatchedStatements=true", "root", "");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public Connection getConn() {
        return conn;
    }

    public void closeConn(){
        
        try{
            if(conn!=null){
                conn.close();
            }
        }catch(SQLException se){
            se.printStackTrace();
        }
      
    }

}
