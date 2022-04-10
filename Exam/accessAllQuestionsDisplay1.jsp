<%-- 
    Document   : accessAllQuestionsDisplay
    Created on : 10 Feb, 2022, 2:30:13 PM
    Author     : SIVASANKAR
--%>


<%@page import="java.util.ArrayList"%>
<%@page import="QuestionsPackage.Questions"%>
<%@page import="QuestionsPackage.LiveResults"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
        <title>Online Exam - BEC</title>
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
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
        <style>
            #overlay{
                position: absolute;
                opacity: 0.3;
                transform:rotate(-45deg);
                overflow-y: hidden;
                overflow-x: hidden;
                overflow-wrap: break-word;
/*                margin-left: 200px;*/
                user-select: none;
                pointer-events: none;
                
            }
            .noselect {
                user-select: none; /* Non-prefixed version, currently
                                                supported by Chrome, Edge, Opera and Firefox */
            }
        </style>
        
        <script>
             $(document).on("click", "input[type='radio']", function(e) {
            var checked = $(this).attr("checked");
            if(!checked){
                $(this).attr("checked", true);
            } else {
                $(this).removeAttr("checked");
                $(this).prop("checked", false);
                var thisElem = $(this); 
                var id1=thisElem.attr('id');
                if(!thisElem.is(':checked')) {
                    window.localStorage.removeItem(id1);
                }
                
            }
        });
        </script>
        
    </head>
    <body id="page-top" style="padding: 5;">
        
        <center>
            <p id="demo" class="bg-success rounded text-center" style="width:125px; color: black; position: static;"></p>
        </center>
   
    
    

<script>
    $(function() { $("input[type=\"radio\"]").click(function(){ 
            var thisElem = $(this); 
            var value = thisElem.val(); 
            var id1=thisElem.attr('id');
//            console.log("ADDING");
//            console.log(id1);
//            console.log("SUBS");
//            console.log(id1.substring(0, id1.length-1));
            for (var i = 0; i < localStorage.length; i++){
                var itemId=localStorage.getItem(localStorage.key(i));
                if (itemId.substring(0, itemId.length-1)==id1.substring(0, id1.length-1)) { 
                        console.log("Removing"+itemId);
                        window.localStorage.removeItem(itemId);
                        
                    //localStorage.removeItem(localStorage.key(i));
                } 
            }
            
            localStorage.setItem(id1, id1);
            
        }); 
        
        for (var i = 0; i < localStorage.length; i++){
            var itemId=localStorage.getItem(localStorage.key(i));
            if (itemId !== null) { 
                
                $("input[id=\""+itemId+"\"]").click(); 
            } 
        }
        
    });
    
    $(function() { $("input[type=\"checkbox\"]").click(function(){ 
            var thisElem = $(this); 
            var value = thisElem.val(); 
            var id1=thisElem.attr('id');
            if(!thisElem.is(':checked')) {
                window.localStorage.removeItem(id1);
            }
            else{
                localStorage.setItem(id1, id1); 
            }
        }); 
        
        for (var i = 0; i < localStorage.length; i++){
            var itemId=localStorage.getItem(localStorage.key(i));
            if (itemId !== null) { 
                $("input[id=\""+itemId+"\"]").check(); 
                //localStorage.removeItem(localStorage.key(i));
            } 
        }
        
    });
    
    
    
    //For BLANKS
    $(document).ready(function(){
        $("input").keypress(function(){
          var thisElem = $(this); 
            var value = thisElem.val(); 
            var id1=thisElem.attr('id');
            localStorage.setItem(id1, value); 
            console.log("TYPING");
        });
      });
    
    $(function() { $("input").keypress(function(){ 
            var thisElem = $(this); 
            var value = thisElem.val(); 
            var id1=thisElem.attr('id');
            localStorage.setItem(id1, value); 
            console.log("TYPING");
        }); 
        
        for (var i = 0; i < localStorage.length; i++){
            var itemId=localStorage.getItem(localStorage.key(i));
            if (itemId !== null) { 
                $("input[id=\""+itemId+"\"]").text(itemId.value);
                //localStorage.removeItem(localStorage.key(i));
            } 
        }
        
    });
    
    
    
    
//    $(function() { $("input[type=\"radio\"]").click(function(){ 
//            var thisElem = $(this); 
//            var value = thisElem.val();  
//            localStorage.setItem("option", value); }); 
//        var itemValue = localStorage.getItem("option"); 
//        if (itemValue !== null) { 
//            $("input[value=\""+itemValue+"\"]").click(); 
//        }
//    });

</script>


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
//            document.forms["myForm"].submit();
            document.getElementById("myForm").submit();
