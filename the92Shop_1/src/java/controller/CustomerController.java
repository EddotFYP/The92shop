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
        String phoneNumber = request.getParameter("phoneNum");
        String birthdayDate = request.getParameter("birthDate");
        String PhoneNumberToDelete = request.getParameter("deleteAction");
        String[] UpdatedValues = request.getParameterValues("editAction");
        /*System.out.println("birthdate :"+birthdayDate);
        System.out.println("phone :"+phoneNumber);
        System.out.println("delete :"+delete);*/
        //System.out.println("PhoneNumberToDelete:  " + PhoneNumberToDelete);
        
        //for add new customer
        String addNewCustId = request.getParameter("newCustId");
        String addNewName = request.getParameter("newName");
        String addNewGender = request.getParameter("newGender");
        String addNewBirthDate = request.getParameter("newBirthdayDate");
        String addNewPhoneNumber = request.getParameter("newPhoneNumber");
        String addNewAddress = request.getParameter("newAddress");
        String addNewPostal = request.getParameter("newPostal");
        
        CustomerDAO custDAO = new CustomerDAO();
        ArrayList<Customer> result = new ArrayList<>();
        
        //delete customer
        if (PhoneNumberToDelete != null) {

            custDAO.deleteCustomer(PhoneNumberToDelete);

            request.setAttribute("message", "Selected customer is deleted successfully");

        //edit customer    
        } else if(UpdatedValues != null){
            System.out.println("UpdatedValues:  " + UpdatedValues[0]+" "+UpdatedValues[1]+" "+UpdatedValues[2]+" "+UpdatedValues[3]);
            String id = UpdatedValues[0];
            String phone = UpdatedValues[1];
            String address = UpdatedValues[2];
            String postal = UpdatedValues[3];
            
            int success = custDAO.editCustomer(id, phone, address, postal);
            
            if(success != 0){
                request.setAttribute("message", "Selected customer is updated successfully");
            }
            
            
        //add new customer
        } else if(addNewName != null){
            Customer c = new Customer(addNewCustId,addNewName,addNewGender,addNewBirthDate,addNewPhoneNumber,addNewAddress, addNewPostal);
            int success = custDAO.addCustomer(c);
            if(success != 0){
                request.setAttribute("message", "New customer is added successfully!");
            }
            
            
        //search customer    
        } else {
            //search customer by phone number
            if (phoneNumber != null && !phoneNumber.isEmpty()) {
                Customer customer = custDAO.retrieve(phoneNumber);

                if (customer != null) {
                    result.add(customer);
                }
            }

            //search customers by birthdate
            if (birthdayDate != null && !birthdayDate.isEmpty()) {
                ArrayList<Customer> custList = custDAO.retrieveCustomerList(birthdayDate);

                for (Customer c : custList) {
                    if (c.getBirthDate().equals(birthdayDate)) {
                        result.add(c);
                    }
                }

            }

            if (result.isEmpty()) {
                request.setAttribute("error", "No result is found");
            } else {
                request.setAttribute("custList", result);
            }
        }
        RequestDispatcher view = request.getRequestDispatcher("customerManagement.jsp");
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
