/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import DAO.PurchaseHistoryDAO;
import entity.PurchaseHistory;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Jacquelyn
 */
@WebServlet(name = "PriceBundlingController", urlPatterns = {"/PriceBundlingController"})

public class PriceBundlingController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        int month = Integer.parseInt(request.getParameter("month"));
        System.out.println(month);
        request.setAttribute("month", month);
        String year = request.getParameter("year");
        request.setAttribute("year", year);

        String monthString = "";
        switch (month) {
            case 1:
                monthString = "January";
                break;
            case 2:
                monthString = "February";
                break;
            case 3:
                monthString = "March";
                break;
            case 4:
                monthString = "April";
                break;
            case 5:
                monthString = "May";
                break;
            case 6:
                monthString = "June";
                break;
            case 7:
                monthString = "July";
                break;
            case 8:
                monthString = "August";
                break;
            case 9:
                monthString = "September";
                break;
            case 10:
                monthString = "October";
                break;
            case 11:
                monthString = "November";
                break;
            case 12:
                monthString = "December";
                break;
            default:
                monthString = "Invalid month";
                break;
        }

        request.setAttribute("monthString", monthString);

        int numResult = Integer.parseInt(request.getParameter("numResult"));
        request.setAttribute("numResult", numResult);
        PurchaseHistoryDAO purchaseHistoryDAO = new PurchaseHistoryDAO();

        String text = "";
        String error = "";
        LinkedHashMap<Integer, Integer> topXStock = new LinkedHashMap<>();
        LinkedHashMap<Integer, Integer> lowXStock = new LinkedHashMap<>();

        topXStock = purchaseHistoryDAO.getTopHighestStock(month, year, numResult);

        lowXStock = purchaseHistoryDAO.getTopLowestStock(month, year, numResult);

        if ((topXStock == null || topXStock.isEmpty()) || (lowXStock == null || lowXStock.isEmpty())) {
            text = monthString + " " + year;
            error = "There are no records!";
            request.setAttribute("errorMsg", error);
            
        } else {

            text = monthString + " " + year;
 
            request.setAttribute("word", text);
            
            request.setAttribute("topXStock", topXStock);
            request.setAttribute("lowXStock", lowXStock);
        
        }
        
        
        
        RequestDispatcher view = request.getRequestDispatcher("priceBundling.jsp");
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

}
