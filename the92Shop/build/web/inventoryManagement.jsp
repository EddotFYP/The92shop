<%-- 
    Document   : inventoryManagement
    Created on : Nov 7, 2017, 10:32:51 PM
    Author     : N56VV
--%>
<%@page import="java.sql.Date"%>
<%@page import="DAO.InventoryDAO"%>
<%@page import="java.util.Collections"%>
<%@page import="java.util.ArrayList"%>
<%@page import="entity.Inventory"%>
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
<style>
</style>
        <title>Inventory Management</title>
        <script type="text/javascript">
            $(document).ready(function () {
                $('#edit').click(function () {
                    $('#iName').attr('contenteditable', 'true');
                    $('#quantity').attr('contenteditable', 'true');
                    $('#date').attr('contenteditable', 'true');
                    $('#iCost').attr('contenteditable', 'true');
                    $('#iPrice').attr('contenteditable', 'true');
                });
                $('#save').click(function () {

                    $('#iId').attr("value", $('#invId').html());
                    $('#newName').attr("value", $('#iName').html());
                    $('#newQuantity').attr("value", $('#quantity').html());
                    $('#newDate').attr("value", $('#date').html());
                    $('#newCost').attr("value", $('#iCost').html());
                    $('#newPrice').attr("value", $('#iPrice').html());

                });
                
            });
            function confirmation() {
                    
                    var ans = confirm("Are you sure you want to delete this item?");
                    if(ans){
                        return true;
                    } else {
                        return false;
                    }

            };
            function initiateCamera() {
                let scanner = new Instascan.Scanner({video: document.getElementById('camera')});
                scanner.addListener('scan', function (content) {

                /*var request = new XMLHttpRequest();

                    /*request.open("POST", "InventoryController", true);
                    request.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
                    request.send("cameraResult=" + content);*/
                    document.getElementById('qrValue').value = content;
                    document.getElementById('myForm').submit();
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
                <h1>Search Inventory</h1>
                <br />
                <%                InventoryDAO dao = new InventoryDAO();
                    ArrayList<Inventory> listOfInventory = dao.retrieveInventoryList();
                    ArrayList<String> allInventory = new ArrayList<>();
                    for (Inventory i : listOfInventory) {
                        allInventory.add(i.getName());
                    }
                    //Collections.sort(allInventory);

                %>

                Choose your SKU:
                <input type="text" list="sku" name="sku" required>

                <datalist id="sku">
                    <%for (String i : allInventory) {%>
                    <option value="<%=i%>"><%=i%></option>
                    <% }%>
                </datalist>

                <button type="submit" name="btnSubmit" class="searchBtn"><i class="fa fa-search"> Search</i></button>

                <button type="button" onclick="initiateCamera()" class="searchBtn"><i class="fa fa-camera"> Scan</i></button>
                <br/>
                <input type="hidden" id="qrValue" name="cameraResult" value="">
                
        </form>
                <video id="camera" width="420"></video>
        <%
            ArrayList<Inventory> list = (ArrayList<Inventory>) request.getAttribute("result");
            String message = (String) request.getAttribute("message");
            int id = 0;
            String inventoryName = "";
            int qty = 0;
            String updatedDate = "";
            double cost = 0.0;
            double price = 0.0;

            if (list != null && !list.isEmpty()) {

        %>
        <table id="invTable" border ="1">
            <thead>
                <tr>
                    <th> SKU ID </th>
                    <th> Name </th>
                    <th> Quantity </th>
                    <th> Updated Date </th>
                    <th> Cost </th>
                    <th> Selling Price </th>
                    <th> Edit </th>
                    <th> Save </th>
                    <th> Delete </th>

                </tr>
            </thead>
            <%for (Inventory i : list) {
                    id = i.getSKUID();
                    inventoryName = i.getName();
                    qty = i.getQuantity();
                    updatedDate = i.getPurchaseDate();
                    cost = i.getCostPrice();
                    price = i.getSellingPrice();
            %>
            <tbody>
                <tr>
                    <td id="invId"><%=id%></td>
                    <td id="iName"><%=inventoryName%></td>
                    <td id="quantity"><%=qty%></td>
                    <td id="date"><%=updatedDate%></td>
                    <td id="iCost"><%=cost%></td>
                    <td id="iPrice"><%=price%></td>
                    <td>
                        <form>
                            <button type="button" name="edit" class="btn" id="edit"><i class="fa fa-edit"></i></button>
                        </form>
                    </td>
                    <td>
                        <form action="InventoryController" method="post">
                            <button type="submit" name="save" class="btn" id="save"><i class="fa fa-save"></i></button>
                            <input type="hidden" id="iId" name="editAction" value="">
                            <input type="hidden" id="newName" name="editAction" value="">
                            <input type="hidden" id="newQuantity" name="editAction" value="">
                            <input type="hidden" id="newDate" name="editAction" value="">
                            <input type="hidden" id="newCost" name="editAction" value="">
                            <input type="hidden" id="newPrice" name="editAction" value="">
                        </form>
                    </td>
                    <td>
                        <form action="InventoryController" method="post" onclick="return confirmation()">
                            <button type="submit" name="delete" class="btn" id="deleteButton"><i class="fa  fa-trash"></i></button>
                            <input type="hidden" name="deleteAction" value="<%=id%>">
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

    </div>
</body>
</html>
