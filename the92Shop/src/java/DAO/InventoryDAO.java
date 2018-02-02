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
import java.util.LinkedHashMap;

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
    
    public LinkedHashMap <Integer, String[]> sortByMonthYear() {

        LinkedHashMap <Integer, String[]> result = new LinkedHashMap<>();
        String[] array;
        int count = 1;

        try {
            DatabaseConnection db = new DatabaseConnection();
            Connection conn = db.getConn();
            PreparedStatement stmt = conn.prepareStatement("select name,sum(cp.quantity) as totalQty,EXTRACT(month FROM Date_Of_Purchase) as month, EXTRACT(year FROM Date_Of_Purchase) as year from inventory i inner join customer_purchase cp on i.SKU_Id = cp.SKU_Id group by cp.sku_id,month order by month ASC,year ASC,totalQty DESC");
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                String name = rs.getString(1);
                String quantity = rs.getString(2);
                String month = rs.getString(3);
                String year = rs.getString(4);
                
                array = new String[]{name,quantity, month, year};
                result.put(count,array);
                count++;
                
            }
            db.closeConn();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return result;
    }
    
    public LinkedHashMap <Integer, String[]> sortByYear() {

        LinkedHashMap <Integer, String[]> result = new LinkedHashMap<>();
        String[] array;
        int count = 1;

        try {
            DatabaseConnection db = new DatabaseConnection();
            Connection conn = db.getConn();
            PreparedStatement stmt = conn.prepareStatement("select name,sum(cp.quantity) as totalQty,EXTRACT(year FROM Date_Of_Purchase) as year from inventory i inner join customer_purchase cp on i.SKU_Id = cp.SKU_Id group by cp.sku_id,year order by year ASC,totalQty DESC");
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                String name = rs.getString(1);
                String quantity = rs.getString(2);
                String year = rs.getString(3);
                
                array = new String[]{name,quantity, year};
                result.put(count,array);
                
                count++;
            }
            db.closeConn();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return result;
    }
    
    public ArrayList<Inventory> retrieveLowInventory() {

        Inventory inv = null;
        ArrayList<Inventory> invList = new ArrayList<>();

        try {
            DatabaseConnection db = new DatabaseConnection();
            Connection conn = db.getConn();
            PreparedStatement stmt = conn.prepareStatement("SELECT SKU_Id,Name, Quantity FROM inventory WHERE Quantity < 30 order by quantity ASC");
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {

                String SKUId = rs.getString(1);
                String name = rs.getString(2);
                int quantity = rs.getInt(3);

                inv = new Inventory(SKUId, name, quantity);
                invList.add(inv);
            }
            db.closeConn();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return invList;
    }

    public int retrieveInventoryAlert() {

        int quantity = 0;

        try {
            DatabaseConnection db = new DatabaseConnection();
            Connection conn = db.getConn();
            PreparedStatement stmt = conn.prepareStatement("SELECT count(Quantity) FROM inventory WHERE Quantity < 30");
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                quantity = rs.getInt(1);
            }
            db.closeConn();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return quantity;
    }
    
    
}
