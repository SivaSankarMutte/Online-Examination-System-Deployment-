<%-- 
    Document   : updateSuperAdminProfileToDB
    Created on : 10 Feb, 2022, 12:09:01 AM
    Author     : SIVASANKAR
--%>

<!DOCTYPE html>
<!--
To change this license header, choose License Headers in Project Properties.
To change this template file, choose Tools | Templates
and open the template in the editor.
-->

<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<html>
    <head>
        <title>Updating SuperAdmin</title>
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
            String password=cipher.AES.encrypt(request.getParameter("formSuperAdminPassword"));
            request.setAttribute("password", password);
        %>
        <jsp:include page="base.jsp"/>
        <sql:setDataSource var="db" driver="com.mysql.jdbc.Driver" url="jdbc:mysql://localhost:3306/demo2?useSSL=false&allowPublicKeyRetrieval=true" user="siva" password="0000"/>
        <sql:update dataSource="${db}" var="add">  
            update superadmin set superAdminName=?,email=?,password=? where superAdminId=?
            <sql:param value="${param.formSuperAdminName}"/>
            <sql:param value="${param.formSuperAdminEmail}"/>
            <sql:param value="${requestScope['password']}"/>
            <sql:param value="${sessionScope.sid}"/>
        </sql:update>  
        
        <c:choose>
            <c:when test="${add>=1}">
                <c:redirect url="superAdminHome.jsp"/>
            </c:when>
            <c:otherwise>
                <c:redirect url="superAdminProfileFailedtoUpdate.jsp"/>
            </c:otherwise>
        </c:choose>
           <script type="text/javascript" src="assets\js\noBack.js"></script>
    </body>
</html>
