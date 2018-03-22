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
<%@include file="sideNavBar.jsp" %>
<%@include file="protect.jsp" %>
<link href="//cdn.muicss.com/mui-0.9.36/css/mui.min.css" rel="stylesheet" type="text/css" />
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<link rel="stylesheet" href="css/master.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
<script type="text/javascript" src="js/jspdf.js"></script>
<script type="text/javascript" src="js/addimage.js"></script>
<script type="text/javascript" src="js/script.js"></script>


<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Financial Statement</title>
    </head>
    <body>
        <form class="mui-form--inline" action="FinancialStatementController" method="post">
            <div id = "financialStatement">
                <div class ="mui-panel">
                    <h1>Financial Statement</h1>
                    <div class="mui-divider"></div>
                    Filter by (Monthly/Yearly):
                    <div class="mui-select">
                        <select name="month" required>
                            <option value=''>Please select</option>
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
                    </div>

                    <div class="mui-select">
                        <select name="year" class="required" required>
                            <option value="" >Please select</option>
                            <option value="2017" >2017</option>
                            <option value="2018" >2018</option>
                        </select>
                    </div>

                    &nbsp;
                    <button type="submit" name="submit" class="mui-btn mui-btn--raised mui-btn--primary" style="font-size:18px;"><i class="fa fa-filter" style="font-size:18px;"> Filter </i></button>
                    <button type="submit" id="button" name="submit" class="mui-btn mui-btn--raised mui-btn--primary"><i class="fa fa-download" style="font-size:18px;"> Download as PDF </i></button>

                    <br />
                     <br />
           
            </div>
            </div>    
        </form> 
        
        <div class="my_text" id="target" align="center" >
            
            <%String monthString = (String) request.getAttribute("monthString"); %>
            <%String year = (String) request.getAttribute("year"); %>
            
            <!--  Starts ---->
            
            <table id="basic-table" border="0" cellpadding="2" cellspacing="5" >
                <h1>the92 shop Income Statement</h1>
                <thead>
                    
                    <tr>
                      
                         <th style="padding-left:15px;padding-bottom:25px"><b>Income Statement for <%=monthString%> <%=year%></b></th>
                         <th style="padding-left:30px;padding-bottom:25px"><b>$</b></th>

                    </tr>
                </thead>   
                
                    
                <tr>
                        <td font style="font-weight:bold;color:	#0000FF;padding-left:15px; padding-bottom:10px">Cost Of Goods Sold</td>
                        <td style="padding-left:15px"><b></b></td>

                    </tr>
                <%
                HashMap<String, Double> invGoodPurchasedwithCost = (HashMap<String, Double>) request.getAttribute("retrieveInvGoodPurchasedwithCost");
                if (invGoodPurchasedwithCost != null && !invGoodPurchasedwithCost.isEmpty()) {
                %>    
    

                <%
                    for (String invPurchasedItems : invGoodPurchasedwithCost.keySet()) {
                        String goodsBrought = invPurchasedItems;
                        double cogs = invGoodPurchasedwithCost.get(goodsBrought);


                %>

                 <tbody>
                    <tr>
                        <td style="padding-left:15px ; padding-bottom:10px"><%=goodsBrought%></td>
                        <td style="padding-left:15px; padding-bottom:10px"><%=cogs%></td>

                    </tr>


                    <%
                        }
                        double totalInventoryCost = (Double) request.getAttribute("totalInvCost");
                    %>

                <td font style="font-weight:bold;color:	#0000FF;padding-left:15px; padding-bottom:10px"><u>Total COGS</u></td>
                <td style="padding-left:15px; padding-top:15px;padding-bottom:15px "><%=totalInventoryCost%></td>
                <%
                    }

                %>

                </tbody> 
            
            
            
            
        <!---------------------------------------------------------->
            
            


            <%
                HashMap<String, Double> retrieveSalesGained = (HashMap<String, Double>) request.getAttribute("retrieveSalesGained");
                if (retrieveSalesGained != null && !retrieveSalesGained.isEmpty()) {
            %>
 

                <tr>
                    <td font style="font-weight:bold;color:	#0000FF;padding-left:15px; padding-bottom:10px">Revenues</td>
                    <td style="padding-left:15px"><b></b></td>

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

                <td font style="font-weight:bold;color:	#0000FF;padding-left:15px; padding-bottom:10px"><u>Total Revenues</u></td>
                <td style="padding-left:15px; padding-top:15px;padding-bottom:15px "><%=totalSales%></td>
                <%
                    }

                %>

                </tbody> 




                <%  HashMap<String, Double> retrieveTypewithCost = (HashMap<String, Double>) request.getAttribute("retrieveTypewithCost");
                    if (retrieveTypewithCost != null && !retrieveTypewithCost.isEmpty()) {

                %>        


                <tr>

                    <td font style="font-weight:bold;color:#0000FF;padding-left:15px; padding-bottom:10px">Expense</td>
                    <th style="padding-left:15px"></th>


                </tr>




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
                <%--<thead>
                    <tr>
                    </tr>

                </thead>  --%>
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
                        <td font style="font-weight:bold;color:	#0000FF;padding-left:15px; padding-bottom:10px"><u>Total Expenses</u></td>
                        <td style="padding-left:15px; padding-bottom:10px;"><%=totalExpensesCost%></td>
                    </tr>
                    <tr>
                        <td font style="font-weight:bold;color:	#0000FF;padding-left:15px; padding-top:15px"><u>Profit</u></td>
                        <td style="padding-left:15px; padding-top:15px;"><u><%=profit%></u></td>
                    </tr>
                    <%
                        }

                    %>
                </tbody> 
            </table>

        <br>
        <br>

        <script>




            $('#button').click(function () {
                var doc = new jsPDF('p', 'pt', 'a4');
                var res = doc.autoTableHtmlToJson(document.getElementById("basic-table"));
                doc.autoTable(res.columns, res.data, {
                    startY: 80
                });

                doc.save('sample-file.pdf');






            });
        </script> 
 </div>
            </div>
</form> 

    </body> 



</html>
