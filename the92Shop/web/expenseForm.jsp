<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Date"%>
<%@page import="entity.ExpenseTypes"%>
<%@page import="entity.ExpenseTracker"%>
<%@page import="java.util.List"%>
<%@page import="DAO.ExpenseTrackerDAO"%>
<%@page import="DAO.ExpenseTypesDAO"%>
<%@include file="sideNavBar.jsp" %>
<%@include file="protect.jsp" %>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link href="//cdn.muicss.com/mui-0.9.36/css/mui.min.css" rel="stylesheet" type="text/css" />
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" type="text/css" href="css/index.css" />
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
        <script type="text/javascript" src="js/jspdf.js"></script>
        <script type="text/javascript" src="js/addimage.js"></script>
        <title>Expenses Form Filling</title>
        <script type="text/javascript">
            function openPage(pageURL)
            {
                window.location.href = pageURL;
            }
        </script>
    </head>

    <body>
        <form  class="mui-form--inline" action="ExpenseTrackerController" method="post">    
            <div class = "subPageContent">
                <div class ="mui-panel expenseFormPanel">   
                    <h1>   Expenses Form Filling</h1>
                    <div class="mui-divider"></div>
                    <br />
                    <table id = "expenseTable">
                        <tbody>
                            <tr>
                                <td>
                                    <span>Date</span><span style="float:right">:</span>
                                </td>
                                <td>
                                    <input type="date" id="date" name="date" min="2017-01-01"  required/>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <span>Expenses</span><span style="float:right">: </span>
                                </td>
                                <td>
                                    <div class="mui-select">
                                        <select  name ="expenseTypes" id="expensesType" selected = '3' required>
                                            <%                                            ExpenseTypesDAO expDAO = new ExpenseTypesDAO();
                                                ArrayList<ExpenseTypes> expTypeList = expDAO.getAllExpenseTypes();
                                                for (int i = 0; i < expTypeList.size(); i++) {
                                                    ExpenseTypes exp = expTypeList.get(i);
                                                    String a = exp.getExpType();

                                                    out.println("<option>" + a + "</option>");
                                                }

                                            %>

                                        </select>  
                                    </div>                    
                                </td>
                            </tr>
                            <tr>
                                <td></td>
                                <td>
                                    
                                    <button type="submit" class="mui-btn mui-btn--raised mui-btn--primary" onclick="openPage('addExpenseType.jsp')" style=" text-transform:capitalize; border-radius: 8px; font-size:18px;">Add Expense <i class="fa fa-plus addexpenseButton" style="font-size:18px;"></i></button> 
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <span>Remark</span><span style="float:right">:</span>
                                </td>
                                <td>
                                    <div class="mui-textfield">
                                        <textarea  name="remark" id="remark" rows="5" cols="22" placeholder="Enter remarks here" required></textarea>   
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <span>Cost($)</span><span style="float:right">:</span>
                                </td>
                                <td>
                                    <div class="mui-textfield">
                                        <input type="number" step="any"  id="cost" name="cost" value="" placeholder="0.0" required/>
                                    </div>

                                </td>
                            </tr>
                            <tr>
                                <td>
                                </td>
                                <td>
                                    <span class="mui-btn mui-btn--raised mui-btn--primary" style="text-transform: capitalize; border-radius:8px;  font-size:18px; float:right;">
                                        <input type="submit" id="button" name="submit"  value="Submit "  />
                                        <i class="fa fa-caret-right"></i> 
                                    </span>

                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>  

            </div>
        </form>                         
        <script>

            $('#button').click(function () {
                var doc = new jsPDF("p", "mm", "a4");
                var img = new Image;



                img.onload = function () {
                    doc.addImage(this, 10, 10);
                    doc.text(80, 135, date.toLocaleDateString());
                    doc.text(80, 165, expensesType);
                    doc.text(80, 190, remark);
                    doc.text(80, 250, cost);

                    doc.save("test.pdf");

                };

                img.crossOrigin = "";  // for demo as we are at different origin than image

                img.src = "image/ExpenseTrackerV1.jpg";  // some random imgur image
                // var date = $('#date').val();
                var date = new Date();

                var expensesType = $('#expensesType').val();
                var remark = $('#remark').val();
                var cost = $('#cost').val();
                doc.setFont("helvetica");
                doc.setTextColor(92, 76, 76);



            });
        </script>
    <body>
</html>

