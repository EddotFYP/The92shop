<%-- 
    Document   : yearlyExpense
    Created on : Feb 10, 2018, 1:50:52 PM
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
        <title>Yearly Trend for Expenses</title>
        <script src="js/jquery.min.js"></script>
        <script src = "js/highcharts.js"></script>
        <script>
            function yearlyExpenses() {

                var text = "abc";
                document.getElementById('yearData').value = text;
                document.getElementById('myForm').submit();
            }

        </script>
    </head>
    <body>
        <form id="myForm" class="mui-form--inline" action="FinancialDbController" method="post" >

            <div class = "subPageContent">
                <a href="financialDb.jsp" class="navDbButton">Profits</a>
                <a href="sales.jsp" class="navDbButton">Sales</a>
                <a href="expenses.jsp" class="navDbButton">Expenses</a>
                
                <br />
                <br />
                <div class ="mui-panel profits">
                <h1>Yearly Trend for Expenses</h1>
                <br />

                <button type="submit" id="ybtn" onclick="yearlyExpenses()" class="mui-btn mui-btn--raised mui-btn--primary" formnovalidate><i class="fa fa-bar-chart-o"style="font-size:18px;"> Yearly Trend</i></button>
                <input type="hidden" id="yearData" name="yearData" value="" >
                </div>
                <br />
                <br />
                <div class ="mui-panel monthlyexpenses">
                <h1>Monthly Expenses</h1>
                Filter monthly expenses by: 
                <div class="mui-select">
                <select name="monthlyExpenses" id="month" required>
                    <option value="" selected>Please select</option>
                    <option value="2017" >2017</option>
                    <option value="2018" >2018</option>
                </select>
                </div>
                
                &nbsp;
                <button type="submit" name="btnSubmit" class="mui-btn mui-btn--raised mui-btn--primary"><i class="fa fa-filter"style="font-size:18px;"> Filter </i></button>
                </div>
                <%                    
                    //yearly expense 
                    ArrayList<String> yearInExpense = (ArrayList<String>) request.getAttribute("yearInExpense");
                    String jsonYear = new Gson().toJson(yearInExpense);
                    
                    ArrayList<String> expInExpense = (ArrayList<String>) request.getAttribute("expInExpense");
                    String jsonExpense = new Gson().toJson(expInExpense);
                    
                    String text = (String) request.getAttribute("sortMonthlyExpense");

                    ArrayList<String> expenseResult = (ArrayList<String>) request.getAttribute("expenseResult");
                    String jsonMonthlyExpenses = new Gson().toJson(expenseResult);

                    if (yearInExpense != null && expInExpense != null) {

                %>
               <div class="mui-panel expenseYearlyResult" >
                <div id = "yearlyExpensesContainer" class="containerDB" >
                    <script>

                        var year = <%=jsonYear%>;
                        var expense = <%=jsonExpense%>;
                        $(document).ready(function () {
                            var chart = {
                              borderColor: '#000000',
                              borderWidth: 1 
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
                                    fontSize: 13
                                    }
                                },
                                categories: year,
                                
                            };
                            var yAxis = {
                                labels: {
                                    style: {
                                    color: 'black',
                                    fontSize: 13
                                    }
                                },
                                title: {
                                    text: 'Expenses',
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
                                    data: JSON.parse("[" + expense + "]")
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
                            $('#yearlyExpensesContainer').highcharts(json);
                        });
                    </script>
                </div>
                 </div>       
                <%
                    }
                    if (expenseResult != null) {
                        out.println("<div class='mui-panel monthlysales'>You have selected: " + text);
                %>
                    <div id = "monthlyExpensesContainer" class="containerDB" >
                        <script>
                            //straight display latest monthly sales
                            var monthlyExpense = <%=jsonMonthlyExpenses%>;
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
                                    fontSize: 13
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
                                        text: 'Expenses'
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
                                        name: 'Monthly Expenses',
                                         color: '#009688',
                                        data: JSON.parse("[" + monthlyExpense + "]")

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

                                $('#monthlyExpensesContainer').highcharts(json);
                            });

                        </script>
                    </div>
                
                <% }
                %>
            </div>
        </form>
    </body>
</html>
