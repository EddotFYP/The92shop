<%-- 
    Document   : financialStatement
    Created on : Feb 5, 2018, 1:02:56 AM
    Author     : Jacquelyn
--%>

<%@page import="java.util.LinkedHashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="entity.Inventory"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<link rel="stylesheet" href="css/master.css">
<%--<%@include file="sideNavBar.jsp" %>
<%@include file="protect.jsp" %>
--%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Inventory Dashboard</title>
    </head>
    <body>
        <form action="InventoryDbController" method="post">
           

            <div id="title"><h2>Financial Statement</h2></div>
            
           
            <div id="topProduct">
                Filter by (Monthly/Yearly):
                <select name="month">
                    <option value="none" selected>Please select</option>
                    <option value="January">January</option>
                    <option value="Febuary" >February</option>
                    <option value="March" >March</option>
                    <option value="April" >April</option>
                    <option value="May" >May</option>
                    <option value="June" >June</option>
                    <option value="July" >July</option>
                    <option value="August" >August</option>
                    <option value="September" >September</option>
                    <option value="October" >October</option>
                    <option value="November" >November</option>
                    <option value="December" >December</option>
                </select>

                <select name="year">
                    <option value="none" selected>Please select</option>
                    <option value="2016">2016</option>
                    <option value="2017" >2017</option>
                </select>

                <button type="submit" name="submit">Filter</button>
                <br>


            
            </div>
        </form>  
    </body>
</html>
