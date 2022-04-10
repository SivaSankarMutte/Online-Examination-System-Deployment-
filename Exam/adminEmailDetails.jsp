<%-- 
    Document   : adminEmailDetails
    Created on : 12 Dec, 2021, 6:47:27 PM
    Author     : SIVASANKAR
--%>

<%@page import="java.sql.*"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Email details to send Mails</title>
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
        
        <sql:setDataSource var="db" driver="com.mysql.jdbc.Driver" url="jdbc:mysql://localhost:3306/demo2?useSSL=false&allowPublicKeyRetrieval=true" user="siva" password="0000"/>
        <sql:query dataSource="${db}" var="result">
            select email from admin where adminId=?;
            <sql:param value="${sessionScope.aid}"/>
        </sql:query>
            
        <c:forEach var="row" items="${result.rows}">
            <div class="container mt-5">
                <div class="jumbotron bg-info">
                    <form method="post" action="uploadFacultyFile.jsp" class="form-control">
                        <fieldset>
                            <legend class="bg-dark text-light"><h2>Enter Admin Email details to send Mails to Faculty</h2></legend>
                                
                                <input type="text" placeholder="Enter your Email to send Mails" class="form-control my-2 text-light" style="background-color: darkgreen" name="adminEmail" value="${row.email}" required>
                                <input type="password" placeholder="Enter your Password to send Mails" class="form-control my-2 text-light" style="background-color: darkgreen" name="adminEmailPassword" required>
                                <div class="row">
                                    <div class="col">
                                        <a href="adminHome.jsp" class="btn btn-info form-control my-2">Back</a>
                                    </div>
                                    <div class="col">
                                        <input type="submit" value="Next" class="form-control my-2 btn btn-success"/>
                                    </div>
                                </div> 
                        </fieldset> 
                    </form>
                </div>
            </div>
        </c:forEach>
        
        <script type="text/javascript" src="assets\js\noBack.js"></script>
    </body>
</html>
