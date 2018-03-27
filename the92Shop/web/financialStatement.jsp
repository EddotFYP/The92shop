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
<script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/1.3.2/jspdf.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf-autotable/2.3.2/jspdf.plugin.autotable.js"></script>
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
                    Filter by (monthly/yearly):
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
                    <button type="submit" name="submit" class="mui-btn mui-btn--raised mui-btn--primary" style="font-size:18px;"> Filter <i class="fa fa-filter" style="font-size:18px;"></i></button>
                    <button type="submit" id="button" name="submit" class="mui-btn mui-btn--raised mui-btn--primary" style="font-size:18px;"> Download as PDF <i class="fa fa-download" style="font-size:18px;"></i></button>
         
            <br />
            <br />
            <table id="basic-table" align="center" bgcolor="#F2F2FF" id="basic-table" border="0" cellpadding="2" cellspacing="5" >
               
                <thead>
                    <img src="image/Eddot_Logo.jpg"/>
                <h1 align="center">the92 shop Income Statement</h1>
                    <tr>
                        
                         <%String monthString = (String) request.getAttribute("monthString"); %>
                         <%String year = (String) request.getAttribute("year"); %>
                         <th style="padding-left:15px;"><b>Income Statement for <%=monthString%> <%=year%></b></th>   
                         <th style="padding-left:15px;"><b>($)</b></th>

                    </tr>
                </thead>
            
                
                <tbody>
                <!--- retrieved the cost of goods sold ---->
                <%
                HashMap<String, Double> invGoodPurchasedwithCost = (HashMap<String, Double>) request.getAttribute("retrieveInvGoodPurchasedwithCost");
                if (invGoodPurchasedwithCost != null && !invGoodPurchasedwithCost.isEmpty()) {
                %>    
                
                
                <% 
                 double totalCostOfGoodsSold = (Double) request.getAttribute("totalInvCost");
                %>

                <td font style="font-weight:bold; font-size:18px;color:#4000BF;padding-top:15px;padding-left:15px; padding-bottom:10px">Total COGS</td>
                <td style="padding-top:15px;padding-left:15px;font-size:18px;color:#1f2e2e; padding-bottom:10px "><b>$ <u><%=totalCostOfGoodsSold%></b></u></td>
                <%
                    }
                %>
                </tbody> 
                
                
                <!--- retrieved GROSS Profit ---->
                <tbody>
                    <% 
                       double profit = (Double) request.getAttribute("profit"); 
                    %>    
                <tr>
                    <td font style="font-weight:bold;font-size:18px;color:#4000BF;padding-left:15px ">Gross Profit</td>
                    <td style="padding-left:15px; font-size:18px;color:#1f2e2e;padding-top:15px"><b>$ <u><%=profit%></b></u></td>
                </tr>
            
                </tbody>
     
                 <!--retrieve the list of expenses------------------------------>
                <tbody>
  
                <% HashMap<String,Double>retrieveExpenses = (HashMap<String, Double>) request.getAttribute("retrieveExpTypesNCost");
                    if (retrieveExpenses != null && !retrieveExpenses.isEmpty()) {
                %>        
                <tr><td font style="font-weight:bold;font-size:15px;color:#4D00B2;padding-left:15px; padding-top:10px;">Less:Expenses</td>
 
              
                </tr>

                  <%    for (String expTrackerItems : retrieveExpenses.keySet()) {
                        String expItems = expTrackerItems;
                        double expenses = retrieveExpenses.get(expItems );
                %>

                    <tr>
                        <td style="padding-left:15px; padding-top:5px; color:#1f2e2e;"><%=expItems%> </td> 
                        <td style="padding-left:15px; padding-top:5px; color:#1f2e2e;">$ <%=expenses%></td>

                    </tr>
                    
                    <% 
                        } 
                        double totalExpensesCost = (Double) request.getAttribute("totalExpCost");
                    %>
                    
                    <tr>
                     <td font style="font-weight:bold;color:#4D00B2;font-size:18px;padding-left:15px;">Total Expenses</td>
                     <td style="padding-left:15px; padding-top:15px;color:#1f2e2e;font-size:18px; "><b>$ <u><%=totalExpensesCost%></b></u></td>
                    </tr>


                    <%
                     }  
                        
                    %>
                
                </tbody>
                
               <!---------------------------------- Profit--------------------------------------------------------->
               <tbody>
                <%
                    HashMap<String, Double> retrieveSalesGained = (HashMap<String, Double>) request.getAttribute("retrieveSalesGained");
                    if (retrieveSalesGained != null && !retrieveSalesGained.isEmpty()) {
                %>
                <%        
                    double totalSales = (Double) request.getAttribute("totalSales");
                %>
                    
                    <tr>
                     <td font style="font-weight:bold;color:#4D00B2;font-size:18px;padding-left:15px;">Profit</td>
                     <td style="padding-left:15px; padding-top:15px;font-size:18px;padding-bottom:15px "><b>$ <u><%=totalSales%></u></b></td>
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
                      startY: 100, 
                      styles: {fillColor: [196, 201, 254]},
                      columnStyles: {
                      id: {fillColor: 255} },
                      margin: {top: 60},
                      beforePageContent: function() {
                      doc.text(40, 30, "Header");
                      
                    }
                      });
                   
                      doc.save('sample-file.pdf');
               
            });
        </script> 
  </div>
               
            
            </div>    
        </form> 
    </body> 
</html>
