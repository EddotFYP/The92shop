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
<<link href="//cdn.muicss.com/mui-0.9.36/css/mui.min.css" rel="stylesheet" type="text/css" />
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

                    
                    $('#newPhone').attr("value", $('#phone').html());
                    $('#newAddress').attr("value", $('#address').html());
                    $('#newPostal').attr("value", $('#postal').html());
                });
                
            });
</script>
        <script type="text/javascript">
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
                    
                    if(!usernameAcc.equals("qingyang")){ %>
                        <%@include file="nonAdminSideNavBar.jsp" %>
                    <%}else{ %>
                        <%@include file="sideNavBar.jsp" %>
                   <% }
                    

                %>
            <div class="subPageContent">       
                <form action="CustomerController" method="post">
                        <h1> Search / Add Customer </h1>
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
                        <table>
                            <tr>
                                Please search either using Phone Number or Name
                            <br />
                            <br />
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
                        <button type="submit" name="submit" class="mui-btn mui-btn--raised mui-btn--primary "><i class="fa fa-search" style="font-size:18px;"> Search</i></button>
                        <input type="button" name="submit" class="mui-btn mui-btn--raised mui-btn--primary" onclick="openPage('addCustomer.jsp')" value="&#xf067 Add Customer" class="fa fa-input" style="font-family: FontAwesome; font-size:18px;">
                </form>
        

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
                            <input type="hidden" id="cId" name="editAction" value="<%=custId%>">
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

