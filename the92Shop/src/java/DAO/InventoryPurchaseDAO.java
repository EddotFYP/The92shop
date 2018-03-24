/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import db.DatabaseConnection;
import entity.Inventory;
import entity.InventoryPurchase;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.HashMap;

/**
 *
 * @author Jacquelyn
 */
public class InventoryPurchaseDAO {
     public InventoryPurchase retrieve(int skuId) {
        DatabaseConnection db = new DatabaseConnection();
        Connection conn = db.getConn();
        InventoryPurchase result = null;
        
        try {
            PreparedStatement stmt = conn.prepareStatement("select * from inventory where SKU_Id = ?");
            stmt.setInt(1, skuId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                int skuID = rs.getInt(1);
                int quantity = rs.getInt(2);
                String dateOfPurchase = rs.getString(3);
                
                result = new InventoryPurchase(skuID, quantity, dateOfPurchase);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        db.closeConn();
        return result;
    }
     
    //NAME + EXPENSES from purchasing of goods from supplier
    public HashMap<String,Double> retrieveGoodsNCost (int month, String year) {
        HashMap<String,Double> goodsList = new HashMap<String, Double>();
         try{
             DatabaseConnection db = new DatabaseConnection();
             Connection conn = db.getConn();
             
             
             PreparedStatement stmt = conn.prepareStatement(
                     "select name, ip.quantity*i.Cost_Price as totalCostOfGoods from inventory_purchase ip inner join inventory i  on i.SKU_Id = ip.SKU_Id where EXTRACT(month FROM Date_Of_Purchase)= '"+ month +"' and EXTRACT(year FROM Date_Of_Purchase)= '"+ year +"' group by ip.sku_id");
             ResultSet rs = stmt.executeQuery();
             
             
             while(rs.next()) {
                 String goodsType = rs.getString(1);
                 double goodsCost = rs.getDouble(2);
                 goodsList.put(goodsType, goodsCost);
             }
                     
         } catch (Exception e) {
            e.printStackTrace();
        }
         
         return goodsList;
    } 
    
    
    
      // DOUBLE EXPENSES from purchasing of goods from supplier
    public double retreiveGoodsCost(int month, String year){
         double totalCost = 0.0;
        try {
            DatabaseConnection db = new DatabaseConnection();
            Connection conn = db.getConn();
            PreparedStatement stmt = conn.prepareStatement("select sum(ip.quantity * Cost_Price) as totalCostOfGoods from inventory_purchase ip inner join inventory i  on i.SKU_Id = ip.SKU_Id where EXTRACT(month FROM Date_Of_Purchase)= '"+ month +"' AND EXTRACT(year FROM Date_Of_Purchase) = '"+ year +"'");           
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                double cost= rs.getDouble(1);
                totalCost += cost;
               
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return totalCost;
    
    }
    
    
}
