<%-- 
    Document   : examCreatedSuccess
    Created on : 2 Dec, 2021, 8:29:31 PM
    Author     : SIVASANKAR
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Exam Created Successfully</title>
        <link rel="stylesheet" type="text/css" href="bootstrap.min.css">
        <link rel="icon" type="text/css" href="images/test.png">
    </head>
    <body>
        <% 
            if(session.getAttribute("fid")==null)
            {
                response.sendRedirect("facultyLogin.jsp");
            }
        %>
        <jsp:include page="base.jsp"/>
        <h1>Exam Created Successfully</h1>
        <a href="facultyHome.jsp" class="btn btn-success">Add Questions the Exam</a>
        <a href="facultyHome.jsp" class="btn btn-dark">Back</a>
        <script type="text/javascript" src="assets\js\noBack.js"></script>
    </body>
</html>
