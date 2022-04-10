<%-- 
    Document   : errorAdminsUpload
    Created on : 1 Dec, 2021, 4:46:49 PM
    Author     : SIVASANKAR
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin Uploading Error</title>
        <link rel="icon" type="text/css" href="images/test.png">
    </head>
    <body>
        <% 
            if(session.getAttribute("sid")==null)
            {
                response.sendRedirect("superAdminLogin.jsp");
            }
        %>
        <div class="bg-danger">
            <h1>File Uploading Failed</h1>
            <div>Given File may contains null values or emails are not unique</div>
        </div>
        
        
        <jsp:include page="viewAdmins.jsp"/>
        <script type="text/javascript" src="assets\js\noBack.js"></script>
    </body>
</html>
