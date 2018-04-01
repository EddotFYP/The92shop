<%-- 
    Document   : orderPicking
    Created on : 12 Feb, 2018, 11:56:16 PM
    Author     : Xiao Weikun
--%>

<%@page import="entity.Inventory"%>
<%@page import="java.util.ArrayList"%>
<%@page import="DAO.InventoryDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<link href="//cdn.muicss.com/mui-0.9.36/css/mui.min.css" rel="stylesheet" type="text/css" />
<%@include file="protect.jsp" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js" type="text/javascript"></script>
        <script type="text/javascript" src="js/instascan.min.js"></script>
        <title>Order Picking Page</title>
        <script type="text/javascript">


            $(document).ready(function () {

                if ($('table#main').length) {
                    document.getElementById("opCustNum").style.display = "block";
                }

                let scanner = new Instascan.Scanner({video: document.getElementById('camera')});
                scanner.addListener('scan', function (content) {

                    $('#qrValue').attr("value", content);
                    window.onbeforeunload = null;
                    document.getElementById('myForm').submit();


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
            });

            window.onbeforeunload = function () {
                var xhttp = new XMLHttpRequest();
                xhttp.open("POST", "OrderPickingController?clearSession=", true);
                xhttp.send();

            };
          
        </script>
    <body>
        <%             String usernameAcc = (String) session.getAttribute("user");

             if (usernameAcc.equals("qingyang") || usernameAcc.equals("cynthia")) {%>
        <%@include file="sideNavBar.jsp" %>
        <%} else {%>
        <%@include file="nonAdminSideNavBar.jsp" %>
        <% }


        %>
        <form id="myForm" class="mui-form--inline" action="OrderPickingController" method="post">
            <div class="subPageContent">
                <div class ="mui-panel orderPickingPanel ">    
                    <h1>Order Picking</h1>
                    <div class="mui-divider"></div>
                    <br />


                    <input type="hidden" id="qrValue" name="cameraResult" value="">

                    </form>
                    <%
                        /* ArrayList<String> message = (ArrayList<String>) request.getAttribute("message");
                        String error = (String) request.getAttribute("error");
                        if (error != null) {
                            out.println("<p style='color:red'>" + error + "</p>");
                        }
                    
                        if (message != null) {
                            for(String m : message){
                                out.println("<p style='color:red'>" + m + "</p>");
                            }
                        
                        }*/
                        String orderSuccessMsg = (String) request.getAttribute("orderSuccessMsg");
                        String orderNoStockMsg = (String) request.getAttribute("orderNoStockMsg");
                        String hpErrorMsg = (String) request.getAttribute("hpErrorMsg");
                        if (orderSuccessMsg != null) {
                            out.println("<p style='color:red'>" + orderSuccessMsg + "</p>");

                        }

                        if (orderNoStockMsg != null) {
                            out.println("<p style='color:red'>" + orderNoStockMsg + "</p>");

                        }

                        if (hpErrorMsg != null) {
                            out.println("<p style='color:red'>" + hpErrorMsg + "</p>");

                        }
                    %>
                    <br />
                    <video id="camera" width="420" align="center"></video>
                        <%
                            ArrayList<Inventory> list = (ArrayList<Inventory>) request.getAttribute("result");

                            //list to keep session values
                            ArrayList<Inventory> currentList = (ArrayList<Inventory>) session.getAttribute("currentList");
                            if (currentList == null) {
                                currentList = new ArrayList<>();
                            }

                            int id = 0;
                            String inventoryName = "";
                            int qty = 1;
                            String updatedDate = "";

                            if (list != null && !list.isEmpty()) {

                                for (Inventory i : list) {
                                    boolean duplicate = false;

                                    for (Inventory current : currentList) {
                                        if (i.getName().equals(current.getName())) {

                                            int num = current.getQuantity();

                                            num++;

                                            current.setQuantity(num);
                                            duplicate = true;

                                        }
                                    }
                                    if (!duplicate) {
                                        currentList.add(new Inventory(i.getSKUID(), i.getName(), qty));
                                    }

                                }
                        %>
                    <div class="orderPicking">
                        <table id="main" class="invMgt-table">
                            <thead>
                                <tr>
                                    <th> Name </th>
                                    <th> Quantity Scanned</th>
                                </tr>
                            </thead>
                            <%
                                for (Inventory i : currentList) {
                                    id = i.getSKUID();
                                    inventoryName = i.getName();
                                    qty = i.getQuantity();
                                    //updatedDate = i.getPurchaseDate();

                            %>
                            <tbody>
                                <tr>
                                    <td id="iName"><%=inventoryName%></td>
                                    <td id="quantity"><%=qty%></td>
                                    <%--<td id="date"><%=updatedDate%></td>--%>
                                </tr>
                                <%
                                        }

                                    }
                                    session.setAttribute("currentList", currentList);
                                %>
                            </tbody>
                        </table>
                        <div id="opCustNum" style="display:none" class="orderPickingcustNum">
                            Enter customer's number: 
                            <div class="mui-textfield">
                                <input type="tel" pattern="[8\d|9\d]{8}"  id="phone" name="phone" required>
                            </div>

                            <button type="submit"  name="btnSubmit" id="btnSubmit" class="mui-btn mui-btn--raised mui-btn--primary"  style="font-size:18px;">Submit <i class="fa fa-caret-right" style="font-size:18px;"></i></button>
                            <br/>

                        </div>
                        <br/>
                        <%-- "discard" and "submit" form --%>


                    </div>
                </div>
            </div>

    </body>
</html>
