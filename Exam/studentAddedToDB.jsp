<%-- 
    Document   : studentAddedToDB
    Created on : 13 Dec, 2021, 12:24:27 PM
    Author     : SIVASANKAR
--%>

<%@page import="java.io.*,java.sql.*" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Student Adding to DB</title>
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
        <jsp:include page="base.jsp"/>
        <%
            String studentRegdno=request.getParameter("formStudentRegdno");
            String studentEmail=request.getParameter("formStudentEmail");
            String studentName=request.getParameter("formStudentName");
            String facultyId=(String)session.getAttribute("fid");
            String listName=request.getParameter("formListName");
            try
            {
                Class.forName("com.mysql.jdbc.Driver");
                String url="jdbc:mysql://localhost:3306/demo2?useSSL=false&allowPublicKeyRetrieval=true";
                String username="siva";
                String password="0000";
                Connection con=DriverManager.getConnection(url,username,password); 
               
                String queryString="insert into students"+facultyId+"(listName,studentName,regdNo,studentEmail) values(?,?,?,?)";
                PreparedStatement pstatement = con.prepareStatement(queryString);
                pstatement.setString(1, listName);
                pstatement.setString(2, studentName);
                pstatement.setString(3, studentRegdno);
                pstatement.setString(4, studentEmail);
                pstatement.executeUpdate();
            }
            catch(Exception e)
            { %>
            <c:redirect url="studentEmailAlreadyInserted.jsp"/>
                <%
            }
        %>
        <div class="alert alert-dismissible bg-success fade show" id="dismiss">
            <div><strong>Success! </strong>Student added Successfully</div>
            <a href="#" class="close" data-dismiss="alert" id="x" aria-label="close">&times;</a>
        </div>
        <c:redirect url="viewStudents.jsp"/>
        <a href="viewStudents.jsp">List all Students</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <a href="facultyHome.jsp" class="btn btn-info form-control my-2">Back to Home</a>
        <script type="text/javascript" src="assets\js\noBack.js"></script>
    </body>
</html>




