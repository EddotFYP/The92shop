<%-- 
    Document   : addCustomer.jsp
    Created on : Nov 1, 2017, 12:28:33 AM
    Author     : Clarey Liow JX
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="protect.jsp" %>
<link href="//cdn.muicss.com/mui-0.9.36/css/mui.min.css" rel="stylesheet" type="text/css" />
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add Customer Page</title>
    </head>
    <body>
        <%           
            String usernameAcc = (String) session.getAttribute("user");

            if (!usernameAcc.equals("qingyang")) { %>
                <%@include file="nonAdminSideNavBar.jsp" %>
            <%} else { %>
                <%@include file="sideNavBar.jsp" %>
            <% }
        %>
        <div class="subPageContent">
            <form class="mui-form" action="CustomerController" method="post">
                <h1>Add New Customer</h1>
                <br />
                <table id="AdminTable">
                    <tr>
                        <td>
                            Name:
                        </td>

                        <td>
                            <div class="mui-textfield">
                            <input type ="text" name ="newName" required/>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Phone Number:
                        </td>
                        <td>
                            <div class="mui-textfield">
                            <input type ="tel" pattern="[8\d|9\d]{8}" name ="newPhoneNumber" required/>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Address:
                        </td>
                        <td>
                            <div class="mui-textfield">
                            <input type ="text" name ="newAddress" required/>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Postal Code:
                        </td>

                        <td>
                            <div class="mui-textfield">
                            <input type ="text" pattern="[0-9]{6}" name ="newPostal" required/>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <button type="submit" name="submit" class="mui-btn mui-btn--raised mui-btn--primary"><i class="fa  fa-plus" style="font-size:18px;"> Add</i></button>
                        </td>
                    </tr>

                </table>

                <%                        
                    String message = (String) request.getAttribute("messages");
                    if (message != null) {
                        out.print(message);
                    }
                %>
        </div>

    </form>
</body>
</html>
