<%-- 
    Document   : superAdminName
    Created on : 14 Feb, 2022, 4:46:21 PM
    Author     : SIVASANKAR
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    </head>
    <body>
        <% 
            if(session.getAttribute("sid")==null)
            {
                response.sendRedirect("superAdminLogin.jsp");
            }
        %>
        <sql:setDataSource var="db" driver="com.mysql.jdbc.Driver" url="jdbc:mysql://localhost:3306/demo2?useSSL=false&allowPublicKeyRetrieval=true" user="siva" password="0000"/>
        <sql:query dataSource="${db}" var="profile">
            select superAdminName from superAdmin where superAdminId=?
            <sql:param value="${sessionScope.sid}"/>
            
        </sql:query>
        <c:forEach var="row" items="${profile.rows}" varStatus="loop">
            ${row.superAdminName}
        </c:forEach>
            <script type="text/javascript" src="assets\js\noBack.js"></script>
    </body>
</html>
