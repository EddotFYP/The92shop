<%-- 
    Document   : sales
    Created on : Feb 9, 2018, 5:02:00 PM
    Author     : Clarey Liow JX
--%>

<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.ArrayList"%>
<%@include file="sideNavBar.jsp" %>
<%@include file="protect.jsp" %>
<link rel="stylesheet" href="css/master.css">
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Yearly Trend for Sales</title>
        <script src="js/jquery.min.js"></script>
        <script src = "js/highcharts.js"></script>

    </head>
    <script>
        function yearlySales() {
            var text = "abc";
            document.getElementById('yearlyTrendSales').value = text;
            document.getElementById('myForm').submit();
        }

    </script>
    <body>
        <form id="myForm" action="FinancialDbController" method="post">
            <div id = "financialDashboard">
                <a href="financialDb.jsp" class="navDbButton">Profits</a>
                <a href="sales.jsp" class="navDbButton">Sales</a>
                <a href="expenses.jsp" class="navDbButton">Expenses</a>
                
                <br />
                <br />
                <br />
                <h2>Yearly Trend for Sales</h2>
                <br />

                <button type="submit" id="ybtn" onclick="yearlySales()" class="btn" >Yearly Trend</button>
                <input type="hidden" id="yearlyTrendSales" name="yearlyTrendSales" value="">
                <br />
                <br />

                <h2>Monthly Sales</h2>
                Filter monthly sales by:
                <select name="monthlySales" id="month" required>
                    <option value="" selected>Please select</option>
                    <option value="2016">2016</option>
                    <option value="2017" >2017</option>
                    <option value="2018" >2018</option>
                </select>

                <button type="submit" name="btnSubmit" class="btn">Filter</button>

                <br />
                <br />

                <%                    //yearly sales 
                    ArrayList<Double> yearlySales = (ArrayList<Double>) request.getAttribute("yearlySalesResult");
                    String jsonYearlySales = new Gson().toJson(yearlySales);

                    String text = (String) request.getAttribute("sortMonthlySales");

                    ArrayList<String> salesResult = (ArrayList<String>) request.getAttribute("salesResult");
                    String jsonMonthlySales = new Gson().toJson(salesResult);

                    if (yearlySales != null) {
                %>
                <div id = "yearlySalesContainer" class="containerDB" >
                    <script>
                        var yearlySales = <%=jsonYearlySales%>;
                        $(document).ready(function () {
                            var title = {
                                text: ''
                            };
                            var subtitle = {
                                text: ''
                            };
                            var xAxis = {
                                categories: [2016, 2017, 2018]
                            };
                            var yAxis = {
                                title: {
                                    text: 'Sales'
                                },
                                min: 0,
                                plotLines: [{
                                        value: 0,
                                        width: 1,
                                        color: '#808080'
                                    }]
                            };
                            var tooltip = {
                                valueSuffix: ''
                            }

                            var series = [{
                                    name: 'Yearly Trend',
                                    data: JSON.parse("[" + yearlySales + "]")
                                }
                            ];

                            var license = {
                                enabled: false
                            };

                            var json = {
                            };
                            json.title = title;
                            json.subtitle = subtitle;
                            json.xAxis = xAxis;
                            json.yAxis = yAxis;
                            json.tooltip = tooltip;
                            json.series = series;
                            json.credits = license;

                            $('#yearlySalesContainer').highcharts(json);
                        });
                    </script>
                </div>
                <%
                    }
                    if (salesResult != null) {
                        out.println("You have selected: " + text + "<br /><br />");
                %>
                <div>
                    <div id = "monthlySalesContainer" class="containerDB" >
                        <script>
                            //straight display latest monthly sales
                            var monthlySales = <%=jsonMonthlySales%>;
                            $(document).ready(function () {
                                var title = {
                                    text: ''
                                };
                                var subtitle = {
                                    text: ''
                                };
                                var xAxis = {
                                    categories: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
                                        'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec']
                                };
                                var yAxis = {
                                    title: {
                                        text: 'Sales'
                                    },
                                    plotLines: [{
                                            value: 0,
                                            width: 1,
                                            color: '#808080'
                                        }]
                                };
                                var tooltip = {
                                    valueSuffix: ' SGD'
                                };

                                var series = [{
                                        name: 'Monthly Sales',
                                        data: JSON.parse("[" + monthlySales + "]")

                                    }
                                ];

                                var license = {
                                    enabled: false
                                };

                                var json = {};
                                json.title = title;
                                json.subtitle = subtitle;
                                json.xAxis = xAxis;
                                json.yAxis = yAxis;
                                json.tooltip = tooltip;
                                json.series = series;
                                json.credits = license;

                                $('#monthlySalesContainer').highcharts(json);
                            });

                        </script>
                    </div>
                </div>
                <% }

                %>

            </div>
        </form>
    </body>
</html>
