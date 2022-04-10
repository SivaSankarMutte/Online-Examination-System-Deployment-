<%-- 
    Document   : studentEmailAlreadyInserted
    Created on : 13 Dec, 2021, 12:37:52 PM
    Author     : SIVASANKAR
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Student Email Already Inserted</title>
        <link rel="stylesheet" type="text/css" href="bootstrap.min.css">
        <link rel="icon" type="text/css" href="images/test.png">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    </head>
    <body>
        <% 
            if(session.getAttribute("fid")==null)
            {
                response.sendRedirect("facultyLogin.jsp");
            }
        %>
        <h1>Student Email Already Inserted</h1>
        <div class="alert alert-dismissible bg-danger fade show" id="dismiss">
            <div><strong>Failed! </strong>student email already inserted</div>
            <a href="#" class="close" data-dismiss="alert" id="x" aria-label="close">&times;</a>
        </div>
        <a href="addStudent.jsp" class="btn btn-info form-control my-2">Retry to add a Student</a>
        <a href="adminEmailDetails.jsp" class="btn btn-info form-control my-2">Retry to upload Faculty CSV File</a>
        <a href="facultyHome.jsp" class="btn btn-info form-control my-2">Back to Home</a>
        <script type="text/javascript" src="assets\js\noBack.js"></script>
    </body>
</html>
