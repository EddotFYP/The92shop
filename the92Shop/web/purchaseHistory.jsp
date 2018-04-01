<%-- 
    Document   : purchaseHistory
    Created on : 19 Feb, 2018, 1:40:10 PM
    Author     : Xiao Weikun
--%>

<%@page import="DAO.PurchaseHistoryDAO"%>
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
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js" type="text/javascript"></script>
        <script src="js/jquery-1.12.3.js"></script>
        <script src="js/jquery.min.js"></script>
        <script src="js/dataTables.min.js"></script>
        <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.16/css/jquery.dataTables.css">
        <script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.10.16/js/jquery.dataTables.js"></script>
        <title>Purchase History</title>
        <script type="text/javascript">
            $(document).ready(function () {
                $('#myTable').dataTable({
                    "bPaginate": true,
                    "bLengthChange": false,
                    "bFilter": false,
                    "bInfo": false,
                    "bAutoWidth": false,
                    "bSorted": true,
                    "order": [],
                    "ordering": true,
                    "pageLength": 5
                    
                });

            });
        </script>
    </head>
    <body> 
       <%             String usernameAcc = (String) session.getAttribute("user");

             if (usernameAcc.equals("qingyang") || usernameAcc.equals("cynthia")) {%>
        <%@include file="sideNavBar.jsp" %>
        <%} else {%>
        <%@include file="nonAdminSideNavBar.jsp" %>
        <% }


        %>
        <form id="myForm" action="OrderPickingController" method="post">
            <div class="subPageContent">
                <div class ="mui-panel invMgt-table">    
                <h1>Purchase History</h1>
                <div class="mui-divider"></div>
                <br />

                </form>
                
                    <%
                        PurchaseHistoryDAO purchaseHistoryDAO = new PurchaseHistoryDAO();
                        ArrayList<PurchaseHistory> list = purchaseHistoryDAO.retrievePurchaseHistory();
                        //ArrayList<PurchaseHistory> list = (ArrayList<PurchaseHistory>) request.getAttribute("history");
                        String message = (String) request.getAttribute("message");
                        String phone = "";
                        int skuId = 0;
                        String inventoryName = "";
                        int qty = 0;
                        String dateOfPurchase = "";
                        

                        if (list != null && !list.isEmpty()) {
                            InventoryDAO dao = new InventoryDAO();

                    %>
                <table id="myTable">
                    <thead>
                        <tr>
                            <th> Phone </th>
                            <th id="aquantity"> Product Name </th>
                            <th> Quantity </th>
                            <th> Purchase Date </th>
                            

                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                    <%for (PurchaseHistory ph : list) {
                            phone = ph.getPhoneNum();
                            skuId = ph.getSkuId();
                            inventoryName = dao.retrieveInventoryNameById(skuId);
                            dateOfPurchase = ph.getDateOfPurchase(); 
                            qty = ph.getQuantity();
                            
                    %>
                    
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
