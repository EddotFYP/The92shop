<%-- 
    Document   : addInventory
    Created on : Nov 9, 2017, 7:19:21 PM
    Author     : N56VV
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<link href="//cdn.muicss.com/mui-0.9.36/css/mui.min.css" rel="stylesheet" type="text/css" />
<%@include file="protect.jsp" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <script type="text/javascript" src="js/qrcode.js"></script>
        <script type="text/javascript" src="js/jquery.min.js"></script>
        <script type="text/javascript" src="js/jspdf.js"></script>
        <script type="text/javascript" src="js/addimage.js"></script>
    </head>
    <body>
        <%             String usernameAcc = (String) session.getAttribute("user");

             if (usernameAcc.equals("qingyang") || usernameAcc.equals("cynthia")) {%>
        <%@include file="sideNavBar.jsp" %>
        <%} else {%>
        <%@include file="nonAdminSideNavBar.jsp" %>
        <% }


        %>
        <div class="subPageContent">
            <form id="myForm" class="mui-form" action="InventoryController" method="post">
                <div class ="mui-panel addInventoryPanel ">    
                    <h1>Add New Inventory</h1>
                    <div class="mui-divider"></div>
                    <br />
                    <table id="AdminTable">
                        <tr>
                            <td>
                                <span>Product Name</span><span style="float:right">:</span>
                            </td>

                            <td>
                                <div class="mui-textfield">
                                    <input type ="text" name ="newName" id="name" placeholder="Name" autocomplete="off" required/>
                                </div>
                            </td>
                        </tr>

                        <tr>
                            <td>
                                <span>Cost</span><span style="float:right">:</span>
                            </td>
                            <td>
                                <div class="mui-textfield">
                                    <input type ="number" step="any" name ="newCost" id="cost" autocomplete="off" placeholder="0.0" required/>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <span>Price</span><span style="float:right">:</span>
                            </td>
                            <td>
                                <div class="mui-textfield">
                                    <input type ="number" step="any" name ="newPrice" id="price" autocomplete="off" placeholder="0.0" required/>
                                </div>
                            </td>
                        </tr>

                        <tr>
                            <td>
                                <span>Quantity</span><span style="float:right">:</span>
                            </td>

                            <td>
                                <div class="mui-textfield">
                                    <input type ="text" name ="newQuantity" id="qty" placeholder="Quantity" autocomplete="off" required/>
                                </div>
                            </td>
                        </tr>

                        <tr>
                            <td>

                            </td>
                            <td>
                                <button type="button" onclick="makeCode()" name="btSubmit" class="mui-btn mui-btn--raised mui-btn--primary" style="font-size:18px;">Add & Download QR code <i class="fa  fa-plus" style="font-size:18px;"> </i></button>

                            </td>
                        </tr>

                    </table>
                    <%
                        String message = (String) request.getAttribute("message");
                        String confirmMessage = (String) request.getAttribute("confirmMessage");
                        if (message != null) {
                            out.println("<p style='color:red'>" + message + "</p>");
                        }
                        if (confirmMessage != null) {
                            out.println("<p style='color:#00cc00'>" + confirmMessage + "</p>");
                         }
                    %>
                    <div id="qrcode" style="width:180px; height:180px; margin-top:15px;"></div>
                    <script type="text/javascript">
                        function makeCode() {
                            $("#qrcode").empty();

                            var qrcode = new QRCode(document.getElementById("qrcode"));
                            var name = document.getElementById("name");
                            var qty = document.getElementById("qty");
                            var cost = document.getElementById("cost");
                            var price = document.getElementById("price");

                            if (name.value != "" && cost.value != "" && price.value != "" && qty.value != "") {
                                qrcode.makeCode(name.value + "?" + cost.value + "?" + price.value + "?" + qty.value);

                                setTimeout(function () {
                                    var specialElementHandlers = {
                                        '#editor': function (element, renderer) {
                                            return true;
                                        }
                                    };

                                    var doc = new jsPDF('p', 'pt', 'a4');
                                    doc.fromHTML(
                                            $('#qrcode').html(), 15, 15,
                                            {'width': 200,
                                                'elementHandlers': specialElementHandlers

                                            },
                                            function () {
                                                doc.save(name.value + '_QR.pdf');
                                            }
                                    );
                                }, 1000)
                                setTimeout(function () {
                                    $("#myForm").submit();
                                }, 2000);
                            } else {
                                alert("Please fill in the missing fields");
                            }
                            ;

                        }


                    </script>

                </div>

            </form>
        </div>
    </body>

</html>
