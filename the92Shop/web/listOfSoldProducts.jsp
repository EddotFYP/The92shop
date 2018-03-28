<%-- 
    Document   : costOfGoods
    Created on : Mar 26, 2018, 12:33:29 AM
    Author     : Jacquelyn
--%>
<%@page import="entity.PurchaseHistory"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.HashMap"%>
<%@include file="sideNavBar.jsp" %>
<%@include file="protect.jsp" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<link href="//cdn.muicss.com/mui-0.9.36/css/mui.min.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="css/master.css">
<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.16/css/jquery.dataTables.css">
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Cost Of Goods Page</title>
        <script src="js/jquery-1.12.3.js"></script>
        <script src="js/jquery.min.js"></script>
        <script src="js/dataTables.min.js"></script>
    </head>
    <body>
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
        <form class="mui-form--inline" action="ProfitController" method="post">
                     <input type="hidden" value='<%=request.getParameter("month")%>' name="month" id="month"/>
                    <input type="hidden" value='<%=request.getParameter("year")%>' name="year" id="year"/> 
        </form>     
                          <%String monthString = (String) request.getAttribute("monthString"); %>
                         <%String year = (String) request.getAttribute("year"); %>
                         
                <%
                ArrayList<PurchaseHistory> retreiveListOfSoldProducts = (ArrayList<PurchaseHistory>)request.getAttribute("retreiveListOfSoldProducts");
                int sku_id =0;
                String product_name = "";
                int qty =0;
                double sales =0.0;
                String date = "";
               
                
                if (retreiveListOfSoldProducts!= null && !retreiveListOfSoldProducts.isEmpty()) {
                %>            
              <div class ="mui-panel subPageContent" style="height: 850px; width: 900px;">  
                <table id="myTable">
                    <thead>
                        <h1> List of Items Sold for <%=monthString%> <%=year%></h1>
                        <div class="mui-divider"></div>
                        <br />
                        <tr>
                            <th> SKU_ID </th>
                            <th> Product Name </th>
                            <th> Quantity </th>
                            <th> Sales </th>
                            <th> Date Of Purchase </th>
                            
                        </tr>
                    </thead>
                    <%for (PurchaseHistory cusPurchaseItems : retreiveListOfSoldProducts) {
                            sku_id = cusPurchaseItems.getSkuId();
                            product_name = cusPurchaseItems.getProductName();
                            qty = cusPurchaseItems.getQuantity();
                            sales = cusPurchaseItems.getSales();
                            date = cusPurchaseItems.getDateOfPurchase();
                            
                            
                    %>
                 
                    <tr>

                        <td id="sku_id"><%=sku_id%></td>
                        <td id="name"><%=product_name%></td>
                        <td id="qty"><%=qty%></td>
                        <td id="sales"><%=sales%></td>
                        <td id="date"><%=date%></td>
                        
                    </tr>    
                    
                
                    <%
                        }
                    }
                        %>
                
             
            
            </table>
            </div>

           
    </body>
</html>
