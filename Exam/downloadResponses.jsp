<%@page import="java.io.*,java.sql.*"%>
<%@page trimDirectiveWhitespaces="true"%>
<% 
    response.setContentType("csv");
    response.setHeader("Content-disposition","attachment; filename=StudentResponses.csv");

//    response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
//    response.setContentType("vnd.ms-excel");
//    response.setHeader("Content-disposition","attachment; filename=StudentResults.xlsx");
//    response.setHeader("Pragma", "no-cache");
    Class.forName("com.mysql.jdbc.Driver");
    Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/demo2?useSSL=false&allowPublicKeyRetrieval=true","siva","0000");
    Statement stmt1=con.createStatement();
    Statement stmt2=con.createStatement();
    Statement stmt3=con.createStatement();
    Statement stmt4=con.createStatement();
    Statement stmt5=con.createStatement();
    Statement stmt6=con.createStatement();
    String eid=session.getAttribute("eid").toString();
    String fid=session.getAttribute("fid").toString();
    try
    {
        out.print("Sl No.");
        out.print(",");
        out.print("Regd No");
        out.print(",");
        out.print("Name");
        
        String questionsQuery="select * from questions"+fid+" where examId="+eid+" order by questionId";
        ResultSet rs1 = stmt1.executeQuery(questionsQuery);
        int i=1;
        while(rs1.next())
        {
            out.print(",");
            out.print(i+". "+rs1.getString(3));
            i++;
        }
        out.print(",");
        out.print("Total Marks");
        out.print("\n");
        
        String queryListName="select listName from exam where examId="+eid+" ";
        ResultSet rs2 = stmt2.executeQuery(queryListName);
        String listName="";
        if(rs2.next())
        {
            listName=rs2.getString(1);
        }
        String query2="select studentName,regdNo from students"+fid+" where listName='"+listName+"' order by regdNo";
        ResultSet rs3 = stmt3.executeQuery(query2);
        i=1;
        
        while(rs3.next())
        {
            out.print(i);
            out.print(",");
            out.print(rs3.getString(2));
            out.print(",");
            if(rs3.getString(1)==null)
                out.print("");
            else
                out.print(rs3.getString(1));
            
            ResultSet rs6 = stmt6.executeQuery(questionsQuery);
            while(rs6.next())
            {
                String query3="select * from examSpecialTable"+eid+" where regdNo='"+rs3.getString(2)+"' and qid='"+rs6.getString(1)+"' ";
                ResultSet rs4 = stmt4.executeQuery(query3);
                out.print(",");
                if(rs4==null)
                {
                    out.print("Unseen");
                }
                else if(rs4.next())
                {
                    if(rs4.getString(4)==null)
                    {
                        out.print("Unanswered");
                    }
                    else if(rs4.getInt(3)>0)
                    {
                        out.print("Correct");
                    }
                    else
                    {
                        out.print("Wrong");
                    }
                }
                
            }
            out.print(",");
            String query4="select sum(marksObtained) from examspecialtable"+eid+" where regdNo='"+rs3.getString(2)+"'"; 
            ResultSet rs5 = stmt5.executeQuery(query4);
            
            if(rs5.next())
            {
                if(rs5.getString(1)==null)
                {
                    out.print("A");
                }
                else
                {
                    out.print(rs5.getInt(1));
                }
            }
            out.print("\n");
            i++;
        }
        
                
                
                
        
        
        con.close();
    } 
    catch (Exception e) 
    {
        e.printStackTrace();
    }
%>
