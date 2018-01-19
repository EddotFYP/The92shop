/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import db.DatabaseConnection;
import entity.Inventory;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

/**
 *
 * @author Brendo Austin
 */
public class InventoryDAO {
    private ArrayList<Inventory> inventoryList; 
    
    public Inventory retrieve(String skuId) {
        DatabaseConnection db = new DatabaseConnection();
        Connection conn = db.getConn();
        Inventory result = null;
        
        try {
            PreparedStatement stmt = conn.prepareStatement("select * from inventory where SKU_Id = '" + skuId + "'");
            stmt.setString(1, skuId + '%');
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                String skuID = rs.getString(1);
                String name = rs.getString(2);
                int quantity = rs.getInt(3);
                Date dateOfPurchase = rs.getDate(4);
                double costPrice = rs.getDouble(5);
                double sellingPrice = rs.getDouble(6);
                result = new Inventory (skuID, name, quantity, dateOfPurchase, costPrice, sellingPrice );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        db.closeConn();
        return result;
    }
    
    public ArrayList<Inventory> retrieveInventoryWithQuantityAtLeast(int number) {
        DatabaseConnection db = new DatabaseConnection();
        Connection conn = db.getConn();
        ArrayList<Inventory> toReturn = new ArrayList<>();
        
        try {
            PreparedStatement stmt = conn.prepareStatement("select * from inventory where quantity >= '" + number + "'");
            
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                String skuID = rs.getString(1);
                String name = rs.getString(2);
                int quantity = rs.getInt(3);
                Date dateOfPurchase = rs.getDate(4);
                double costPrice = rs.getDouble(5);
                double sellingPrice = rs.getDouble(6);
                toReturn.add(new Inventory (skuID, name, quantity, dateOfPurchase, costPrice, sellingPrice));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        db.closeConn();
        return toReturn;
    }
    
    public ArrayList<Inventory> retrieveInventoryWithQuantityBelow(int number){
        DatabaseConnection db = new DatabaseConnection();
        Connection conn = db.getConn();
        ArrayList<Inventory> toReturn = new ArrayList<>();
        
        try {
            PreparedStatement stmt = conn.prepareStatement("select * from inventory where quantity < '" + number + "'");
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                String skuID = rs.getString(1);
                String name = rs.getString(2);
                int quantity = rs.getInt(3);
                Date dateOfPurchase = rs.getDate(4);
                double costPrice = rs.getDouble(5);
                double sellingPrice = rs.getDouble(6);
                toReturn.add(new Inventory (skuID, name, quantity, dateOfPurchase, costPrice, sellingPrice));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        db.closeConn();
        return toReturn;
        
    }
    
    public ArrayList<Inventory> retrieveInventoryPurchasedBefore(String date){
        DatabaseConnection db = new DatabaseConnection();
        Connection conn = db.getConn();
        ArrayList<Inventory> toReturn = new ArrayList<>();
        
        try {
            PreparedStatement stmt = conn.prepareStatement("select * from inventory where Date_Of_Purchase < '" + date + "'");
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                String skuID = rs.getString(1);
                String name = rs.getString(2);
                int quantity = rs.getInt(3);
                Date dateOfPurchase = rs.getDate(4);
                double costPrice = rs.getDouble(5);
                double sellingPrice = rs.getDouble(6);
                toReturn.add(new Inventory (skuID, name, quantity, dateOfPurchase, costPrice, sellingPrice));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        db.closeConn();
        return toReturn;
    }
    
    public ArrayList<Inventory> retrieveInventoryPurchasedBetween(String startDate, String endDate){
        DatabaseConnection db = new DatabaseConnection();
        Connection conn = db.getConn();
        ArrayList<Inventory> toReturn = new ArrayList<>();
        
        try {
            PreparedStatement stmt = conn.prepareStatement("select * from inventory where Date_Of_Purchase Between '" + startDate + "' and '" + endDate + "'");
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                String skuID = rs.getString(1);
                String name = rs.getString(2);
                int quantity = rs.getInt(3);
                Date dateOfPurchase = rs.getDate(4);
                double costPrice = rs.getDouble(5);
                double sellingPrice = rs.getDouble(6);
                toReturn.add(new Inventory (skuID, name, quantity, dateOfPurchase, costPrice, sellingPrice));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        db.closeConn();
        return toReturn;
    }
    
    
}
