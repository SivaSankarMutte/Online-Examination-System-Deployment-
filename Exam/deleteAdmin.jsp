<%-- 
    Document   : deleteAdmin
    Created on : 28 Nov, 2021, 5:39:27 PM
    Author     : SIVASANKAR
--%>

<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<html>
    <head>
        <title>Deleting Admin</title>
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
        <jsp:include page="base.jsp"/>
        <sql:setDataSource var="db" driver="com.mysql.jdbc.Driver" url="jdbc:mysql://localhost:3306/demo2?useSSL=false&allowPublicKeyRetrieval=true" user="siva" password="0000"/>
        
        <sql:update dataSource="${db}" var="count">  
            DELETE from admin where adminId=?
            <sql:param value="${param.adminId}"/>
        </sql:update>
        <c:if test="${count>=1}">
            <c:redirect url="viewAdmins.jsp"/>
        </c:if>
           
    </body>
    <script type="text/javascript" src="assets\js\noBack.js"></script>
</html>

