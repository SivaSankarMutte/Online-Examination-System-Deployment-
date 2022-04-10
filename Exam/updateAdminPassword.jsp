<%-- 
    Document   : updateAdminPassword
    Created on : 3 Dec, 2021, 2:34:48 PM
    Author     : SIVASANKAR
--%>

<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<html>
    <head>
        <title>Updating Admin Password</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
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
        
        <sql:setDataSource var="db" driver="com.mysql.jdbc.Driver" url="jdbc:mysql://localhost:3306/demo2?useSSL=false&allowPublicKeyRetrieval=true" user="siva" password="0000"/>
        
        <sql:query dataSource="${db}" var="result">  
            select password from admin where adminId=?
            <sql:param value="${sessionScope.aid}"/>
        </sql:query>
        
        <c:forEach var="row" items="${result.rows}">
            <c:choose>
                <c:when test="${row.password==param.formOldPsw && param.formNewPsw==param.formRePsw}">
                    <sql:update dataSource="${db}" var="add">  
                        update admin set password=? where adminId=?
                        <sql:param value="${param.formNewPsw}"/>
                        <sql:param value="${sessionScope.aid}"/>
                    </sql:update>
                        <c:redirect url="adminPasswordChangedSuccess.jsp"/>
                </c:when>
                
                <c:otherwise>
                    <c:redirect url="adminPasswordFailedToChange.jsp"/>
                </c:otherwise>
                
            </c:choose>
        </c:forEach>     
                        <script type="text/javascript" src="assets\js\noBack.js"></script>
    </body>
</html>

