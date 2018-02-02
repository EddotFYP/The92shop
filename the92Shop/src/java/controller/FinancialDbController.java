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
        String sortMonthly = request.getParameter("month");

        //Parameters for straight display monthly data (2017) && yearly data
        String monthlyData = request.getParameter("monthData");
        String yearlyData = request.getParameter("yearData");

        PurchaseHistoryDAO custPurchaseDAO = new PurchaseHistoryDAO();
        ExpenseTrackerDAO expenseDAO = new ExpenseTrackerDAO();

        //declare yearly variables
        LinkedHashMap<String, Double> yearlyGain = new LinkedHashMap<>();
        LinkedHashMap<String, Double> yearlyExp = new LinkedHashMap<>();
        ArrayList<Double> yearlyProfitsResult = new ArrayList<>();
        ArrayList<Double> yearlySalesResult = new ArrayList<>();
        LinkedHashMap<String, Double> yearlyExpenseList = new LinkedHashMap<>();
        ArrayList<Double> yearlyExpenseResult = new ArrayList<>();

        //Default 
        LinkedHashMap<Integer, String[]> monthlyDefaultSalesList = new LinkedHashMap<>();
        ArrayList<String> monthlyDefaultSalesResult = new ArrayList<>();
        LinkedHashMap<Integer, String[]> monthlyDefaultExpenseList = new LinkedHashMap<>();
        ArrayList<String> monthlyDefaultExpenseResult = new ArrayList<>();
        LinkedHashMap<Integer, String[]> monthlyDefaultGain = new LinkedHashMap<>();
        LinkedHashMap<Integer, String[]> monthlyDefaultExpense = new LinkedHashMap<>();
        ArrayList<Double> monthlyDefaultProfitsResult = new ArrayList<>();

        //By Dropdown
        LinkedHashMap<Integer, String[]> monthlyGain = new LinkedHashMap<>();
        ArrayList<Double> profitsResult = new ArrayList<>();
        LinkedHashMap<Integer, String[]> monthlySalesList = new LinkedHashMap<>();
        ArrayList<String> salesResult = new ArrayList<>();
        LinkedHashMap<Integer, String[]> monthlyExpenseList = new LinkedHashMap<>();
        ArrayList<String> expenseResult = new ArrayList<>();
        
        String text = "";
        String error = "";

        //set latest data as default (monthly profits,sales,expenses)
        if (monthlyData != null) {
            monthlyDefaultGain = custPurchaseDAO.retrieveMonthlyGain();
            monthlyDefaultExpense = expenseDAO.retrieveMonthlyExpenses();
            monthlyDefaultProfitsResult = retrieveDefaultMonthlyProfit(monthlyDefaultGain, monthlyDefaultExpense);

            monthlyDefaultSalesList = custPurchaseDAO.retrieveMonthlySales();
            monthlyDefaultSalesResult = sortDefaultSalesListMonthly(monthlyDefaultSalesList);
            monthlyDefaultExpenseList = expenseDAO.retrieveMonthlyExpenses();
            monthlyDefaultExpenseResult = sortDefaultSalesListMonthly(monthlyDefaultExpenseList);

            request.setAttribute("monthlyDefaultProfitsResult", monthlyDefaultProfitsResult);
            request.setAttribute("monthlyDefaultSalesResult", monthlyDefaultSalesResult);
            request.setAttribute("monthlyDefaultExpenseResult", monthlyDefaultExpenseResult);
        }

        //set {monthly} data based on user choosing from dropdown
        if (sortMonthly != null) {
            monthlyGain = custPurchaseDAO.retrieveMonthlyGain();
            monthlySalesList = custPurchaseDAO.retrieveMonthlySales();
            monthlyExpenseList = expenseDAO.retrieveMonthlyExpenses();
            
            profitsResult = retrieveMonthlyProfit(sortMonthly, monthlyGain, monthlyExpenseList);

            if (profitsResult == null || profitsResult.isEmpty()) {
                text = sortMonthly;
                error = "There are no records!";
                
                //request.setAttribute("word", text);
            } else {
                text = sortMonthly;
            }
        


            salesResult = sortListMonthly(sortMonthly, monthlySalesList);
            expenseResult = sortListMonthly(sortMonthly, monthlyExpenseList);

            request.setAttribute("profitsResult", profitsResult);
            request.setAttribute("salesResult", salesResult);
            request.setAttribute("expenseResult", expenseResult);
        }

        //set yearly data for profits, sales and expenses
        if (yearlyData != null) {
            yearlyGain = custPurchaseDAO.retrieveYearlyGain();
            yearlyExp = expenseDAO.retrieveYearlyExpense();
            yearlyProfitsResult = retrieveYearlyProfit(yearlyGain, yearlyExp);

            yearlySalesResult = custPurchaseDAO.retrieveYearlySales();
            yearlyExpenseList = expenseDAO.retrieveYearlyExpense();
            yearlyExpenseResult = retrieveExpense(yearlyExpenseList);

            request.setAttribute("yearlyProfitsResult", yearlyProfitsResult);
            request.setAttribute("yearlySalesResult", yearlySalesResult);
            request.setAttribute("yearlyExpensesResult", yearlyExpenseResult);
        }
       
        //never select month and year
        try {
            if (sortMonthly.equals("none")) {
                error = "Please select year to see the monthly results";
            }
        } catch (Exception e) {
            error = "Please remember to select year to view past data";
        }
        
        request.setAttribute("word", text);
        request.setAttribute("error", error);
        request.setAttribute("sortMonthly", sortMonthly);
         
        RequestDispatcher view = request.getRequestDispatcher("financialDashboard.jsp");
        view.forward(request, response);
    }

    public ArrayList<String> sortDefaultSalesListMonthly(LinkedHashMap<Integer, String[]> salesList) {
        ArrayList<String> list = new ArrayList<>();

        for (int count : salesList.keySet()) {
            String year = salesList.get(count)[0];
            String month = salesList.get(count)[1];
            String sales = salesList.get(count)[2];

            if (year.equals("2017")) {
                list.add(sales);
            }
        }
        return list;
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

    public ArrayList<Double> retrieveYearlyProfit(LinkedHashMap<String, Double> gainList, LinkedHashMap<String, Double> expenseList) {
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

    public ArrayList<Double> retrieveMonthlyProfit(String sortMonthly, LinkedHashMap<Integer, String[]> gainList, LinkedHashMap<Integer, String[]> expenseList) {
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
        for (Double sales : result) {
            //String year = monthlyExpenseList.get(count)[0];
            //String month = monthlyExpenseList.get(count)[1];
            //String sales = monthlyExpenseList.get(count)[2];

            out.println(sales);

        }
        return result;
    }

    public ArrayList<Double> retrieveDefaultMonthlyProfit(LinkedHashMap<Integer, String[]> gainList, LinkedHashMap<Integer, String[]> expenseList) {
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

                if (yr.equals(year) && month.equals(mth) && yr.equals("2017")) {
                    profit = gainAmt - expenseAmt;
                    result.add(profit);
                    out.println(yr);
                }
            }
        }
        for (Double sales : result) {
            //String year = monthlyExpenseList.get(count)[0];
            //String month = monthlyExpenseList.get(count)[1];
            //String sales = monthlyExpenseList.get(count)[2];

            out.println(sales);

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
