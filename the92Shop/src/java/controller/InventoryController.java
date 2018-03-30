/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import DAO.InventoryDAO;
import DAO.InventoryPurchaseDAO;
import entity.Inventory;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author N56VV
 */
@WebServlet(name = "InventoryController", urlPatterns = {"/InventoryController"})
public class InventoryController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
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
            //for searching
            String skuName = request.getParameter("sku");
            InventoryDAO inventoryDAO = new InventoryDAO();
            InventoryPurchaseDAO inventoryPurchaseDAO = new InventoryPurchaseDAO();
            String inventoryToDelete = request.getParameter("deleteAction");
            String[] UpdatedValues = request.getParameterValues("editAction");
            String cameraResult = request.getParameter("cameraResult");
            String addInventorySearch = request.getParameter("addInventorySearch");
            String[] addQty = request.getParameterValues("addQuantity");

            //for add new inventory
            //String addNewInvId = request.getParameter("newInvId");
            String addNewName = request.getParameter("newName");
            String addNewQuantity = request.getParameter("newQuantity");
            //String addNewDate = request.getParameter("newDate");
            String addNewCost = request.getParameter("newCost");
            String addNewPrice = request.getParameter("newPrice");

            DateFormat df = new SimpleDateFormat("yyyy-MM-dd");

            ArrayList<Inventory> result = new ArrayList<>();
            //delete
            if (inventoryToDelete != null) {
                int success = inventoryDAO.deleteSpecifiedInventory(inventoryToDelete);
                
                if(success != 0){
                    request.setAttribute("message", "Selected SKU is deleted successfully");
                }
                

                //update
            } else if (UpdatedValues != null) {
                System.out.println("in update");
                int id = Integer.parseInt(UpdatedValues[0]);
                System.out.println(id);
                String name = UpdatedValues[1];
                System.out.println(name);
                int quantity = Integer.parseInt(UpdatedValues[2]);
                Date today = new Date();
                String dateString = df.format(today);
                double cost = Double.parseDouble(UpdatedValues[4]);
                double price = Double.parseDouble(UpdatedValues[5]);

                int success = inventoryDAO.editInventory(id, name, quantity, dateString, cost, price);
                if (success != 0) {
                    request.setAttribute("message", "Selected SKU is updated successfully");
                }

                //add
            } else if (addNewName != null) {
                //int qty = Integer.parseInt(addNewQuantity);
                System.out.println("in add inventory");
                double cost = Double.parseDouble(addNewCost);
                double price = Double.parseDouble(addNewPrice);
                int qty = Integer.parseInt(addNewQuantity);
                
                if (inventoryDAO.retrieveInventoryByName(addNewName) != null) {
                    request.setAttribute("message", "The inventory is already existed in the database!");
                    
                } else {
                    Date today = new Date();
                    String updateDate = df.format(today);

                    System.out.println("------------- today= " + updateDate + "----------------");

                    Inventory i = new Inventory(addNewName, qty, updateDate, cost, price);

                    int success = inventoryDAO.addInventory(i);

                    if (success != 0) {
                        
                        inventoryPurchaseDAO.addRecord(inventoryDAO.retrieveInventoryByName(addNewName).getSKUID(), qty, updateDate);
                        request.setAttribute("message", "Selected SKU is added successfully");
                    }
                }

                RequestDispatcher view = request.getRequestDispatcher("addInventory.jsp");
                view.forward(request, response);
                return;

                //QR code search 
            } else if (cameraResult != null && !cameraResult.isEmpty()) {

                System.out.println("in camera search");
                int firstQnMark = cameraResult.indexOf('?');

                String name = cameraResult.substring(0, firstQnMark);
                System.out.println("camera result name= " + name);
                Inventory inventory = inventoryDAO.retrieveInventoryByName(name);

                if (inventory != null) {
                    System.out.println("retrieve success");
                    result.add(inventory);
                }

            } else if (addInventorySearch != null && !addInventorySearch.isEmpty()) {
                System.out.println("in add inventory search");

                int firstQnMark = addInventorySearch.indexOf('?');

                String name = addInventorySearch.substring(0, firstQnMark);

                Inventory inventory = inventoryDAO.retrieveInventoryByName(name);

                if (inventory != null) {
                    result.add(inventory);
                }
                System.out.println("no. of items in result= " + result.size());
                request.setAttribute("result", result);
                RequestDispatcher view = request.getRequestDispatcher("addInventoryQty.jsp");
                view.forward(request, response);
                return;

                //add inventory quantity
            } else if (addQty != null) {
                System.out.println("in add inventory quantity");

                String name = addQty[0];
                String add = addQty[1];

                System.out.println("name and add = " + name + " " + add);
                int addNumber = Integer.parseInt(add);

                Inventory inventory = inventoryDAO.retrieveInventoryByName(name);

                int newQty = inventory.getQuantity() + addNumber;

                Date today = new Date();
                String dateString = df.format(today);
                System.out.println("------------- today= " + dateString + "----------------");

                int success = inventoryDAO.addInventoryQty(name, newQty, dateString);
                int success2 = inventoryPurchaseDAO.addRecord(inventory.getSKUID(), addNumber, dateString);

                if (success != 0 && success2 != 0) {
                    request.setAttribute("message", "Selected SKU is updated successfully");
                }
                RequestDispatcher view = request.getRequestDispatcher("addInventoryQty.jsp");
                view.forward(request, response);
                return;
            } else if (skuName.length() == 0) {
                System.out.println("retrieving all inventory");
                ArrayList<Inventory> list = inventoryDAO.retrieveInventoryList();

                if (list != null) {
                    for (Inventory i : list) {
                        result.add(i);
                    }

                }
            } //Normal search
            else if (skuName != null) {
                System.out.println("in normal search");
                Inventory inventory = inventoryDAO.retrieveInventoryByName(skuName);

                if (inventory != null) {
                    result.add(inventory);
                }
            }
            request.setAttribute("result", result);
            RequestDispatcher view = request.getRequestDispatcher("inventoryManagement.jsp");
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
