<%-- 
    Document   : addAdmin
    Created on : Feb 14, 2018, 11:02:11 PM
    Author     : Jacquelyn
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<link href="//cdn.muicss.com/mui-0.9.36/css/mui.min.css" rel="stylesheet" type="text/css" />
<%@include file="nonAdminSideNavBar.jsp" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Change Password</title>
    </head>
    <body>
        <div class="subPageContent">
            <form class="mui-form" action="UserController" method="post" >
                <div class ="mui-panel "> 
                <h1>Change Password</h1>
                <div class="mui-divider"></div>
                <br />
                <table id="AdminTable">
                    <tr>
                        <td>
                            <span>Current Password</span><span style="float:right">:</span>
                        </td>

                        <td>
                            <div class="mui-textfield">
                                <input type ="text" name ="currentpassword" id="currentpassword" required />
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <span>New Password</span><span style="float:right">:</span>
                        </td>

                        <td>
                            <div class="mui-textfield">
                                <input type ="text" name ="passwordChange" id="passwordChange" required />
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <span>Confirm New Password</span><span style="float:right">:</span>
                        </td>

                        <td>
                            <div class="mui-textfield">
                                <input type ="text" name ="newpassword" id="newpassword" required />
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td></td>
                        <td>
                            <button type="submit" name="submit" class="mui-btn mui-btn--raised mui-btn--primary"><i class="fa  fa-check" style="font-size:18px;"> Change Password</i></button>
                        </td>

                    </tr>
                </table>
                <%                    String error = (String) request.getAttribute("error");
                    String message = (String) request.getAttribute("message");
                    if (error != null) {
                        out.println("<br /><p style='color:red'>" + error + "</p>");
                    }

                    if (message != null) {
                        out.println("<br /><p style='color:red'>" + message + "</p>");
                    }
                %>

            </form>
                </div>
        </div>

    </body>
</html>