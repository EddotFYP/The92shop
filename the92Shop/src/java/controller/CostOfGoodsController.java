/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;


import DAO.InventoryDAO;
import entity.Inventory;
import entity.ExpenseTracker;
import DAO.ExpenseTrackerDAO;
import DAO.InventoryPurchaseDAO;
import entity.InventoryPurchase;
import java.io.IOException;
import java.io.PrintWriter;
import static java.lang.System.out;
import java.util.ArrayList;
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
 * @author Jacquelyn
 */
@WebServlet(name = "CostOfGoodsController", urlPatterns = {"/CostOfGoodsController"})
public class CostOfGoodsController extends HttpServlet {

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
        
        int month = Integer.parseInt(request.getParameter("month"));
        String year = request.getParameter("year");
        request.setAttribute("year",year);
        
        String monthString ="";
        switch (month) {
            case 1:  monthString = "January";
                     break;
            case 2:  monthString = "February";
                     break;
            case 3:  monthString = "March";
                     break;
            case 4:  monthString = "April";
                     break;
            case 5:  monthString = "May";
                     break;
            case 6:  monthString = "June";
                     break;
            case 7:  monthString = "July";
                     break;
            case 8:  monthString = "August";
                     break;
            case 9:  monthString = "September";
                     break;
            case 10: monthString = "October";
                     break;
            case 11: monthString = "November";
                     break;
            case 12: monthString = "December";
                     break;
            default: monthString = "Invalid month";
                     break;
        }
    
        request.setAttribute("monthString", monthString);
        
        System.out.print(month);
        System.out.print(year);
        
        InventoryPurchaseDAO invPurchaseDAO = new InventoryPurchaseDAO();
        
        
       //To list of the COGS
        ArrayList<InventoryPurchase> listofCOGSItems = invPurchaseDAO.listCogItems(month, year);
        request.setAttribute("listofCOGSItems", listofCOGSItems);
       for(int i = 0 ; i<listofCOGSItems.size() ; i++){
          
                InventoryPurchase purchase = listofCOGSItems.get(i);
                System.out.println(purchase.getSkuId());
                System.out.println(purchase.getQuantity());
                System.out.println(purchase.getDateOfPurchase());
                
            }
       
    
        
        RequestDispatcher view = request.getRequestDispatcher("costOfGoods.jsp");
        view.forward(request, response);
        
    
       
    }
        
       
    
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