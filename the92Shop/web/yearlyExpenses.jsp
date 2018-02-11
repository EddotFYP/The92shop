<%-- 
    Document   : yearlyExpense
    Created on : Feb 10, 2018, 1:50:52 PM
    Author     : Clarey Liow JX
--%>

<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.ArrayList"%>
<link rel="stylesheet" href="css/master.css">
<%@include file="sideNavBar.jsp" %>
<%@include file="protect.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Yearly Trend for Expenses</title>
        <script src="js/jquery.min.js"></script>
        <script src = "js/highcharts.js"></script>
    </head>
    <body>
          <form id="myForm" action="FinancialDbController" method="post">
            <div id = "financialDashboard">
                <h2>Yearly Trend for Expense</h2>
                <br />
                <input type="hidden" name="yearlyExpense" value="yearData">
                <button type="submit" name="submit" class="btn">Yearly Trend</button>
                
                <br />
                <br />

                <%
                   //yearly expense 
                    ArrayList<Double> yearlyExpenses = (ArrayList<Double>) request.getAttribute("yearlyExpensesResult");
                    String jsonYearlyExpenses = new Gson().toJson(yearlyExpenses);
                    

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
                            categories: [2016, 2017]
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
            %>
            </div>
        </form>
    </body>
</html>
