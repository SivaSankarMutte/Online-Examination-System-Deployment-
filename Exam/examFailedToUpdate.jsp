<%-- 
    Document   : examFailedToUpdate
    Created on : 27 Jan, 2022, 7:05:21 PM
    Author     : SIVASANKAR
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Exam Failed to Update</title>
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
        <h1>Exam Failed to Update!</h1>
       
        <a href="addQuestionsForm.jsp" class="btn btn-outline-warning my-2">Back</a>
        <script type="text/javascript" src="assets\js\noBack.js"></script>
    </body>
</html>
