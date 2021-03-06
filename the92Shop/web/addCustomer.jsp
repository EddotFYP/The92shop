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
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Add Customer Page</title>
    </head>
    <body>
        <%             String usernameAcc = (String) session.getAttribute("user");

             if (usernameAcc.equals("qingyang") || usernameAcc.equals("cynthia")) {%>
        <%@include file="sideNavBar.jsp" %>
        <%} else {%>
        <%@include file="nonAdminSideNavBar.jsp" %>
        <% }


        %>
        <div class="subPageContent">
            <form class="mui-form" action="CustomerController" method="post">
                <div class ="mui-panel ">
                <h1>Add New Customer</h1>
                <div class="mui-divider"></div>
                <br />
                <table id="AdminTable">
                    <tr>
                        <td>
                            <span>Name</span><span style="float:right">:</span>
                        </td>

                        <td>
                            <div class="mui-textfield">
                            <input type ="text" placeholder="Name" name ="newName" required/>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <span>Phone Number</span><span style="float:right">:</span>
                        </td>
                        <td>
                            <div class="mui-textfield">
                            <input type ="tel" pattern="[8\d|9\d]{8}" placeholder="Phone Number" name ="newPhoneNumber" required/>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <span>Address</span><span style="float:right">:</span>
                        </td>
                        <td>
                            <div class="mui-textfield">
                            <input type ="text" placeholder="Address"  name ="newAddress" required/>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <span>Postal Code</span><span style="float:right">:</span>
                        </td>

                        <td>
                            <div class="mui-textfield">
                            <input type ="text" pattern="[0-9]{6}" placeholder="Postal Code"  name ="newPostal" required/>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                        </td>
                        <td>
                            <button type="submit" name="submit" class="mui-btn mui-btn--raised mui-btn--primary" style="float:right; font-size:18px"> Add <i class="fa  fa-plus" style="font-size:18px;"></i></button>
                        </td>
                    </tr>

                </table>

                <%                        
                    String message = (String) request.getAttribute("messages");
                    String confirmMessage = (String) request.getAttribute("confirmMessage");
                    if (message != null) {
                        out.println("<p style='color:red'>" + message + "</p>");
                    }
                    
                    
                %>
                 </div>
        </div>

    </form>
</body>
</html>
