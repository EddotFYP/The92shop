<%-- 
    Document   : logout
    Created on : Oct 11, 2017, 12:44:18 AM
    Author     : N56VV
--%>

<%@page import="DAO.UserDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    String name = (String) session.getAttribute("user");
    UserDAO dao = new UserDAO();
    dao.editUserLoginStatus(name, 0);
    session.invalidate();
    response.sendRedirect("login.jsp");
%>
