<%@page import="java.io.*,java.sql.*"%>
<%@page trimDirectiveWhitespaces="true"%>
<% 
    response.setContentType("csv");
    response.setHeader("Content-disposition","attachment; filename=StudentQuestionStatus.csv");
    Class.forName("com.mysql.jdbc.Driver");
    Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/demo2?useSSL=false&allowPublicKeyRetrieval=true","siva","0000");
    Statement stmt=con.createStatement();
    Statement stmt2=con.createStatement();
    String eid=session.getAttribute("eid").toString();
    String fid=session.getAttribute("fid").toString();
    try
    {
        out.print("RegdNo");
        out.print(",");
        out.print("Question");
        out.print(",");
        out.print("Status");
        out.print("\n");
        String query = "select * from examSpecialTable"+eid+" order by regdNo";
       
        ResultSet rs = stmt.executeQuery(query);
        
        while(rs.next())
        {
            String questionsQuery="select * from questions"+fid+" where questionId="+rs.getInt(1);
            ResultSet rs2 = stmt2.executeQuery(questionsQuery);
            while(rs2.next())
            {
                
                out.print(rs.getString(2));
                out.print(",");
                out.print(rs2.getString(3));
                out.print(",");
                if(rs.getString(4)==null)
                {
                    out.print("Unanswered");
                }
                else if(rs.getInt(3)>0)
                {
                    out.print("Correct");
                }
                else
                {
                    out.print("Wrong");
                }
//                out.print(rs.getString(4));
//                out.print(",");
//                out.print(rs2.getString(13));
                out.print("\n");
            }
        }
        
        con.close();
    } 
    catch (Exception e) 
    {
        e.printStackTrace();
    }
%>
