<%-- 
    Document   : updateSuperAdminDetails
    Created on : 22 Jan, 2022, 10:39:20 AM
    Author     : SIVASANKAR
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<html>
    <head>
        <title>Updating SuperAdmin Details</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" type="text/css" href="bootstrap.min.css">
        <link rel="icon" type="text/css" href="images/test.png">
    </head>
        
    <body>
        <% 
            if(session.getAttribute("sid")==null)
            {
                response.sendRedirect("superAdminLogin.jsp");
            }
        %>
        <sql:setDataSource var="db" driver="com.mysql.jdbc.Driver" url="jdbc:mysql://localhost:3306/demo2?useSSL=false&allowPublicKeyRetrieval=true" user="siva" password="0000"/>
        
        <sql:query dataSource="${db}" var="rs">  
            SELECT * from superAdmin where superAdminId=?
            <sql:param value="${sessionScope.sid}"/>
        </sql:query>  
        <div class="container mt-5">
            <div class="jumbotron bg-info">
                <form action="updateSuperAdminDetailsToDB.jsp" method="post" class="form-control">
                    <fieldset>
                        <legend class="bg-dark text-light"> <h2>Changing SuperAdmin Details</h2></legend>
                        <c:forEach items="${rs.rows}" var="row">
                            <input type="email" value="${row.email}" placeholder="Enter New Email" class="form-control my-2" name="formNewEmail">
                            <input type="password" value="${row.password}" placeholder="Enter New Password" class="form-control my-2" name="formNewPsw">
                        </c:forEach>

                        <div class="row">
                            <div class="col">
                                <a href="superAdminHome.jsp" class="btn btn-info form-control my-2">Back</a>
                            </div>
                            <div class="col">
                                <input type="submit" value="Change" class="form-control my-2 btn btn-success"/>
                            </div>
                        </div> 
                    </fieldset>
                </form>
            </div>
        </div>
            <script type="text/javascript" src="assets\js\noBack.js"></script>
    </body>
</html>

