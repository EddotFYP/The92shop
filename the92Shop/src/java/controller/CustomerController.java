/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import DAO.CustomerDAO;
import entity.Customer;
import java.io.IOException;
import java.io.PrintWriter;
import static java.lang.System.out;
import java.sql.Date;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Clarey Liow JX
 */
@WebServlet(name = "CustomerController", urlPatterns = {"/CustomerController"})

public class CustomerController extends HttpServlet {

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
        //for customer management
        String phoneNumberAndName = request.getParameter("phoneAndNameList");
        //String birthdayDate = request.getParameter("birthDate");
        
        String delete = request.getParameter("deleteAction");
        String[] UpdatedValues = request.getParameterValues("editAction");
        //System.out.println("birthdate :"+birthdayDate);
        //System.out.println("phone :"+phoneNumber);
        //System.out.println("delete :"+delete);*/
        //System.out.println("PhoneNumberToDelete:  " + PhoneNumberToDelete);
        
        //for add new customer
        String addNewName = request.getParameter("newName");
        String addNewPhoneNumber = request.getParameter("newPhoneNumber");
        String addNewAddress = request.getParameter("newAddress");
        String addNewPostal = request.getParameter("newPostal");
        
        CustomerDAO custDAO = new CustomerDAO();
        ArrayList<Customer> result = new ArrayList<>();
        
        //delete customer
        if (delete != null && !delete.isEmpty()) {
            int number = Integer.parseInt(delete);
            int success = custDAO.deleteCustomer(number);
            if(success != 0){
                request.setAttribute("message", "Selected customer is deleted successfully");
            }

        //edit customer    
        } else if(UpdatedValues != null && UpdatedValues.length != 0){
            System.out.println("UpdatedValues:  " + UpdatedValues[0]+" "+UpdatedValues[1]+" "+UpdatedValues[2]+" "+UpdatedValues[3]);
            String idStr = UpdatedValues[0];
            int id = Integer.parseInt(idStr);
            String name = UpdatedValues[1];
            String phone = UpdatedValues[2];
            String address = UpdatedValues[3];
            String postal = UpdatedValues[4];
            
            int success = custDAO.editCustomer(id, name, phone, address, postal);
            
            if(success != 0){
                request.setAttribute("message", "Selected customer is updated successfully");
            }
            
            
        //add new customer
        } else if(addNewName != null && !addNewName.isEmpty()){
            int success = checkDuplicate(addNewPhoneNumber);

            if(success != 0){
                Customer c = new Customer(addNewName,addNewPhoneNumber,addNewAddress, addNewPostal);
                success = custDAO.addCustomer(c);
                request.setAttribute("message", "New customer is added successfully!");
            }else{
                request.setAttribute("messages", "Duplicate customer!");
                RequestDispatcher view = request.getRequestDispatcher("addCustomer.jsp");
                view.forward(request, response);
            }
            
            
            
        //search customer    
        } else {
            //search customer by phone number and name
            
            if (phoneNumberAndName != null && !phoneNumberAndName.isEmpty()) {
                if(phoneNumberAndName.matches("[0-9]+") && phoneNumberAndName.length() > 2){
                    Customer customer = custDAO.retrieve(phoneNumberAndName);
                    
                    if (customer != null) {
                        result.add(customer);
                    }
                } else {
                    ArrayList<Customer> custList = custDAO.retrieveCustomerList(phoneNumberAndName);

                    for (Customer c : custList) {
                        if (c.getName().equals(phoneNumberAndName)) {
                            result.add(c);
                        }
                    }
                }
                
            } else {
                ArrayList<Customer> custList = custDAO.retrieveAllCustomers();
                
                for(Customer c : custList){
                    result.add(c);
                }
                
            }
            
            //search customers by name
            /*if (name != null && !name.isEmpty()) {
                ArrayList<Customer> custList = custDAO.retrieveCustomerList(name);

                for (Customer c : custList) {
                    if (c.getName().equals(name)) {
                        result.add(c);
                    }
                }
            }
            */
            if (result.isEmpty()) {
                request.setAttribute("error", "No result is found!");
            } else {
                request.setAttribute("custList", result);
            }
        }
        RequestDispatcher view = request.getRequestDispatcher("customerManagement.jsp");
        view.forward(request, response);
    }
    
    public int checkDuplicate(String newPhoneNumber){
        int result = 0;
        CustomerDAO cDAO = new CustomerDAO();
        ArrayList<Customer> cList = cDAO.retrieveAllCustomers();
        
        for(Customer c: cList){
            if(c.getPhoneNum().equals(newPhoneNumber)){
                return result;
            }
        }
        return 1;
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
