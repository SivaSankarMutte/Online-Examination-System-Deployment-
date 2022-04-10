<%-- 
    Document   : accessAllQuestions
    Created on : 15 Jan, 2022, 11:34:38 AM
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
        <link rel="stylesheet" type="text/css" href="bootstrap.min.css">
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
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
        <script>
                $(document).on("keydown",function(ev){
                console.log(ev.keyCode);
                if(ev.keyCode===27||ev.keyCode===122) console.log("pressed esc or f11");
        });
        </script>
        <script>
        document.addEventListener("keydown", e => {
            if(e.key === "F11") {
              // Suppress default behaviour 
              // e.g. F1 in Microsoft Edge on Windows usually opens Windows help
              e.preventDefault()
            }
          })

        document.addEventListener("keyup", e => {
            if(e.key === "F11") {
              // Handle the keyup event
              alert("Keypress event F11");
            }
          })
        </script>



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
        <sql:setDataSource var="db" driver="com.mysql.jdbc.Driver" url="jdbc:mysql://localhost:3306/demo2?useSSL=false&allowPublicKeyRetrieval=true" user="siva" password="0000"/>
        <sql:query dataSource="${db}" var="result">
            select mode from exam where examId=?;
			<sql:param value="${sessionScope.examId}"/>
        </sql:query>
        <c:forEach var="row" items="${result.rows}">
            <c:choose>
		<c:when test="${row.mode == 1}">
			<div style="background-color:white; margin:0; width:100%;height:100%;">
				<button id="go-button" onclick="fun1()" class="btn btn-success form-control">Start Exam</button>
				<iframe id="frame" style="height: 800px;width: 100%;display: none;" src="accessAllQuestionsDisplay1.jsp" title="Questions" class="responsive-iframe"></iframe>
	<!--            <iframe id="frame" style="height: 800px;width: 100%;display: none;" src="accessAllQuestionsDisplayRetainAnswers.jsp" title="Questions" class="responsive-iframe"></iframe>-->
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
	
    