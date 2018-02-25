/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import db.DatabaseConnection;
import entity.ExpenseTypes;
import java.sql.Connection;
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
public class ExpenseTypesDAO {
   
    
   public ArrayList<ExpenseTypes> getAllExpenseTypes() {
        ArrayList<ExpenseTypes> expenseTypeList = new ArrayList<>();
        DatabaseConnection db = new DatabaseConnection();
        Connection conn = db.getConn();
        try {
           
            PreparedStatement stmt = conn.prepareStatement("select * from expensetypes");
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                String expense_type = rs.getString(1);
                

                expenseTypeList.add(new ExpenseTypes(expense_type));

            }
            db.closeConn();
        } catch (Exception e) {
            e.printStackTrace();
        }
         
        return expenseTypeList;
   
   }
    
    
   /* public void insertExpenseTypes(List<ExpenseTypes> expenseTypesList) throws SQLException, ClassNotFoundException, InstantiationException, IllegalAccessException {
        DatabaseConnection db = new DatabaseConnection();
        Connection conn = db.getConn();
        //set to false so that SQL Statements can be group into transactions
        conn.setAutoCommit(false);

       

        PreparedStatement stmt = conn.prepareStatement("INSERT INTO expensetypes VALUES (?)");

        for (ExpenseTypes e : expenseTypesList) {
            stmt.setString(1, rs.getString(1));
            stmt.addBatch();
            
        }

        stmt.executeBatch();
        conn.commit();
        db.closeConn();
    }
    */
   
   public int addExpenseType(ExpenseTypes expType) {
        int updateQuery = 0;
        try {
            DatabaseConnection db = new DatabaseConnection();
            Connection conn = db.getConn();
            PreparedStatement stmt = conn.prepareStatement("INSERT INTO expensetypes VALUES (?)");
             
            stmt.setString(1, expType.getExpType());
           

            updateQuery = stmt.executeUpdate();

            db.closeConn();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return updateQuery;

    }
        
        public int deleteSpecifiedExpense(String expenseType) {
        int updateQuery = 0;
        
        try {
            DatabaseConnection db = new DatabaseConnection();
            Connection conn = db.getConn();
            PreparedStatement stmt = conn.prepareStatement("delete from expensetypes where expenseType = ?");
            stmt.setString(1, expenseType);
            updateQuery = stmt.executeUpdate();
            db.closeConn();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return updateQuery;

    }
   
   public LinkedHashMap<String, Double> retrieveYearlyExpense() {
        LinkedHashMap<String, Double> list = new LinkedHashMap<>();
        

        try {
            DatabaseConnection db = new DatabaseConnection();
            Connection conn = db.getConn();
            PreparedStatement stmt = conn.prepareStatement("select SUBSTRING(date, 1, 4) as year,sum(cost) from expensetracker group by year order by year ASC");
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
            PreparedStatement stmt = conn.prepareStatement("select SUBSTRING(date, 1, 4) as year, SUBSTRING(date, 7, 1) as month, sum(cost) as expense from expensetracker e group by month,year order by year ASC, month ASC");
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

