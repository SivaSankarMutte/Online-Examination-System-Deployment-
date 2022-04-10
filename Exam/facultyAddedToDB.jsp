<%-- 
    Document   : facultyAddedToDB
    Created on : 20 Nov, 2021, 11:40:13 AM
    Author     : SIVASANKAR
--%>
<%@page import="java.util.Random"%>
<%@page import="MailDemo.sendMailToFaculty"%>
<%@page import="java.io.*,java.sql.*" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Faculty Adding to DB</title>
        <link rel="stylesheet" type="text/css" href="bootstrap.min.css">
        <link rel="icon" type="text/css" href="images/test.png">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    </head>
    <body>
        <% 
            if(session.getAttribute("aid")==null)
            {
                response.sendRedirect("adminLogin.jsp");
            }
        %>
        <jsp:include page="base.jsp"/>
        <%
            String allSymbols="ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890~!@#$%^&*";
            Random random=new Random();
            char[] psw=new char[8];            

            for(int i=0;i<8;i++)
            {
               psw[i]=allSymbols.charAt(random.nextInt(71));  //71 is allSymbols.length()
            }
            String facultyPassword=new String(psw); 
            
            String adminIdf=(String)session.getAttribute("aid");
            String facultyName=request.getParameter("facultyName");
            String facultyEmail=request.getParameter("facultyEmail");
            
            
            try
            {
                Class.forName("com.mysql.jdbc.Driver");
                String url="jdbc:mysql://localhost:3306/demo2?useSSL=false&allowPublicKeyRetrieval=true";
                String username="siva";
                String password="0000";
                Connection con=DriverManager.getConnection(url,username,password); 
               
                String queryString="insert into faculty(adminId,facultyName,email,password) values(?,?,?,?)";
                PreparedStatement pstatement = con.prepareStatement(queryString);
                pstatement.setString(1,adminIdf);
                pstatement.setString(2, facultyName);
                pstatement.setString(3, facultyEmail);
                pstatement.setString(4, cipher.AES.encrypt(facultyPassword));
                pstatement.executeUpdate();
                
                String queryString2="select facultyId from faculty where adminId=? and email=?";
                PreparedStatement pstatement2 = con.prepareStatement(queryString2);
                pstatement2.setString(1,adminIdf);
                pstatement2.setString(2, facultyEmail);
                ResultSet rs1=pstatement2.executeQuery();
                while(rs1.next())
                {
                    String fid=rs1.getString(1);
                    String sqlCreate = "CREATE TABLE IF NOT EXISTS " + "questions"+fid
                    + "  (questionId int auto_increment,"
                    + "   examId int not null,"
                    + "   questionName varchar(120),"
                    + "   questionNameImg varchar(120),"
                    + "   opt1 varchar(120),"
                    + "   opt1Img varchar(120),"
                    + "   opt2 varchar(120),"
                    + "   opt2Img varchar(120),"
                    + "   opt3 varchar(120),"
                    + "   opt3Img varchar(120),"
                    + "   opt4 varchar(120),"
                    + "   opt4Img varchar(120),"
                    + "   ans varchar(120) not null,"
                    + "   questionMarks float default 1,"
                    + "   negativeMarks float default 0,"
                    + "   questionType int default 0,"
                    + "   questionTimeMinutes int default 1,"
                    + "   questionTimeSeconds int default 0,"        
                    + "   primary key(questionId),"
                    + "   foreign key(examId) references exam(examId) on delete cascade on update cascade)";

                    Statement stmt = con.createStatement();
                    stmt.execute(sqlCreate);
                    
                    String sqlCreate2 = "CREATE TABLE IF NOT EXISTS " + "students"+fid
                    + "  (studentId int auto_increment,"
                    + "   listName varchar(100) not null,"
                    + "   studentName varchar(100),"
                    + "   regdNo varchar(100) not null,"
                    + "   studentEmail varchar(100) not null,"
                    + "   CONSTRAINT studentsRegdnoList UNIQUE(listName,regdNo),"
                    + "   CONSTRAINT studentsEmailList UNIQUE(listName,studentEmail),"
                    + "   primary key(studentId))";
                    
                    Statement stmt2 = con.createStatement();
                    stmt2.execute(sqlCreate2);
                    
                }
                
                
            }
            catch(Exception e)
            {
                %>
                    <c:redirect url="facultyEmailAlreadyInserted.jsp"/>
                <%
            }
                
            try    
            {       
                //String to=facultyEmail;
                String sub="Online Examination System - Password";
                String msg="Welcome to Online Examination System -  Your Password is: <h1>"+facultyPassword+"</h1>";
                sendMailToFaculty.send(facultyEmail,sub,msg);
                //response.sendRedirect("emailToFacultySentSuccessfully.jsp");
            }
            catch(Exception e)
            {
                Class.forName("com.mysql.jdbc.Driver");
                String url="jdbc:mysql://localhost:3306/demo2?useSSL=false&allowPublicKeyRetrieval=true";
                String username="siva";
                String password="0000";
                Connection con=DriverManager.getConnection(url,username,password); 

                String queryString="delete from faculty where email=?";
                PreparedStatement pstatement = con.prepareStatement(queryString);
                pstatement.setString(1,facultyEmail);
                pstatement.executeUpdate();
                response.sendRedirect("emailToFacultyFailedToSent.jsp");
            }
        %>
        <c:redirect url="emailToFacultySentSuccessfully.jsp"/>
        <script type="text/javascript" src="assets\js\noBack.js"></script>
    </body>
</html>


