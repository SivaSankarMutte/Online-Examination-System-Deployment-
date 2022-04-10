<%-- 
    Document   : updateFacultyToDB
    Created on : 1 Dec, 2021, 7:04:46 PM
    Author     : SIVASANKAR
--%>

<!DOCTYPE html>
<!--
To change this license header, choose License Headers in Project Properties.
To change this template file, choose Tools | Templates
and open the template in the editor.
-->

<%@page import="java.sql.*"%>
<%@page import="java.io.*,java.sql.*,java.util.*"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<html>
    <head>
        <title>Updating Faculty</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" type="text/css" href="bootstrap.min.css">
        <link rel="icon" type="text/css" href="images/test.png">
    </head>
    
        <% 
            if(session.getAttribute("aid")==null)
            {
                response.sendRedirect("adminLogin.jsp");
            }
        %>
        <jsp:include page="base.jsp"/>
        
        <sql:setDataSource var="db" driver="com.mysql.jdbc.Driver" url="jdbc:mysql://localhost:3306/demo2?useSSL=false&allowPublicKeyRetrieval=true" user="siva" password="0000"/>
        <sql:update dataSource="${db}" var="add">  
            update faculty set facultyName=?,email=? where facultyId=?
            <sql:param value="${param.formFacultyName}"/>
            <sql:param value="${param.formFacultyEmail}"/>
            
            <sql:param value="${sessionScope.sessionFacultyId}"/>
        </sql:update>  
        <c:choose>
            <c:when test="${add>=1}">
                <% session.removeAttribute("sessionFacultyId"); %>
                <c:redirect url="viewFaculty.jsp"/>
            </c:when>
            
            <c:otherwise>
                <c:redirect url="facultyFailedToUpdate.jsp"/>
            </c:otherwise>
        </c:choose>
    <script type="text/javascript" src="assets\js\noBack.js"></script>
</html>

