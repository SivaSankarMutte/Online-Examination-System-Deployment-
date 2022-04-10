<%-- 
    Document   : questionFailedToInsert
    Created on : 3 Dec, 2021, 12:46:16 PM
    Author     : SIVASANKAR
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Question failed to INSERT</title>
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
        <h1>Question failed to INSERT!</h1>
        <a href="addQuestionForm.jsp" class="btn form-control btn-warning my-2">Try Again to add a Question</a>
        <a href="facultyHome.jsp" class="btn form-control btn-dark my-2">Back To Home</a>
        <script type="text/javascript" src="assets\js\noBack.js"></script>
    </body>
</html>
