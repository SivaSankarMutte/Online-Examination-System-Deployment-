<%-- 
    Document   : feedbackSubmission
    Created on : 27 Jan, 2022, 4:42:43 PM
    Author     : SIVASANKAR
--%>

<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>FeedBack Submission</title>
        <link rel="icon" type="text/css" href="images/test.png">
    </head>
    <body>
        <c:if test='${not empty param.formFeedback && fn:trim(param.formFeedback)!=""}'>
            <sql:setDataSource var="db" driver="com.mysql.jdbc.Driver" url="jdbc:mysql://localhost:3306/demo2?useSSL=false&allowPublicKeyRetrieval=true" user="siva" password="0000"/>    
            <sql:update dataSource="${db}" var="add">
                insert into feedback(facultyId,examId,feedbackMessage,studentRegdNo) values(?,?,?,?)
                    <sql:param value="${sessionScope.facultyId}"/>
                    <sql:param value='${sessionScope.fexamId}'/>
                    <sql:param value="${param.formFeedback}"/>
                    <sql:param value="${sessionScope.fregdNo}"/>
            </sql:update>  
        </c:if>
        <c:redirect url="closeExam.jsp"/>
        <script type="text/javascript" src="assets\js\noBack.js"></script>
    </body>
</html>
