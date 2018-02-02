<%-- 
    Document   : customerDashboard
    Created on : Jan 19, 2018, 12:38:17 PM
    Author     : Clarey Liow JX
--%>

<%@page import="java.util.LinkedHashMap"%>
<%@page import="DAO.CustomerDAO"%>
<%@page import="java.util.HashMap"%>
<%@page import="entity.Customer"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="sideNavBar.jsp" %>
<%@include file="protect.jsp" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <form action="CustomerDbController" method="post">
            
            <div id ="custDropdown">
                <h2> Customer Dashboard </h2>
                <br />
                <br />
                Filter by monthly/yearly:
                <select name="month">
                    <option value="none" selected>Please select</option>
                    <option value="January">January</option>
                    <option value="Febuary" >February</option>
                    <option value="March" >March</option>
                    <option value="April" >April</option>
                    <option value="May" >May</option>
                    <option value="June" >June</option>
                    <option value="July" >July</option>
                    <option value="August" >August</option>
                    <option value="September" >September</option>
                    <option value="October" >October</option>
                    <option value="November" >November</option>
                    <option value="December" >December</option>
                </select>


                <select name="year">
                    <option value="none" selected>Please select</option>
                    <option value="2016">2016</option>
                    <option value="2017" >2017</option>
                </select>


                <button type="submit" name="submit">Filter</button>

                <%
                    LinkedHashMap<String, String[]> finalResult = (LinkedHashMap<String, String[]>) request.getAttribute("result");
                    String text = (String) request.getAttribute("word");
                    if (text != null) {

                        out.println("<br /><br />" + "You have selected: " + text + "<br />");
                    }

                    if (finalResult != null && !finalResult.isEmpty()) {
                %>
                <br />
                <h3>Top Customers:</h3>
                <table border="1">
                    <thead>
                        <tr>
                            <th>Customer ID</th>
                            <th>Name</th>
                            <th>Phone Number</th>
                        </tr>
                    </thead>
                    <%
                        for (String cid : finalResult.keySet()) {
                            String customerName = finalResult.get(cid)[0];
                            String phoneNumber = finalResult.get(cid)[1];
                    %>
                    <tbody>
                        <tr>
                            <td>
                                <%=cid%>
                            </td>
                            <td>
                                <%=customerName%>
                            </td>
                            <td>
                                <%=phoneNumber%>
                            </td>
                        </tr>
                        <%
                                }
                            } else {
                                String error = (String) request.getAttribute("errorMsg");
                                if (error == null) {
                                    error = "";
                                } else {
                                    out.println("<p style='color:red'>" + error + "</p>");
                                }

                            }
                        %>
                    </tbody>
                </table>
            </div>
        </form>
    </body>
</html>
