<%-- 
    Document   : customerManagement
    Created on : Oct 17, 2017, 7:47:26 PM
    Author     : Clarey Liow JX
--%>





<%@page import="DAO.CustomerDAO"%>
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
<script type="text/javas            cript">
                    $(document).ready(functi            on () {
            $('#edit').click(functi            on () {
            $('#phone').attr('contenteditable', '                    true');
            $('#address').attr('contenteditable', '                    true');
            $('#postal').attr('contenteditable', '            true');
            });
            $('#save').click(functi            on () {
            //alert($('#phone').h            tml());
            $('#cId').attr("value", $('#cusId').h                    tml());
            $('#newPhone').attr("value", $('#phone').h                    tml());
            $('#newAddress').attr("value", $('#address').h                    tml());
            $('#newPostal').attr("value", $('#postal').h            tml());
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
                    <fieldset  class="fieldset-auto-                                        width">
                        <legend class="lg"><h2> Search / Add Customer </h2></legend>
                        <%                             
                            CustomerDAO dao = new CustomerDAO();
                            ArrayList<Customer> customerList = dao.retrieveAllCustomers();
                            ArrayList<String> phoneNumList = new ArrayList<>();
                            ArrayList<String> nameList = new ArrayList<>();
                            for (Customer c : customerList) {
                                phoneNumList.add(c.getPhoneNum());
                                nameList.add(c.getName());
                            }
                        %>
                        <table>
                            <tr>
                                Please search either using Phone Number or Name
                            </tr>
                            <tr>
                                <td>
                                    Phone Number:
                                </td>
                                <td> 
                                    <input type ="text" list ="phoneNumList" name = "phoneNumList" placeholder=" &#xf095;" style="font-family:Arial,FontAwesome"/>
                                    <datalist id="phoneNumList">
                                        <%for (String i : phoneNumList) {%>
                                        <option value="<%=i%>"><%=i%></option>
                                        <% }%>

                                    </datalist>
                                </td>
                            </tr>
                            <img  src="image/customer.png" align="right">
                            <tr>
                                <td>
                                    Name:
                                </td>
                                <td>
                                    <input type ="text" list = "nameList" name ="nameList" placeholder=" &#xf007;" style="font-family: Arial, FontAwesome" /> 
                                    <datalist id="nameList">
                                        <%for (String i : nameList) {%>
                                        <option value="<%=i%>"><%=i%></option>
                                        <% }%>
                                    </datalist> 
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
                int custId = 0;
                String custName = "";
                String phoneNum = "";
                String address = "";
                String postalCode = "";

                if (custList != null && !custList.isEmpty()) {%>
            <table id="custTable" border ="1">
                <thead>
                    <tr>
                        <th> Customer Id </th>
                        <th> Name </th>
                        <th> Phone Number </th>
                        <th> Address </th>
                        <th> Postal Code </th>
                        <th> Edit </th>
                        <th> Save </th>
                        <th> Delete </th>
                    </tr>
                </thead>
                <%for (Customer cus : custList) {
                        custId = cus.getCustId();
                        custName = cus.getName();
                        phoneNum = cus.getPhoneNum();

                        address = cus.getAddress();
                        postalCode = cus.getPostalCode();
                %>
                <br>
                <br>
                <body>
                <tr>
                    <td id="custId"><%=custId%></td>
                    <td id="custName"><%=custName%></td>
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

