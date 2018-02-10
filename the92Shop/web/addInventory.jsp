<%-- 
    Document   : addInventory
    Created on : Nov 9, 2017, 7:19:21 PM
    Author     : N56VV
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<link rel="stylesheet" href="css/master.css">
<%@include file="sideNavBar.jsp" %>
<%@include file="protect.jsp" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script type="text/javascript" src="js/qrcode.js"></script>
        <script type="text/javascript" src="js/jquery.min.js"></script>

        <title>Add New SKU Page</title>
    </head>
    <body>
        <div class="subPageContent">
            <form  action="InventoryController" method="post">
                <fieldset  class="fieldset-auto-width">
                    <legend>Add New SKU</legend>
                    <table>

                        <tr>
                            <td>
                                Product Name:
                            </td>

                            <td>
                                <input type ="text" name ="newName" id="name" required/>
                            </td>
                        </tr>

                        <tr>
                            <td>
                                Cost:
                            </td>
                            <td>
                                <input type ="text" name ="newCost" id="cost" required/>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                Price:
                            </td>
                            <td>
                                <input type ="text" name ="newPrice" id="price" required/>
                            </td>
                        </tr>

                        <tr>
                            <td>
                                <button type="submit" name="submit" class="btn"><i class="fa  fa-plus"> Add</i></button>
                                
                            </td>
                            <td>
                                <button type="button" onclick="makeCode()" class="btn"><i class="fa  fa-photo">Generate QR code</i></button>
                            </td>
                        </tr>

                        <tr>
                            <td>
                                <div id="qrcode" style="width:160px; height:160px; margin-top:15px;"></div>
                            </td>
                        </tr>

                    </table>
                </fieldset>
                <script type="text/javascript">
                    function makeCode() {
                        $("#qrcode").empty();

                        var qrcode = new QRCode(document.getElementById("qrcode"));
                        var name = document.getElementById("name");
                        var cost = document.getElementById("cost");
                        var price = document.getElementById("price");
                        
                        if(name.value !="" && cost.value !="" && price.value !=""){
                            qrcode.makeCode(name.value + "?" + cost.value + "?" + price.value);
                        } else {
                            alert("Please fill in the missing fields");
                        }
                        
                    }

                </script>
            </form>

            <%                        String message = (String) request.getAttribute("messages");
                if (message != null) {
                    out.print(message);
                }
            %>


        </div>
    </body>
</html>
