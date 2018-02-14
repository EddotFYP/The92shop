<%-- 
    Document   : yearlyExpense
    Created on : Feb 10, 2018, 1:50:52 PM
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
        <form id="myForm" action="FinancialDbController" method="post" >

            <div id = "financialDashboard">
                <a href="financialDb.jsp" class="navDbButton">Profits</a>
                <a href="sales.jsp" class="navDbButton">Sales</a>
                <a href="expenses.jsp" class="navDbButton">Expenses</a>
                
                <br />
                <br />
                <br />
                <h2>Yearly Trend for Expenses</h2>
                <br />

                <button type="submit" id="ybtn" onclick="yearlyExpenses()" class="btn">Yearly Trend</button>
                <input type="hidden" id="yearData" name="yearData" value="" >
                <br />
                <br />

                <h2>Monthly Expenses</h2>
                Filter monthly expenses by:
                <select name="monthlyExpenses" id="month" required>
                    <option value="" selected>Please select</option>
                    <option value="2016">2016</option>
                    <option value="2017" >2017</option>
                    <option value="2018" >2018</option>
                </select>
                
                <button type="submit" name="btnSubmit" class="btn" >Filter</button>
                <br />
                <br />
                <%                    
                    //yearly expense 
                    ArrayList<Double> yearlyExpenses = (ArrayList<Double>) request.getAttribute("yearlyExpensesResult");
                    String jsonYearlyExpenses = new Gson().toJson(yearlyExpenses);
                    

                    String text = (String) request.getAttribute("sortMonthlyExpense");

                    ArrayList<String> expenseResult = (ArrayList<String>) request.getAttribute("expenseResult");
                    String jsonMonthlyExpenses = new Gson().toJson(expenseResult);

                    if (yearlyExpenses != null) {

                %>
                <div id = "yearlyExpensesContainer" class="containerDB" >
                    <script>

                        var yearlyExpense = <%=jsonYearlyExpenses%>;
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
                                    text: 'Expenses'
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
                                    data: JSON.parse("[" + yearlyExpense + "]")
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
                            $('#yearlyExpensesContainer').highcharts(json);
                        });
                    </script>
                </div>

                <%
                    }
                    if (expenseResult != null) {
                        out.println("You have selected: " + text + " <br /><br />");
                %>
                <div>
                    <div id = "monthlyExpensesContainer" class="containerDB" >
                        <script>
                            //straight display latest monthly sales
                            var monthlyExpense = <%=jsonMonthlyExpenses%>;
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
                                        data: JSON.parse("[" + monthlyExpense + "]")

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

                                $('#monthlyExpensesContainer').highcharts(json);
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
