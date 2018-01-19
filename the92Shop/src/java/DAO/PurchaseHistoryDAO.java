/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import db.DatabaseConnection;
import entity.Customer;
import entity.PurchaseHistory;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

/**
 *
 * @author Clarey Liow JX
 */
public class PurchaseHistoryDAO {
    private ArrayList<PurchaseHistory> purchaseHistoryList;
    
    public PurchaseHistory retrieve(int sortValue) {
        DatabaseConnection db = new DatabaseConnection();
        
        PurchaseHistory result = null;
        
        try {
            Connection conn = db.getConn();
            PreparedStatement stmt = conn.prepareStatement("SELECT custId,sum(quantity) FROM `purchase_history` group by custId;");
            stmt.setInt(1, sortValue + '%');
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                String custId = rs.getString(1);
                String dateOfPurchase = rs.getString(2); 
                int quantity = rs.getInt(3);
                String skuId = rs.getString(4);
                result = new PurchaseHistory(custId, dateOfPurchase, quantity,skuId);
                
            }
            db.closeConn();
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        
        return result;
    }
    
    
}
