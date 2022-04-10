<%-- 
    Document   : adminName
    Created on : 14 Feb, 2022, 4:05:06 PM
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
            if(session.getAttribute("aid")==null)
            {
                response.sendRedirect("adminLogin.jsp");
            }
        %>
        <sql:setDataSource var="db" driver="com.mysql.jdbc.Driver" url="jdbc:mysql://localhost:3306/demo2?useSSL=false&allowPublicKeyRetrieval=true" user="siva" password="0000"/>
        <sql:query dataSource="${db}" var="profile">
            select adminName from admin where adminId=?
            <sql:param value="${sessionScope.aid}"/>
            
        </sql:query>
        <c:forEach var="row" items="${profile.rows}" varStatus="loop">
            ${row.adminName}
        </c:forEach>
            <script type="text/javascript" src="assets\js\noBack.js"></script>
    </body>
</html>
