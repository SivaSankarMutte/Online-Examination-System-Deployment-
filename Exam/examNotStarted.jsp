<%-- 
    Document   : examNotStarted
    Created on : 4 Apr, 2022, 1:02:15 PM
    Author     : SIVASANKAR
--%>

<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Je</title>
    </head>
    <body>
        <c:out value="${sessionScope.startTime}"/>
        <c:out value="${sessionScope.endTime}"/>
        <script type="text/javascript" src="assets\js\noBack.js"></script>
    </body>
</html>
