<%-- 
    Document   : login
    Created on : Oct 11, 2017, 12:43:46 AM
    Author     : N56VV
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <script src="js/jquery.min.js" type="text/javascript"></script>
        <script src="js/bootstrap.min.js" type="text/javascript"></script>
        <link rel="stylesheet" href="css/bootstrap.min.css">




        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login Page</title>
    </head>
    <body>
       
        <div class="container" >
            <div ng-view class="col-sm-12" style="width: 600px; margin-left: 300px; margin-top: 125px;">
                <div class="jumbotron">


                    <div ng-view class="form-group">
                        <h3 class="form-signin-heading"style="margin-left: 10px">Welcome To The 92 Shop Inventory Management System</h3>
                    </div>

                    <form ng-view class="form-horizontal" style="margin-left: 100px" action="LoginController" onsubmit="return validation()" method="post">
                        <div class="form-group input-group">
                            <span class="input-group-addon">
                                <span class="glyphicon glyphicon-user">

                                </span>
                            </span>

                            <input type="text" name="username" id="username" class="form-control" placeholder="username"  style="width: 300px;" required autofocus /><br />

                        </div>
                        <div ng-view class="form-group input-group">
                            <span class="input-group-addon">
                                <span class="glyphicon glyphicon-lock">

                                </span>
                            </span>

                            <input type="password" name="password" id="password" class="form-control" placeholder="password" style="width: 300px;" required  /><br/>

                        </div>
                        <div ng-view class="form-group ">
                            <input type="submit" class="btn btn-primary" value="submit" ><br>
                        </div>
                        <div ng-view class="form-group ">

                            <label id ="warning"> 

                                <%
                                    String error = request.getParameter("error");
                                    if (error != null) {

                                        out.print(error);
                                    }

                                %></label>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </body>
</html>
