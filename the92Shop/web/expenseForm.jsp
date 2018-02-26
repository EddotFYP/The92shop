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
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <link rel="stylesheet" type="text/css" href="css/index.css" />
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
        <script type="text/javascript" src="js/jspdf.js"></script>
        <script type="text/javascript" src="js/addimage.js"></script>
        <title>Expenses Form Filling</title>
    </head>

    <body>
    <center>

        <div id="wrapper" align="center" >
            <form action="addExpenseType.jsp" method="post">
                <button type="submit" width="50" height="50" style="position: absolute; left: 710;top:135 " class="searchBtn">Add Expense</button>
            </form>
            <form  action="ExpenseTrackerController" method="post">    
                <div id = "expenseForm">
                    <h1>   Expenses Form Filling</h1>
                    <br>
                    <table>
                        <tbody>
                            <tr>
                                <td>
                                    <b>Date:</b>

                                </td>
                                <td>
                                    <input type="date" id="date" name="date" min="2017-01-01"/>
                                    <br />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <b>Expenses:</b>
                                </td>
                                <td>
                                    <select  name ="expenseTypes" id="expensesType" selected = '3'>
                                        <%                                     
                                            ExpenseTypesDAO expDAO = new ExpenseTypesDAO();
                                            ArrayList<ExpenseTypes> expTypeList = expDAO.getAllExpenseTypes();
                                            for (int i = 0; i < expTypeList.size(); i++) {
                                                ExpenseTypes exp = expTypeList.get(i);
                                                String a = exp.getExpType();

                                                out.println("<option>" + a + "</option>");
                                            }

                                        %>

                                    </select>
                                    <br />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <b>Remark:</b>
                                </td>
                                <td>
                                    <textarea  name="remark" id="remark" rows="5" cols="22"></textarea>
                                    <br />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <b>Cost($):</b>
                                </td>
                                <td>
                                    <input type="text" id="cost" name="cost" value="" placeholder="0.0" />
                                    <br />
                                   
                                </td>
                            </tr>
                            <tr>
                                <td>
                                </td>
                                <td>
                                    
                                    <input align="center" type="submit" id="button" value="Submit" class="searchBtn"/>
                                </td>
                            </tr>
                        </tbody>
                    </table>
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
    </center>


</body>
</html>

