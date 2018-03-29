<%-- 
    Document   : costOfGoods
    Created on : Mar 26, 2018, 12:33:29 AM
    Author     : Jacquelyn
--%>
<%@page import="entity.InventoryPurchase"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.HashMap"%>
<%@include file="sideNavBar.jsp" %>
<%@include file="protect.jsp" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<link href="//cdn.muicss.com/mui-0.9.36/css/mui.min.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.16/css/jquery.dataTables.css">

<link rel="stylesheet" href="css/master.css">
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
                    "bPaginate": false,
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
        <form class="mui-form--inline" action="CostOfGoodsController" method="post">
                     <input type="hidden" value='<%=request.getParameter("month")%>' name="month" id="month"/>
                    <input type="hidden" value='<%=request.getParameter("year")%>' name="year" id="year"/>
        </form>                
                 <%String monthString = (String) request.getAttribute("monthString"); %>
                 <%String year = (String) request.getAttribute("year"); %>
                <%
                ArrayList<InventoryPurchase> listofCOGSItems = (ArrayList<InventoryPurchase>)request.getAttribute("listofCOGSItems");
                int sku_id =0;
                String name = "";
                String date = "";
                int qty = 0;
                
                if (listofCOGSItems != null && !listofCOGSItems.isEmpty()) {
                %>    
                
              <div class ="mui-panel subPageContent">  
                  
                <table class="cogTable" id="myTable">
                    <thead>
                        <h1> Cost of Goods for <%=monthString%> <%=year%></h1>
                        <div class="mui-divider"></div>
                        <br />
                        <tr>

                            <th> SKU_ID </th>
                            <th> Name </th>
                            <th> Quantity </th>
                            <th> Date Of Purchase </th>
                            
                        </tr>
                    </thead>
                    <%for (InventoryPurchase invPurchaseItems : listofCOGSItems) {
                            sku_id = invPurchaseItems.getSkuId();
                            name = invPurchaseItems.getName();
                            date = invPurchaseItems.getDateOfPurchase();
                            qty = invPurchaseItems.getQuantity();
                            
                    %>
                    
                 
                    <tr>

                        <td id="sku_id"><%=sku_id%></td>
                        <td id="name"><%=name%></td>
                        <td id="qty"><%=qty%></td>
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
