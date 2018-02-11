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
        <title>Monthly Sales</title>
        <script src="js/jquery.min.js"></script>
        <script src = "js/highcharts.js"></script>

    </head>
    <body>
        <form action="FinancialDbController" method="post">
            <div id = "financialDashboard">
                <h2>Monthly Sales</h2>
                <br />
                Filter monthly sales by:
                <select name="monthlySales" required>
                    <option value="">Please select</option>
                    <option value="2016">2016</option>
                    <option value="2017" >2017</option>
                </select>

                <button type="submit" name="submit" class="btn">Filter</button>

                <br />
                <br />

                <%
                    String text = (String) request.getAttribute("sortMonthlySales");

                    ArrayList<String> salesResult = (ArrayList<String>) request.getAttribute("salesResult");
                    String jsonMonthlySales = new Gson().toJson(salesResult);

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
