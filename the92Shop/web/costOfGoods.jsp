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
<link rel="stylesheet" href="css/master.css">
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cost Of Goods Page</title>
    </head>
    <body>
        
        <form class="mui-form--inline" action="CostOfGoodsController" method="post">
                     <input type="hidden" value='<%=request.getParameter("month")%>' name="month" id="month"/>
                    <input type="hidden" value='<%=request.getParameter("year")%>' name="year" id="year"/>
        `   
               
             
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
                
              <div class ="mui-panel costOfGoodsTable">  
                <table class="cogTable">
                    <thead>
                        <h1> Cost of Goods for <%=monthString%> <%=year%></h1>
                        <tr>

                            <th> SKU_ID </th>
                            <th> Name </th>
                            <th> Date Of Purchase </th>
                            <th> Quantity </th>
                            
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
                        <td id="date"><%=date%></td>
                        <td id="qty"><%=qty%></td>
                    </tr>    
                    
                
                    <%
                        }
                    }
                        %>
                
             
            
            </table>
            </div>

           
    </body>
</html>
