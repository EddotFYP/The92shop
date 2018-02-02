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

}

