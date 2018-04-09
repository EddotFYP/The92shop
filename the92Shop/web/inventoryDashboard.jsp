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
<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.16/css/jquery.dataTables.css">
<script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.10.16/js/jquery.dataTables.js"></script>
<link href="//cdn.muicss.com/mui-0.9.36/css/mui.min.css" rel="stylesheet" type="text/css" />
<%@include file="sideNavBar.jsp" %>
<%@include file="protect.jsp" %>


<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
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
                    "bSorted": true,
                    "order": [],
                    "ordering": true
                    
                });
            });

        </script>
    </head>
    <body>
        <form action="InventoryDbController" method="post" class="mui-form--inline">
            <input type="hidden" name="invLevel" value="inventoryLevel">
            <input type="hidden" name="invList" value="lowInvList">
                <div class="mui-panel subPageTitleContentInventory">
                <h1>Inventory Dashboard</h1>
                <div class="mui-divider"></div>
                <%
                    int qty = (Integer) request.getAttribute("alertResult");
                    %>
               
                     
                    <%if (qty >= 0) {%>
               
                    <h2>Low inventory alert: </h2>
                    <h2><u><strong style="color: red;"><%=qty%></strong></u> products</h2>
                    
                     </div>
                    <%}

                        ArrayList<Inventory> invList = (ArrayList<Inventory>) request.getAttribute("listResult");
                        if (invList != null || !invList.isEmpty()) {
                    %>
               
                    <br /> 
                    
                    <div class=" table-responsive mui-panel subPageContentInventory">
                        <h2> List of low inventory products</h2>
                        <table  id="myTable" >
                            <thead>
                                <tr>
                                    <th width="100px" id="aquantity">Name</th>
                                    <th>Quantity</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <%
                                        for (Inventory i : invList) {
                                            String productName = i.getName();
                                            int quantity = i.getQuantity();
                                    %>    
                                    <td width="100px" id="iName"><%=productName%></td>
                                    <td width="50px" id="quantity" align="center" ><%=quantity%></td>
                                </tr>
                                <%
                            } %>
                            </tbody>
                        </table>      
                        <%
                            }
                        %>
                    </div>
                    
                    <div class="mui-panel topProduct">
                    <h2>Top 5 Best Sellers</h2>
                    <table>
                        <tbody>
                            <tr>
                                <td><span class="priceBundleSpan">Filter by (monthly/yearly):</span></td>
                                <td><div class="mui-select">
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
                    </div></td>
                    <td><div class="mui-select">
                        <select name="year">
                            <option value="none" selected>Please select</option>
                            <option value="2017" >2017</option>
                            <option value="2018" >2018</option>
                        </select>
                    </div></td>
                    </tr>
                   
                            
                        
                        </tbody>
                    </table>
                     <button type="submit" name="submit" id="filterBtn" class="mui-btn mui-btn--raised mui-btn--primary" style="text-transform: capitalize; border-radius:8px;  font-size:18px;"> Filter <i class="fa fa-filter" style="font-size:18px;"></i></button>
                    <%                ArrayList<String> itemNameList = (ArrayList<String>) request.getAttribute("itemNameResult");
                        String jsonItemName = new Gson().toJson(itemNameList);

                        ArrayList<String> itemQtyList = (ArrayList<String>) request.getAttribute("itemQtyResult");
                        String jsonItemQty = new Gson().toJson(itemQtyList);

                        String text = (String) request.getAttribute("word");
                        String error = (String) request.getAttribute("error");

                        if (text != null && !text.isEmpty()) {
                            if (!text.equals("none")) {
                                out.println("<br /><p style='font-size:18px;'>" + "You have selected: <b><u> " + text + "</b></u></p>");   
                            }
                        }

                        if (itemNameList != null && !itemNameList.isEmpty() && itemQtyList != null && !itemQtyList.isEmpty()) {
                    %>
                   
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
                                    valueSuffix: ' products'
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
                            }else {
                                out.println("<br /><p style='color:red; font-size:18px;'>" + error + "</p>");
                            }

                           
                        }
                    %>
                </div>
        </form>  
    </body>
</html>
