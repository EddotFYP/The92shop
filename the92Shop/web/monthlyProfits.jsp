<%-- 
    Document   : sales
    Created on : Feb 9, 2018, 5:02:00 PM
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
        <title>Monthly Profits</title>
        <script src="js/jquery.min.js"></script>
        <script src = "js/highcharts.js"></script>

    </head>
    <body>
        <form action="FinancialDbController" method="post">
            <div id = "financialDashboard">
                <h2>Monthly Profits</h2>
                <br />
                Filter monthly profits by:
                <select name="monthlyProfits" required>
                    <option value="">Please select</option>
                    <option value="2016">2016</option>
                    <option value="2017" >2017</option>
                </select>

                <button type="submit" name="submit" class="btn">Filter</button>

                <br />
                <br />

                <%                    String text = (String) request.getAttribute("sortMonthlyProfits");

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
