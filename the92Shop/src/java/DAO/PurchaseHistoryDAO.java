/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import db.DatabaseConnection;
import entity.Customer;
import entity.PurchaseHistory;
import static java.lang.System.out;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.LinkedHashMap;

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
                int custId = rs.getInt(1);
                String dateOfPurchase = rs.getString(2); 
                int quantity = rs.getInt(3);
                int skuId = rs.getInt(4);
                result = new PurchaseHistory(custId, dateOfPurchase, quantity,skuId);
                
            }
            db.closeConn();
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        
        return result;
    }
    
    public LinkedHashMap<Integer, String[]> sortByMonthYear() {

        LinkedHashMap<Integer, String[]> result = new LinkedHashMap<>();
        String[] array;
        int custId = 1;

        try {
            DatabaseConnection db = new DatabaseConnection();
            Connection conn = db.getConn();
            PreparedStatement stmt = conn.prepareStatement("select name,c.Phone_number,sum(cp.quantity) as qty,SUBSTRING(Date_Of_Purchase, 7, 1) as month, SUBSTRING(Date_Of_Purchase, 1, 4) as year from customer c inner join customer_purchase cp on c.Phone_number = cp.Phone_number group by name order by year ASC,month ASC,qty DESC");
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                
                custId++;
                String name = rs.getString(1);
                String phoneNum = rs.getString(2);
                String quantity = rs.getString(3);
                String month = rs.getString(4);
                String year = rs.getString(5);

                array = new String[]{name, phoneNum, quantity, month, year};

                result.put(custId, array);
            }
            db.closeConn();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return result;
    }

    public LinkedHashMap<Integer, String[]> sortByYear() {

        LinkedHashMap<Integer, String[]> result = new LinkedHashMap<>();
        String[] array;
        int custId = 1;

        try {
            DatabaseConnection db = new DatabaseConnection();
            Connection conn = db.getConn();
            PreparedStatement stmt = conn.prepareStatement("select name,c.Phone_number,SUBSTRING(Date_Of_Purchase, 1, 4) as year from customer c inner join customer_purchase cp on c.Phone_number = cp.Phone_number group by name order by year ASC,sum(cp.quantity) DESC");
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                custId++;
                String name = rs.getString(1);
                String phoneNum = rs.getString(2);
                String year = rs.getString(3);

                array = new String[]{name, phoneNum, year};

                result.put(custId, array);
            }
            db.closeConn();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return result;
    }

    public LinkedHashMap<Integer, String[]> retrieveMonthlySales() {

        LinkedHashMap<Integer, String[]> result = new LinkedHashMap<>();
        String[] array;
        int count = 1;

        try {
            DatabaseConnection db = new DatabaseConnection();
            Connection conn = db.getConn();
            PreparedStatement stmt = conn.prepareStatement("select SUBSTRING(Date_Of_Purchase, 1, 4) as year, SUBSTRING(Date_Of_Purchase, 7, 1) as month, sum(selling_price*cp.quantity) as sales from customer_purchase cp inner join inventory i on i.sku_id = cp.sku_id group by month,year order by year ASC, month ASC");
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                String year = rs.getString(1);
                String month = rs.getString(2);
                String sales = rs.getString(3);

                array = new String[]{year,month,sales};
                result.put(count, array);
                count++;

            }
            db.closeConn();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return result;
    }

    public ArrayList<Double> retrieveYearlySales() {

        ArrayList<Double> list = new ArrayList<>();

        try {
            DatabaseConnection db = new DatabaseConnection();
            Connection conn = db.getConn();
            PreparedStatement stmt = conn.prepareStatement("select SUBSTRING(Date_Of_Purchase, 1, 4) as year,sum(selling_price*cp.quantity) as sales from customer_purchase cp inner join inventory i on cp.sku_id = i.sku_id group by year order by year ASC");
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                String year = rs.getString(1);
                Double sales = rs.getDouble(2);

                //array = new String[]{sales};
                list.add(sales);
                 
            }
             for(Double s: list){
            out.println(s);
        }
            db.closeConn();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
    
    public LinkedHashMap<Integer, String[]> retrieveMonthlyGain() {

        LinkedHashMap<Integer, String[]> result = new LinkedHashMap<>();
        String[] array;
        int count = 1;

        try {
            DatabaseConnection db = new DatabaseConnection();
            Connection conn = db.getConn();
            PreparedStatement stmt = conn.prepareStatement("select SUBSTRING(Date_Of_Purchase, 1, 4) as year,SUBSTRING(Date_Of_Purchase, 7, 1) as month, sum((cp.quantity)*(selling_price-cost_price)) as gain from customer_purchase cp,inventory i where cp.sku_id = i.sku_id group by month,year order by year ASC,month ASC");
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                String year = rs.getString(1);
                String month = rs.getString(2);
                String gain = rs.getString(3);

                array = new String[]{year,month,gain};
                result.put(count, array);
                count++;
            }
            db.closeConn();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return result;
    }
     public LinkedHashMap<String, Double> retrieveYearlyGain() {

        LinkedHashMap<String, Double> result = new LinkedHashMap<>();
        String[] array;

        try {
            DatabaseConnection db = new DatabaseConnection();
            Connection conn = db.getConn();
            PreparedStatement stmt = conn.prepareStatement("select SUBSTRING(Date_Of_Purchase, 1, 4) as year,sum((cp.quantity)*(selling_price-cost_price)) as gain from customer_purchase cp,inventory i where cp.sku_id = i.sku_id group by year order by year ASC");
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                String year = rs.getString(1);
                Double gain = rs.getDouble(2);

                result.put(year, gain);
            }
            db.closeConn();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return result;
    }
    
    public int addRecord(PurchaseHistory p) {
        int updateQuery = 0;
        try {
            DatabaseConnection db = new DatabaseConnection();
            Connection conn = db.getConn();
            PreparedStatement stmt = conn.prepareStatement("INSERT INTO customer_purchase VALUES (?,?,?,?,?,?)");
            
            stmt.setInt(1, p.getOrderId());
            stmt.setInt(2, p.getCustId());
            stmt.setString(3, p.getPhoneNum());
            stmt.setInt(4, p.getQuantity());
            stmt.setString(5, p.getDateOfPurchase());
            stmt.setInt(6, p.getQuantity());
            
            

            updateQuery = stmt.executeUpdate();

            db.closeConn();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return updateQuery;
    }
    
    /*public ArrayList<PurchaseHistory> retrievePurchaseHistory() {
        DatabaseConnection db = new DatabaseConnection();
        Connection conn = db.getConn();
        ArrayList<PurchaseHistory> result = new ArrayList<>();

        try {
            PreparedStatement stmt = conn.prepareStatement("select * from customer_purchase");

            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                int orderId = rs.getInt(1);
                int custId = rs.getInt(2);
                String phone = rs.getString(3);
                int skuId = rs.getInt(4);
                String dateOfPurchase = rs.getString(5);
                int qty = rs.getInt(6);
                
                result.add(new PurchaseHistory(orderId, custId, phone, skuId, dateOfPurchase, qty));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        db.closeConn();
        return result;
    }*/
}
