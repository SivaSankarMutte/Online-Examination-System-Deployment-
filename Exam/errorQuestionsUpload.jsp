<%-- 
    Document   : errorQuestionsUpload
    Created on : 15 Jan, 2022, 1:48:52 PM
    Author     : SIVASANKAR
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Questions Uploading Error</title>
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
        <h1>File Uploading Failed</h1>
        <div>Retry please, there is an error while uploading Questions CSV file</div>
        
        
        <jsp:include page="addQuestionForm.jsp"/>
        <script type="text/javascript" src="assets\js\noBack.js"></script>
    </body>
</html>
