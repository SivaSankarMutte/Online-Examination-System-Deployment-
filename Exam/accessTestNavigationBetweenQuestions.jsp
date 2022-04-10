<%-- 
    Document   : accessTestNavigationBetweenQuestions
    Created on : 14 Jan, 2022, 7:30:47 PM
    Author     : SIVASANKAR
--%>

<%@page import="java.util.Arrays"%>
<%@page import="QuestionsPackage.Questions"%>
<%@page import="QuestionsPackage.LiveResults"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>

<% ArrayList<Questions> questionsRecords = (ArrayList<Questions>)session.getAttribute("questionsRecords"); %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Online Test</title>
        <link rel="stylesheet" href="assets\bootstrap\css\bootstrap.min.css">
        <link rel="icon" type="text/css" href="images/test.png">
        <style>
            #overlay{
                position: absolute;
                opacity: 0.3;
                transform:rotate(-45deg);
                overflow-y: hidden;
                overflow-x: hidden;
                overflow-wrap: break-word;
                margin-left: 200px;
                
            }
            .noselect {
                user-select: none; /* Non-prefixed version, currently
                                                supported by Chrome, Edge, Opera and Firefox */
            }
        </style>
        <script>
            function fun1()
            {
                var x=document.getElementById("frame");
                x.style.display="block";
                var y=document.getElementById("go-button");
                y.style.display="none";
            }
        </script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
<style type="text/css">
body {
	margin: 0;
}

#go-button {
	width: 200px;
	display: block;
	margin: 50px auto 0 auto;
}

/* webkit requires explicit width, height = 100% of sceeen */
/* webkit also takes margin into account in full screen also - so margin should be removed (otherwise black areas will be seen) */


</style>
    </head>
    
    <body id="element" style="margin:0;">
        
        
        
        <script type="text/javascript">     
        // Set the date we're counting down to
        var countDownDate = new Date("${sessionScope.endTime}").getTime();
                                     
        // Update the count down every 1 second
        var x = setInterval(function() {

          // Get today's date and time
          var now = new Date().getTime();

          // Find the distance between now and the count down date
          var distance = countDownDate - now;

          // Time calculations for days, hours, minutes and seconds
          //var days = Math.floor(distance / (1000 * 60 * 60 * 24));
          var hours = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
          var minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
          var seconds = Math.floor((distance % (1000 * 60)) / 1000);

          // Output the result in an element with id="demo"
          document.getElementById("demo").innerHTML = hours + "h "
          + minutes + "m " + seconds + "s ";

          // If the count down is over, write some text 
          if (distance < 0) {
            clearInterval(x);
            window.location.replace("http://34.203.225.61:8080/Exam/examNavigationSubmitButtonPressed");
          }
        }, 1000);
        </script>
    
        
        
        <sql:setDataSource var="db" driver="com.mysql.jdbc.Driver" url="jdbc:mysql://localhost:3306/demo2?useSSL=false&allowPublicKeyRetrieval=true" user="siva" password="0000"/>
        <sql:query dataSource="${db}" var="result">
            select mode from exam where examId=?;
			<sql:param value="${sessionScope.examId}"/>
        </sql:query>
        <c:forEach var="row" items="${result.rows}">
            <c:choose>
		<c:when test="${row.mode == 2}">
        <div style="background-color:white; margin:0; width:100%;height:100%;">
            <center>
                <p id="demo" class="bg-success rounded text-center" style="width:125px; color: black; position: static;">Timer</p>
            </center>
            <br/>
            <button id="go-button" onclick="fun1()" class="btn btn-success form-control">Start Exam</button>
            <iframe id="frame" style="height: 800px; width: 100%;display: none;" src="accessTestNavigationBetweenQuestionsDisplay1.jsp" title="Questions" class="responsive-iframe"></iframe>
        </div>
		</c:when>
                <c:otherwise>
                    <c:redirect url="tryingToSelectInvalidMode.jsp"/>
                </c:otherwise>
            </c:choose>
	</c:forEach>
    </body>
    <script type="text/javascript" src="assets\js\myscript.js"></script>
	<script type="text/javascript" src="assets\js\noBack.js"></script>
</html>
	
    