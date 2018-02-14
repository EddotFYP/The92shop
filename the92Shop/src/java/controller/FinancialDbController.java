/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import DAO.ExpenseTrackerDAO;
import DAO.PurchaseHistoryDAO;
import java.io.IOException;
import java.io.PrintWriter;
import static java.lang.System.out;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.LinkedHashMap;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Clarey Liow JX
 */
@WebServlet(name = "FinancialDbController", urlPatterns = {"/FinancialDbController"})
public class FinancialDbController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String sortMonthlySales = request.getParameter("monthlySales");
        String yearlySales = request.getParameter("yearlyTrendSales");
        String sortMonthlyExpense = request.getParameter("monthlyExpenses");
        String yearlyExpenses = request.getParameter("yearData");
        String sortMonthlyProfits = request.getParameter("monthlyProfits");
        String yearlyProfits = request.getParameter("yearlyTrendProfits");

        PurchaseHistoryDAO custPurchaseDAO = new PurchaseHistoryDAO();
        ExpenseTrackerDAO expenseDAO = new ExpenseTrackerDAO();

        LinkedHashMap<String, Double> yearlyGain = new LinkedHashMap<>();
        LinkedHashMap<String, Double> yearlyExp = new LinkedHashMap<>();
        ArrayList<Double> yearlyProfitsResult = new ArrayList<>();
        
        LinkedHashMap<Integer, String[]> monthlyGain = new LinkedHashMap<>();
        ArrayList<Double> profitsResult = new ArrayList<>();
        
        LinkedHashMap<Integer, String[]> monthlySalesList = new LinkedHashMap<>();
        ArrayList<String> salesResult = new ArrayList<>();
        ArrayList<Double> yearlySalesResult = new ArrayList<>();
        
        LinkedHashMap<Integer, String[]> monthlyExpenseList = new LinkedHashMap<>();
        ArrayList<String> monthlyExpenseResult = new ArrayList<>();
        LinkedHashMap<String, Double> yearlyExpenseList = new LinkedHashMap<>();
        ArrayList<Double> yearlyExpenseResult = new ArrayList<>();
        
       
        //Monthly profits
        if (sortMonthlyProfits != null && !sortMonthlyProfits.isEmpty()) {
            
            monthlyGain = custPurchaseDAO.retrieveMonthlyGain();
            monthlyExpenseList = expenseDAO.retrieveMonthlyExpenses();
            
            profitsResult = retrieveMonthlyProfits(sortMonthlyProfits, monthlyGain, monthlyExpenseList);
         
            request.setAttribute("sortMonthlyProfits", sortMonthlyProfits);
            request.setAttribute("profitsResult", profitsResult);
            RequestDispatcher view = request.getRequestDispatcher("financialDb.jsp");
            view.forward(request, response);
            return;
        }else if (sortMonthlySales != null && !sortMonthlySales.isEmpty()) {
            //Monthly sales
            
            monthlySalesList = custPurchaseDAO.retrieveMonthlySales();
            salesResult = sortListMonthly(sortMonthlySales, monthlySalesList);
            
            request.setAttribute("sortMonthlySales", sortMonthlySales);
            request.setAttribute("salesResult", salesResult);
            RequestDispatcher view = request.getRequestDispatcher("sales.jsp");
            view.forward(request, response);
            return;
        }else if (sortMonthlyExpense != null && !sortMonthlyExpense.isEmpty()) {
             //Monthly Expense
            monthlyExpenseList = expenseDAO.retrieveMonthlyExpenses();
            monthlyExpenseResult = sortListMonthly(sortMonthlyExpense, monthlyExpenseList);

            request.setAttribute("expenseResult", monthlyExpenseResult);
            request.setAttribute("sortMonthlyExpense", sortMonthlyExpense);
            RequestDispatcher view = request.getRequestDispatcher("expenses.jsp");
            view.forward(request, response);
            return;
        }else if (yearlyProfits != null) {
             //Yearly trend for profits
            yearlyGain = custPurchaseDAO.retrieveYearlyGain();
            yearlyExp = expenseDAO.retrieveYearlyExpense();
            yearlyProfitsResult = retrieveYearlyProfits(yearlyGain, yearlyExp);
            
            request.setAttribute("yearlyProfitsResult", yearlyProfitsResult);
            RequestDispatcher view = request.getRequestDispatcher("financialDb.jsp");
            view.forward(request, response);
            return;
        }else if (yearlySales != null) {
            //Yearly trend for sales
            yearlySalesResult = custPurchaseDAO.retrieveYearlySales();
            
            request.setAttribute("yearlySalesResult", yearlySalesResult);
            RequestDispatcher view = request.getRequestDispatcher("sales.jsp");
            view.forward(request, response);
            return;
        }else if (yearlyExpenses != null) {
            //Yearly trend for expense
            
            yearlyExpenseList = expenseDAO.retrieveYearlyExpense();
            yearlyExpenseResult = retrieveExpense(yearlyExpenseList);
            
           

            request.setAttribute("yearlyExpensesResult", yearlyExpenseResult);
            RequestDispatcher view = request.getRequestDispatcher("expenses.jsp");
            view.forward(request, response);
            return;
        }
 
    } 
    
    public ArrayList<String> sortListMonthly(String sortMonthly, LinkedHashMap<Integer, String[]> list) {
        ArrayList<String> resultList = new ArrayList<>();

        for (int count : list.keySet()) {
            String year = list.get(count)[0];
            String month = list.get(count)[1];
            String type = list.get(count)[2];

            if (year.equals(sortMonthly)) {
                resultList.add(type);

            }
        }

        return resultList;
    }
    
    public ArrayList<Double> retrieveExpense(LinkedHashMap<String, Double> list) {
        ArrayList<Double> resultList = new ArrayList<>();

        for (String year : list.keySet()) {
            Double expense = list.get(year);
            resultList.add(expense);
        }

        return resultList;
    }
    
     public ArrayList<Double> retrieveYearlyProfits(LinkedHashMap<String, Double> gainList, LinkedHashMap<String, Double> expenseList) {
        ArrayList<Double> result = new ArrayList<>();

        for (String year : gainList.keySet()) {
            double gain = gainList.get(year);
            double profit = 0;

            for (String yr : expenseList.keySet()) {
                double expense = expenseList.get(yr);
                if (yr.equals(year)) {
                    profit = gain - expense;
                    result.add(profit);
                }
            }
        }

        return result;
    }
     
      public ArrayList<Double> retrieveMonthlyProfits(String sortMonthly, LinkedHashMap<Integer, String[]> gainList, LinkedHashMap<Integer, String[]> expenseList) {
        ArrayList<Double> result = new ArrayList<>();

        for (int gainId : gainList.keySet()) {
            String year = gainList.get(gainId)[0];
            String month = gainList.get(gainId)[1];
            String gain = gainList.get(gainId)[2];
            double gainAmt = Double.parseDouble(gain);

            double profit = 0;

            for (int expenseId : expenseList.keySet()) {
                String yr = expenseList.get(expenseId)[0];
                String mth = expenseList.get(expenseId)[1];
                String expense = expenseList.get(expenseId)[2];
                double expenseAmt = Double.parseDouble(expense);

                if (yr.equals(year) && month.equals(mth) && yr.equals(sortMonthly)) {
                    profit = gainAmt - expenseAmt;
                    result.add(profit);
                }
            }
        }

        return result;
    }

// <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
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
