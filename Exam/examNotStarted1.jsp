<%-- 
    Document   : examNotStarted1
    Created on : 4 Apr, 2022, 5:01:38 PM
    Author     : SIVASANKAR
--%>


<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
		<title>Exam Not Started</title>
		<meta name="description" content="BEC Exam Portal">
		<link rel="stylesheet" href="assets\bootstrap\css\bootstrap.min.css">
		<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i">
		<link rel="stylesheet" href="assets\fonts\fontawesome-all.min.css">
		<link rel="stylesheet" href="assets\fonts\font-awesome.min.css">
		<link rel="stylesheet" href="assets\fonts\ionicons.min.css">
		<link rel="stylesheet" href="assets\fonts\typicons.min.css">
		<link rel="stylesheet" href="assets\fonts\fontawesome5-overrides.min.css">
		<link rel="stylesheet" href="assets\css\styles.min.css">
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/3.5.2/animate.min.css">
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/aos/2.3.4/aos.css">
		<link rel="icon" type="text/css" href="images/test.png">	
	</head>
    <body>
	
		<script type="text/javascript">     
            // Set the date we're counting down to
            var countDownDate = new Date("${sessionScope.startTime}").getTime();

            // Update the count down every 1 second
            var x = setInterval(function() {
                
                var countDownDate = new Date("${sessionScope.startTime}").getTime();
				console.log("startTime "+countDownDate);
				console.log("${sessionScope.startTime}");
              // Get today's date and time
			  //var now1=new Date();
			  //console.log("Before Date "+now1);
			  //now1.setHours(now1.getHours()+5);
			  //now1.setMinutes(now1.getMinutes()+30);
			  //console.log("AAfter Date "+now1);
			  
              var now = new Date();
			  
				console.log(now);
              // Find the distance between now and the count down date
              var distance = countDownDate-now.getTime();
				console.log(distance);
              // Time calculations for days, hours, minutes and seconds
              //var days = Math.floor(distance / (1000 * 60 * 60 * 24));
              var hours = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
              var minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
              var seconds = Math.floor((distance % (1000 * 60)) / 1000);

              // Output the result in an element with id="demo"
              document.getElementById("demo").innerHTML = hours + "h "
              + minutes + "m " + seconds + "s ";

              // If the count down is over, write some text 
              if (distance <= 2000) {
                clearInterval(x);
                window.location.replace("http://34.203.225.61:8080/Exam/examLinkValidation1?p=${sessionScope.encrypted}");
              }
            }, 1000);
            
        </script>
	
		<center>
            <p id="demo" class="bg-warning rounded text-center" style="width:125px; color: black; position: static;">Timer</p>
			<c:out value="Please wait for some time, we will navigate you to the Exam Page after the countdown becomes Zero"/> 
    
		</center>
    <script type="text/javascript" src="assets\js\noBack.js"></script>
    </body>
</html>