//            window.location.replace("http://127.0.0.1:8080/Online%20Examination%20System/allAnswersSubmission");
          }
        }, 1000);
        </script>
        
        

        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
    <div id="wrapper">
        <div class="d-flex flex-column" id="content-wrapper">
            <form action="allAnswersSubmission" method="get" name="myForm" id="myForm" class="form-control">
                <nav class="navbar navbar-light navbar-expand bg-white shadow mb-4 topbar static-top" style="background: var(--bs-success);color: var(--bs-success);">
                    <div class="container-fluid"><button class="btn btn-link d-md-none rounded-circle me-3" id="sidebarToggleTop" type="button" style="background: var(--bs-success);"><i class="fas fa-bars"></i></button>
                        <h1>Online Exam Portal</h1><button type="submit" class="btn btn-success btn-icon-split" role="button"><span class="text-white-50 icon"><i class="typcn typcn-chevron-right"></i></span><span class="text-white text">Submit</span></button>
                    </div>
                </nav>

        <% 
            if(session.getAttribute("examId")!=null && session.getAttribute("regdNo")!=null)
            {  %>
                
                    <%
                    ArrayList<Questions> q=(ArrayList<Questions>)session.getAttribute("questionsRecords");
                    for(int i=0;i<q.size();i++)
                    {
                        %>
                        <p class="bg-danger rounded" style="margin-right:50px; float: right; color: black;">&nbsp;&nbsp;<% out.println(-q.get(i).getNegativeMarks()); %>&nbsp;&nbsp;</p>
                        <p class="bg-success rounded" style="margin-right:3px; float: right; color: black;">&nbsp;&nbsp;<% out.println("+"+q.get(i).getQuestionMarks()); %>&nbsp;&nbsp;</p>
                        <%
                        
                        if(q.get(i).getQuestionType()==1)
                        {
                            %>
                            <div id="overlay">
                                ${sessionScope.regdNo}&nbsp;&nbsp;${sessionScope.regdNo}&nbsp;&nbsp;${sessionScope.regdNo}<br/>
                                ${sessionScope.regdNo}&nbsp;&nbsp;${sessionScope.regdNo}&nbsp;&nbsp;${sessionScope.regdNo}<br/>
                                ${sessionScope.regdNo}&nbsp;&nbsp;${sessionScope.regdNo}&nbsp;&nbsp;${sessionScope.regdNo}<br/>
                                ${sessionScope.regdNo}&nbsp;&nbsp;${sessionScope.regdNo}&nbsp;&nbsp;${sessionScope.regdNo}<br/>
                                ${sessionScope.regdNo}&nbsp;&nbsp;${sessionScope.regdNo}&nbsp;&nbsp;${sessionScope.regdNo}<br/>
                                ${sessionScope.regdNo}&nbsp;&nbsp;${sessionScope.regdNo}&nbsp;&nbsp;${sessionScope.regdNo}
                            </div>
                            
                            
                            
                            <h4 class="card-title" style="user-select:none; background-color: lightgray;"><%
                                out.print(i+1);
                                out.print(".");
                                if(q.get(i).getQuestionName()!=null){
                                    out.print(q.get(i).getQuestionName());
                                }
                                %></h4><%
                             
                            if(q.get(i).getQuestionNameImg()!=null && !q.get(i).getQuestionNameImg().equals("")){
                                %><br/><div style="background-color:lightgray;"><img src="<%= q.get(i).getQuestionNameImg() %>" alt="Image Loading" height="200px" width="100%"></div><br/><%
                         } %>
                         <input type="text" name="<%= q.get(i).getQuestionId() %>" id="<%= "blank"+q.get(i).getQuestionId() %>" placeholder="Enter your answer here" class="form-control"><br/><%
                        }
                        else if(q.get(i).getQuestionType()==0)
                        {
                            %>
                            <div id="overlay">
                                ${sessionScope.regdNo}&nbsp;&nbsp;${sessionScope.regdNo}&nbsp;&nbsp;${sessionScope.regdNo}<br/>
                                ${sessionScope.regdNo}&nbsp;&nbsp;${sessionScope.regdNo}&nbsp;&nbsp;${sessionScope.regdNo}<br/>
                                ${sessionScope.regdNo}&nbsp;&nbsp;${sessionScope.regdNo}&nbsp;&nbsp;${sessionScope.regdNo}<br/>
                                ${sessionScope.regdNo}&nbsp;&nbsp;${sessionScope.regdNo}&nbsp;&nbsp;${sessionScope.regdNo}<br/>
                                ${sessionScope.regdNo}&nbsp;&nbsp;${sessionScope.regdNo}&nbsp;&nbsp;${sessionScope.regdNo}<br/>
                                ${sessionScope.regdNo}&nbsp;&nbsp;${sessionScope.regdNo}&nbsp;&nbsp;${sessionScope.regdNo}
                            </div>
                            <h4 class="card-title" style="user-select:none; background-color: lightgray;"><%
                                out.print(i+1);
                                out.print(".");
                                if(q.get(i).getQuestionName()!=null){
                                    out.print(q.get(i).getQuestionName());
                                }
                                %></h4><%
                             
                            if(q.get(i).getQuestionNameImg()!=null && !q.get(i).getQuestionNameImg().equals("")){
                                %><br/><div style="background-color:lightgray;"><img src="<%= q.get(i).getQuestionNameImg() %>" alt="Image Loading" height="200px" width="100%"></div><br/><%
                            }
                            for(int j=0;j<4;j++)
                            {
                                if( (q.get(i).getOptions().get(j)!=null && !q.get(i).getOptions().get(j).equals("")) || (q.get(i).getOptionsImages().get(j)!=null && !q.get(i).getOptionsImages().get(j).equals("")) )
                                {
%><label><input type="radio" name="<%= q.get(i).getQuestionId() %>" value="<%= q.get(i).getOptionNumbers().get(j) %>" id="<%= q.get(i).getQuestionId()+""+(j+1) %>" class="form-control-radio" autocomplete="on"><%
                                }
                                if(q.get(i).getOptions().get(j)!=null && !q.get(i).getOptions().get(j).equals("")){ 
                                    out.print(q.get(i).getOptions().get(j));
                                    out.print("\n");
                                }
                                if(q.get(i).getOptionsImages().get(j)!=null && !q.get(i).getOptionsImages().get(j).equals("")){ 
                                    %>
                                    <br/><img src="<%= q.get(i).getOptionsImages().get(j) %>" alt="Image Loading" height="200px" width="100%">
                                <%
                                }
                                if( (q.get(i).getOptions().get(j)!=null && !q.get(i).getOptions().get(j).equals("")) || (q.get(i).getOptionsImages().get(j)!=null && !q.get(i).getOptionsImages().get(j).equals("")) )
                                {
                                    %></label><br/><%
                                }
                                
                            }
                        } 

                        else
                        {
                            %>
                            <div id="overlay">
                                ${sessionScope.regdNo}&nbsp;&nbsp;${sessionScope.regdNo}&nbsp;&nbsp;${sessionScope.regdNo}<br/>
                                ${sessionScope.regdNo}&nbsp;&nbsp;${sessionScope.regdNo}&nbsp;&nbsp;${sessionScope.regdNo}<br/>
                                ${sessionScope.regdNo}&nbsp;&nbsp;${sessionScope.regdNo}&nbsp;&nbsp;${sessionScope.regdNo}<br/>
                                ${sessionScope.regdNo}&nbsp;&nbsp;${sessionScope.regdNo}&nbsp;&nbsp;${sessionScope.regdNo}<br/>
                                ${sessionScope.regdNo}&nbsp;&nbsp;${sessionScope.regdNo}&nbsp;&nbsp;${sessionScope.regdNo}<br/>
                                ${sessionScope.regdNo}&nbsp;&nbsp;${sessionScope.regdNo}&nbsp;&nbsp;${sessionScope.regdNo}
                            </div>
                            <h4 class="card-title" style="user-select:none; background-color: lightgray;"><%
                                out.print(i+1);
                                out.print(".");
                                if(q.get(i).getQuestionName()!=null){
                                    out.print(q.get(i).getQuestionName());
                                }
                                %></h4><%
                             
                            if(q.get(i).getQuestionNameImg()!=null && !q.get(i).getQuestionNameImg().equals("")){
                                %><br/><div style="background-color:lightgray;"><img src="<%= q.get(i).getQuestionNameImg() %>" alt="Image Loading" height="200px" width="100%"></div><br/><%
                            }
                            for(int j=0;j<4;j++)
                            {
                                if( (q.get(i).getOptions().get(j)!=null && !q.get(i).getOptions().get(j).equals("")) || (q.get(i).getOptionsImages().get(j)!=null && !q.get(i).getOptionsImages().get(j).equals("")) )
                                { 
                                %><label><input type="checkbox" name="<%= q.get(i).getQuestionId() %>" value="<%= q.get(i).getOptionNumbers().get(j) %>" id="<%= q.get(i).getQuestionId() %><%= q.get(i).getOptionNumbers().get(j) %>"><%
                                }
                                if(q.get(i).getOptions().get(j)!=null && !q.get(i).getOptions().get(j).equals("")){ 
                                    out.print(q.get(i).getOptions().get(j));
                                    out.print("\n");
                                }
                                if(q.get(i).getOptionsImages().get(j)!=null && !q.get(i).getOptionsImages().get(j).equals("")){ 
                                    %>
                                    <br/><img src="<%= q.get(i).getOptionsImages().get(j) %>" alt="Image Loading" height="200px" width="100%">
                                <%
                                }
                                if( (q.get(i).getOptions().get(j)!=null && !q.get(i).getOptions().get(j).equals("")) || (q.get(i).getOptionsImages().get(j)!=null && !q.get(i).getOptionsImages().get(j).equals("")) )
                                { 
                                    %></label><br/><%
                                }
                                
                                
                            }
                        }

                        %><br/><br/><br/><%
                    }
                    
                    %>
                    
                    
                    <input type="submit" value="Submit" class="btn btn-success form-control">

                </form>    
               <%
            }
        %>
        
       
            <footer class="bg-white sticky-footer">
                <div class="container my-auto">
                    <div class="text-center my-auto copyright"><span>Copyright © BEC 2021</span></div>
                </div>
            </footer>
        </div><a class="border rounded d-inline scroll-to-top" href="#page-top"><i class="fas fa-angle-up"></i></a>
    </div>
        <script src="assets\bootstrap\js\bootstrap.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/aos/2.3.4/aos.js"></script>
    <script src="assets\js\script.min.js"></script>
	<script type="text/javascript" src="assets\js\noBack.js"></script>
    </body>
</html>