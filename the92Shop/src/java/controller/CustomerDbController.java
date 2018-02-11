/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import DAO.PurchaseHistoryDAO;
import java.io.IOException;
import static java.lang.System.out;
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
@WebServlet(name = "CustomerDbController", urlPatterns = {"/CustomerDbController"})
public class CustomerDbController extends HttpServlet {

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

        PurchaseHistoryDAO custPurchaseDAO = new PurchaseHistoryDAO();

        LinkedHashMap<Integer, String[]> custList = new LinkedHashMap<>();
        LinkedHashMap<Integer, String[]> result = new LinkedHashMap<>();
        
        String text = "";
        String error = "";

        if (sortMonth != null && sortYear != null) {
            custList = custPurchaseDAO.sortByMonthYear();
            result = sortCustListByMonthYear(sortMonth, sortYear, custList);
            if(result == null || result.isEmpty()){
                text = sortMonth + " " + sortYear;
                error = "There are no records!";
                request.setAttribute("word", text);
            }else{
                text = sortMonth + " " + sortYear;
            }
            
        }
        
        if (sortMonth.equals("none")) {
            custList = custPurchaseDAO.sortByYear();
            result = sortCustListByYear(sortYear, custList);
            text = sortYear;
        }else if(sortYear.equals("none")){
            text = sortMonth + " only";
            error = "Please select a year!";
        }
        
        if(sortMonth.equals("none") && sortYear.equals("none")){
            error = "Please select month and year!";
        }
        
        LinkedHashMap<Integer, String[]> custHashmap = limitTop5(result);
        
        request.setAttribute("errorMsg", error);
        request.setAttribute("word", text);
        request.setAttribute("result", custHashmap);

        RequestDispatcher view = request.getRequestDispatcher("customerDashboard.jsp");
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

    public LinkedHashMap<Integer, String[]> limitTop5(LinkedHashMap<Integer, String[]> customerList) {
        LinkedHashMap<Integer, String[]> result = new LinkedHashMap<>();
        String[] array;
        int count = 0;

        for (int cid : customerList.keySet()) {
            String name = customerList.get(cid)[0];
            String phoneNumber = customerList.get(cid)[1];

            if (count < 5) {
                array = new String[]{name, phoneNumber};
                result.put(cid, array);
                count++;
            }
        }
        return result;
    }

    public LinkedHashMap<Integer, String[]> sortCustListByMonthYear(String sortMonth, String sortYear, LinkedHashMap<Integer, String[]> customerList) {
        LinkedHashMap<Integer, String[]> result = new LinkedHashMap<>();
        String[] array;

        for (int cid : customerList.keySet()) {
            String name = customerList.get(cid)[0];
            String phoneNumber = customerList.get(cid)[1];
            String quantity = customerList.get(cid)[2];
            String month = customerList.get(cid)[3];
            String year = customerList.get(cid)[4];

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
                array = new String[]{name, phoneNumber};
                result.put(cid, array);
            }
        }

        return result;

    }
    
    public LinkedHashMap<Integer, String[]> sortCustListByYear(String sortYear, LinkedHashMap<Integer, String[]> customerList) {
        LinkedHashMap<Integer, String[]> result = new LinkedHashMap<>();
        String[] array;

        for (int cid : customerList.keySet()) {
            String name = customerList.get(cid)[0];
            String phoneNumber = customerList.get(cid)[1];
            String year = customerList.get(cid)[2];

            if (year.equals(sortYear)) {
                array = new String[]{name, phoneNumber};
                result.put(cid, array);
            }
        }

        return result;

    }
}
