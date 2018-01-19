<link href="//maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css" rel="stylesheet">
<link rel="stylesheet" href="css/master.css">
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
                    String[] nameArr = username.split("\\.");
                    String name = nameArr[0].toUpperCase();

                %>

                <h5>Current User: <%=name%> </h5>
            </div>
            <i class="fa fa-bars fa-2x toggle-btn" data-toggle="collapse" data-target="#menu-content"></i>

            <div class="menu-list">

                <ul id="menu-content" class="menu-content collapse out">              
                    <li data-toggle="collapse" data-target="#service" class="collapsed">
                        <a href="customerManagement.jsp"><i class="fa fa-user fa-lg"></i> Customer Management</a>


                    <li data-toggle="collapse" data-target="#service" class="collapsed">
                        <a href="inventoryManagement.jsp"><i class="fa fa-inbox  fa-lg"></i> Inventory Management</a>
                    </li>   

                    <li>
                        <%
                            if (username.equals("qingyang")) {%>
                                 <a href="user.jsp" id="user">
                            <i class="fa fa-users fa-lg"></i> Users
                        </a>

                        <% }%>   


                       
                    </li>
                </ul>
                <br>
                <br>
                <form action="logout.jsp">
                    <div class="form-group input-group">
                        <input type="submit" class="btn btn-default btn-lg" name="logout" value="Logout">

                    </div>
                </form>
            </div>
        </div>
    </body>
</html>