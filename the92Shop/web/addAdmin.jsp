<%-- 
    Document   : addAdmin
    Created on : Feb 14, 2018, 11:02:11 PM
    Author     : Jacquelyn
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<link rel="stylesheet" href="css/master.css">
<%@include file="sideNavBar.jsp" %>
<%@include file="protect.jsp" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add new Admin Page</title>
    </head>
    <body>
        <div class="subPageContent">
            <form  action="UserController" method="post">
             <!--   <fieldset  class="fieldset-auto-width"> -->
                    <legend class="lg"><h2>Add New Admin</h2></legend>
                    <table>
                        <tr>
                            <td>
                                Admin Name:
                            </td>

                            <td>
                                <input type ="text" name ="name" id="name" required/>
                            </td>
                        </tr>
                        
                        <tr>
                            <td>
                                Password:
                            </td>

                            <td>
                                 <input type="password" placeholder="Password" id="password" name="password" required/>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                Confirm Password:
                            </td>    
                            <td>
                                <input type="password" placeholder="Confirm Password" id="confirm_password" required>
                            </td>
                        </tr>
                        
                        <tr>
                            <td>
                              <button type="submit" name="submit" class="btn"><i class="fa  fa-plus"> Add</i></button>
                            </td>
                            
                        </tr>
                       
                        
                        
                        
                    </table>
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
              <!--  </fieldset> -->

            </form>
        </div>

</body>
</html>
