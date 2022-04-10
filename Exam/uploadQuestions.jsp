<%-- 
    Document   : uploadQuestions
    Created on : 15 Jan, 2022, 1:40:43 PM
    Author     : SIVASANKAR
--%>

<%@page import="java.io.*,java.sql.*,java.util.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<% 
    if(session.getAttribute("fid")==null)
    {
        response.sendRedirect("facultyLogin.jsp");
    }
%>
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
            String fid=session.getAttribute("fid").toString();
            
            while(( line = input.readLine()) != null)
            {
                String t=line.toString();
                System.out.print(t);
                String words[]=t.split(",");
                String eid=(String)session.getAttribute("eid");
                String queryString="insert into questions"+fid+" (examId,questionName,opt1,opt2,opt3,opt4,ans,questionMarks,negativeMarks,questionType,questionTimeMinutes,questionTimeSeconds) values(?,?,?,?,?,?,?,?,?,?,?,?)";
                pstatement = con.prepareStatement(queryString);
                pstatement.setString(1, eid);
                pstatement.setString(2, words[0]);
                System.out.print(words[0]);
                if(words[9].equals("1"))
                {
                    pstatement.setString(3,"don't consider");
                    pstatement.setString(4,"don't consider");
                }
                else
                {
                    pstatement.setString(3, words[1]);   //opt1
                    pstatement.setString(4, words[2]);   //opt2
                }
                
                pstatement.setString(5, words[3]);   //opt3
                pstatement.setString(6, words[4]);   //opt4
                pstatement.setString(7, words[5]);   //ans
                if(words[6].equals(""))
                    pstatement.setString(8, "1");
                else
                    pstatement.setString(8, words[6]);  //questionMarks
                if(words[7].equals(""))
                    pstatement.setString(9, "0");
                else
                    pstatement.setString(9, words[7]);   //neagtiveMarks
                
                
                if(words[8].equals(""))
                    pstatement.setInt(11, 1);
                else
                    pstatement.setString(11, words[8]);  //question Time Limit (Minutes)
                
                if(words[9].equals(""))
                    pstatement.setInt(12, 30);
                else
                    pstatement.setString(12, words[9]);  //question Time Limit (seconds)
                
                
                
                if(words[10].equals(""))
                {
                    if(words[5].length()==1)
                        pstatement.setString(10, "0");
                    else if(words[5].contains("&"))
                    {
                        pstatement.setString(10, "2");
                    }
                    else
                        pstatement.setString(10, "1");
                } 
                else
                    pstatement.setString(10, words[10]);
//                if(words[11].trim().equals(""))
//                {
//                    if(words[1].equals("") || words[2].equals(""))
//                    {
//                        pstatement.setString(11, "1");
//                    }
//                    else
//                    {
//                        pstatement.setString(11, "0");
//                    }
//                }
//                else
//                    pstatement.setString(11, words[11]);
                pstatement.executeUpdate();
                
            }
            %> <c:redirect url="questions.jsp"/>  <%
        }
        catch(Exception e)
        {
            System.out.println(e);
        }
        %>  <c:redirect url="errorQuestionsUpload.jsp"/>   <%
    }
%>
</html>