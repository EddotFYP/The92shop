<%-- 
    Document   : inventoryManagement
    Created on : Nov 7, 2017, 10:32:51 PM
    Author     : N56VV
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<link rel="stylesheet" href="css/master.css">
<%@include file="sideNavBar.jsp" %>
<%@include file="protect.jsp" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <form  action="InventoryController" method="post">
             <div class="subPageContent">
                 <table>
                     <tr>
                         <td>
            Customer ID:
                         </td>
                         <td>
            <input type ="text" name ="newCustId" required/>
                         </td>
            </tr>
            <tr>
                <td>
            Name:
                </td>
                <td>
            <input type ="text" name ="newName" required/>
                </td>
                </tr>
                 </table>
             </div>
        </form>
    </body>
</html>
