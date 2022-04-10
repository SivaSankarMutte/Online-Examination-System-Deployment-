<%-- 
    Document   : examAddedToDB
    Created on : 2 Dec, 2021, 4:14:03 PM
    Author     : SIVASANKAR
--%>

<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Exam Added to DB</title>
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
        
        <sql:setDataSource var="db" driver="com.mysql.jdbc.Driver" url="jdbc:mysql://localhost:3306/demo2?useSSL=false&allowPublicKeyRetrieval=true" user="siva" password="0000"/>    
        <c:choose>
            <c:when test='${param.formNoOfQuestions=="" && param.formTotalMarks==""}'>
                <sql:update dataSource="${db}" var="add">
                    insert into exam(examName,facultyId,listName,startTime,endTime,loginTime,randomizeQuestions,randomizeOptions,mode,enableFeedbackForm,enableResultsToStudents) values(?,?,?,?,?,?,?,?,?,?,?)

                    <sql:param value="${param.formExamName}"/>
                    <sql:param value='${sessionScope.fid}'/>
                    <sql:param value="${param.formListName}"/>
                    <sql:param value="${param.formStartTime}"/>
                    <sql:param value='${param.formEndTime}'/>
                    <sql:param value='${param.formLoginTime}'/>
                    <sql:param value="${param.formRandomizeQuestions}"/>
                    <sql:param value="${param.formRandomizeOptions}"/>
                    <sql:param value='${param.formExamMode}'/>
                    <sql:param value='${param.formEnableFeedback}'/>
                    <sql:param value='${param.formEnableResults}'/>
                </sql:update>  
            </c:when>

            <c:when test='${param.formNoOfQuestions==""}'>
                <sql:update dataSource="${db}" var="add">
                    insert into exam(examName,facultyId,listName,startTime,endTime,loginTime,totalMarks,randomizeQuestions,randomizeOptions,mode,enableFeedbackForm,enableResultsToStudents) values(?,?,?,?,?,?,?,?,?,?,?,?)

                    <sql:param value="${param.formExamName}"/>
                    <sql:param value='${sessionScope.fid}'/>
                    <sql:param value="${param.formListName}"/>
                    <sql:param value="${param.formStartTime}"/>
                    <sql:param value='${param.formEndTime}'/>
                    <sql:param value='${param.formLoginTime}'/>
                    <sql:param value="${param.formTotalMarks}"/>
                    <sql:param value="${param.formRandomizeQuestions}"/>
                    <sql:param value="${param.formRandomizeOptions}"/>
                    <sql:param value='${param.formExamMode}'/>
                    <sql:param value='${param.formEnableFeedback}'/>
                    <sql:param value='${param.formEnableResults}'/>
                </sql:update>  
            </c:when>

            <c:when test='${param.formTotalMarks==""}'>
                <sql:update dataSource="${db}" var="add">
                    insert into exam(examName,facultyId,listName,noOfQuestions,startTime,endTime,loginTime,randomizeQuestions,randomizeOptions,mode,enableFeedbackForm,enableResultsToStudents) values(?,?,?,?,?,?,?,?,?,?,?,?)

                    <sql:param value="${param.formExamName}"/>
                    <sql:param value='${sessionScope.fid}'/>
                    <sql:param value="${param.formListName}"/>
                    <sql:param value='${param.formNoOfQuestions}'/>
                    <sql:param value="${param.formStartTime}"/>
                    <sql:param value='${param.formEndTime}'/>
                    <sql:param value='${param.formLoginTime}'/>
                    <sql:param value="${param.formRandomizeQuestions}"/>
                    <sql:param value="${param.formRandomizeOptions}"/>
                    <sql:param value='${param.formExamMode}'/>
                    <sql:param value='${param.formEnableFeedback}'/>
                    <sql:param value='${param.formEnableResults}'/>
                    
                </sql:update>  
            </c:when>

            <c:otherwise>
                <sql:update dataSource="${db}" var="add">
                    insert into exam(examName,facultyId,listName,noOfQuestions,startTime,endTime,loginTime,totalMarks,randomizeQuestions,randomizeOptions,mode,enableFeedbackForm,enableResultsToStudents) values(?,?,?,?,?,?,?,?,?,?,?,?,?)

                    <sql:param value="${param.formExamName}"/>
                    <sql:param value='${sessionScope.fid}'/>
                    <sql:param value="${param.formListName}"/>
                    <sql:param value='${param.formNoOfQuestions}'/>
                    <sql:param value="${param.formStartTime}"/>
                    <sql:param value='${param.formEndTime}'/>
                    <sql:param value='${param.formLoginTime}'/>
                    <sql:param value="${param.formTotalMarks}"/>
                    <sql:param value="${param.formRandomizeQuestions}"/>
                    <sql:param value="${param.formRandomizeOptions}"/>
                    <sql:param value='${param.formExamMode}'/>
                    <sql:param value='${param.formEnableFeedback}'/>
                    <sql:param value='${param.formEnableResults}'/>
                </sql:update>  
            </c:otherwise>
        </c:choose>
                  
        <c:choose>
            <c:when test='${add>=1}'>
                <c:redirect url="facultyHome.jsp"/>
            </c:when>

            <c:otherwise>
                <c:redirect url="examFailedToCreate.jsp"/>
            </c:otherwise>
        </c:choose>
                    <script type="text/javascript" src="assets\js\noBack.js"></script>
    </body> 
</html>
