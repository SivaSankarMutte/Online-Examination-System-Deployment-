<%-- 
    Document   : adminPasswordFailedToChange
    Created on : 3 Dec, 2021, 3:51:55 PM
    Author     : SIVASANKAR
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin Password Failed to Change</title>
        <link rel="icon" type="text/css" href="images/test.png">
    </head>
    <body>
        <% 
            if(session.getAttribute("aid")==null)
            {
                response.sendRedirect("adminLogin.jsp");
            }
        %>
        <h1>Admin Password Failed to Change!</h1>
        <a href="updateAdminPasswordForm.jsp">Retry to change Password</a>
        <a href="adminHome.jsp">Admin Home</a>
        <script type="text/javascript" src="assets\js\noBack.js"></script>
    </body>
</html>
