<%-- 
    Document   : accessTestQuestionTimeLimitDisplay1
    Created on : 15 Mar, 2022, 8:30:50 PM
    Author     : SIVASANKAR
--%>

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
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
        <style>
            #overlay{
                position: absolute;
                opacity: 0.3;
                transform:rotate(-45deg);
                overflow-y: hidden;
                overflow-x: hidden;
                overflow-wrap: break-word;
                margin-left: 200px;
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
            }
        });
        </script>
    </head>
    
    <body id="page-top" style="padding: 5;">
       
       
        <br/>
        <center>
            <p id="timeLimit" class="bg-warning rounded text-center" style="width:125px; color: black; position: static;">Timer</p>
        </center>
        
        <c:if test='${Integer.parseInt(sessionScope.n)<questionsRecords.size()}'>
            
            <% int n3=Integer.parseInt(session.getAttribute("n").toString()); %>
            <% Questions que=(Questions)questionsRecords.get(n3); %>
            
            <% session.setAttribute("timeLimitMinutes", que.getMinutesTimeLimit()); %>
            <% session.setAttribute("timeLimitSeconds", que.getSecondsTimeLimit()); %>           
                        
        <script type="text/javascript">     
           
            // Set the date we're counting down to
            var countDownDate1 = new Date();
            countDownDate1.setSeconds(countDownDate1.getSeconds()+${sessionScope.timeLimitSeconds});
            countDownDate1.setMinutes(countDownDate1.getMinutes()+${sessionScope.timeLimitMinutes});
            
            var countDownDate2=countDownDate1.getTime();
            // Update the count down every 1 second
            
            function submitform()
            {
                document.forms["myform"].submit();
            }
            
            var x2 = setInterval(function() {

              // Get today's date and time
              var now = new Date().getTime();

              // Find the distance between now and the count down date
              var distance = countDownDate2 - now;

              // Time calculations for days, hours, minutes and seconds
              //var days = Math.floor(distance / (1000 * 60 * 60 * 24));
              var hours = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
              var minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
              var seconds = Math.floor((distance % (1000 * 60)) / 1000);

              // Output the result in an element with id="demo"
              document.getElementById("timeLimit").innerHTML = hours + "h "
              + minutes + "m " + seconds + "s ";

              // If the count down is over, write some text 
              if (distance < 0) {
                clearInterval(x2);
                submitform();
                //window.location.replace("http://127.0.0.1:8080/Online%20Examination%20System/LiveResults");
              }
            }, 1000);
        </script>
        </c:if>
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
    <div id="wrapper">
        <div class="d-flex flex-column" id="content-wrapper">
            <div id="content" style="border-color: var(--bs-success);">
                
                <form action="calculateMarksForAStudent" method="get" target="_parent" class="form-control">
                
                <nav class="navbar navbar-light navbar-expand bg-white shadow mb-4 topbar static-top" style="background: var(--bs-success);color: var(--bs-success);">
                    <div class="container-fluid"><button class="btn btn-link d-md-none rounded-circle me-3" id="sidebarToggleTop" type="button" style="background: var(--bs-success);"><i class="fas fa-bars"></i></button>
                        <h1>Online Exam Portal</h1><button type="submit" class="btn btn-success btn-icon-split" role="button"><span class="text-white-50 icon"><i class="typcn typcn-chevron-right"></i></span><span class="text-white text">Submit Test</span></button>
                    </div>
                </nav>
                
                    
                </form>
        <%
        if(session.getAttribute("examId")!=null && session.getAttribute("regdNo")!=null)
        {  %>
            <c:choose>
                <c:when test='${Integer.parseInt(sessionScope.n)<questionsRecords.size()}'>
                    <form action="LiveResults" method="post" class="form-control" name="myform" id="myform">
                        <% int n2=Integer.parseInt(session.getAttribute("n").toString()); %>
                        <% Questions q=(Questions)questionsRecords.get(n2); %>
                        <% session.setAttribute("qobj", q); %>
                        <p class="bg-danger rounded" style="margin-right:50px; float: right; color: black;">&nbsp;&nbsp;<% out.println(-q.getNegativeMarks()); %>&nbsp;&nbsp;</p>
                        <p class="bg-success rounded" style="margin-right:3px; float: right; color: black;">&nbsp;&nbsp;<% out.println("+"+q.getQuestionMarks()); %>&nbsp;&nbsp;</p>
                        
                        
                        <% if(q.getQuestionType()==1){ %>
                            
                                    <div id="overlay">
                                        ${sessionScope.regdNo}&nbsp;&nbsp;${sessionScope.regdNo}&nbsp;&nbsp;${sessionScope.regdNo}<br/>
                                        ${sessionScope.regdNo}&nbsp;&nbsp;${sessionScope.regdNo}&nbsp;&nbsp;${sessionScope.regdNo}<br/>
                                        ${sessionScope.regdNo}&nbsp;&nbsp;${sessionScope.regdNo}&nbsp;&nbsp;${sessionScope.regdNo}<br/>
                                        ${sessionScope.regdNo}&nbsp;&nbsp;${sessionScope.regdNo}&nbsp;&nbsp;${sessionScope.regdNo}<br/>
                                        ${sessionScope.regdNo}&nbsp;&nbsp;${sessionScope.regdNo}&nbsp;&nbsp;${sessionScope.regdNo}<br/>
                                        ${sessionScope.regdNo}&nbsp;&nbsp;${sessionScope.regdNo}&nbsp;&nbsp;${sessionScope.regdNo}
                                    </div>
                                        <h4 class="card-title" style="user-select:none;"><% out.println(n2+1+"."+q.getQuestionName()); %></h4>
                                        <%
                                        if(q.getQuestionNameImg()!=null && !q.getQuestionNameImg().equals("")){
                                                %><br/><div style="background-color:lightgray;"><img src="<%= q.getQuestionNameImg() %>" alt="Image Loading" height="200px" width="100%"></div><br/><%
                                         } %>
                                    <input type="text" name="blankTypeName" placeholder="Enter your answer here" class="form-control">
                           
                        <% } 
                            else if(q.getQuestionType()==0){  %>

                               
                                    <div id="overlay">
                                        ${sessionScope.regdNo}&nbsp;&nbsp;${sessionScope.regdNo}&nbsp;&nbsp;${sessionScope.regdNo}<br/>
                                        ${sessionScope.regdNo}&nbsp;&nbsp;${sessionScope.regdNo}&nbsp;&nbsp;${sessionScope.regdNo}<br/>
                                        ${sessionScope.regdNo}&nbsp;&nbsp;${sessionScope.regdNo}&nbsp;&nbsp;${sessionScope.regdNo}<br/>
                                        ${sessionScope.regdNo}&nbsp;&nbsp;${sessionScope.regdNo}&nbsp;&nbsp;${sessionScope.regdNo}<br/>
                                        ${sessionScope.regdNo}&nbsp;&nbsp;${sessionScope.regdNo}&nbsp;&nbsp;${sessionScope.regdNo}<br/>
                                        ${sessionScope.regdNo}&nbsp;&nbsp;${sessionScope.regdNo}&nbsp;&nbsp;${sessionScope.regdNo}
                                    </div>
                                    <h4 class="card-title" style="user-select:none;"><% out.println(n2+1+"."+q.getQuestionName()); %></h4>
                                    <%
                                        if(q.getQuestionNameImg()!=null && !q.getQuestionNameImg().equals("")){
                                                %><br/><div style="background-color:lightgray;"><img src="<%= q.getQuestionNameImg() %>" alt="Image Loading" height="200px" width="100%"></div><br/><%
                                         } %>
                                    <h6 class="text-muted card-subtitle mb-2">Select from following options</h6>

                                    
                                    <%
                                    for(int j=0;j<4;j++)
                                    {
                                        if( (q.getOptions().get(j)!=null && !q.getOptions().get(j).equals("")) || (q.getOptionsImages().get(j)!=null && !q.getOptionsImages().get(j).equals("")) )
                                        {
                                            %><div class="form-check"><input class="form-check-input" type="radio" name="radioName" value="<%= q.getOptionNumbers().get(j) %>" id="formCheck-<%= q.getOptionNumbers().get(j) %>"><label class="form-check-label" for="formCheck-<%= q.getOptionNumbers().get(j) %>">
                                            <%
                                        }
                                        if(q.getOptions().get(j)!=null && !q.getOptions().get(j).equals("")){ 
                                            out.print(q.getOptions().get(j));
                                            
                                        }
                                        if(q.getOptionsImages().get(j)!=null && !q.getOptionsImages().get(j).equals("")){ 
                                            %>
                                            <br/><img src="<%= q.getOptionsImages().get(j) %>" alt="Image Loading" height="200px" width="100%">
                                        <%
                                          
                                        }
                                        if( (q.getOptions().get(j)!=null && !q.getOptions().get(j).equals("")) || (q.getOptionsImages().get(j)!=null && !q.getOptionsImages().get(j).equals("")) )
                                        {
                                            %></label></div><br/> <% 
                                        }

                                    }
                                
                                    %>

                            <% } else { %>
                               
                                    <div id="overlay">
                                        ${sessionScope.regdNo}&nbsp;&nbsp;${sessionScope.regdNo}&nbsp;&nbsp;${sessionScope.regdNo}<br/>
                                        ${sessionScope.regdNo}&nbsp;&nbsp;${sessionScope.regdNo}&nbsp;&nbsp;${sessionScope.regdNo}<br/>
                                        ${sessionScope.regdNo}&nbsp;&nbsp;${sessionScope.regdNo}&nbsp;&nbsp;${sessionScope.regdNo}<br/>
                                        ${sessionScope.regdNo}&nbsp;&nbsp;${sessionScope.regdNo}&nbsp;&nbsp;${sessionScope.regdNo}<br/>
                                        ${sessionScope.regdNo}&nbsp;&nbsp;${sessionScope.regdNo}&nbsp;&nbsp;${sessionScope.regdNo}<br/>
                                        ${sessionScope.regdNo}&nbsp;&nbsp;${sessionScope.regdNo}&nbsp;&nbsp;${sessionScope.regdNo}
                                    </div>

                                   <h4 class="card-title" style="user-select:none;"><% out.println(n2+1+"."+q.getQuestionName()); %></h4>
                                   <%
                                        if(q.getQuestionNameImg()!=null && !q.getQuestionNameImg().equals("")){
                                                %><br/><div style="background-color:lightgray;"><img src="<%= q.getQuestionNameImg() %>" alt="Image Loading" height="200px" width="100%"></div><br/><%
                                         } %>
                                    <h6 class="text-muted card-subtitle mb-2">Select from following options</h6>
                                    
                                    <%
                                    for(int j=0;j<4;j++)
                                    {
                                        if( (q.getOptions().get(j)!=null && !q.getOptions().get(j).equals("")) || (q.getOptionsImages().get(j)!=null && !q.getOptionsImages().get(j).equals("")) )
                                        { 
                                        %><div class="form-check"><input class="form-check-input" type="checkbox" name="checkboxname" value="<%= q.getOptionNumbers().get(j) %>" id="formCheck-<%= q.getOptionNumbers().get(j) %>"><label class="form-check-label" for="formCheck-<%= q.getOptionNumbers().get(j) %>"><%
                                        }
                                        if(q.getOptions().get(j)!=null && !q.getOptions().get(j).equals("")){ 
                                            out.print(q.getOptions().get(j));
                                            out.print("\n");
                                        }
                                        if(q.getOptionsImages().get(j)!=null && !q.getOptionsImages().get(j).equals("")){ 
                                            %>
                                            <br/><img src="<%= q.getOptionsImages().get(j) %>" alt="Image Loading" height="200px" width="100%">
                                        <%
                                        }
                                        if( (q.getOptions().get(j)!=null && !q.getOptions().get(j).equals("")) || (q.getOptionsImages().get(j)!=null && !q.getOptionsImages().get(j).equals("")) )
                                        {
                                            %></label></div><br/> <% 
                                        }
                                    
                                    } %>
                                    
                                   

                            <% } %>
                        <input type="submit" value="Submit" class="btn btn-success form-control">

                    </form>
                </c:when>
                <c:otherwise>
                    
                   <form action="calculateMarksForAStudent" method="get" target="_parent" class="form-control" name="myform2">
                       <input type="submit" value="Final Submit" class="bg-success">
                   </form>
                    
                </c:otherwise>
            </c:choose>
        <%
         }
        %>
        </div>
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
