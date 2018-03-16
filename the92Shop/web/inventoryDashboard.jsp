<%-- 
    Document   : inventoryDashboard
    Created on : Jan 21, 2018, 5:01:24 PM
    Author     : Clarey Liow JX
--%>

<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.LinkedHashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="entity.Inventory"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<link rel="stylesheet" href="css/dataTables.min.css">
<link href="//cdn.muicss.com/mui-0.9.36/css/mui.min.css" rel="stylesheet" type="text/css" />
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
        <script src = "js/highcharts.js"></script>
        
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
        <form action="InventoryDbController" method="post" class="mui-form--inline">
            <input type="hidden" name="invLevel" value="inventoryLevel">
            <input type="hidden" name="invList" value="lowInvList">

            <div class="subPageContent"><h1>Inventory Dashboard</h1></div>
            <div id="topProduct">
            <h2>Top 5 Best Sellers:</h2>
            Filter by (Monthly/Yearly): &nbsp;
            <div class="mui-select">
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
            </div>
            <div class="mui-select">
            <select name="year">
                <option value="none" selected>Please select</option>
                <option value="2017" >2017</option>
                <option value="2018" >2018</option>
            </select>
            </div>
            <br />
            <br />
            <button type="submit" name="submit" class="mui-btn mui-btn--raised mui-btn--primary"><i class="fa fa-filter" style="font-size:18px;"> Filter </i></button>
            <br>


            <%
                ArrayList<String> itemNameList = (ArrayList<String>) request.getAttribute("itemNameResult");
                String jsonItemName = new Gson().toJson(itemNameList);
                
                ArrayList<String> itemQtyList = (ArrayList<String>) request.getAttribute("itemQtyResult");
                String jsonItemQty = new Gson().toJson(itemQtyList);   
                
                String text = (String) request.getAttribute("word");
                String error = (String) request.getAttribute("error");

                if (text != null && !text.isEmpty()) {
                    if (!text.equals("none")) {
                        out.println("<br />" + "You have selected: " + text + "<br />");
                    }
                }

                if (itemNameList != null && !itemNameList.isEmpty() && itemQtyList != null && !itemQtyList.isEmpty()) {
            %>
                <br />
                <div id = "inventoryContainer" >
                        <script>
                            var nameList = <%=jsonItemName%>;
                            var qtyList = <%=jsonItemQty%>;
                            $(document).ready(function () {
                                var chart = {
                                    borderColor: '#000000',
                                    borderWidth: 1,
                                    type: 'column'
                                };
                                var title = {
                                    text: ''
                                };
                                var subtitle = {
                                    text: ''
                                };
                                var xAxis = {
                                    categories: nameList,
                                    
                                    labels: {
                                        style: {
                                            color: 'black',
                                            fontSize: 14
                                        }
                                    }
                                };
                                var yAxis = {
                                    labels: {
                                        style: {
                                            color: 'black',
                                            fontSize: 13
                                        }
                                    },
                                    title: {

                                        text: 'Quantity'
                                    },
                                    min: 0,
                                    plotLines: [{
                                            value: 0,
                                            width: 1,
                                            color: '#808080'
                                        }]
                                };
                                var tooltip = {
                                    valueSuffix: ' items'
                                };

                                var series = [{
                                        name: 'Product Name',
                                        color: '#FFB74D',
                                        data: JSON.parse("[" + qtyList + "]")
                                    }
                                ];

                                var license = {
                                    enabled: false
                                };

                                var json = {
                                };
                                json.chart = chart;
                                json.title = title;
                                json.subtitle = subtitle;
                                json.xAxis = xAxis;
                                json.yAxis = yAxis;
                                json.tooltip = tooltip;
                                json.series = series;
                                json.credits = license;

                                $('#inventoryContainer').highcharts(json);
                            });
                        </script>
                    </div>
            
            <%
                        } else {

                            if (error == null) {
                                error = "";
                            } else {
                                out.println("<br /><p style='color:red'>" + error + "</p>");
                            }
                        }
                    %>
        </div>
        <br />
        <br />
        <%
            int qty = (Integer) request.getAttribute("alertResult");
            
            if (qty >= 0){  %>
                <div id="lowInv">
                <h2>Low inventory alert: </h2>
                <h2><strong style="color: red;"><%=qty%></strong> items</h2>
            <%}
            
            ArrayList<Inventory> invList = (ArrayList<Inventory>) request.getAttribute("listResult");
            if (invList != null || !invList.isEmpty()) {
        %>
        
            <br /> 
            <h2> List of low inventory items</h2>
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
                            <td ><%=SKUId%></td>
                            <td ><%=productName%></td>
                            <td ><%=quantity%></td>
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
