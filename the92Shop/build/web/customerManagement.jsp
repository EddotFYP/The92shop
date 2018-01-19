<%-- 
    Document   : customerManagement
    Created on : Oct 17, 2017, 7:47:26 PM
    Author     : Clarey Liow JX
--%>





<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.Date"%>
<%@page import="entity.Customer"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<link rel="stylesheet" href="css/master.css">
<%@include file="sideNavBar.jsp" %>
<%@include file="protect.jsp" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
                <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js" type="text/javascript"></script
    <style>

    </style>
<script type="text/javascript">
                    $(document).ready(function () {
                    $('#edit').click(function () {
                    $('#phone').attr('contenteditable', 'true');
                            $('#address').attr('contenteditable', 'true');
                            $('#postal').attr('contenteditable', 'true');
                    });
                    $('#save').click(function () {
                    //alert($('#phone').html());
                    $('#cId').attr("value", $('#cusId').html());
                            $('#newPhone').attr("value", $('#phone').html());
                            $('#newAddress').attr("value", $('#address').html());
                            $('#newPostal').attr("value", $('#postal').html());
                    });
                    }
                    );
            </script>
            <title> Customer Search</title>            
        </head>
        <body>
            <div class="subPageContent">       
                <form action="CustomerController" method="post">
                    <br>
                    <fieldset  class="fieldset-auto-width">
                         <legend class="lg"><h2> Search / Add Customer </h2></legend>
                                <table>
                                    <tr>
                                        <td>
                                Phone Number:
                                        </td>
                                       <td> 
                                <input type ="text" name ="phoneNum" class="form-control"  placeholder="&#xf095;" style="font-family:Arial,FontAwesome"/>
                                        </td>
                                         </tr>
                                          <img  src="image/customer.png" align="right">
                                         <tr>
                                          <td>
                                Birth Date:
                                        </td>
                                         <td>
                                <input type ="date" name ="birthDate" placeholder="&#xf073;;" style="font-family: Arial, FontAwesome" /> 
                                         </td>
                                         </tr>
                                           </table>
                         <br>
                                     <button type="submit" name="submit" class="searchBtn"><i class="fa fa-search"> Search</i></button>
                                        <a href="addCustomer.jsp" class="addBtn"><i class="fa fa-plus"> Add Customer</i></a>     
                                        
                                          
                   
                          
                                </form>
                 </fieldset>

                <%
                    ArrayList<Customer> custList = (ArrayList<Customer>) request.getAttribute("custList");
                    String error = (String) request.getAttribute("error");
                    String message = (String) request.getAttribute("message");
                    String id = "";
                    String custName = "";
                    String gender = "";
                    String birthDate = "";
                    String phoneNum = "";
                    String address = "";
                    String postalCode = "";

                    if (custList != null && !custList.isEmpty()) {%>
                <table id="custTable" border ="1">
                    <thead>
                        <tr>
                            <th> Customer Id </th>
                            <th> Name </th>
                            <th> Gender </th>
                            <th> Birth Date </th>
                            <th> Phone Number </th>
                            <th> Address </th>
                            <th> Postal Code </th>
                            <th> Edit </th>
                            <th> Save </th>
                            <th> Delete </th>
                        </tr>
                    </thead>
                    <%for (Customer cus : custList) {
                            id = cus.getCustId();
                            custName = cus.getName();
                            gender = cus.getGender();
                            birthDate = cus.getBirthDate();
                            phoneNum = cus.getPhoneNum();
                            address = cus.getAddress();
                            postalCode = cus.getPostalCode();%>
                    <br>
                    <br>
                    <tbody>
                        <tr>
                            <td id="cusId"><%=id%></td>
                            <td><%=custName%></td>
                            <td><%=gender%></td>
                            <td><%=birthDate%></td>
                            <td id="phone"><%=phoneNum%></td>
                            <td id="address"><%=address%></td>
                            <td id="postal"><%=postalCode%></td>
                            <td>
                                <button type="submit" name="submit" class="btn" id="edit"><i class="fa fa-edit"></i></button>
                            </td>
                            <td>
                                <form action="CustomerController" method="post">
                                    <button type="submit" name="save" class="btn" id="save"><i class="fa fa-save"></i></button>
                                    <input type="hidden" id="cId" name="editAction" value="">
                                    <input type="hidden" id="newPhone" name="editAction" value="">
                                    <input type="hidden" id="newAddress" name="editAction" value="">
                                    <input type="hidden" id="newPostal" name="editAction" value="">
                                </form>
                            </td>
                            <td>
                                <form action="CustomerController" method="post">
                                    <button type="submit" name="delete" class="btn" id="deleteButton"><i class="fa  fa-trash"></i></button>
                                    <input type="hidden" name="deleteAction" value="<%=phoneNum%>">
                                </form>
                            </td>
                        </tr>
                    </tbody>
                </table>
                <%}

                    }
                    if (error != null) {
                        out.println("<p style='color:red'>" + error + "</p>");
                    }

                    if (message != null) {
                        out.println("<p style='color:red'>" + message + "</p>");
                    }
                %>
           
             
        </div>
    </body>
</html>

