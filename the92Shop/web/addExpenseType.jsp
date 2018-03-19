<%-- 
    Document   : addExpenseType
    Created on : Feb 12, 2018, 9:31:06 PM
    Author     : Jacquelyn
--%>
<%@page import="DAO.ExpenseTrackerDAO"%>
<%@page import="DAO.ExpenseTypesDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="entity.ExpenseTypes"%>
<%@page import="entity.ExpenseTracker"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="sideNavBar.jsp" %>
<%@include file="protect.jsp" %>
<link href="//cdn.muicss.com/mui-0.9.36/css/mui.min.css" rel="stylesheet" type="text/css" />
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Edit Expense Type</title>
    </head>
    <body>
        <div class="subPageContent">
            <form  action="ExpenseTypeController" method="post">
                <div class ="mui-panel ">    
                    <h1>Add Expense Type</h1>
                    <div class="mui-divider"></div>
                    <br />
                    <table id="AdminTable">
                        <tr>
                            <td>
                                Expense Type : &nbsp;
                            </td>

                            <td>
                                <div class="mui-textfield">
                                    <input type ="text" name ="newExpType" id="newExpType" required/>
                                </div>
                            </td>
                            <td>
                                &nbsp;<button type="submit" name="submit" class="mui-btn mui-btn--raised mui-btn--primary"><i class="fa  fa-plus" style="font-size:18px;"> Add</i></button>
                            </td>
                        </tr>

                    </table>

                    <%                           String error = (String) request.getAttribute("error");
                        String message = (String) request.getAttribute("message");
                        if (error != null) {
                            out.println("<p style='color:red'>" + error + "</p>");
                        }

                        if (message != null) {
                            out.println("<p style='color:red'>" + message + "</p>");
                        }
                    %>
            </form>
        </div>
    </div>
</body>
</html>

