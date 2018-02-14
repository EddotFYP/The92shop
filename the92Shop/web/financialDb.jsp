<%-- 
    Document   : financialDb
    Created on : Feb 13, 2018, 11:24:34 PM
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
    </head>
    <script>

        function yearlyProfits() {

            var text = "abc";
            document.getElementById('yearlyTrendProfits').value = text;
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
                <h2>Yearly Trend for Profits</h2>
                <br />

                <button type="submit" id="ybtn" onclick="yearlyProfits()" class="btn" >Yearly Trend</button>
                <input type="hidden" id="yearlyTrendProfits" name="yearlyTrendProfits" value="">

                <br />
                <br />
                <h2>Monthly Profits</h2>
                Filter monthly profits by:
                <select name="monthlyProfits" id="month" required>
                    <option value="" selected>Please select</option>
                    <option value="2016">2016</option>
                    <option value="2017" >2017</option>
                    <option value="2018" >2018</option>
                </select>

                <button type="submit" name="btnSubmit" class="btn">Filter</button>

                <br />
                <br />
                <%                    
                    ArrayList<Double> yearlyProfits = (ArrayList<Double>) request.getAttribute("yearlyProfitsResult");
                    String jsonYearlyProfits = new Gson().toJson(yearlyProfits);

                    if (yearlyProfits != null) {
                %>
                <div id = "yearlyProfitsContainer" class="containerDB" >
                    <script>
                        var yearlyProfits = <%=jsonYearlyProfits%>;
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
                                    text: 'Profits'
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
                                    data: JSON.parse("[" + yearlyProfits + "]")
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

                            $('#yearlyProfitsContainer').highcharts(json);
                        });
                    </script>
                </div>
                <%
                    }
                %>


                <%
                    String text = (String) request.getAttribute("sortMonthlyProfits");

                    ArrayList<String> profitsResult = (ArrayList<String>) request.getAttribute("profitsResult");
                    String jsonMonthlyProfits = new Gson().toJson(profitsResult);

                    if (profitsResult != null) {
                        out.println("You have selected: " + text + "<br /><br />");
                %>
                <div id = "monthlyProfitsContainer" class="containerDB" >
                    <script>
                        var monthlyProfits = <%=jsonMonthlyProfits%>;
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
                                    data: JSON.parse("[" + monthlyProfits + "]")

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
