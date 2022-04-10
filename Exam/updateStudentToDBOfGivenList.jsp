<%-- 
    Document   : updateStudentToDBOfGivenList
    Created on : 5 Apr, 2022, 3:14:14 PM
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
        <title>Updating Student</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
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
        <%
            HttpSession ses1=request.getSession();
            ses1.setAttribute("studentsTableName", "students"+session.getAttribute("fid").toString());
        %>
        <jsp:include page="base.jsp"/>
        
        <sql:setDataSource var="db" driver="com.mysql.jdbc.Driver" url="jdbc:mysql://localhost:3306/demo2?useSSL=false&allowPublicKeyRetrieval=true" user="siva" password="0000"/>
        <sql:update dataSource="${db}" var="add">  
            update ${sessionScope.studentsTableName} set studentName=?,regdNo=?,studentEmail=? where studentId=?
            <sql:param value="${param.formStudentName}"/>
            <sql:param value="${param.formRegdNo}"/>
            <sql:param value='${param.formStudentEmail}'/>
            
            <sql:param value='${sessionScope.sessionStudentId}'/>
        </sql:update>  
        <c:choose>
            <c:when test="${add>=1}">
                <% session.removeAttribute("sessionStudentId"); %>
                <c:redirect url="viewStudentsOfGivenList.jsp"/>
            </c:when>
            
            <c:otherwise>
                <c:redirect url="studentFailedToUpdateOfGivenList.jsp"/>
            </c:otherwise>
        </c:choose>
            <script type="text/javascript" src="assets\js\noBack.js"></script>
    </body>
</html>

