<%-- 
    Document   : addInventoryQty
    Created on : 5 Feb, 2018, 4:49:46 PM
    Author     : Xiao Weikun
--%>

<%@page import="entity.Inventory"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<link rel="stylesheet" href="css/master.css">
<%@include file="sideNavBar.jsp" %>
<%@include file="protect.jsp" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js" type="text/javascript"></script>
        <script type="text/javascript" src="js/instascan.min.js"></script>
        <title>Add SKU Quantity Page</title>
        <script type="text/javascript">
            $(document).ready(function () {
                $('#save').click(function () {
                    $('#newName').attr("value", $('#iName').html());
                    $('#newQuantity').attr("value", document.getElementById('qty').value);
                    
                });
            });
            
            function initiateCamera() {
                let scanner = new Instascan.Scanner({video: document.getElementById('camera')});
                scanner.addListener('scan', function (content) {

                    $('#qrValue').attr("value", content);
                    document.getElementById('myForm').submit();

                    //Actions after submitting the form
                    scanner.stop();

                });

                //check if the device has cameras
                Instascan.Camera.getCameras().then(function (cameras) {
                    if (cameras.length > 0) {
                        scanner.start(cameras[0]);
                    } else {
                        console.error('No cameras found.');
                    }
                }).catch(function (e) {
                    console.error(e);
                });


            }
        </script>
    </head>
    <body>

        <form id="myForm" action="InventoryController" method="post">
            <div class="subPageContent">
                <h1>Add Inventory Quantity</h1>

                <button type="button" onclick="initiateCamera()" class="searchBtn"><i class="fa fa-search"> Scan</i></button>
                <input type="hidden" id="qrValue" name="addInventorySearch" value="">
                <br/>
                <video id="camera" width="420"></video>





        </form>
        <%            ArrayList<Inventory> list = (ArrayList<Inventory>) request.getAttribute("result");
            String message = (String) request.getAttribute("message");

            String inventoryName = "";
            int qty = 0;
            String updatedDate = "";

            if (list != null && !list.isEmpty()) {

        %>
        <table id="invTable" border ="1">
            <thead>
                <tr>

                    <th> Name </th>
                    <th> Current Quantity </th>
                    <th> Updated Date </th>
                    <th> Add Quantity </th>
                    <th> Save </th>

                </tr>
            </thead>
            <%for (Inventory i : list) {
                    //id = i.getSKUID();
                    inventoryName = i.getName();
                    qty = i.getQuantity();
                    updatedDate = i.getPurchaseDate();

            %>
            <tbody>
                <tr>
                    <%--<td id="invId"><%=id%></td>--%>
                    <td id="iName"><%=inventoryName%></td>
                    <td id="quantity"><%=qty%></td>
                    <td id="date"><%=updatedDate%></td>
                    
                    <td>
                        <input type="text" id="qty">
                    </td>
                    
                    <td>
                        <form action="InventoryController" method="post">
                            <button type="submit" name="save" class="btn" id="save"><i class="fa fa-save"></i></button>
                            <input type="hidden" id="newName" name="addQuantity" value="">
                            <input type="hidden" id="newQuantity" name="addQuantity" value="">
                            
                        </form>
                    </td>
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
    </body>
</div>
</html>
