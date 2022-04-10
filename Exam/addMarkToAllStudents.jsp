<%-- 
    Document   : addMarkToAllStudents
    Created on : 16 Jan, 2022, 2:24:16 PM
    Author     : SIVASANKAR
--%>

<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<html>
    <head>
        <title>Add Mark</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" type="text/css" href="bootstrap.min.css">
        <link rel="icon" type="text/css" href="images/test.png">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    </head>
    <body>
        <% 
            if(session.getAttribute("fid")==null)
            {
                response.sendRedirect("facultyLogin.jsp");
            }
        %>
        <jsp:include page="base.jsp"/>
        
        <%
            try
            {
                String eid=session.getAttribute("eid").toString();
                int qid=Integer.parseInt(request.getParameter("qid").toString());
                Class.forName("com.mysql.jdbc.Driver");
                Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/demo2?useSSL=false&allowPublicKeyRetrieval=true","siva","0000");   

                String sqlUpdate="Update examSpecialTable"+eid+ " set marksObtained=(select questionMarks from questions"+session.getAttribute("fid").toString()+" where questionId=?) where qid=?";
                PreparedStatement ps = con.prepareStatement(sqlUpdate);
                ps.setInt(1,qid);
                ps.setInt(2,qid);
                ps.executeUpdate();
               
                String getRegdNos="select distinct(regdNo) from examSpecialTable"+eid+ " where qid=?" ;
                PreparedStatement ps2=con.prepareStatement(getRegdNos);
                ps2.setInt(1,qid);
                ResultSet rs2=ps2.executeQuery();
                String regdNo;
                while(rs2.next())
                {
                    regdNo=rs2.getString(1);
                    String resultsUpdate="update results"+eid+ " set totalMarks=(select sum(marksObtained) from examSpecialTable"+eid+" where regdNo=?) where regdNo=?";
                    PreparedStatement ps3 = con.prepareStatement(resultsUpdate);
                    ps3.setString(1,regdNo);
                    ps3.setString(2,regdNo);
                    ps3.executeUpdate();
                    
                }

            }
            catch(Exception e)
            {
                out.println("Marks not added");
                out.println("Database connection Error");
            }
            response.sendRedirect("eachQuestionStatistics.jsp");
        %>
        
        <script type="text/javascript" src="assets\js\noBack.js"></script>
    </body>
</html>

