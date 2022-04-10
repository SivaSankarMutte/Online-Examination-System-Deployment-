<%-- 
    Document   : adminFailedToUpdate
    Created on : 3 Dec, 2021, 11:02:59 AM
    Author     : SIVASANKAR
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin Failed to Update</title>
        <link rel="stylesheet" type="text/css" href="bootstrap.min.css">
        <link rel="icon" type="text/css" href="images/test.png">
    </head>
    <body>
        <% 
            if(session.getAttribute("sid")==null)
            {
                response.sendRedirect("superAdminLogin.jsp");
            }
        %>
        <jsp:include page="base.jsp"/>
        <h1>Faculty Failed to Update!</h1>
        <a href="updateAdmin.jsp?adminIdurl=${sessionScope.sessionAdminId}" class="btn btn-outline-warning my-2">Retry to Update Admin</a>
        <% session.removeAttribute("sessionAdminId"); %>
        <a href="viewAdmins.jsp" class="btn btn-outline-warning my-2">Back To view Admin Rows</a>
        <script type="text/javascript" src="assets\js\noBack.js"></script>
    </body>
</html>
