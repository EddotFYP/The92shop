<%-- 
    Document   : logout
    Created on : Oct 11, 2017, 12:44:18 AM
    Author     : N56VV
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    session.invalidate();
    response.sendRedirect("login.jsp");
%>
