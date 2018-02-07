<link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css" >
<link rel="stylesheet" href="css/master.css">
<link rel="stylesheet" href="css/bootstrap.min.css">

<script src="js/jquery.min.js"></script>
<script src="js/bootstrap.min.js"></script>

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
                    String[] nameArr = username.split("\\.");
                    String name = nameArr[0].toUpperCase();

                %>
                <h5>Current User:  <%=name%></h5>
            </div>
            <i class="fa fa-bars fa-2x toggle-btn" data-toggle="collapse" data-target="#menu-content"></i>

            <div class="menu-list">

                <ul id="menu-content" class="menu-content collapse out">              
                    <li data-toggle="collapse" data-target="#service" class="collapsed">
                        <a href="customerManagement.jsp"><i class="fa fa-user fa-lg"></i> Customer Management</a>


                    <li data-toggle="collapse" data-target="#service" class="collapsed">
                        <a href="inventoryManagement.jsp"><i class="fa fa-inbox  fa-lg"></i> Inventory Management</a>
                    </li>   
                    <li  data-toggle="collapse" data-target="#products" class="collapsed">
                        <a href="#"><i class="fa fa-gift fa-lg"></i> Dashboard <span class="arrow"></span></a>

                        <ul class="sub-menu collapse" id="products">
                            <form action="FinancialDbController" method="post">
                                <input type="hidden" name="monthData" value="monthData">
                                <input type="hidden" name="yearData" value="yearData">
                                <button type="submit" name="submit" class="navButton" >Financial Overview</button>
                            </form>
                             <li data-toggle="collapse" data-target="#service" class="collapsed">
                                <a href="financialStatement.jsp"></i> Financial Statement</a>
                            </li>  
                            
                            

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