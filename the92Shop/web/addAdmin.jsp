<%-- 
    Document   : addAdmin
    Created on : Feb 14, 2018, 11:02:11 PM
    Author     : Jacquelyn
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<link href="//cdn.muicss.com/mui-0.9.36/css/mui.min.css" rel="stylesheet" type="text/css" />
<%@include file="sideNavBar.jsp" %>
<%@include file="protect.jsp" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Add Admin Page</title>
    </head>
    <body>
        <div class="subPageContent">
            <form class="mui-form" action="UserController" method="post">
                <div class ="mui-panel ">    
                <h1>Add New Admin</h1>
                <div class="mui-divider"></div>
                    <br />
                    <table id="AdminTable">
                        <tr>
                            <td>
                                <span>Admin Name</span><span style="float:right">:</span>
                            </td>

                            <td>
                                <div class="mui-textfield">
                                <input type ="text" placeholder="Name" name ="name" id="name" required/>
                                </div>
                            </td>
                        </tr>
                        
                        <tr>
                            <td>
                                <span>Password</span><span style="float:right">:</span>
                            </td>

                            <td>
                                <div class="mui-textfield">
                                 <input type="password" placeholder="Password" id="password" name="password" required/>
                                 </div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <span>Confirm Password</span><span style="float:right">:</span>
                            </td>    
                            <td>
                                <div class="mui-textfield">
                                <input type="password" placeholder="Confirm Password" id="confirm_password" required>
                                </div>
                            </td>
                        </tr>
                        
                        <tr>
                            <td>
                            </td>
                            <td>
                              <button type="submit" name="submit" class="mui-btn mui-btn--raised mui-btn--primary" style="float:right; font-size:18px;"> Add <i class="fa  fa-plus" style="font-size:18px;"></i></button>
                            </td>
                            
                        </tr>
                    </table>
                    <%
                        
                        String error = (String) request.getAttribute("error");
                        String message = (String) request.getAttribute("message");
                        String confirmMessage = (String) request.getAttribute("confirmMessage");
                        if (error != null) {
                            out.println("<p style='color:red'>" + error + "</p>");
                        }
                        
                        if (confirmMessage != null) {
                            out.println("<p style='color:#00cc00'>" + confirmMessage + "</p>");
                        }
                        
                        if (message != null) {
                            out.println("<p style='color:red'>" + message + "</p>");
                        }
                    %>
                    <script>
                      var password = document.getElementById("password")
                     , confirm_password = document.getElementById("confirm_password");

                    function validatePassword(){
                      if(password.value != confirm_password.value) {
                        confirm_password.setCustomValidity("Passwords Don't Match");
                      } else {
                        confirm_password.setCustomValidity('');
                      }
                    }

                    password.onchange = validatePassword;
                    confirm_password.onkeyup = validatePassword;
                        
                    </script>    
            </form>
        </div>
        </div>
</body>
</html>
