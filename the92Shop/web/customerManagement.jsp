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
        <script src="js/jquery-1.12.3.js"></script>
        <script src="js/jquery.min.js"></script>
        <script src="js/dataTables.min.js"></script>
        <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.16/css/jquery.dataTables.css">
        <style>
            table {
                max-width: 950px;
                margin: auto;
                
            }
        </style>
        <script type="text/javascript">
            function editClick(clickedId) {
                var row = clickedId.substr(clickedId.indexOf('?') + 1);
                var name = "name?" + row;
                var phone = "phone?" + row;
                var address = "address?" + row;
                var postal = "postal?" + row;

                document.getElementById(name).contentEditable = "true";
                document.getElementById(phone).contentEditable = "true";
                document.getElementById(address).contentEditable = "true";
                document.getElementById(postal).contentEditable = "true";


            }
            ;
            function saveClick(clickedId) {
                var row = clickedId.substr(clickedId.indexOf('?') + 1);
                var name = "name?" + row;
                var phone = "phone?" + row;
                var address = "address?" + row;
                var postal = "postal?" + row;


                var newName = "newName?" + row;
                var newPhone = "newPhone?" + row;
                var newAddress = "newAddress?" + row;
                var newPostal = "newPostal?" + row;


                document.getElementById(newName).value = document.getElementById(name).innerHTML;
                document.getElementById(newPhone).value = document.getElementById(phone).innerHTML;
                document.getElementById(newAddress).value = document.getElementById(address).innerHTML;
                document.getElementById(newPostal).value = document.getElementById(postal).innerHTML;



            }
            ;
            function showDiv(clickedId) {
                var row = clickedId.substr(clickedId.indexOf('?') + 1);
                var edit = "editButtonDiv?" + row;
                var save = "saveButtonDiv?" + row;
                document.getElementById(edit).style.display = "none";
                document.getElementById(save).style.display = "block";
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
            
            $(document).ready(function () {
                $('#custTable').dataTable({
                    "bPaginate": true,
                    "bLengthChange": false,
                    "bFilter": false,
                    "bInfo": false,
                    "bAutoWidth": false,
                    "bSorted": true,
                    "order": [],
                    "ordering": true
                });
            });
        </script>
        <title> Customer Search</title>            
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
            <div class ="mui-panel addCustomerPanel ">    
                <h1>Add Customer</h1>
                <div class="mui-divider"></div>
                <br />
                <span class="mui-btn mui-btn--raised mui-btn--primary" style="text-transform: capitalize; border-radius:8px;  font-size:18px;">
                    <input type="button" name="submit" onclick="openPage('addCustomer.jsp')" value=" Add Customer" />
                    <i class="fa fa-plus" style="font-size:18px;"></i> 
                </span>

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
                                    <input type ="text" list ="phoneAndNameList" name = "phoneAndNameList"/>
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
                            <button type="submit" name="submit" class="mui-btn mui-btn--raised mui-btn--primary" style="float:right; font-size:18px;">Search <i class="fa fa-search" style="font-size:18px;"> </i></button>
                        </td>
                    </table>
                </form>


                <%
                    ArrayList<Customer> custList = (ArrayList<Customer>) request.getAttribute("custList");
                    String error = (String) request.getAttribute("error");
                    String message = (String) request.getAttribute("message");
                    String confirmMessage = (String) request.getAttribute("confirmMessage");

                    if (error != null) {
                        out.println("<p style='color:red'>" + error + "</p>");
                    }

                    if (message != null) {
                        out.println("<p style='color:red'>" + message + "</p>");
                    }
                    
                    if (confirmMessage != null) {
                        out.println("<p style='color:#00cc00'>" + confirmMessage + "</p>");
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
                <table id="custTable" >
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

                                    String nameId = "name?" + custId;
                                    String phoneId = "phone?" + custId;
                                    String addressId = "address?" + custId;
                                    String postalId = "postal?" + custId;

                                    String editId = "edit?" + custId;
                                    String saveId = "save?" + custId;
                                    String editButtonDiv = "editButtonDiv?" + custId;
                                    String saveButtonDiv = "saveButtonDiv?" + custId;
                            %>


                            <td id="<%=nameId%>"><%=custName%></td>
                            <td width="150px" id="<%=phoneId%>"><%=phoneNum%></td>
                            <td id="<%=addressId%>"><%=address%></td>
                            <td width="120px" id="<%=postalId%>"><%=postalCode%></td>
                            <td width="100px">
                                <div id="<%=editButtonDiv%>" class="answer_list" >
                                    <button type="submit" name="submit" class="btn" id="<%=editId%>" onclick="showDiv(this.id);editClick(this.id);">  <i class="fa fa-edit"></i></button>
                                </div>
                                <%
                                    String newName = "newName?" + custId;
                                    String newPhone = "newPhone?" + custId;
                                    String newAddress = "newAddress?" + custId;
                                    String newPostal = "newPostal?" + custId;

                                %>
                                <div id="<%=saveButtonDiv%>"  style="display:none;" class="answer_list" >
                                    <form action="CustomerController" method="post">
                                        <button type="submit" name="save" class="btn" id="<%=saveId%>" onclick="saveClick(this.id)"><i class="fa fa-save"></i></button>
                                        <input type="hidden" id="cId" name="editAction" value="<%=custId%>">
                                        <input type="hidden" id="<%=newName%>" name="editAction" value="">
                                        <input type="hidden" id="<%=newPhone%>" name="editAction" value="">
                                        <input type="hidden" id="<%=newAddress%>" name="editAction" value="">
                                        <input type="hidden" id="<%=newPostal%>" name="editAction" value="">
                                    </form>
                                </div>
                            </td>
                            <td width="100px">
                                <form action="CustomerController" method="post" onclick="return confirmation()">
                                    <button type="submit" name="delete" class="btn" id="deleteButton"><i class="fa  fa-trash"></i></button>
                                    <input type="hidden" name="deleteAction" value="<%=custId%>">
                                </form>
                            </td>
                        </tr>
                        <% }; %>
                    </tbody>
                </table>
                <%

                    }


                %>
            </div>


        </div>
    </body>
</html>

