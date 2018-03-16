<%-- 
    Document   : login
    Created on : Oct 11, 2017, 12:43:46 AM
    Author     : N56VV
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<link href="css/master.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="https://netdna.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css">
<link href="//cdn.muicss.com/mui-0.9.36/css/mui.min.css" rel="stylesheet" type="text/css" />
<!DOCTYPE html>
<html>
    <head>
        <script src="js/jquery.min.js" type="text/javascript"></script>
        <script src="js/bootstrap.min.js" type="text/javascript"></script>
        <link rel="stylesheet" href="css/bootstrap.min.css">
        
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login Page</title>
    </head>
    <body background="image/loginPic.jpg">
       
        <div id ="loginContainer">
            <img class ="loginpic" src="image/Eddot_Logo.jpg" />
            <h2>Inventory Management System</h2>
            <form class="mui-form--inline" action="LoginController" method="post">
                
                <div class="mui-textfield">
                <input type="text" name="username" id="username" placeholder="Username"  style="width: 300px;" required /><br />
                </div>
                <br />
                <div class="mui-textfield">
                <input type="password" name="password" id="password" placeholder="Password" style="width: 300px;" required/><br/>
                </div>
                <br />
                <button type="submit" name="login" class="mui-btn mui-btn--raised mui-btn--danger "><i class="fa fa-sign-in" style="font-size:18px;"> Login</i></button>
                 </form>
                <%
                    String error = (String) request.getAttribute("error");
                    if (error != null) {
                        out.println("<p style='color:red'>" + error + "</p>");
                    }
                %>
           
        </div>
    </body>
</html>
