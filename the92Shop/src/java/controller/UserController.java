/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import DAO.UserDAO;
import entity.User;
import java.io.IOException;
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
@WebServlet(name = "UserController", urlPatterns = {"/UserController"})
public class UserController extends HttpServlet {

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
        String name = request.getParameter("name");
        String password = request.getParameter("password");
        String passwordChange = request.getParameter("passwordChange");
        String currPassword = request.getParameter("currentpassword");
        String newPassword = request.getParameter("newpassword");

        UserDAO userDAO = new UserDAO();

        if (name != null) {
            int success = checkDuplicate(name,password);
            
            if (success != 0) {
                User user = new User(name, password);
                success = userDAO.addUser(user);
                request.setAttribute("message", "New user is added successfully!");
                RequestDispatcher view = request.getRequestDispatcher("addAdmin.jsp");
                view.forward(request, response);
            }else{
                request.setAttribute("message", "Duplicate user!");
            }
        }else if(passwordChange != null && currPassword != null){
            User user = userDAO.retrieveUserAcc(currPassword);
            
            if(user != null){
                if(currPassword.equals(passwordChange)){
                    request.setAttribute("message", "Your old password and new password is the same!");
                }
                
                else if(!passwordChange.equals(newPassword)){
                    request.setAttribute("message", "Your password does not match!");

                }else if (passwordChange.equals(newPassword)){
                    int success = userDAO.editUser(user, passwordChange);
                    
                    if(success != 0){
                        request.setAttribute("message", "Your password has been changed!");
                        
                    }
                }
 
            }else{
                request.setAttribute("message", "Your current password is wrong!");
                RequestDispatcher view = request.getRequestDispatcher("changePassword.jsp");
                view.forward(request, response);
            }

        }
            RequestDispatcher view = request.getRequestDispatcher("changePassword.jsp");
            view.forward(request, response);
    }
    
     public int checkDuplicate(String username, String password){
        int result = 0;
        UserDAO uDAO = new UserDAO();
        ArrayList<User> cList = uDAO.retrieveAllUsers();
        
        for(User u: cList){
            if(u.getUsername().equals(username) && u.getPassword().equals(password)){
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
