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
                    $('#newPhone').attr("value", $('#phone').html());
                    $('#newAddress').attr("value", $('#address').html());
                    $('#newPostal').attr("value", $('#postal').html());
                });
                
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
            function showDiv() {
                document.getElementById('editButtonDiv').style.display = "none";
                document.getElementById('saveButtonDiv').style.display = "block";
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
            
            function openPage(pageURL)
            {
                window.location.href = pageURL;
            }

        </script>
        <title> Customer Search</title>            
    </head>
    <body>
        <%                
            String usernameAcc = (String) session.getAttribute("user");

            if (!usernameAcc.equals("qingyang")) {%>
        <%@include file="nonAdminSideNavBar.jsp" %>
        <%} else {
        %>
        <%@include file="sideNavBar.jsp" %>
        <% }


        %>
        <div class="subPageContent">  
            <div class ="mui-panel addCustomerPanel ">    
                <h1>Add Customer</h1>
                <div class="mui-divider"></div>
                <br />
                <input type="button" name="submit" class="mui-btn mui-btn--raised mui-btn--primary" onclick="openPage('addCustomer.jsp')" value="&#xf067 Add Customer" class="fa fa-input" style="font-family: FontAwesome; text-transform: capitalize; border-radius:8px;  font-size:18px;">
            </div>
            <div class ="mui-panel searchCustomerPanel ">    
                <form action="CustomerController" method="post">

                    <h1> Search Customer </h1>
                    <div class="mui-divider"></div>
                    <br />
                    <%  CustomerDAO dao = new CustomerDAO();
                        ArrayList<Customer> customerList = dao.retrieveAllCustomers();
                        ArrayList<String> phoneNumList = new ArrayList<>();
                        ArrayList<String> nameList = new ArrayList<>();
                        for (Customer c : customerList) {
                            phoneNumList.add(c.getPhoneNum());
                            nameList.add(c.getName());
                        }
                    %>
                    <table id="AdminTable">

                        <tr>
                            <td>
                                Phone Number / Name:
                            </td>
                            <td> 
                                <div class="mui-textfield">
                                <input type ="text" list ="phoneAndNameList" name = "phoneAndNameList" placeholder=" &#xf007;" style="font-family:Arial,FontAwesome"/>
                                <%--<datalist id="phoneNumList">
                                    <%for (String i : phoneNumList) {%>
                                    <option value="<%=i%>"><%=i%></option>
                                    <% }%>

                                            </datalist>--%>
                                </div>
                            </td>
                        </tr>

                        <%--<tr>
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
                        </tr>--%>
                        <td></td>
                        <td>
                            <button type="submit" name="submit" class="mui-btn mui-btn--raised mui-btn--primary" style=float:right;"><i class="fa fa-search" style="font-size:18px;"> Search</i></button>
                        </td>
                    </table>
                </form>
           

            <%
                ArrayList<Customer> custList = (ArrayList<Customer>) request.getAttribute("custList");
                String error = (String) request.getAttribute("error");
                String message = (String) request.getAttribute("message");
                
                 if (error != null) {
                        out.println("<p style='color:red'>" + error + "</p>");
                    }

                    if (message != null) {
                        out.println("<p style='color:red'>" + message + "</p>");
                    }
                  %>
                   </div>
                   <%
                int custId = 0;
                String custName = "";
                String phoneNum = "";
                String address = "";
                String postalCode = "";

                if (custList != null && !custList.isEmpty()) {%>
            <div class ="mui-panel customerTableResult">  
                <table id="myTable" class="invMgt-table">
                    <thead>
                        <tr>

                            <th> Name </th>
                            <th> Phone Number </th>
                            <th> Address </th>
                            <th> Postal Code </th>
                            <th> Edit/Save </th>
                            <th> Delete </th>
                        </tr>
                    </thead>
                    <tbody>
                    <tr>
                    <%for (Customer cus : custList) {
                            custId = cus.getCustId();
                            custName = cus.getName();
                            phoneNum = cus.getPhoneNum();

                            address = cus.getAddress();
                            postalCode = cus.getPostalCode();
                    %>
                    

                        <td id="custName"><%=custName%></td>
                        <td id="phone"><%=phoneNum%></td>
                        <td id="address"><%=address%></td>
                        <td id="postal"><%=postalCode%></td>
                        <td>
                            <div id="editButtonDiv" class="answer_list" >
                                <button type="submit" name="submit" class="btn" id="edit" onclick="showDiv()">  <i class="fa fa-edit"></i></button>
                            </div>

                            <div id="saveButtonDiv"  style="display:none;" class="answer_list" >
                                <form action="CustomerController" method="post">
                                    <button type="submit" name="save" class="btn" id="save"><i class="fa fa-save"></i></button>
                                    <input type="hidden" id="cId" name="editAction" value="<%=custId%>">
                                    <input type="hidden" id="newPhone" name="editAction" value="">
                                    <input type="hidden" id="newAddress" name="editAction" value="">
                                    <input type="hidden" id="newPostal" name="editAction" value="">
                                </form>
                            </div>
                        </td>
                        <td>
                            <form action="CustomerController" method="post" onclick="return confirmation()">
                                <button type="submit" name="delete" class="btn" id="deleteButton"><i class="fa  fa-trash"></i></button>
                                <input type="hidden" name="deleteAction" value="<%=phoneNum%>">
                            </form>
                        </td>
                    </tr>
                    <% }; %>
                    </tbody>
                </table>
                <%

                    }
                    if (error != null) {
                        out.println("<p style='color:red'>" + error + "</p>");
                    }

                    if (message != null) {
                        out.println("<p style='color:red'>" + message + "</p>");
                    }
                   
                %>
            </div>


        </div>
    </body>
</html>

