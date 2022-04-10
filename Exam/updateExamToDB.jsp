<%-- 
    Document   : updateExamToDB
    Created on : 27 Jan, 2022, 6:33:32 PM
    Author     : SIVASANKAR
--%>



<!DOCTYPE html>
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
            update exam set examName=?,facultyId=?,listName=?,noOfQuestions=?,startTime=?,endTime=?,loginTime=?,totalMarks=?,randomizeQuestions=?,randomizeOptions=?,mode=?,enableFeedbackForm=?,enableResultsToStudents=? where examId=?
            <sql:param value="${param.formExamName}"/>
            <sql:param value="${sessionScope.fid}"/>
            <sql:param value='${param.formListName}'/>
            <sql:param value='${param.formNoOfQuestions}'/>
            <sql:param value='${param.formStartTime}'/>
            <sql:param value='${param.formEndTime}'/>
            <sql:param value='${param.formLoginTime}'/>
            <sql:param value='${param.formTotalMarks}'/>
            <sql:param value='${param.formRandomizeQuestions}'/>
            <sql:param value='${param.formRandomizeOptions}'/>
            <sql:param value='${param.formExamMode}'/>
            <sql:param value='${param.formEnableFeedbackForm}'/>
            <sql:param value='${param.formEnableResults}'/>
            <sql:param value='${sessionScope.eid}'/>
        </sql:update>  
        <c:choose>
            <c:when test="${add>=1}">
                <% session.removeAttribute("sessionStudentId"); %>
                <c:redirect url="addQuestionForm.jsp"/>
            </c:when>
            
            <c:otherwise>
                <c:redirect url="examFailedToUpdate.jsp"/>
            </c:otherwise>
        </c:choose>
            <script type="text/javascript" src="assets\js\noBack.js"></script>
    </body>
</html>

