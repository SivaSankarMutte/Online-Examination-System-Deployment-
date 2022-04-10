<%@page import="java.io.*,java.sql.*"%>
<%@page trimDirectiveWhitespaces="true"%>
<%
    response.setContentType("html");
    Class.forName("com.mysql.jdbc.Driver");
    Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/demo2?useSSL=false&allowPublicKeyRetrieval=true","siva","0000");
    Statement stmt=con.createStatement();
    String eid=session.getAttribute("eid").toString();
    try
    {
        out.print("RegdNo");
        out.print(",");
        out.print("Marks");
        out.print("\n");
        String query = "select * from results"+eid+" order by regdNo";
        ResultSet rs = stmt.executeQuery(query);
        while(rs.next())
        {
            out.print(rs.getString(1));
            out.print(",");
            out.print(rs.getString(2));
            out.print("\n");
        }
        response.reset();
        response.setContentType("csv");
        response.setHeader("Content-disposition","attachment; filename=results.csv");
        con.close();
    } 
    catch (Exception e) 
    {
        e.printStackTrace();
    }
%>
