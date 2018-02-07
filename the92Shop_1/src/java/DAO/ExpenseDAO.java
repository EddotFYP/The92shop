/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import db.DatabaseConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.LinkedHashMap;

/**
 *
 * @author Clarey Liow JX
 */
public class ExpenseDAO {
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
