/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import DAO.InventoryDAO;
import entity.Inventory;
import java.io.IOException;
import java.io.PrintWriter;
import static java.lang.System.out;
import java.util.ArrayList;
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
@WebServlet(name = "InventoryDbController", urlPatterns = {"/InventoryDbController"})
public class InventoryDbController extends HttpServlet {

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
        String sortMonth = request.getParameter("month");
        String sortYear = request.getParameter("year");

        InventoryDAO invDAO = new InventoryDAO();

        LinkedHashMap<Integer, String[]> inventoryList = new LinkedHashMap<>();
        LinkedHashMap<Integer, String[]> result = new LinkedHashMap<>();

        String text = "";

        //hidden parameters from dashboard.jsp
        String invLevel = request.getParameter("invLevel");
        String lowInvList = request.getParameter("invList");

        ArrayList<Inventory> invList = new ArrayList<>();
        String error = "";

        int invAlert = 0;

        if (invLevel != null) {
            invAlert = invDAO.retrieveInventoryAlert();
            request.setAttribute("alertResult", invAlert);
        }

        if (lowInvList != null) {
            invList = invDAO.retrieveLowInventory();
            request.setAttribute("listResult", invList);
        }
        
        //select month and year
        if (sortYear != null && sortMonth != null) {
            inventoryList = invDAO.sortByMonthYear();
            result = sortInvListByMonthYear(sortMonth, sortYear, inventoryList);
            if (result == null || result.isEmpty()) {
                text = sortMonth + " " + sortYear;
                error = "There are no records!";
                
                request.setAttribute("word", text);
            } else {
                text = sortMonth + " " + sortYear;
            }
        }

        //choose by year
        if (sortYear != null && sortMonth.equals("none")) {
            inventoryList = invDAO.sortByYear();
            result = sortInvListByYear(sortYear, inventoryList);
            text = sortYear;
        } else if (sortMonth != null && sortYear.equals("none")) {
            error = "Please select a year!";

            text = sortMonth + " only";
        }
        
        //never select month and year
        try {
            if (sortMonth.equals("none") && sortYear.equals("none")) {
                error = "Please select month or/and year to see monthly and yearly results";
            }
        } catch (Exception e) {
            error = "Please remember to select month or/and year";
        }

        //limit only top 5 product
        LinkedHashMap<String, String> topList = limitTop5(result);

        request.setAttribute("word", text);
        request.setAttribute("error", error);
        request.setAttribute("result", topList);

        RequestDispatcher view = request.getRequestDispatcher("inventoryDashboard.jsp");
        view.forward(request, response);
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

    public LinkedHashMap<String, String> limitTop5(LinkedHashMap<Integer, String[]> invList) {
        LinkedHashMap<String, String> result = new LinkedHashMap<>();
        int count = 0;

        for (int id : invList.keySet()) {
            String name = invList.get(id)[0];
            String quantity = invList.get(id)[1];

            if (count < 5) {
                result.put(name, quantity);
                count++;
            }
        }
        return result;
    }

    public LinkedHashMap<Integer, String[]> sortInvListByMonthYear(String sortMonth, String sortYear, LinkedHashMap<Integer, String[]> inventoryList) {
        LinkedHashMap<Integer, String[]> result = new LinkedHashMap<>();
        int id = 1;
        String[] array;

        for (int count : inventoryList.keySet()) {
            String name = inventoryList.get(count)[0];
            String quantity = inventoryList.get(count)[1];
            String month = inventoryList.get(count)[2];
            String year = inventoryList.get(count)[3];

            if (month.equals("1")) {
                month = "January";
            } else if (month.equals("2")) {
                month = "Febuary";
            } else if (month.equals("3")) {
                month = "March";
            } else if (month.equals("4")) {
                month = "April";
            } else if (month.equals("5")) {
                month = "May";
            } else if (month.equals("6")) {
                month = "June";
            } else if (month.equals("7")) {
                month = "July";
            } else if (month.equals("8")) {
                month = "August";
            } else if (month.equals("9")) {
                month = "September";
            } else if (month.equals("10")) {
                month = "October";
            } else if (month.equals("11")) {
                month = "November";
            } else {
                month = "December";
            }

            if (month.equals(sortMonth) && year.equals(sortYear)) {
                array = new String[]{name, quantity};
                result.put(id, array);

                id++;
            }
        }
        return result;

    }

    public LinkedHashMap<Integer, String[]> sortInvListByYear(String sortYear, LinkedHashMap<Integer, String[]> inventoryList) {
        LinkedHashMap<Integer, String[]> result = new LinkedHashMap<>();
        String[] array;

        for (int count : inventoryList.keySet()) {
            String name = inventoryList.get(count)[0];
            String quantity = inventoryList.get(count)[1];
            String year = inventoryList.get(count)[2];

            if (year.equals(sortYear)) {
                array = new String[]{name, quantity};
                result.put(count, array);
            }
        }
        return result;
    }
}
