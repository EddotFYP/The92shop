<%-- 
    Document   : addCustomer.jsp
    Created on : Nov 1, 2017, 12:28:33 AM
    Author     : Clarey Liow JX
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
        <div class="subPageContent">
            <form  action="CustomerController" method="post">
                <fieldset  class="fieldset-auto-width">
                    <legend>Add New Customer</legend>
                    <table>
                        <tr>
                            <td>
                                Name:
                            </td>

                            <td>
                                <input type ="text" name ="newName" required/>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                Phone Number:
                            </td>
                            <td>
                                <input type ="text" name ="newPhoneNumber" required/>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                Address:
                            </td>
                            <td>
                                <input type ="text" name ="newAddress" required/>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                Postal Code:
                            </td>

                            <td>
                                <input type ="text" name ="newPostal" required/>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <button type="submit" name="submit" class="btn"><i class="fa  fa-plus"> Add</i></button>
                            </td>
                        </tr>
                        
                    </table>
                    
                    <%
                        String message = (String) request.getAttribute("messages");
                        if (message != null) {
                            out.print(message);
                        }
                    %>
                </fieldset>
        </div>

    </form>
</body>
</html>
