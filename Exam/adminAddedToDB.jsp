<%-- 
    Document   : adminAddedToDB
    Created on : 27 Nov, 2021, 12:59:22 PM
    Author     : SIVASANKAR
--%>


<%@page import="MailDemo.sendMailToFaculty"%>
<%@page import="java.util.Random"%>
<%@ page import="java.io.*,java.sql.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin Adding to DB</title>
        <link rel="stylesheet" type="text/css" href="bootstrap.min.css">
        <link rel="icon" type="text/css" href="images/test.png">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    </head>
    <body>
        <% 
            if(session.getAttribute("sid")==null)
            {
                response.sendRedirect("superAdminLogin.jsp");
            }
        %>
        <jsp:include page="base.jsp"/>
        <%
            String adminName=request.getParameter("adminName");
            String adminEmail=request.getParameter("adminEmail");
            String adminDept=request.getParameter("adminDept");
            //String adminPassword=request.getParameter("adminPassword");
            String allSymbols="ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890~!@#$%^&*";
            Random random=new Random();
            char[] psw=new char[8];            

            for(int i=0;i<8;i++)
            {
               psw[i]=allSymbols.charAt(random.nextInt(71));  //71 is allSymbols.length()
            }
            String adminPassword=new String(psw); 
            int flag=0;
            
            try
            {
                Class.forName("com.mysql.jdbc.Driver");
                String url="jdbc:mysql://localhost:3306/demo2?useSSL=false&allowPublicKeyRetrieval=true";
                String username="siva";
                String password="0000";
                Connection con=DriverManager.getConnection(url,username,password); 
               
                String queryString="insert into admin(adminName,email,password,department) values(?,?,?,?)";
                PreparedStatement pstatement = con.prepareStatement(queryString);
                pstatement.setString(1, adminName);
                pstatement.setString(2, adminEmail);
                pstatement.setString(3, cipher.AES.encrypt(adminPassword));
                pstatement.setString(4, adminDept);
                
                pstatement.executeUpdate();
                
            }
            catch(Exception e)
            {
                response.sendRedirect("adminEmailAlreadyInserted.jsp");
                flag=1;
            }
             
            if(flag==0)
            {
                try    
                {       
                    //String to=facultyEmail;
                    String sub="Online Examination System - Password";
                    String msg="Welcome to Online Examination System ("+adminName+") as Admin for "+adminDept+" -  Your Password is: <h1>"+adminPassword+"</h1>";
                    sendMailToFaculty.send(adminEmail,sub,msg);
                    response.sendRedirect("emailToAdminSentSuccessfully.jsp");
                }
                catch(Exception e)
                {
                    Class.forName("com.mysql.jdbc.Driver");
                    String url="jdbc:mysql://localhost:3306/demo2?useSSL=false&allowPublicKeyRetrieval=true";
                    String username="siva";
                    String password="0000";
                    Connection con=DriverManager.getConnection(url,username,password); 

                    String queryString="delete from admin where email=?";
                    PreparedStatement pstatement = con.prepareStatement(queryString);
                    pstatement.setString(1,adminEmail);
                    pstatement.executeUpdate();
                    response.sendRedirect("emailToAdminFailedToSent.jsp");
                }
            }
        %>
        <c:redirect url="emailToAdminSentSuccessfully.jsp"/>
        <script type="text/javascript" src="assets\js\noBack.js"></script>
    </body>
</html>



