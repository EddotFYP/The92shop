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
<link href="//cdn.muicss.com/mui-0.9.36/css/mui.min.css" rel="stylesheet" type="text/css" />
<%@include file="protect.jsp" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <script src="js/jquery-1.12.3.js"></script>
        <script src="js/jquery.min.js"></script>
        <script src="js/dataTables.min.js"></script>
        <script type="text/javascript" src="js/instascan.min.js"></script>
        <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.16/css/jquery.dataTables.css">
        <style>
            table {
                max-width: 950px;
                margin: auto;
                
            }
        </style>
        <title>Inventory Management</title>
        <script type="text/javascript">
            $(document).ready(function () {

                $.ajax({
                    type: 'POST',
                    url: 'inventoryJson',
                    headers: {
                        Accept: "application/json; charset=utf-8",
                        "Content-Type": "application/json; charset=utf-8"
                    },
                    success: function (result) {
                        var json = $.parseJSON(result);
                        var str = '';

                        for (var i = 0; i < json.names.length; i++) {
                            str += '<option value="' + json.names[i].name + '" />'; // Storing options in variable

                        }



                    }

                });

                $('#invTable').dataTable({
                    "bPaginate": true,
                    "bLengthChange": false,
                    "bFilter": true,
                    "bInfo": false,
                    "bAutoWidth": false,
                    "bSorted": true,
                    "order": [],
                    "ordering": true,
                    "pageLength": 5,
                    

                });


            });
            function editClick(clickedId) {
                var row = clickedId.substr(clickedId.indexOf('?') + 1);
                var name = "name?" + row;
                var qty = "qty?" + row;
                var date = "date?" + row;
                var cost = "cost?" + row;
                var price = "price?" + row;

                document.getElementById(name).contentEditable = "true";
                document.getElementById(qty).contentEditable = "true";
                document.getElementById(date).contentEditable = "true";
                document.getElementById(cost).contentEditable = "true";
                document.getElementById(price).contentEditable = "true";

            }
            ;
            function saveClick(clickedId) {
                var row = clickedId.substr(clickedId.indexOf('?') + 1);
                var name = "name?" + row;
                var qty = "qty?" + row;
                var date = "date?" + row;
                var cost = "cost?" + row;
                var price = "price?" + row;

                var newName = "newName?" + row;
                var newQuantity = "newQuantity?" + row;
                var newDate = "newDate?" + row;
                var newCost = "newCost?" + row;
                var newPrice = "newPrice?" + row;

                document.getElementById(newName).value = document.getElementById(name).innerHTML;
                document.getElementById(newQuantity).value = document.getElementById(qty).innerHTML;
                document.getElementById(newDate).value = document.getElementById(date).innerHTML;
                document.getElementById(newCost).value = document.getElementById(cost).innerHTML;
                document.getElementById(newPrice).value = document.getElementById(price).innerHTML;


            }
            ;
            function confirmation() {

                var ans = confirm("Are you sure you want to delete this item?");
                if (ans) {
                    return true;
                } else {
                    return false;
                }

            }
            ;
            function initiateCamera() {
                document.getElementById('camera').style.display = "block";
                let scanner = new Instascan.Scanner({video: document.getElementById('camera')});
                scanner.addListener('scan', function (content) {

                    var name = content.substr(0, content.indexOf('?'));

                    $('input[type="search"]').val(name).keyup();
                    scanner.stop();
                    document.getElementById('camera').style.display = "none";
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
            ;

            function showDiv(clickedId) {
                var row = clickedId.substr(clickedId.indexOf('?') + 1);
                var edit = "editButtonDiv?" + row;
                var save = "saveButtonDiv?" + row;
                document.getElementById(edit).style.display = "none";
                document.getElementById(save).style.display = "block";
            }
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
        <form id="myForm" action="InventoryController" method="post">
            <div class="subPageContent">
                <div class ="mui-panel" width="650px" >
                    <h1>Search Inventory</h1>
                    <div class="mui-divider"></div>
                    <br />
                    <%--
                    Enter product name:
                    <input type="text" list="sku" name="sku" autocomplete="off">

                    <datalist id="sku"></datalist>

                    <button type="submit" name="btnSubmit" class="mui-btn mui-btn--raised mui-btn--primary"><i class="fa fa-search" style="font-size:18px;"> Search</i></button>

                    <button type="button" onclick="initiateCamera()" class="mui-btn mui-btn--raised mui-btn--primary"><i class="fa fa-camera" style="font-size:18px;"> Scan</i></button>
                    <br/>
                    <input type="hidden" id="qrValue" name="cameraResult" value="">

                    </form>
                    --%>
                    <button type="button" onclick="initiateCamera()" class="mui-btn mui-btn--raised mui-btn--primary" style="font-size:18px;">Scan <i class="fa fa-camera" style="font-size:18px;"></i></button>
                    <br/>
                    <div><video id="camera" width="420" style="display:none;"></video></div>
                            <%                                //ArrayList<Inventory> list = (ArrayList<Inventory>) request.getAttribute("result");
                                String message = (String) request.getAttribute("message");

                                if (message != null) {
                                    out.println("<p style='color:red'>" + message + "</p>");
                                }
                                InventoryDAO dao = new InventoryDAO();
                                ArrayList<Inventory> list = dao.retrieveInventoryList();

                                int id = 0;
                                String inventoryName = "";
                                int qty = 0;
                                String updatedDate = "";
                                double cost = 0.0;
                                double price = 0.0;

                                if (list != null && !list.isEmpty()) {

                            %>
                    <br />

                    <table id="invTable" >
                        <thead>
                            <tr align ="left">

                                <th> Name </th>
                                <th> Quantity </th>
                                <th> Updated Date </th>
                                <th> Cost </th>
                                <th> Selling Price </th>
                                <th> Edit/Save </th>
                                <th> Delete </th>

                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <%for (Inventory i : list) {
                                        id = i.getSKUID();
                                        inventoryName = i.getName();
                                        qty = i.getQuantity();
                                        updatedDate = i.getPurchaseDate();
                                        cost = i.getCostPrice();
                                        price = i.getSellingPrice();

                                        String nameId = "name?" + id;
                                        String qtyId = "qty?" + id;
                                        String dateId = "date?" + id;
                                        String costId = "cost?" + id;
                                        String priceId = "price?" + id;
                                        String editId = "edit?" + id;
                                        String saveId = "save?" + id;
                                        String editButtonDiv = "editButtonDiv?" + id;
                                        String saveButtonDiv = "saveButtonDiv?" + id;
                                %>

                                <td class ="invName" id="<%=nameId%>"><%=inventoryName%></td>
                                <td width="90px" id="<%=qtyId%>"><%=qty%></td>
                                <td width="125px" id="<%=dateId%>"><%=updatedDate%></td>
                                <td width="60px" id="<%=costId%>"><%=cost%></td>
                                <td width="120px" id="<%=priceId%>"><%=price%></td>
                                <td width="100px">
                                    <div id="<%=editButtonDiv%>" class="answer_list" >
                                        <form action="InventoryController" method="post">
                                            <button type="button" name="edit" class="btn" id="<%=editId%>" onclick="showDiv(this.id);
                                                    editClick(this.id);"><i class="fa fa-edit"></i></button>
                                        </form>
                                    </div>
                                    <%
                                        String newName = "newName?" + id;
                                        String newQuantity = "newQuantity?" + id;
                                        String newDate = "newDate?" + id;
                                        String newCost = "newCost?" + id;
                                        String newPrice = "newPrice?" + id;
                                    %>
                                    <div id="<%=saveButtonDiv%>"  style="display:none;" class="answer_list" >
                                        <form action="InventoryController" method="post">
                                            <button type="submit" name="save" class="btn" id="<%=saveId%>" onclick="saveClick(this.id)"><i class="fa fa-save"></i></button>
                                            <input type="hidden" id="iId" name="editAction" value="<%=id%>">
                                            <input type="hidden" id="<%=newName%>" name="editAction" value="">
                                            <input type="hidden" id="<%=newQuantity%>" name="editAction" value="">
                                            <input type="hidden" id="<%=newDate%>" name="editAction" value="">
                                            <input type="hidden" id="<%=newCost%>" name="editAction" value="">
                                            <input type="hidden" id="<%=newPrice%>" name="editAction" value="">
                                        </form>
                                    </div>
                                </td>
                                <td width="75px">
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

                    %>

                </div>
            </div>
    </body>
</html>
