/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;



import DAO.PurchaseHistoryDAO;
import entity.InventoryPurchase;
import entity.PurchaseHistory;
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
@WebServlet(name = "ProfitController", urlPatterns = {"/ProfitController"})
public class ProfitController extends HttpServlet {

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
        
        PurchaseHistoryDAO purchaseHisDAO = new PurchaseHistoryDAO();
        
        
       //To list of the COGS
        ArrayList<PurchaseHistory> retreiveListOfSoldProducts = purchaseHisDAO.retreiveListOfSoldProducts(month, year);
        request.setAttribute("retreiveListOfSoldProducts", retreiveListOfSoldProducts);
       for(int i = 0 ; i<retreiveListOfSoldProducts.size() ; i++){
          
                PurchaseHistory ph= retreiveListOfSoldProducts.get(i);
                System.out.println(ph.getSkuId());
                System.out.println(ph.getQuantity());
                System.out.println(ph.getDateOfPurchase());
                
            }
       
    
        
        RequestDispatcher view = request.getRequestDispatcher("listOfSoldProducts.jsp");
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