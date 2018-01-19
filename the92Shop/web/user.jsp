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

    </head>
    <body>
        <div class="subPageContent">
            <form  action="UserController" method="post">
                <fieldset  class="fieldset-auto-width">
                    <legend class="lg"><h2>Add New User</h2></legend>
                    <table>
                        <tr>
                            <td>
                                Name:
                            </td>
                            <td>
                                <input type ="text" name ="name" required/>
                            </td>
                        </tr>
                        <img  src="image/addUser.png" align="right">
                        <tr>
                            <td>
                                Password:
                            </td>

                            <td>
                                <input type ="text" name ="password" required/>
                            </td>
                        </tr>

                        <tr>
                            <td>
                                <button type="submit" name="submit" class="btn"><i class="fa  fa-plus"> Add</i></button>
                            </td>
                        </tr>

                    </table>



                    <%
                        String error = (String) request.getAttribute("error");
                        String message = (String) request.getAttribute("message");
                        if (error != null) {
                            out.println("<p style='color:red'>" + error + "</p>");
                        }

                        if (message != null) {
                            out.println("<p style='color:red'>" + message + "</p>");
                        }
                    %>
                </fieldset>

        </div>

    </form>
</body>
</html>
