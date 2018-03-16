<%-- 
    Document   : sales
    Created on : Feb 9, 2018, 5:02:00 PM
    Author     : Clarey Liow JX
--%>

<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.ArrayList"%>
<%@include file="sideNavBar.jsp" %>
<%@include file="protect.jsp" %>
<link href="//cdn.muicss.com/mui-0.9.36/css/mui.min.css" rel="stylesheet" type="text/css" />
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
        <form id="myForm" class="mui-form--inline" action="FinancialDbController" method="post">
            <div class = "subPageContent">
                <a href="financialDb.jsp" class="navDbButton">Profits</a>
                <a href="sales.jsp" class="navDbButton">Sales</a>
                <a href="expenses.jsp" class="navDbButton">Expenses</a>
                
                <br />
                <br />
                <br />
                <h1>Yearly Trend for Sales</h1>
                <br />

                <button type="submit" id="ybtn" onclick="yearlySales()" class="mui-btn mui-btn--raised mui-btn--primary" formnovalidate><i class="fa fa-bar-chart-o" style="font-size:18px;"> Yearly Trend</i></button>
                <input type="hidden" id="yearlyTrendSales" name="yearlyTrendSales" value="">
                <br />
                <br />

                <h1>Monthly Sales</h1>
                Filter monthly sales by:
                <div class="mui-select">
                <select name="monthlySales" id="month" required>
                    <option value="" selected>Please select</option>
                    <option value="2017" >2017</option>
                    <option value="2018" >2018</option>
                </select>
                </div>

               &nbsp;
                <button type="submit" name="btnSubmit" class="mui-btn mui-btn--raised mui-btn--primary"><i class="fa fa-filter" style="font-size:18px;"> Filter </i></button>

                <br />
                <br />

                <%                    
                    //yearly sales 
                    ArrayList<String> yearInSales = (ArrayList<String>) request.getAttribute("yearInSales");
                    String jsonYear = new Gson().toJson(yearInSales);
                    
                    ArrayList<String> salesInSales = (ArrayList<String>) request.getAttribute("salesInSales");
                    String jsonSales = new Gson().toJson(salesInSales);

                    String text = (String) request.getAttribute("sortMonthlySales");

                    ArrayList<String> salesResult = (ArrayList<String>) request.getAttribute("salesResult");
                    String jsonMonthlySales = new Gson().toJson(salesResult);

                    if (yearInSales != null && salesInSales != null) {
                %>
                <div id = "yearlySalesContainer" class="containerDB" >
                    <script>
                        var year = <%=jsonYear%>;
                        var sales = <%=jsonSales%>;
                        $(document).ready(function () {
                            var chart = {
                              borderColor: '#000000',
                              borderWidth: 1,  
                            };
                            var title = {
                                text: ''
                            };
                            var subtitle = {
                                text: ''
                            };
                            var xAxis = {
                                categories: year,
                                labels: {
                                    style: {
                                    color: 'black',
                                    fontSize: 13,
                                    }
                                }
                            };
                            var yAxis = {
                                labels: {
                                    style: {
                                    color: 'black',
                                    fontSize: 13,
                                    }
                                },
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
                                valueSuffix: ' SGD'
                            }

                            var series = [{
                                    name: 'Yearly Trend',
                                    color: '#009688',
                                    data: JSON.parse("[" + sales + "]")
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
                                var chart = {
                                borderColor: '#000000',
                                borderWidth: 1,  
                                };
                                var title = {
                                    text: ''
                                };
                                var subtitle = {
                                    text: ''
                                };
                                var xAxis = {
                                    labels: {
                                    style: {
                                    color: 'black',
                                    fontSize: 13,
                                    }
                                },
                                    categories: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
                                        'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec']
                                };
                                var yAxis = {
                                    labels: {
                                        style: {
                                            color: 'black',
                                            fontSize: 13
                                        }
                                    },
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
                                        color: '#009688',
                                        data: JSON.parse("[" + monthlySales + "]")

                                    }
                                ];

                                var license = {
                                    enabled: false
                                };

                                var json = {};
                                json.chart = chart;
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
