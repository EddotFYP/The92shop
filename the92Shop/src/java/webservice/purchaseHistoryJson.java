/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package webservice;

import DAO.InventoryDAO;
import DAO.PurchaseHistoryDAO;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import entity.PurchaseHistory;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Xiao Weikun
 */
@WebServlet(urlPatterns = {"/purchaseHistoryJson"})
public class purchaseHistoryJson extends HttpServlet {

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

            Gson gson = new GsonBuilder().setPrettyPrinting().create();
            JsonObject jsonOutput = new JsonObject();
            JsonArray jsonArray = new JsonArray();
            
            PurchaseHistoryDAO purchaseHistoryDAO = new PurchaseHistoryDAO();
            ArrayList<PurchaseHistory> list = purchaseHistoryDAO.retrievePurchaseHistory();
            InventoryDAO dao = new InventoryDAO();
            
            int id = 0;
            String productName = "";
            String phone = "";
            int qty = 0;
            String purchaseDate = "";
            
            if (list != null) {
                for (PurchaseHistory p : list) {
                    id = p.getSkuId();
                    productName = dao.retrieveInventoryNameById(id);
                    phone = p.getPhoneNum();
                    qty = p.getQuantity();
                    purchaseDate = p.getDateOfPurchase();
                    
                    JsonObject obj = new JsonObject();
                    obj.addProperty("phone", phone);
                    obj.addProperty("productName", productName);
                    obj.addProperty("qty", qty);
                    obj.addProperty("purchaseDate", purchaseDate);
                    
                    jsonArray.add(obj);
                }
                jsonOutput.add("history", jsonArray);
            }
            out.print(gson.toJson(jsonOutput));
            out.flush();
            out.close();

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
