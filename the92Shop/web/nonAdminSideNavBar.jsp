
<link rel="stylesheet" href="css/master.css">
<link rel="stylesheet" href="https://netdna.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css">
<link href="//cdn.muicss.com/mui-0.9.36/css/mui.min.css" rel="stylesheet" type="text/css" />

<html>
    <head>
        <meta http-equiv="Conteant-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
    </head>
    <body>
        <div id="header">
            <%
                String choosenUsername = (String) session.getAttribute("user");
            %>

            <div id="currentUser"><h3 style="color: white">&nbsp; Current User: <%= choosenUsername%></h3></div>

            <form action="logout.jsp">
                <button type="submit" name="logout" id="logoutBtn" class="mui-btn mui-btn--raised mui-btn--danger "><i class="fa fa-sign-out" style="font-size:18px;"> Logout</i></button>
            </form>
        </div>

        <div class="nav-side-menu">
            <center>
                <ul class="drawer">
                    <li> <a href="changePassword.jsp" style="text-decoration:none;"> <i class="fa fa-edit"></i> <span>Change Password</span> </a>     
                    <li> <a href="customerManagement.jsp" style="text-decoration:none;"> <i class="fa fa-users"></i> <span>Customer Management</span> </a>
                    <li> <a href="#" style="text-decoration:none;"> <i class="fa fa-clipboard"></i> <span>Inventory Management</span> </a>    
                        <ul>
                            <li> <a href="inventoryManagement.jsp" style="text-decoration:none;"> <i class="fa fa-search-plus"></i> <span>Search Inventory</span> </a> </li>
                            <li> <a href="addInventory.jsp" style="text-decoration:none;"> <i class="fa fa-cart-plus"></i> <span>Add New Inventory</span> </a> </li>
                            <li> <a href="addInventoryQty.jsp" style="text-decoration:none;"> <i class="fa fa-qrcode"></i> <span>Add Inventory Quantity</span> </a> </li>
                        </ul>
                    <li> <a href="orderPicking.jsp" style="text-decoration:none;"> <i class="fa fa-archive"></i> <span>Order Picking</span> </a>   
                    <li> <a href="purchaseHistory.jsp" style="text-decoration:none;"> <i class="fa fa-book"></i> <span>Purchase History</span> </a>              
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