
<%@include file="protect.jsp" %>
<link rel="stylesheet" href="css/master.css">
<link rel="stylesheet" href="https://netdna.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css">
<link href="//cdn.muicss.com/mui-0.9.36/css/mui.min.css" rel="stylesheet" type="text/css" />

<html>
    <head>
        <meta http-equiv="Conteant-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Inventory Management System</title>
    </head>
    <body>
        <div id="header">
            <%                    
                String choosenUsername = (String) session.getAttribute("user");
                
            %>

            <div id="currentUser" style="display: inline"><h3 style="color: white">&nbsp; Current User: <%= choosenUsername%></h3></div>

            <form action="logout.jsp">
                <button type="submit" name="logout" id="logoutBtn" class="mui-btn mui-btn--raised mui-btn--danger "><i class="fa fa-sign-out" style="font-size:18px;"> Logout</i></button>
            </form>
            
        </div>

        <div id="sidebar">
            <center>
            <ul class="admimdrawer">
               
                <li><a href="productBundlingOutcome.jsp" style="text-decoration:none;" > <i class="fa fa-line-chart fa-xs"></i> <span> Analytics</span> </a>
                <li> <a href="#" style="text-decoration:none;"> <i class="fa fa-tachometer fa-xs"></i> <span>Dashboard</span> </a>
                    <ul>
                        <li> <a href="financialDb.jsp" style="text-decoration:none;"> <i class="fa fa-signal fa-sm"></i> <span>Financial Overview</span> </a> </li>
                        <li> <a href="financialStatement.jsp" style="text-decoration:none;"> <i class="fa fa-briefcase fa-sm"></i> <span>Financial Statement</span> </a> </li>
                        <li> 
                            <form id = "invForm" action="InventoryDbController" method="post">
                                <a href="#" onclick="document.getElementById('invForm').submit();" style="text-decoration:none;"><i class="fa fa-bar-chart fa-sm"></i><span>Inventory</span></a>    
                                <input type="hidden" name="invLevel" value="inventoryLevel">
                                <input type="hidden" name="invList" value="lowInvList">
                            </form>
                        </li>
                        <li> <a href="customerDashboard.jsp" style="text-decoration:none;"> <i class="fa fa-list-alt fa-sm"></i> <span>Customer</span> </a> </li>
                    </ul>
                <li> <a href="#" style="text-decoration:none;"> <i class="fa fa-money fa-sm"></i> <span>Expenses</span> </a>
                    <ul>
                        <li> <a href="expenseForm.jsp" style="text-decoration:none;"> <i class="fa fa-dollar fa-sm"></i> <span>Input Expense</span> </a> </li>
                    </ul>
                <li> <a href="addAdmin.jsp" style="text-decoration:none;" > <i class="fa fa-user-plus fa-sm"></i> <span> Admin Management</span> </a>
                <li> <a href="customerManagement.jsp" style="text-decoration:none;"> <i class="fa fa-users fa-sm"></i> <span>Customer Management</span> </a>
                <li> <a href="#" style="text-decoration:none;"> <i class="fa fa-inbox fa-sm"></i> <span>Inventory Management</span> </a>    
                    <ul>
                        <li> <a href="inventoryManagement.jsp" style="text-decoration:none;"> <i class="fa fa-search-plus fa-sm"></i> <span>Search Inventory</span> </a> </li>
                        <li> <a href="addInventory.jsp" style="text-decoration:none;"> <i class="fa fa-cart-plus fa-sm"></i> <span>Add New Inventory</span> </a> </li>
                        <li> <a href="addInventoryQty.jsp" style="text-decoration:none;"> <i class="fa fa-qrcode fa-sm"></i> <span>Add Inventory Quantity</span> </a> </li>
                    </ul>
                <li> <a href="orderPicking.jsp" style="text-decoration:none;"> <i class="fa fa-archive fa-sm"></i> <span>Order Picking</span> </a>   
                <li> <a href="purchaseHistory.jsp" style="text-decoration:none;"> <i class="fa fa-book fa-sm"></i> <span>Purchase History</span> </a>
                <li> <a href="priceBundling.jsp" style="text-decoration:none;"> <i class="fa fa-search fa-sm"></i> <span>Bundle Recommendation</span> </a>
                <% 
                    for(int i=0; i<30; i++){
                        out.println("<li></li>");
    
                    }
                %>
  
            </ul>
            </center>
        </div>
    </body>
</html>