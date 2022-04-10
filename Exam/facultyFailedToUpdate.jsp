<%-- 
    Document   : facultyFailedToUpdate
    Created on : 3 Dec, 2021, 8:55:09 PM
    Author     : SIVASANKAR
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Faculty Failed to Update</title>
        <link rel="stylesheet" type="text/css" href="bootstrap.min.css">
        <link rel="icon" type="text/css" href="images/test.png">
    </head>
    <body>
        <% 
            if(session.getAttribute("aid")==null)
            {
                response.sendRedirect("adminLogin.jsp");
            }
        %>
        <jsp:include page="base.jsp"/>
        <h1>Faculty Failed to Update!</h1>
        <a href="updateFaculty.jsp?facultyIdurl=${sessionScope.sessionFacultyId}" class="btn btn-outline-warning my-2">Retry to Update Faculty</a>
        <% session.removeAttribute("sessionFacultyId"); %>
        <a href="viewFaculty.jsp" class="btn btn-outline-warning my-2">Back To view Faculty Rows</a>
        <script type="text/javascript" src="assets\js\noBack.js"></script>
    </body>
</html>
