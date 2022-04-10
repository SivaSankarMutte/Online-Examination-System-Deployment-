<%-- 
    Document   : image-process
    Created on : 19 Feb, 2022, 1:19:58 PM
    Author     : SIVASANKAR
--%>

<%@page import="java.io.InputStream"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.File"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Insert an Image into MySQL Database</title>
    </head>
    <body>
         <%

FileInputStream fis=null;
String fname=request.getParameter("fname");
String lname=request.getParameter("lname");
String email=request.getParameter("email");
String myloc=request.getParameter("myimg");
//out.print("First Name :"+fname+"myloc="+myloc);
File image= new File(myloc);
fis=new FileInputStream(image);
out.print(fis);

%>
    <script type="text/javascript" src="assets\js\noBack.js"></script>
    </body>
</html>