<%-- 
    Document   : financialDb
    Created on : Feb 13, 2018, 11:24:34 PM
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
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Financial Overview</title>
        <script src="js/jquery.min.js"></script>
        <script src = "js/highcharts.js"></script>
    </head>
    <script>

        function yearlyProfits() {

            var text = "abc";
            document.getElementById('yearlyTrendProfits').value = text;
            document.getElementById('myForm').submit();
        }

    </script>
    <body>
        <form id="myForm" class="mui-form--inline" action="FinancialDbController" method="post">
            <div class = "financeSubPageContent">
                <div id="financeNavigation"> 
                <table>
                    <tbody>
                    <th style="width:150px"></th>
                    <th style="width:150px"><a href="financialDb.jsp"><i class="fa fa-bar-chart-o fa-lg"></i> Profits</a></th>
                    <th style="width:150px"></th>
                    <th style="width:150px"><a href="sales.jsp"><i class="fa fa-line-chart fa-lg"></i> Sales</a></th>
                    <th style="width:150px"></th>
                    <th style="width:150px"><i class="fa fa-dollar fa-lg" style="color:white"></i><a href="expenses.jsp"> Expenses</a></th>
                    
                    </tbody>
                </table>
                    
                </div>
               
                <br />
                <br />
                
                <div class ="mui-panel profits">
                <h1>Yearly Trend for Profits</h1>
                <br />

                <button type="submit" id="ybtn" onclick="yearlyProfits()" class="mui-btn mui-btn--raised mui-btn--primary buttonType" formnovalidate><i class="fa fa-bar-chart-o"style="font-size:18px;"> Yearly Trend</i></button>
                <input type="hidden" id="yearlyTrendProfits" name="yearlyTrendProfits" value="">
                </div>
                <br />
                <br />
                
                <div class ="mui-panel monthlyprofits">
                <h1>Monthly Profits</h1>
                Filter monthly profits by:
                <div class="mui-select">
                <select name="monthlyProfits" id="month" required>
                    <option value="" selected>Please select</option>
                    <option value="2017" >2017</option>
                    <option value="2018" >2018</option>
                </select>
                </div>
                &nbsp;
                <button type="submit" name="btnSubmit" class="mui-btn mui-btn--raised mui-btn--primary buttonType "><i class="fa fa-filter" style=" font-size:18px;"> Filter </i></button>
                </div>
               <%                    
                    ArrayList<String> yearInProfits = (ArrayList<String>) request.getAttribute("yearInProfits");
                    String jsonYear = new Gson().toJson(yearInProfits);
                    
                    ArrayList<String> profitInProfits = (ArrayList<String>) request.getAttribute("profitInProfits");
                    String jsonProfit = new Gson().toJson(profitInProfits);
                    
                    if (yearInProfits != null && profitInProfits != null) {
                %>
                
                <div class="mui-panel profitYearlyResult" >
                <div id = "yearlyProfitsContainer" >
                    <script>
                        var year = <%=jsonYear%>;
                        var profit = <%=jsonProfit%>;
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
                                    text: 'Profits',
                                    color: '#000000'
                                },
                                min: 0,
                                plotLines: [{
                                        value: 0,
                                        width: 1,
                                        color: '#000000'
                                    }]
                            };
                            var tooltip = {
                                valueSuffix: ' SGD'
                            }

                            var series = [{
                                    name: 'Yearly Trend',
                                    color: '#009688',
                                    data: JSON.parse("[" + profit + "]")
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

                            $('#yearlyProfitsContainer').highcharts(json);
                        });
                    </script>
                
                <%
                    }
                %>
                </div>
                </div>
                
                <%
                    String text = (String) request.getAttribute("sortMonthlyProfits");

                    ArrayList<Double> profitsResult = (ArrayList<Double>) request.getAttribute("profitsResults");
                    String jsonMonthlyProfits = new Gson().toJson(profitsResult);
                   
                    if (profitsResult != null) {
                        out.println("<div class='mui-panel profitMonthlyResult' style='font-size: 20px;'>You have selected: " + text);
                %>
                
                <div id = "monthlyProfitsContainer" class="containerDB" >
                    <script>
                        var monthlyProfits = <%=jsonMonthlyProfits%>;
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
                                    fontSize: 13,
                                    }
                                },
                                title: {
                                    text: 'Profits'
                                },
                                plotLines: [{
                                        value: 0,
                                        width: 1,
                                        color: '#000099'
                                    }]
                            };
                            var tooltip = {
                                valueSuffix: ' SGD'
                            };

                            var series = [{
                                    name: 'Monthly Profits',
                                    color: '#009688',
                                    data: JSON.parse("[" + monthlyProfits + "]")

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

                            $('#monthlyProfitsContainer').highcharts(json);
                        });

                    </script>
                </div>
                <% }
                %>
                
            </div>
        </form>
    </body>
</html>
