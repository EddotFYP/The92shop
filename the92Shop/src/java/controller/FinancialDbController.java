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
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
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
        LinkedHashMap<String, String> yearlyProfitsResult = new LinkedHashMap<>();
        ArrayList<String> yearInProfits = new ArrayList<>();
        ArrayList<String> profitInProfits = new ArrayList<>();
        
        LinkedHashMap<Integer, String[]> monthlyGain = new LinkedHashMap<>();
        ArrayList<Double> profitsResults = new ArrayList<>();
        
        LinkedHashMap<Integer, String[]> monthlySalesList = new LinkedHashMap<>();
        ArrayList<String> salesResult = new ArrayList<>();
        LinkedHashMap<String, Double> yearlySalesResult = new LinkedHashMap<>();
        
        LinkedHashMap<Integer, String[]> monthlyExpenseList = new LinkedHashMap<>();
        ArrayList<String> monthlyExpenseResult = new ArrayList<>();
        LinkedHashMap<String, Double> yearlyExpenseList = new LinkedHashMap<>();
        LinkedHashMap<String, String> yearlyExpenseResult = new LinkedHashMap<>();
        
       
        //Monthly profits
        if (sortMonthlyProfits != null && !sortMonthlyProfits.isEmpty()) {
            
            monthlyGain = custPurchaseDAO.retrieveMonthlyGain();
          
            monthlyExpenseList = expenseDAO.retrieveMonthlyExpenses();
            
            profitsResults = retrieveMonthlyProfits(sortMonthlyProfits, monthlyGain, monthlyExpenseList);
         
            request.setAttribute("sortMonthlyProfits", sortMonthlyProfits);
            request.setAttribute("profitsResults", profitsResults);
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
            
            for(String year: yearlyProfitsResult.keySet()){
                String profit = yearlyProfitsResult.get(year);
                //System.out.println(year);
                yearInProfits.add(year);
                profitInProfits.add(profit);
            }
            request.setAttribute("yearInProfits", yearInProfits);
            request.setAttribute("profitInProfits", profitInProfits);
            RequestDispatcher view = request.getRequestDispatcher("financialDb.jsp");
            view.forward(request, response);
            return;
        }else if (yearlySales != null) {
            //Yearly trend for sales
            yearlySalesResult = custPurchaseDAO.retrieveYearlySales();
            
            ArrayList<String> yearInSales = new ArrayList<>();
            ArrayList<String> salesInSales = new ArrayList<>();
            
            for(String year: yearlySalesResult.keySet()){
                double sales = yearlySalesResult.get(year);
                yearInSales.add(year);
                salesInSales.add(Double.toString(sales));
            }
            request.setAttribute("yearInSales", yearInSales);
            request.setAttribute("salesInSales", salesInSales);
            RequestDispatcher view = request.getRequestDispatcher("sales.jsp");
            view.forward(request, response);
            return;
        }else if (yearlyExpenses != null) {
            //Yearly trend for expense
            
            yearlyExpenseList = expenseDAO.retrieveYearlyExpense();
            yearlyExpenseResult = retrieveExpense(yearlyExpenseList);
            
            ArrayList<String> yearInExpense = new ArrayList<>();
            ArrayList<String> expInExpense = new ArrayList<>();
            
            for(String year: yearlyExpenseResult.keySet()){
                String expense = yearlyExpenseResult.get(year);
                yearInExpense.add(year);
                expInExpense.add(expense);
            }
            
            request.setAttribute("yearInExpense", yearInExpense);
            request.setAttribute("expInExpense", expInExpense);
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
    
    public LinkedHashMap<String, String> retrieveExpense(LinkedHashMap<String, Double> list) {
        LinkedHashMap<String, String> resultList = new LinkedHashMap<>();
        DecimalFormat df = new DecimalFormat("###.##");
        

        for (String year : list.keySet()) {
            Double expense = list.get(year);
            String formatString = df.format(expense);
            resultList.put(year,formatString);

        }

        return resultList;
    }
    
     public LinkedHashMap<String, String> retrieveYearlyProfits(LinkedHashMap<String, Double> gainList, LinkedHashMap<String, Double> expenseList) {
        LinkedHashMap<String, String> resultList = new LinkedHashMap<>();
        //ArrayList<Double> result = new ArrayList<>();
        DecimalFormat df = new DecimalFormat("###.##");

        for (String year : gainList.keySet()) {
            double gain = gainList.get(year);
            double profit = 0;
            
            for (String yr : expenseList.keySet()) {
                double expense = expenseList.get(yr);
                if (yr.equals(year)) {
                    profit = gain - expense;
                   
                    String formatString = df.format(profit);
                    resultList.put(yr,formatString);
                     System.out.println(yr + "cl");
                    //result.add(Double.parseDouble(formatString));
                }
            }
        }

        return resultList;
    }
     
      public ArrayList<Double> retrieveMonthlyProfits(String sortMonthly, LinkedHashMap<Integer, String[]> gainList, LinkedHashMap<Integer, String[]> expenseList) {
        ArrayList<Double> result = new ArrayList<>();
        ArrayList<String> check = new ArrayList<>();
        DecimalFormat df = new DecimalFormat("###.##");

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
                    String formatString = df.format(profit);
                    result.add(Double.parseDouble(formatString));
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
