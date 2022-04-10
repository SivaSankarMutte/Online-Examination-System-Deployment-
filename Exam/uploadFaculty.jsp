<%@page import="java.util.Random"%>
<%@page import="MailDemo.sendMailToFaculty"%>
<%@page import="java.io.*,java.sql.*,java.util.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<% 
    if(session.getAttribute("aid")==null)
    {
        response.sendRedirect("adminLogin.jsp");
    }
%>
<jsp:include page="base.jsp"/>

<html>
<%
    String contentType = request.getContentType();
    if ((contentType != null) && (contentType.indexOf("multipart/form-data") >= 0)) 
    {
        DataInputStream in = new DataInputStream(request.getInputStream());
        int formDataLength = request.getContentLength();
        byte dataBytes[] = new byte[formDataLength];
        int byteRead = 0;
        int totalBytesRead = 0;

        while (totalBytesRead < formDataLength) 
        {
            byteRead = in.read(dataBytes, totalBytesRead, formDataLength);
            totalBytesRead += byteRead;
        }
        
        String file = new String(dataBytes);
        
        String saveFile = file.substring(file.indexOf("filename=\"") + 10);
        saveFile = saveFile.substring(0, saveFile.indexOf("\n"));
        saveFile = saveFile.substring(saveFile.lastIndexOf("\\")+ 1,saveFile.indexOf("\""));
        int lastIndex = contentType.lastIndexOf("=");
        String boundary = contentType.substring(lastIndex + 1,contentType.length());
        
        int pos;
        pos = file.indexOf("filename=\""); 
        pos = file.indexOf("\n", pos) + 1;
        pos = file.indexOf("\n", pos) + 1;
        pos = file.indexOf("\n", pos) + 1;
        int boundaryLocation = file.indexOf(boundary, pos) - 4;
        int startPos = ((file.substring(0, pos)).getBytes()).length;
        int endPos = ((file.substring(0, boundaryLocation)).getBytes()).length;

        FileOutputStream fileOut = new FileOutputStream(saveFile);
        fileOut.write(dataBytes, startPos, (endPos - startPos));

        String line = null;
        try
        {
            BufferedReader input = new BufferedReader(new FileReader(saveFile));

            Class.forName("com.mysql.jdbc.Driver");
            String url="jdbc:mysql://localhost:3306/demo2?useSSL=false&allowPublicKeyRetrieval=true";
            String username="siva";
            String password="0000";
            Connection con=DriverManager.getConnection(url,username,password); 
            PreparedStatement pstatement=null;
            
            //Random Password
            String allSymbols="ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz1234567890~!@#$%^&*";
            Random random=new Random();
            
            
            //Mail sending to Faculty
            
            while(( line = input.readLine()) != null)
            {
                String t=line.toString();
                String words[]=t.split(",");
                String adminIdf=(String)session.getAttribute("aid");
                String queryString="insert into faculty(adminId,facultyName,email,password) values(?,?,?,?)";
                pstatement = con.prepareStatement(queryString);
                pstatement.setString(1, adminIdf);
                pstatement.setString(2, words[0]);
                pstatement.setString(3, words[1]);
                //String psw=words[0].substring(0,4)+words[1].substring(0,4);
                
                
                char[] psw=new char[8];
                
                for(int i=0;i<8;i++)
                {
                    psw[i]=allSymbols.charAt(random.nextInt(71));  //71 is allSymbols.length()
                }
                String p=new String(psw);
                pstatement.setString(4,cipher.AES.encrypt(p));
                pstatement.executeUpdate();
                
                String queryStringToGetFID="select facultyId from faculty where adminId=? and email=?";
                PreparedStatement pstatement2 = con.prepareStatement(queryStringToGetFID);
                pstatement2.setString(1,adminIdf);
                pstatement2.setString(2, words[1]);
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
                
                try
                {
                    String to=words[1];
                    String sub="Online Examination System - Password";
                    String msg="Welcome to Online Examination System -  Your Password is: <h1>"+p+"</h1>";
                    sendMailToFaculty.send(to,sub,msg);
                    
                }
                catch(Exception e)
                {
                    out.println("Error while sending passwords to Faculty Emails");
                    out.println(e);  
                    
                    String queryString3="delete from faculty where email=?";
                    PreparedStatement pstatement3 = con.prepareStatement(queryString3);
                    pstatement3.setString(1,words[1]);
                    pstatement3.executeUpdate();
                }
            }
            %> <c:redirect url="viewFaculty.jsp"/>  <%
        }
        catch(Exception e)
        {
            System.out.println(e);
        }
        %>  <c:redirect url="errorFacultyUpload.jsp"/>   <%
    }
%>
</html>