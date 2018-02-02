/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import db.DatabaseConnection;
import entity.ExpenseTracker;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;

/**
 *
 * @author Jacquelyn
 */
public class ExpenseTrackerDAO {
    
    public ExpenseTrackerDAO(){
    
}
  //  private ArrayList<ExpenseTracker> expTrackers;
    
  
    //private Connection conn;
    //private PreparedStatement stmt;
  //  private ResultSet rs;
   /*
     public void insertExpenseTracker(ExpenseTracker exp) throws SQLException, ClassNotFoundException, InstantiationException, IllegalAccessException {
        DatabaseConnection db = new DatabaseConnection();
        conn = db.getConn();
        

        stmt = conn.prepareStatement("INSERT INTO expensetracker VALUES (?,?,?,?)");
            stmt.setDate(1, exp.getDate());
            stmt.setString(2, exp.getExpenseType());
            stmt.setString(3, exp.getRemark());
            stmt.setDouble(4, exp.getCost());
       
            
      
        stmt.executeUpdate();
       
        db.closeConn();
    }
    */
     
     public int insertExpenseTracker(ExpenseTracker exp) {
        int updateQuery = 0;
        try {
            DatabaseConnection db = new DatabaseConnection();
            Connection conn = db.getConn();
            PreparedStatement stmt = conn.prepareStatement("INSERT INTO expensetracker VALUES (?,?,?,?)");
             
            stmt.setString(1, exp.getDate());
            stmt.setString(2, exp.getExpenseType());
            stmt.setString(3, exp.getRemark());
            stmt.setString(4, exp.getCost());
          

            updateQuery = stmt.executeUpdate();

            db.closeConn();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return updateQuery;

    }
    
    /*
    public List<ExpenseTracker> getAllExpenseTypes() throws SQLException, ClassNotFoundException, InstantiationException, IllegalAccessException {
      
        DatabaseConnection db = new DatabaseConnection();
        conn = db.getConn();

        stmt = conn.prepareStatement("select * from ExpenseTracker");
        rs = stmt.executeQuery();
        List<ExpenseTracker> expList = new ArrayList<>();

        while (rs.next()) {
            Date date = rs.getDate("date");
            String expenseType = rs.getString("expenseType");
            String remark = rs.getString("remark");
            Double cost = rs.getDouble("cost");

            ExpenseTracker e = new ExpenseTracker(date, expenseType, remark, cost);
            expList.add(e);
        }
        db.closeConn();
        return expList;
    }
    
   
    */
    
    public LinkedHashMap<String, Double> retrieveYearlyExpense() {
        LinkedHashMap<String, Double> list = new LinkedHashMap<>();
        

        try {
            DatabaseConnection db = new DatabaseConnection();
            Connection conn = db.getConn();
            PreparedStatement stmt = conn.prepareStatement("select EXTRACT(year FROM date) as year,sum(cost) from expensetracker group by year order by year ASC");
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                String year = rs.getString(1);
                Double expense = rs.getDouble(2);

                list.put(year,expense);
            }
            db.closeConn();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
    
   
    
     public LinkedHashMap<Integer, String[]> retrieveMonthlyExpenses() {

        LinkedHashMap<Integer, String[]> result = new LinkedHashMap<>();
        String[] array;
        int count = 1;

        try {
            DatabaseConnection db = new DatabaseConnection();
            Connection conn = db.getConn();
            PreparedStatement stmt = conn.prepareStatement("select EXTRACT(year FROM date) as year, EXTRACT(MONTH FROM date) as month, sum(cost) as expense from expensetracker e group by month,year order by year ASC, month ASC");
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                String year = rs.getString(1);
                String month = rs.getString(2);
                String expense = rs.getString(3);

                array = new String[]{year,month, expense};
                result.put(count, array);
                count++;

            }
            db.closeConn();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return result;
    }

}

