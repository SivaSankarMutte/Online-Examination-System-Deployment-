<%-- 
    Document   : studentAddedToListAndExamLinkSend
    Created on : 26 Jan, 2022, 1:32:32 PM
    Author     : SIVASANKAR
--%>


<%@page import="java.io.*,java.sql.*" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Student Adding to DB and Exam Link Sending</title>
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
            String examId=(String)session.getAttribute("eid");
            String facultyId=(String)session.getAttribute("fid");
            String studentRegdno=request.getParameter("formStudentRegdno");
            String studentEmail=request.getParameter("formStudentEmail");
            String studentName=request.getParameter("formStudentName");
            try
            {
                Class.forName("com.mysql.jdbc.Driver");
                String url="jdbc:mysql://localhost:3306/demo2?useSSL=false&allowPublicKeyRetrieval=true";
                String username="siva";
                String password="0000";
                Connection con=DriverManager.getConnection(url,username,password); 
               
                String queryString1="select listName from exam where examId=?";
                PreparedStatement pstatement1 = con.prepareStatement(queryString1);
                pstatement1.setString(1,examId);
                ResultSet rs1=pstatement1.executeQuery();
                
                session.setAttribute("regdNo", studentRegdno);
                session.setAttribute("sEmail",studentEmail);
                
                while(rs1.next())
                {
                    if(studentName==null)
                    {
                        String listName=rs1.getString(1);
                        String queryString2="insert into students"+facultyId+"(listName,regdNo,studentEmail) values(?,?,?)";
                        PreparedStatement pstatement2 = con.prepareStatement(queryString2);
                        
                        pstatement2.setString(1, listName);
                        pstatement2.setString(2, studentRegdno);
                        pstatement2.setString(3, studentEmail);
                        pstatement2.executeUpdate();
                        
                    }
                    else
                    {
                        String listName=rs1.getString(1);
                        String queryString2="insert into students"+facultyId+"(listName,studentName,regdNo,studentEmail) values(?,?,?,?)";
                        PreparedStatement pstatement2 = con.prepareStatement(queryString2);
                        pstatement2.setString(1, listName);
                        pstatement2.setString(2, studentName);
                        pstatement2.setString(3, studentRegdno);
                        pstatement2.setString(4, studentEmail);
                        pstatement2.executeUpdate();
                    }
                }
            }
            catch(Exception e)
            {
                %>
                    <c:redirect url="sendExamLinkToNewStudent"/>
                <%
            }
        %>
        <div class="alert alert-dismissible bg-success fade show" id="dismiss">
            <div><strong>Success! </strong>Student added Successfully</div>
            <a href="#" class="close" data-dismiss="alert" id="x" aria-label="close">&times;</a>
        </div>
        
        <c:redirect url="sendExamLinkToNewStudent"/>
        <script type="text/javascript" src="assets\js\noBack.js"></script>
    </body>
</html>




