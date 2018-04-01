<%-- 
    Document   : analytics
    Created on : Mar 18, 2018, 2:33:50 PM
    Author     : Jacquelyn
--%>

<%@page import="com.google.gson.Gson"%>
<%@page import="entity.Inventory"%>
<%@page import="java.util.ArrayList"%>
<%@page import="DAO.InventoryDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="protect.jsp" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
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
        <title>Analytics </title>
    </head>
    <body>
      <%             String usernameAcc = (String) session.getAttribute("user");

             if (usernameAcc.equals("qingyang") || usernameAcc.equals("cynthia")) {%>
        <%@include file="sideNavBar.jsp" %>
        <%} else {%>
        <%@include file="nonAdminSideNavBar.jsp" %>
        <% }


        %>

        <form class="mui-form--inline" action="AnalyticsDB" method="post">
            <div class="subPageContent">
                <div id = "pricingBundleTable">
                    <div class ="mui-panel">
                        <h1>Product Bundling Sales</h1>
                        <div class="mui-divider"></div>
                        Filter by (monthly/yearly):
                        <div class="mui-select">
                            <select name="month" required>
                                <option value=''>Please select</option>
                                <option value='1'>January</option>
                                <option value='2' >February</option>
                                <option value='3' >March</option>
                                <option value='4' >April</option>
                                <option value='5' >May</option>
                                <option value='6' >June</option>
                                <option value='7' >July</option>
                                <option value='8' >August</option>
                                <option value='9' >September</option>
                                <option value='10' >October</option>
                                <option value='11' >November</option>
                                <option value='12' >December</option>
                            </select>
                        </div>

                        <div class="mui-select">
                            <select name="year" class="required" required>
                                <option value="" >Please select</option>
                                <option value="2017" >2017</option>
                                <option value="2018" >2018</option>
                            </select>
                        </div>

                        &nbsp;
                        <button type="submit" name="submit" class="mui-btn mui-btn--raised mui-btn--primary" style="font-size:18px;">Submit <i class="fa fa-caret-right" style="font-size:18px;"></i></button>

                        <br />
                        <br />
                               
                    <%                 
                        InventoryDAO invDAO = new InventoryDAO();
                        ArrayList<String> promoNameList = (ArrayList<String>) request.getAttribute("promoNameResult");
                        String jsonPromoName = new Gson().toJson(promoNameList);
                        ArrayList<String> promoQtyList = (ArrayList<String>) request.getAttribute("promoQtyResult");
                        String jsonPromoQty = new Gson().toJson(promoQtyList);
                        
                        String text = (String) request.getAttribute("word");
                            if (text != null) {

                                out.println("You have selected: <b><u>" + text + "</b></u><br /><br />");
                            }
                        if (promoNameList != null && !promoNameList.isEmpty() && promoQtyList != null && !promoQtyList.isEmpty()) {
                            
                    %>    
                </div>   
                <div class ="mui-panel">
                    <div id = "inventoryContainer" >
                        <script>
                            var nameList = <%=jsonPromoName%>;
                            var qtyList = <%=jsonPromoQty%>;
                            $(document).ready(function () {
                                var chart = {
                                    borderColor: '#000000',
                                    borderWidth: 1,
                                    type: 'spline'
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
                            String error = (String) request.getAttribute("errorMsg");
                            if (error == null) {
                                error = "";
                            } else {
                                out.println("<p style='color:red'>" + error + "</p>");
                            }
                        }
                    %>
                </div>                
        </form> 
    </body>
</html>
