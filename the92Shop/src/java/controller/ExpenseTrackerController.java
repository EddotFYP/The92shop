/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import DAO.ExpenseTrackerDAO;
import entity.ExpenseTracker;
import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Jacquelyn See
 */
@WebServlet(name = "ExpenseTrackerController", urlPatterns = {"/ExpenseTrackerController"})

public class ExpenseTrackerController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
      //  processRequest(request, response);
        /*try {
            
        } catch (ParseException ex) {
            Logger.getLogger(ExpenseTrackerController.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(ExpenseTrackerController.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(ExpenseTrackerController.class.getName()).log(Level.SEVERE, null, ex);
        } catch (InstantiationException ex) {
            Logger.getLogger(ExpenseTrackerController.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IllegalAccessException ex) {
            Logger.getLogger(ExpenseTrackerController.class.getName()).log(Level.SEVERE, null, ex);
        }*/
        
        response.setContentType("text/html;charset=UTF-8");
        // to add new Expenses 
        String addExpensesType = request.getParameter("expenseTypes");
        //System.out.println(addExpensesType);
        /*java.util.Date dateD = Calendar.getInstance().getTime();
        
        java.sql.Date dateSQL = new java.sql.Date(dateD.getTime());
        DateFormat df = new SimpleDateFormat("yyyy-MM-dd ");
        String today = df.format(dateSQL);
        
        */
       // java.util.Date date=new SimpleDateFormat("dd/MM/yyyy").parse(dat);
     //ctime=new java.sql.Date(date.getTime());
        //java.sql.Date sqlDate=null,ofrmonth=null,ctime=null;
      //  sqlDate = new java.sql.Date(date.getTime());
        String addDate = request.getParameter("date");
        
        String remark = request.getParameter("remark");
        //Double cost = Double.parseDouble(request.getParameter("cost"));
        String cost = request.getParameter("cost");
        ExpenseTracker expTracker = new ExpenseTracker(addDate,addExpensesType,remark,cost);
        
        ExpenseTrackerDAO expDAO= new ExpenseTrackerDAO();
       // expDAO.insertExpenseTracker(expTracker);
        int success = expDAO.insertExpenseTracker(expTracker);
           
        
        RequestDispatcher view = request.getRequestDispatcher("expenseForm.jsp");
         view.forward(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
