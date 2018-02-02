<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Date"%>
<%@page import="entity.ExpenseTypes"%>
<%@page import="entity.ExpenseTracker"%>
<%@page import="java.util.List"%>
<%@page import="DAO.ExpenseTrackerDAO"%>
<%@page import="DAO.ExpenseTypesDAO"%>

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
        <div id="navbar"><span>Expenses Form Filling</span></div>
        <div id="wrapper">
            <form  action="ExpenseTrackerController" method="post">    
           
            <br>
            Date:<br>
           
            <input type="date" id="date" name="date" min="2017-01-01"/>
            <br>
           
            Expenses:<br>
            <select name ="expenseTypes" id="expensesType" selected = '3'>
                
                <%
                      ExpenseTypesDAO expDAO = new ExpenseTypesDAO();
                      ArrayList<ExpenseTypes> expTypeList = expDAO.getAllExpenseTypes();
                      for(int i = 0 ; i < expTypeList.size() ; i++){
                          ExpenseTypes exp = expTypeList.get(i);
                          String a = exp.getExpType();
                          
                          out.println("<option>" + a+"</option>");
                      }
                    
                    %>
                
            </select> <br>
            <br>
            
            Remark: <br>
            <textarea  name="remark" id="remark" rows="10" cols="20"></textarea><br>
            <br>
            Cost($):
            <input type="text" id="cost" name="cost" value="" placeholder="0.0" /><br>
            
            
            <br>
            <input type="submit" id="button" value="Submit"/>
            
         
        </form>    
        </div>  
        <script>
                
            $('#button').click(function () {
                var doc = new jsPDF("p", "mm", "a4");      
                var img = new Image;
                
                
            img.onload = function() {
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
        
      
    </body>
</html>

