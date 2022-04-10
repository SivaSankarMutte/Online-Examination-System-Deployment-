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
        <title>Updating Admin</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" type="text/css" href="bootstrap.min.css">
        <link rel="icon" type="text/css" href="images/test.png">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    </head>
    <body>
        <% 
            if(session.getAttribute("sid")==null)
            {
                response.sendRedirect("superAdminLogin.jsp");
            }
        %>
        <jsp:include page="base.jsp"/>
        
        <c:set var="id" value="${param.formAdminId}"/>
        <c:set var="nm" value="${param.formAdminName}"/>
        <c:set var="em" value="${param.formAdminEmail}"/>
        <c:set var="dpt" value="${param.formAdminDept}"/>
       
        <sql:setDataSource var="db" driver="com.mysql.jdbc.Driver" url="jdbc:mysql://localhost:3306/demo2?useSSL=false&allowPublicKeyRetrieval=true" user="siva" password="0000"/>
        <sql:update dataSource="${db}" var="add">  
            update admin set adminName=?,email=?,department=? where adminId=?
            <sql:param value="${nm}"/>
            <sql:param value='${em}'/>
            <sql:param value='${dpt}'/>
            <sql:param value='${id}'/>
        </sql:update>  
            
        <c:choose>
            <c:when test="${add>=1}">
                <% session.removeAttribute("sessionAdminId"); %>
                <c:redirect url="viewAdmins.jsp"/>
            </c:when>
            
            <c:otherwise>
                <c:redirect url="adminFailedToUpdate.jsp"/>
                <div class="alert alert-dismissible bg-success fade show" id="dismiss">
                    <div><strong>Failed! </strong>Admin details failed to update</div>
                    <a href="#" class="close" data-dismiss="alert" id="x" aria-label="close">&times;</a>
                </div>
                
                <h1>Faculty Failed to Update!</h1>
                
                <form method="post" action="updateAdmin.jsp">
                    <input type="hidden" name="adminId" value="${param.formAdminId}">
                    <input type="submit" value="Retry" class="btn btn-outline-warning my-2">
                </form>
                
                <a href="viewAdmins.jsp" class="btn btn-outline-warning my-2">Back To view Admin Rows</a>
            </c:otherwise>
        </c:choose>
           <script type="text/javascript" src="assets\js\noBack.js"></script>
    </body>
</html>

