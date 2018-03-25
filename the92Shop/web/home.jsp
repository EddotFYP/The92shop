<%-- 
    Document   : home
    Created on : Oct 17, 2017, 7:24:25 PM
    Author     : Clarey Liow JX
--%>

<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.ArrayList"%>
<%@page import="DAO.InventoryDAO"%>
<%@page import="DAO.InventoryDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="protect.jsp" %>
 <%@include file="sideNavBar.jsp" %>
<link rel="stylesheet" href="css/main.css">

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="js/jquery-1.12.3.js"></script>
        <script src="js/jquery.min.js"></script>
        <script src="js/dataTables.min.js"></script>
        <script src = "js/highcharts.js"></script>
          <script>
            $(document).ready(function () {
            $('#myTable').dataTable({
                "bPaginate": true,
                "bLengthChange": false,
                "bFilter": false,
                "bInfo": false,
                "bAutoWidth": false,
                "bSorted": false,
                "order": [],
                "ordering": false
            }); 
             });     
 
        </script>
        <title>Analytics </title>
    </head>
    <body>
        <form class="mui-form--inline" action="AnalyticsDB" method="post">
            
        </form>   
      
                 
             <%
                 InventoryDAO invDAO = new InventoryDAO();
                 ArrayList<String> promoNameList = (ArrayList<String>)request.getAttribute("promoNameResult");
                 String jsonPromoName = new Gson().toJson(promoNameList); 
                 ArrayList<String> promoQtyList = (ArrayList<String>)request.getAttribute("promoQtyResult");
                 String jsonPromoQty = new Gson().toJson(promoQtyList);
                 if (promoNameList != null && !promoNameList.isEmpty() && promoQtyList != null && !promoQtyList.isEmpty()) {
             %>    
              <br />
             <div id = "inventoryContainer" >
                        <script>
                            var nameList = <%=jsonPromoName%>;
                            var qtyList = <%=jsonPromoQty%>;
                            $(document).ready(function () {
                                var chart = {
                                    borderColor: '#000000',
                                    borderWidth: 1,
                                    type:'spline'
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
                                            fontSize: 13
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
                                    valueSuffix: ' items'
                                };

                                var series = [{
                                        name: 'Product Name',
                                        color: '#FFB74D',
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

                                $('#inventoryContainer').highcharts(json);
                            });
                        </script>
                    </div>
            
                            <%
                                }
                                %>
             
             
             
                        
        </div>                

    </body>
</html>
