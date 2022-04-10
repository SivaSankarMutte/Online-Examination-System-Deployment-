<%-- 
    Document   : saveAdminPassword
    Created on : 22 Feb, 2022, 4:28:36 PM
    Author     : SIVASANKAR
--%>

<!DOCTYPE html>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Save Admin Password</title>
    </head>
    <body>
        <% if(session.getAttribute("otp").equals(request.getParameter("formOtp")))
        { 
            String password=cipher.AES.encrypt(request.getParameter("formPassword"));
            request.setAttribute("password", password);
        %>
            <sql:setDataSource var="db" driver="com.mysql.jdbc.Driver" url="jdbc:mysql://localhost:3306/demo2?useSSL=false&allowPublicKeyRetrieval=true" user="siva" password="0000"/>
            <sql:update dataSource="${db}" var="add">  
                update admin set password=? where email like ?
                <sql:param value="${requestScope['password']}"/>
                <sql:param value='${sessionScope.email}'/>
            </sql:update>  
        <c:choose>
            <c:when test="${add>=1}">
                <% session.removeAttribute("email"); %>
                <% session.removeAttribute("otp"); %>
                <c:redirect url="adminPasswordResetSuccess.jsp"/>
            </c:when>
            
            <c:otherwise>
                <c:redirect url="adminPasswordResetFailed.jsp"/>
            </c:otherwise>
        </c:choose>
     <% }
    else{ 
        out.print("Yes");
        out.print(session.getAttribute("otp"));
        out.print(request.getParameter("formOtp"));
    }%>
    <script type="text/javascript" src="assets\js\noBack.js"></script>
    </body>
</html>
