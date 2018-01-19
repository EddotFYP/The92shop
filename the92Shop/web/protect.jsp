<%-- 
    Document   : protect
    Created on : 22 Sep, 2017, 9:59:31 AM
    Author     : jaclyn
--%>

<%
    if(session.getAttribute("user") == null){
        response.sendRedirect("");
        return;
    }
%>