<%-- 
    Document   : inventoryDashboard
    Created on : Jan 21, 2018, 5:01:24 PM
    Author     : Clarey Liow JX
--%>

<%@page import="java.util.LinkedHashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="entity.Inventory"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<link rel="stylesheet" href="css/master.css">
<link rel="stylesheet" href="css/dataTables.min.css">
<%@include file="sideNavBar.jsp" %>
<%@include file="protect.jsp" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Inventory Dashboard</title>
        <script src="js/jquery-1.12.3.js"></script>
        <script src="js/jquery.min.js"></script>
        <script src="js/dataTables.min.js"></script>
        
        <script>
            $(document).ready(function () {
            $('#myTable').dataTable({
                "bPaginate": true,
                "bLengthChange": false,
                "bFilter": false,
                "bInfo": false,
                "bAutoWidth": false,
                "bSorted": false,
                "order": [],
                "ordering": false
            }); 
             });     
 
        </script>
    </head>
    <body>
        <form action="InventoryDbController" method="post">
            <input type="hidden" name="invLevel" value="inventoryLevel">
            <input type="hidden" name="invList" value="lowInvList">

            <div id="title"><h2>Inventory Dashboard</h2></div>
            <div id="invAlert">

                <center><h3>Low inventory alert:</h3></center>
                    <%                        
                        int qty = (Integer) request.getAttribute("alertResult");
                        if (qty >= 0) {%>
                <div style="background-color:#ffffcc;"><%=qty%> Items</div>
                <%
                    }
                %>
            </div> 
               <div id="topProduct">
                <h3>Top 5 Best Sellers:</h3>
                Filter by (Monthly/Yearly):
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
                    <option value="2017" >2017</option>
                    <option value="2018" >2018</option>
                </select>

                <button type="submit" name="submit" class="btn">Filter</button>
                <br>


                <%
                    LinkedHashMap<String, String> finalResult = (LinkedHashMap<String, String>) request.getAttribute("result");

                    String text = (String) request.getAttribute("word");
                    String error = (String) request.getAttribute("error");

                    if (text != null && !text.isEmpty()) {
                        if (!text.equals("none")) {
                            out.println("<br />" + "You have selected: " + text + "<br />");
                        }
                    }

                    if (finalResult != null && !finalResult.isEmpty()) {
                %>
                
                
                <table border="1" id="invTable">
                    <thead>
                        <tr>
                            <th>Name</th>
                            <th>Quantity Sold</th>
                        </tr>
                    </thead>
                    <%
                        for (String nameOfProduct : finalResult.keySet()) {

                            String quantity = finalResult.get(nameOfProduct);
                    %>
                    <tbody>
                        <tr>
                            <td>
                                <%=nameOfProduct%>
                            </td>
                            <td>
                                <%=quantity%>
                            </td>
                        </tr>
                        <%
                                }
                            } else {

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
            <br />
            <br />
            <%
                ArrayList<Inventory> invList = (ArrayList<Inventory>) request.getAttribute("listResult");
                if (invList != null || !invList.isEmpty()) {
            %>
            <div id="lowInv">
                <h3> List of low inventory items</h3>
                    <div class="table-responsive">
                        <table border="1" id="myTable">
                            <thead>
                                <tr>
                                    <th>SKU ID</th>
                                    <th>Name</th>
                                    <th>Quantity</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <%
                                        for (Inventory i : invList) {
                                            int SKUId = i.getSKUID();
                                            String productName = i.getName();
                                            int quantity = i.getQuantity();
                                    %>    
                                    <td><%=SKUId%></td>
                                    <td><%=productName%></td>
                                    <td><%=quantity%></td>
                                </tr>
                            <%
                } %>
                            </tbody>
                        </table>      
                        <%
                            }
                        %>
                    </div>
            </div>
        </form>  
    </body>
</html>
