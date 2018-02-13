<link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css" >
<link rel="stylesheet" href="css/master.css">
<link rel="stylesheet" href="css/bootstrap.min.css">

<script src="js/jquery.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<%@include file="protect.jsp" %>
<html>
    <head>
        <meta http-equiv="Conteant-Type" content="text/html; charset=UTF-8">
        <title>Inventory Management System</title>
    </head>
    <body>
        <div class="nav-side-menu">
            <div class="brand">
                The 92 Shop
                <%
                    String username = (String) session.getAttribute("user");
                    String name = "";
                    if(username != null){
                        String[] nameArr = username.split("\\.");
                        name = nameArr[0].toUpperCase();
                    }
                    

                %>
                <h5>Current User:  <%=name%></h5>
            </div>
            <i class="fa fa-bars fa-2x toggle-btn" data-toggle="collapse" data-target="#menu-content"></i>

            <div class="menu-list">

                <ul id="menu-content" class="menu-content collapse out">              
                    <li data-toggle="collapse" data-target="#customer" class="collapsed">
                        <a href="customerManagement.jsp"><i class="fa fa-user fa-lg"></i> Customer Management</a>

                    </li>
                    <li data-toggle="collapse" data-target="#inventory" class="collapsed">
                        <a href="#"><i class="fa fa-inbox  fa-lg"></i> Inventory Management<span class="arrow"></span></a></a>
                        <ul class="sub-menu collapse" id="inventory">
                            <a href="inventoryManagement.jsp">Search Inventory</a>
                            <br />
                            <a href="addInventory.jsp">Add Inventory</a>
                            <br />
                            <a href="addInventoryQty.jsp">Add Inventory Quantity</a>
                            <br />
                        </ul>
                    </li> 
                    
                    <li data-toggle="collapse" data-target="#order" class="collapsed">
                        <a href="orderPicking.jsp"><i class="fa fa-archive  fa-lg"></i> Order Picking </a>
                        
                    </li> 
                    
                    <li  data-toggle="collapse" data-target="#products" class="collapsed">
                        <a href="#"><i class="fa fa-gift fa-lg"></i> Dashboard <span class="arrow"></span></a>

                        <ul class="sub-menu collapse" id="products">
                            <a href="monthlyProfits.jsp">Monthly Profits</a>
                            <br />
                            <a href="yearlyProfits.jsp">Yearly Profits</a>
                            <br />
                            <a href="monthlySales.jsp">Monthly Sales</a>
                            <br />
                            <a href="yearlySales.jsp">Yearly Sales</a>
                            <br />
                            <a href="monthlyExpenses.jsp">Monthly Expenses</a>
                            <br />
                            <a href="yearlyExpenses.jsp">Yearly Expenses</a>
                            <br />
                            <a href="financialStatement.jsp"> Financial Statement</a>

                            <form action="InventoryDbController" method="post">       
                                <input type="hidden" name="invLevel" value="inventoryLevel">
                                <input type="hidden" name="invList" value="lowInvList">

                                <button type="submit" name="submit" class="navButton">Inventory</button>
                            </form>
                            <a href="customerDashboard.jsp">Customer</a>
                        </ul>
                    </li>
                </ul>
                <br>
                <br>
                <form action="logout.jsp">
                    <div class="form-group input-group">
                        <input type="submit" class="btn " name="logout" value="Logout">

                    </div>
                </form>
            </div>
        </div>
    </body>
</html>