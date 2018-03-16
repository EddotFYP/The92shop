
<%@include file="protect.jsp" %>
<link rel="stylesheet" href="css/master.css">
<link rel="stylesheet" href="https://netdna.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css">
<link href="//cdn.muicss.com/mui-0.9.36/css/mui.min.css" rel="stylesheet" type="text/css" />

<html>
    <head>
        <meta http-equiv="Conteant-Type" content="text/html; charset=UTF-8">
        <title>Inventory Management System</title>
    </head>
    <body>

        <div class="nav-side-menu">
            <ul class="drawer">
                <li> <a href="home.jsp" style="text-decoration:none;" > <i class="fa fa-line-chart"></i> <span> Analytics</span> </a>
                     <li> <a href="#" style="text-decoration:none;"> <i class="fa fa-tachometer"></i> <span>Dashboard</span> </a>
                     <ul>
                        <li> <a href="financialDb.jsp" style="text-decoration:none;"> <i class="fa fa-signal"></i> <span>Financial Overview</span> </a> </li>
                        <li> <a href="financialStatement.jsp" style="text-decoration:none;"> <i class="fa fa-briefcase"></i> <span>Financial Statement</span> </a> </li>
                        <li> 
                                <form id = "invForm" action="InventoryDbController" method="post">
                                <a href="#" onclick="document.getElementById('invForm').submit();" style="text-decoration:none;"><i class="fa fa-bar-chart"></i><span>Inventory</span></a>    
                                <input type="hidden" name="invLevel" value="inventoryLevel">
                                <input type="hidden" name="invList" value="lowInvList">
                                </form>
                        </li>
                        <li> <a href="customerDashboard.jsp" style="text-decoration:none;"> <i class="fa fa-list-alt"></i> <span>Customer</span> </a> </li>
                    </ul>
                <li> <a href="#" style="text-decoration:none;"> <i class="fa fa-money "></i> <span>Expense</span> </a>
                    <ul>
                        <li> <a href="expenseForm.jsp" style="text-decoration:none;"> <i class="fa fa-dollar"></i> <span>Input Expense</span> </a> </li>
                    </ul>
                <li> <a href="addAdmin.jsp" style="text-decoration:none;" > <i class="fa fa-user-plus"></i> <span> Admin Management</span> </a>
                <li> <a href="customerManagement.jsp" style="text-decoration:none;"> <i class="fa fa-users"></i> <span>Customer Management</span> </a>
                <li> <a href="#" style="text-decoration:none;"> <i class="fa fa-inbox"></i> <span>Inventory Management</span> </a>    
                    <ul>
                        <li> <a href="inventoryManagement.jsp" style="text-decoration:none;"> <i class="fa fa-search-plus"></i> <span>Search Inventory</span> </a> </li>
                        <li> <a href="addInventory.jsp" style="text-decoration:none;"> <i class="fa fa-cart-plus"></i> <span>Add Inventory</span> </a> </li>
                        <li> <a href="addInventoryQty.jsp" style="text-decoration:none;"> <i class="fa fa-qrcode"></i> <span>Add Inventory Quantity</span> </a> </li>
                    </ul>
                <li> <a href="orderPicking.jsp" style="text-decoration:none;"> <i class="fa fa-archive"></i> <span>Order Picking</span> </a>   
                <li> <a href="purchaseHistory.jsp" style="text-decoration:none;"> <i class="fa fa-book"></i> <span>Purchase History</span> </a>
               
            </ul>
        </div>
            <div id="userBar">
                <%
                    String choosenUsername = (String) session.getAttribute("user");
                    String nameOfUser = "";
                    if(choosenUsername != null){
                        String[] nameArr = choosenUsername.split("\\.");
                        nameOfUser = nameArr[0].toUpperCase();
                    }
                %>
                <h3 style="font-family: Wellfleet"><b>Current User: <%=nameOfUser%></b></h3>
                </div>
                <div id="logoutBtn">
                <form action="logout.jsp">
                  <button type="submit" name="logout" class="mui-btn mui-btn--raised mui-btn--danger "><i class="fa fa-sign-out" style="font-size:18px;"> Logout</i></button>
                </form>
                </div>
            
    </body>
</html>