/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import DAO.CustomerDAO;
import DAO.InventoryDAO;
import DAO.PurchaseHistoryDAO;
import entity.Customer;
import entity.Inventory;
import entity.PurchaseHistory;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.websocket.Session;

/**
 *
 * @author Xiao Weikun
 */
@WebServlet(name = "OrderPickingController", urlPatterns = {"/OrderPickingController"})
public class OrderPickingController extends HttpServlet {

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
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */

            InventoryDAO inventoryDAO = new InventoryDAO();
            ArrayList<Inventory> result = new ArrayList<>();
            CustomerDAO cusDAO = new CustomerDAO();
            String cameraResult = request.getParameter("cameraResult");
            ArrayList<Inventory> currentList = (ArrayList<Inventory>) request.getSession(false).getAttribute("currentList");
            ArrayList<String> message = new ArrayList<>();
            PurchaseHistoryDAO purchaseHistoryDAO = new PurchaseHistoryDAO();
            String phone = request.getParameter("phone");
            Customer customer = cusDAO.retrieve(phone);
            String viewPurchaseHistory = request.getParameter("ViewPurchaseHistory");

            DateFormat df = new SimpleDateFormat("yyyy-MM-dd");

            //QR code search 
            if (cameraResult != null && !cameraResult.isEmpty()) {

                System.out.println("in camera search");
                int firstQnMark = cameraResult.indexOf('?');

                String name = cameraResult.substring(0, firstQnMark);
                System.out.println("camera result name= " + name);
                Inventory inventory = inventoryDAO.retrieveInventoryByName(name);

                if (inventory != null) {
                    System.out.println("retrieve success");
                    result.add(inventory);
                }

                //process the current list in orderPicking.jsp
            } else if (currentList != null && currentList.size() != 0) {
                System.out.println("processing list");

                Date today = new Date();
                String dateString = df.format(today);

                for (Inventory i : currentList) {
                    String name = i.getName();
                    System.out.println("inventory name = "+name);
                    Inventory inventory = inventoryDAO.retrieveInventoryByName(name);
                    int diff = inventory.getQuantity() - i.getQuantity();

                    if (diff > 0) {

                        inventoryDAO.addInventoryQty(name, diff, dateString);
                        message.add("The order of " + name + " is recorded!");
                        if(customer == null){
                            request.setAttribute("error", "Invalid phone number!");
                            RequestDispatcher view = request.getRequestDispatcher("orderPicking.jsp");
                            view.forward(request, response);
                        }else{
                        int custId = customer.getCustId();
                        int invId = inventory.getSKUID();
                        System.out.println("inventory id = "+invId);

                        purchaseHistoryDAO.addRecord(new PurchaseHistory(custId, phone, invId, dateString, i.getQuantity()));

                        }
                    } else {

                        message.add("The order of " + name + " has exceeded its stock");
                    }

                }

                request.getSession().removeAttribute("currentList");

                //purchase history
            } else if (viewPurchaseHistory != null && viewPurchaseHistory.equals("1")) {
                ArrayList<PurchaseHistory> list = purchaseHistoryDAO.retrievePurchaseHistory();
                ArrayList<PurchaseHistory> history = new ArrayList<>();

                if (list != null) {
                    for (PurchaseHistory p : list) {
                        history.add(p);
                    }
                    request.setAttribute("history", history);
                    RequestDispatcher view = request.getRequestDispatcher("purchaseHistory.jsp");
                    view.forward(request, response);
                    return;

                }
            }

            request.setAttribute("message", message);
            request.setAttribute("result", result);
            RequestDispatcher view = request.getRequestDispatcher("orderPicking.jsp");
            view.forward(request, response);
        }

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
