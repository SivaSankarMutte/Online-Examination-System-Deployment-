<%-- 
    Document   : facultyName.jsp
    Created on : 10 Feb, 2022, 5:20:29 AM
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
            if(session.getAttribute("fid")==null)
            {
                response.sendRedirect("facultyLogin.jsp");
            }
        %>
        <sql:setDataSource var="db" driver="com.mysql.jdbc.Driver" url="jdbc:mysql://localhost:3306/demo2?useSSL=false&allowPublicKeyRetrieval=true" user="siva" password="0000"/>
        <sql:query dataSource="${db}" var="profile">
            select facultyName from faculty where facultyId=?
            <sql:param value="${sessionScope.fid}"/>
            
        </sql:query>
        <c:forEach var="row" items="${profile.rows}" varStatus="loop">
            ${row.facultyName}
        </c:forEach>
            <script type="text/javascript" src="assets\js\noBack.js"></script>
    </body>
</html>
