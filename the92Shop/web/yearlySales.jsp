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
        <title>Yearly Trend for Sales</title>
       <script src="js/jquery.min.js"></script>
        <script src = "js/highcharts.js"></script>

    </head>
    <body>
        <form id="myForm" action="FinancialDbController" method="post">
            <div id = "financialDashboard">
                <h2>Yearly Trend for Sales</h2>
                <br />
                <input type="hidden" name="yearlySales" value="yearData">
                <button type="submit" name="submit" class="btn">Yearly Trend</button>
                
                <br />
                <br />

                <%
                    //yearly sales 
                    ArrayList<Double> yearlySales = (ArrayList<Double>) request.getAttribute("yearlySalesResult");
                    String jsonYearlySales = new Gson().toJson(yearlySales);

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
                            categories: [2016, 2017]
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
            %>
            </div>
        </form>
    </body>
</html>
