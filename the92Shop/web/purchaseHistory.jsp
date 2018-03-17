<%-- 
    Document   : purchaseHistory
    Created on : 19 Feb, 2018, 1:40:10 PM
    Author     : Xiao Weikun
--%>

<%@page import="entity.PurchaseHistory"%>
<%@page import="entity.Inventory"%>
<%@page import="java.util.ArrayList"%>
<%@page import="DAO.InventoryDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<link rel="stylesheet" href="css/master.css">
<link href="//cdn.muicss.com/mui-0.9.36/css/mui.min.css" rel="stylesheet" type="text/css" />
<%@include file="protect.jsp" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Purchase History</title>
    </head>
    <body> 
        <%
                    String usernameAcc = (String) session.getAttribute("user");
                    
                    if(!usernameAcc.equals("qingyang")){ %>
                        <%@include file="nonAdminSideNavBar.jsp" %>
                    <%}else{ %>
                        <%@include file="sideNavBar.jsp" %>
                   <% }
                    

                %>
        <form id="myForm" action="OrderPickingController" method="post">
            <div class="subPageContent">
                <div class ="mui-panel ">    
                <h1>Purchase History</h1>
                <div class="mui-divider"></div>
                <br />
                <button type="submit" name="btnSubmit" class="mui-btn mui-btn--raised mui-btn--primary"><i class="fa fa-search"> View History</i></button>
                <input type="hidden" name="ViewPurchaseHistory" value="1">

                </form>
                
                    <%
                        ArrayList<PurchaseHistory> list = (ArrayList<PurchaseHistory>) request.getAttribute("history");
                        String message = (String) request.getAttribute("message");
                        String phone = "";
                        int skuId = 0;
                        String inventoryName = "";
                        int qty = 0;
                        String dateOfPurchase = "";
                        

                        if (list != null && !list.isEmpty()) {
                            InventoryDAO dao = new InventoryDAO();

                    %>
                <table class="invMgt-table">
                    <thead>
                        <tr>
                            <th> Phone </th>
                            <th> Product Name </th>
                            <th> Quantity </th>
                            <th> Purchase Date </th>
                            

                        </tr>
                    </thead>
                    <%for (PurchaseHistory ph : list) {
                            phone = ph.getPhoneNum();
                            skuId = ph.getSkuId();
                            Inventory i = dao.retrieve(skuId);
                            inventoryName = i.getName();
                            dateOfPurchase = ph.getDateOfPurchase(); 
                            qty = ph.getQuantity();
                            
                    %>
                    <tbody>
                        <tr>
                            <td id="phone"><%=phone%></td>
                            <td id="iName"><%=inventoryName%></td>
                            <td id="quantity"><%=qty%></td>
                            <td id="date"><%=dateOfPurchase%></td>
                            
                            
                        </tr>
                        <%
                            }
                        %>
                    </tbody>
                </table>


                <%
                    }
                    if (message != null) {
                        out.println("<p style='color:red'>" + message + "</p>");
                    }
                %>
</div>
            </div>
    </body>
</html>
