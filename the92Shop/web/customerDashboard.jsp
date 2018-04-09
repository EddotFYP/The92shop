<%-- 
    Document   : customerDashboard
    Created on : Jan 19, 2018, 12:38:17 PM
    Author     : Clarey Liow JX
--%>

<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.LinkedHashMap"%>
<%@page import="DAO.CustomerDAO"%>
<%@page import="java.util.HashMap"%>
<%@page import="entity.Customer"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="sideNavBar.jsp" %>
<%@include file="protect.jsp" %>
<link href="//cdn.muicss.com/mui-0.9.36/css/mui.min.css" rel="stylesheet" type="text/css" />
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Customer Dashboard</title>
        <script src="js/jquery.min.js"></script>
        <script src = "js/highcharts.js"></script>
    </head>
    <body>
        <form class="mui-form--inline" action="CustomerDbController" method="post">
            <div class = "subPageContent">
                <div class ="mui-panel ">   
                <h1> Customer Dashboard </h1>
                <div class="mui-divider"></div>
                    <br />
                    Filter by monthly/yearly: 
                    <div class="mui-select">

                        <select  name="month">
                            <option value="none" selected>Please select</option>
                            <option value="January">January</option>
                            <option value="Febuary" >February</option>
                            <option value="March" >March</option>
                            <option value="April" >April</option>
                            <option value="May" >May</option>
                            <option value="June" >June</option>
                            <option value="July" >July</option>
                            <option value="August" >August</option>
                            <option value="September" >September</option>
                            <option value="October" >October</option>
                            <option value="November" >November</option>
                            <option value="December" >December</option>
                        </select>

                    </div>
                    <div  class="mui-select">
                        <select name="year">
                            <option value="none" selected>Please select</option>
                            <option value="2017" >2017</option>
                            <option value="2018" >2018</option>
                        </select>
                    </div>

                    <button type="submit" name="submit" class="mui-btn mui-btn--raised mui-btn--primary" style="font-size:18px;"> Filter <i class="fa fa-filter" style="font-size:18px;"></i></button>
                    
                    <%                        
                        ArrayList<String> customerNameList = (ArrayList<String>) request.getAttribute("custNameResult");
                        String jsonCustName = new Gson().toJson(customerNameList);
                        System.out.println(jsonCustName);
                        ArrayList<String> customerQtyList = (ArrayList<String>) request.getAttribute("custQtyResult");
                        String jsonCustQty = new Gson().toJson(customerQtyList);
                        System.out.println(jsonCustQty);
                        String text = (String) request.getAttribute("word");
                        if (text != null && !text.isEmpty()) {
                            if (!text.equals("none")) {
                                out.println("<br /><br /><p style='font-size:18px;'>" + "You have selected: <b><u> " + text + "</b></u></p>");   
                            }else{
                                out.println("<br />");
                            }
                        }

                        if (customerNameList != null && !customerNameList.isEmpty() && customerQtyList != null && !customerQtyList.isEmpty()) {
                    %>
                    </div>
                   <div class ='mui-panel'>
                    <div id = "customerContainer" >
                        <script>
                            var nameList = <%=jsonCustName%>;
                            var qtyList = <%=jsonCustQty%>;
                            $(document).ready(function () {
                                var chart = {
                                    borderColor: '#000000',
                                    borderWidth: 1,
                                    type: 'column',
                                };
                                var title = {
                                    text: ''
                                };
                                var subtitle = {
                                    text: ''
                                };
                                var xAxis = {
                                    categories: nameList,
                                    
                                    labels: {
                                        style: {
                                            color: 'black',
                                            fontSize: 14
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

                                        text: 'Quantity'
                                    },
                                    min: 0,
                                    plotLines: [{
                                            value: 0,
                                            width: 1,
                                            color: '#808080'
                                        }]
                                };
                                var tooltip = {
                                    valueSuffix: ' products'
                                }

                                var series = [{
                                        name: 'Customer Name',
                                        color: '#f15c80',
                                        data: JSON.parse("[" + qtyList + "]")
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

                                $('#customerContainer').highcharts(json);
                            });
                        </script>
                    </div>
                    <% }else {
                            String error = (String) request.getAttribute("errorMsg");
                                if (error == null) {
                                    error = "";
                                } else {
                                    out.println("<br /><p style='color:red'>" + error + "</p>");
                                }
                        }


                    
                                
                    %>  
                    </div>
            </div>
        </form>
    </body>
</html>
