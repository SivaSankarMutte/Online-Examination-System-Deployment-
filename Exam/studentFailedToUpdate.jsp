

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Student Failed to Update</title>
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
        <h1>Faculty Failed to Update!</h1>
        <a href="updateStudent.jsp?studentIdurl=${sessionScope.sessionStudentId}" class="btn btn-outline-warning my-2">Retry to Update Student</a>
        <% session.removeAttribute("sessionStudentId"); %>
        <a href="viewStudents.jsp" class="btn btn-outline-warning my-2">Back To view Student Rows</a>
        <script type="text/javascript" src="assets\js\noBack.js"></script>
    </body>
</html>
