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
        <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js" type="text/javascript"></script>
        <script type="text/javascript" src="js/instascan.min.js"></script>
        <title>Order Picking Page</title>
        <script type="text/javascript">
            
            function initiateCamera() {
                let scanner = new Instascan.Scanner({video: document.getElementById('camera')});
                scanner.addListener('scan', function (content) {

                    $('#qrValue').attr("value", content);


                    document.getElementById('myForm').submit();


                    //Actions after submitting the form
                    //scanner.stop();

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
         <%
            String usernameAcc = (String) session.getAttribute("user");
                    
            if(!usernameAcc.equals("qingyang")){ %>
                <%@include file="nonAdminSideNavBar.jsp" %>
            <%}else{ %>
                <%@include file="sideNavBar.jsp" %>
            <% }
            %>
        <form id="myForm" class="mui-form--inline" action="OrderPickingController" method="post">
            <div class="subPageContent">
                <div class ="mui-panel orderPickingPanel ">    
                <h1>Order Picking</h1>
                <div class="mui-divider"></div>
                <br />
                <%--                    ArrayList<Inventory> savedList = (ArrayList<Inventory>) session.getAttribute("currentList");
                    if (savedList != null) {
                        out.println(savedList.size());
                    }
                --%>
                Scan SKU:

                <button type="button" onclick="initiateCamera()" class="mui-btn mui-btn--raised mui-btn--primary" style="font-size:18px; margin-right: 70px"><i class="fa fa-camera" style="font-size:18px;"> Scan</i></button>
                
                <br/>
               
                <input type="hidden" id="qrValue" name="cameraResult" value="">
                
                </form>
                <%
                    String error = (String) request.getAttribute("error");
                    if (error != null) {
                        out.println("<p style='color:red'>" + error + "</p>");
                    }
                    %>
                <br />
                <video id="camera" width="420" align="center"></video>
                    <%                        ArrayList<Inventory> list = (ArrayList<Inventory>) request.getAttribute("result");

                        //list to keep session values
                        ArrayList<Inventory> currentList = (ArrayList<Inventory>) session.getAttribute("currentList");
                        if (currentList == null) {
                            currentList = new ArrayList<>();
                        }

                        ArrayList<String> message = (ArrayList<String>) request.getAttribute("message");
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
                <table class="invMgt-table">
                    <thead>
                        <tr>

                            <th> Name </th>
                            <th> Quantity Scanned</th>


                        </tr>
                    </thead>
                    <%                        for (Inventory i : currentList) {
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
                  </div>
                <br/>
                <%-- "discard" and "submit" form --%>
                 <div class="orderPickingcustNum">
                 Enter customer's number: 
                <div class="mui-textfield">
                    <input type="tel" pattern="[8\d|9\d]{8}"  id="phone" name="phone" required>
                 </div>
                
                <button type="submit"  name="btnSubmit" id="btnSubmit" class="mui-btn mui-btn--raised mui-btn--primary"  style="font-size:18px;">Submit</button>
                <br/>
                <%                    
                    
                    
                    
                    if (message != null) {
                        for(String m : message){
                            out.println("<p style='color:red'>" + m + "</p>");
                        }
                        
                    }
                %>
                 </div>
                </div>
            </div>

    </body>
</html>
