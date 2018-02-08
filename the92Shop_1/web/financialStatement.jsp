<%-- 
    Document   : financialStatement
    Created on : Feb 5, 2018, 1:02:56 AM
    Author     : Jacquelyn
--%>


<%@page import="java.util.LinkedHashMap"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="entity.Inventory"%>
<%@page import="entity.ExpenseTracker"%>
<link rel="stylesheet" href="css/master.css">
<%@include file="sideNavBar.jsp" %>
<%@include file="protect.jsp" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<link rel="stylesheet" href="css/master.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
<script type="text/javascript" src="js/jspdf.js"></script>
<script type="text/javascript" src="js/addimage.js"></script>
<%--<%@include file="sideNavBar.jsp" %>
<%@include file="protect.jsp" %>
--%>

<!DOCTYPE html>
<html>
    <head>
        <style>
             .my_text
            {
                font-family:    Arial, Helvetica, sans-serif;
                font-size:      40px;
                font-weight:    bold;
            }
        </style>


        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Financial Statement</title>
    </head>
    <body>
        <form action="FinancialStatementController" method="post">
            <div id = "financialStatement">

                <h2>Financial Statement</h2>


                <div id="selectionOfMonthNYear"  class="required" >
                    Filter by (Monthly/Yearly):
                    <select name="month" >
                        <option value="none" selected>Please select</option>
                        <option value='1'>January</option>
                        <option value='2' >February</option>
                        <option value='3' >March</option>
                        <option value='4' >April</option>
                        <option value='5' >May</option>
                        <option value='6' >June</option>
                        <option value='7' >July</option>
                        <option value='8' >August</option>
                        <option value='9' >September</option>
                        <option value='10' >October</option>
                        <option value='11' >November</option>
                        <option value='12' >December</option>
                    </select>

                    <select name="year" class="required" >
                        <option value="none" selected>Please select</option>
                        <option value="2016">2016</option>
                        <option value="2017" >2017</option>
                        <option value="2018" >2018</option>
                    </select>

                    <button type="submit" name="submit">Go</button>
                    <button type="submit" id="button" name="submit">GeneratePDF</button>

                    <br>


                </div>
            </div>

        </form> 

        <div class="my_text" id="target" align="center" >



            <%String monthString = (String) request.getAttribute("monthString"); %>
            <%String year = (String) request.getAttribute("year"); %>


            <%
                HashMap<String, Double> retrieveSalesGained = (HashMap<String, Double>) request.getAttribute("retrieveSalesGained");
                if (retrieveSalesGained != null && !retrieveSalesGained.isEmpty()) {
            %>
            <h1> Income Statement for <%=monthString%> <%=year%></h1>
            <table  border="0" cellpadding="2" cellspacing="5" >

                <thead>
                    <tr>
                        <td style="padding-left:15px ; padding-bottom:10px"><b>Revenues</b></td>
                        <th style="padding-left:15px">$</th>

                    </tr>


                    <%
                        for (String goods : retrieveSalesGained.keySet()) {
                            String goodsSold = goods;
                            double profit = retrieveSalesGained.get(goods);


                    %>

                <tbody>
                    <tr>
                        <td style="padding-left:15px ; padding-bottom:10px"><%=goodsSold%></td>
                        <td style="padding-left:15px; padding-bottom:10px"><%=profit%></td>

                    </tr>


                    <%
                        }
                        double totalSales = (Double) request.getAttribute("totalSales");
                    %>

                <td style="padding-left:15px; padding-top:5px "><b><u>Total Revenue</u></b></td>
                <td style="padding-left:15px; padding-top:15px;padding-bottom:15px "><%=totalSales%></td>
                <%
                    }

                %>

                </tbody> 




                <%  HashMap<String, Double> retrieveTypewithCost = (HashMap<String, Double>) request.getAttribute("retrieveTypewithCost");
                    if (retrieveTypewithCost != null && !retrieveTypewithCost.isEmpty()) {

                %>        


                <tr>

                    <td style="padding-left:15px ; padding-bottom:10px"><b>Expense</b></td>
                    <th style="padding-left:15px">$</th>


                </tr>

                </thead>  


                <%                        for (String expTrackerItems : retrieveTypewithCost.keySet()) {
                        String expItems = expTrackerItems;
                        double expenses = retrieveTypewithCost.get(expTrackerItems);

                %>

                <tbody>

                    <tr>
                        <td style="padding-left:15px; padding-bottom:10px"><%=expItems%></td>
                        <td style="padding-left:15px; padding-bottom:10px"><%=expenses%></td>

                    </tr>

                    <%
                            }
                        }

                    %>

                </tbody> 
                <thead>
                    <tr>
                    </tr>

                </thead>  



                <% HashMap<String, Double> retrieveInvGoodPurchasedwithCost = (HashMap<String, Double>) request.getAttribute("retrieveInvGoodPurchasedwithCost");
                    if (retrieveInvGoodPurchasedwithCost != null && !retrieveInvGoodPurchasedwithCost.isEmpty()) {

                        for (String costofgoods : retrieveInvGoodPurchasedwithCost.keySet()) {
                            String cogItems = costofgoods;
                            double expenses = retrieveInvGoodPurchasedwithCost.get(costofgoods);


                %>

                <tbody>
                    <tr>
                        <td style="padding-left:15px; padding-bottom:10px"><%=cogItems%></td>


                        <td style="padding-left:15px; padding-bottom:10px ; padding-bottom:10px"><%=expenses%></td>

                        <%
                            }
                            double totalInvCost = (Double) request.getAttribute("totalInvCost");
                            double totalExpCost = (Double) request.getAttribute("totalExpCost");
                            double totalExpensesCost = totalInvCost + totalExpCost;
                            double profit = (Double) request.getAttribute("profit");
                        %>
                    <tr>
                        <td style="padding-left:15px; padding-top:15px "><b><u>Total Expenses</u></b></td>
                        <td style="padding-left:15px; padding-top:15px;"><%=totalExpensesCost%></td>
                    </tr>
                    <tr>
                        <td style="padding-left:15px; padding-top:15px;"><b><u>Profit</b></u></td>
                        <td style="padding-left:15px; padding-top:15px;"><u><%=profit%></u></td>
                    </tr>
                    <%
                        }

                    %>

                </tbody> 




            </table>
        </div>    

        <br>
        <br>

        <script>
            $(function () {

                var specialElementHandlers = {
                    '#editor': function (element, renderer) {
                        return true;
                    }
                };
                $('#button').click(function () {
                    var doc = new jsPDF('p', 'pt', 'a4');
                    doc.fromHTML(
                            $('#target').html(), 15, 15,
                            {'width': 200,
                                'elementHandlers': specialElementHandlers

                            },
                            function () {
                                doc.save('sample-file.pdf');
                            }
                    );



                });
            });
        </script> 



    </body> 



</html>
