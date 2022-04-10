<%-- 
    Document   : eachQuestionStatistics
    Created on : 15 Jan, 2022, 1:23:47 PM
    Author     : SIVASANKAR
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/fmt" prefix = "fmt" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
    <title>Each Question Statistics</title>
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
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <link rel="icon" type="text/css" href="images/test.png">

    <style>
        .correct-icon {
            color: #009933;
        }
    </style>
</head>

<body id="page-top">
    <% 
        if(session.getAttribute("fid")==null)
        {
            response.sendRedirect("facultyLogin.jsp");
        }
    %>
    <% 
       if(session.getAttribute("eid")==null || session.getAttribute("listName")==null || session.getAttribute("totalMarks")==null)
        {
            response.sendRedirect("facultyHome.jsp");
        }
    %>
    <% 
        HttpSession ses1=request.getSession();
            ses1.setAttribute("studentsTableName", "students"+session.getAttribute("fid").toString());
            ses1.setAttribute("questionsTableName", "questions"+session.getAttribute("fid").toString());
            ses1.setAttribute("examSpecialTableName", "examSpecialTable"+session.getAttribute("eid").toString());
    %>
    
    <sql:setDataSource var="db" driver="com.mysql.jdbc.Driver" url="jdbc:mysql://localhost:3306/demo2?useSSL=false&allowPublicKeyRetrieval=true" user="siva" password="0000"/>
       
            
    <div id="wrapper">
        <nav class="navbar navbar-dark align-items-start sidebar sidebar-dark accordion bg-gradient-primary p-0" style="color: var(--bs-blue);background: var(--bs-success);">
            <div class="container-fluid d-flex flex-column p-0"><a class="navbar-brand d-flex justify-content-center align-items-center sidebar-brand m-0" href="#">
                    <div class="sidebar-brand-icon rotate-n-15"><i class="fas fa-laugh-wink"></i></div>
                    <div class="sidebar-brand-text mx-3"><span>exam portal</span></div>
                </a>
                <hr class="sidebar-divider my-0">
                <ul class="navbar-nav text-light" id="accordionSidebar">
                    <li class="nav-item"><a class="nav-link active" href="facultyHome.jsp"><i class="icon ion-ios-home"></i>&nbsp;Home</a></li>
                    <li class="nav-item"><a class="nav-link" href="addQuestionForm.jsp"><i class="fas fa-user-circle"></i><span>Add a Question</span></a></li>
                    <li class="nav-item"><a class="nav-link" href="questions.jsp"><i class="fas fa-user-circle"></i><span>Questions</span></a></li>
                    <li class="nav-item"><a class="nav-link" href="updateExamDetails.jsp"><i class="fas fa-user-circle"></i><span>Update Exam</span></a></li>
                    <li class="nav-item"><a class="nav-link" href="index.jsp"><i class="fas fa-tachometer-alt"></i><span>Dashboard</span></a></li>
                    <li class="nav-item"><a class="nav-link" href="viewFeedbacks.jsp"><i class="fas fa-user"></i><span>View Feedbacks</span></a></li>
                    <li class="nav-item"><a class="nav-link" href="viewStudentsOfGivenList.jsp"><i class="fas fa-table"></i><span>Students List (${sessionScope.listName})</span></a></li>
                    <li class="nav-item"><a class="nav-link" href="deleteExamYesNo.jsp"><i class="far fa-user-circle"></i><span>Delete Exam</span></a></li>
                    <li class="nav-item"><a class="nav-link" href="addStudentAndSendExamLink.jsp"><i class="fas fa-user-circle"></i><span>Add a new Student and Send Exam Link</span></a></li>
                    <li class="nav-item"></li>
                    <li class="nav-item"><a class="nav-link" href="uploadQuestionsFile.jsp"><i class="icon ion-pie-graph"></i>Upload Questions CSV</a></li>
                    
                        <li class="nav-item">
                            <form method="post" action="sendMailToStudent" class="nav-link">
                                <button type="submit" class="nav-link" style="all:unset;"><i class="far fa-user-circle"></i><span>Send Exam Link to Students</span></button>
                            </form>
                        </li>
                   
                    <sql:query dataSource="${db}" var="actresult">
                        select activation from exam where examId=?
                        <sql:param value="${sessionScope.eid}"/>
                    </sql:query>
                    <c:forEach var="row" items="${actresult.rows}">
                        <c:choose>
                            <c:when test="${row.activation!=1}">
                                <li class="nav-item">
                                    <form method="post" action="examResults.jsp" class="nav-link">
                                        <% 
                                            HttpSession ses=request.getSession();
                                            String resultsTableName = "results"+ses.getAttribute("eid").toString(); 
                                            ses.setAttribute("resultsTableName", resultsTableName);
                                        %>
                                        <button type="submit" class="nav-link" style="all:unset;"><i class="far fa-user-circle"></i><span>Results</span></button>
                                    </form>
                                </li>
                                <li class="nav-item"><a class="nav-link" href="activateTest.jsp"><i class="far fa-user-circle"></i><span>Activate Test</span></a></li>
                    
                            </c:when> 
                            
                            <c:otherwise>
                                <sql:query dataSource="${db}" var="aqatresult">
                                    select mode from exam where examId=?
                                    <sql:param value="${sessionScope.eid}"/>
                                </sql:query>
                                <c:forEach var="row2" items="${aqatresult.rows}">
                                    <c:if test="${row2.mode!=1}">
                                        <li class="nav-item">
                                            <form method="post" action="eachQuestionStatistics.jsp" class="nav-link">
                                                <% 
                                                    HttpSession ses2=request.getSession();
                                                    String examSpecialTableNameForStatistics = "examSpecialTable"+ses2.getAttribute("eid").toString(); 
                                                    ses2.setAttribute("examSpecialTableName", examSpecialTableNameForStatistics);
                                                %>
                                                <button type="submit" class="nav-link" style="all:unset;"><i class="far fa-user-circle"></i><span>Live Results</span></button>
                                            </form>
                                        </li>
                                    </c:if>
                                </c:forEach>
                                <li class="nav-item"><a class="nav-link" href="endTest.jsp"><i class="far fa-user-circle"></i><span>End Test</span></a></li>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                </ul>
                <div class="text-center d-none d-md-inline"><button class="btn rounded-circle border-0" id="sidebarToggle" type="button"></button></div>
            </div>
        </nav>
        <div class="d-flex flex-column" id="content-wrapper">
            <div id="content" style="background: #ffffff;height: 575px;">
                <nav class="navbar navbar-light navbar-expand bg-white shadow mb-4 topbar static-top">
                    <div class="container-fluid"><button class="btn btn-link d-md-none rounded-circle me-3" id="sidebarToggleTop" type="button"><i class="fas fa-bars"></i></button>
                        <form class="d-none d-sm-inline-block me-auto ms-md-3 my-2 my-md-0 mw-100 navbar-search">
                            <div class="input-group"><input class="bg-light form-control border-0 small" type="text" placeholder="Search for ..."><button class="btn btn-primary py-0" type="button" style="background: var(--bs-success);"><i class="fas fa-search"></i></button></div>
                        </form>
                        <ul class="navbar-nav flex-nowrap ms-auto">
                            <li class="nav-item dropdown d-sm-none no-arrow"><a class="dropdown-toggle nav-link" aria-expanded="false" data-bs-toggle="dropdown" href="#"><i class="fas fa-search"></i></a>
                                <div class="dropdown-menu dropdown-menu-end p-3 animated--grow-in" aria-labelledby="searchDropdown">
                                    <form class="me-auto navbar-search w-100">
                                        <div class="input-group"><input class="bg-light form-control border-0 small" type="text" placeholder="Search for ...">
                                            <div class="input-group-append"><button class="btn btn-primary py-0" type="button"><i class="fas fa-search"></i></button></div>
                                        </div>
                                    </form>
                                </div>
                            </li>
                            <li class="nav-item dropdown no-arrow mx-1">
                                <div class="nav-item dropdown no-arrow"><a class="dropdown-toggle nav-link" aria-expanded="false" data-bs-toggle="dropdown" href="#"><span class="badge bg-danger badge-counter">3+</span><i class="fas fa-bell fa-fw"></i></a>
                                    <div class="dropdown-menu dropdown-menu-end dropdown-list animated--grow-in">
                                        <h6 class="dropdown-header">alerts center</h6><a class="dropdown-item d-flex align-items-center" href="#">
                                            <div class="me-3">
                                                <div class="bg-primary icon-circle"><i class="fas fa-file-alt text-white"></i></div>
                                            </div>
                                            <div><span class="small text-gray-500">December 12, 2019</span>
                                                <p>A new monthly report is ready to download!</p>
                                            </div>
                                        </a><a class="dropdown-item d-flex align-items-center" href="#">
                                            <div class="me-3">
                                                <div class="bg-success icon-circle"><i class="fas fa-donate text-white"></i></div>
                                            </div>
                                            <div><span class="small text-gray-500">December 7, 2019</span>
                                                <p>$290.29 has been deposited into your account!</p>
                                            </div>
                                        </a><a class="dropdown-item d-flex align-items-center" href="#">
                                            <div class="me-3">
                                                <div class="bg-warning icon-circle"><i class="fas fa-exclamation-triangle text-white"></i></div>
                                            </div>
                                            <div><span class="small text-gray-500">December 2, 2019</span>
                                                <p>Spending Alert: We've noticed unusually high spending for your account.</p>
                                            </div>
                                        </a><a class="dropdown-item text-center small text-gray-500" href="#">Show All Alerts</a>
                                    </div>
                                </div>
                            </li>
                            <li class="nav-item dropdown no-arrow mx-1">
                                <div class="nav-item dropdown no-arrow"><a class="dropdown-toggle nav-link" aria-expanded="false" data-bs-toggle="dropdown" href="#"><span class="badge bg-danger badge-counter">7</span><i class="fas fa-envelope fa-fw"></i></a>
                                    <div class="dropdown-menu dropdown-menu-end dropdown-list animated--grow-in">
                                        <h6 class="dropdown-header">alerts center</h6><a class="dropdown-item d-flex align-items-center" href="#">
                                            <div class="dropdown-list-image me-3"><img class="rounded-circle" src="assets/img/avatars/avatar4.jpeg">
                                                <div class="bg-success status-indicator"></div>
                                            </div>
                                            <div class="fw-bold">
                                                <div class="text-truncate"><span>Hi there! I am wondering if you can help me with a problem I've been having.</span></div>
                                                <p class="small text-gray-500 mb-0">Emily Fowler - 58m</p>
                                            </div>
                                        </a><a class="dropdown-item d-flex align-items-center" href="#">
                                            <div class="dropdown-list-image me-3"><img class="rounded-circle" src="assets/img/avatars/avatar2.jpeg">
                                                <div class="status-indicator"></div>
                                            </div>
                                            <div class="fw-bold">
                                                <div class="text-truncate"><span>I have the photos that you ordered last month!</span></div>
                                                <p class="small text-gray-500 mb-0">Jae Chun - 1d</p>
                                            </div>
                                        </a><a class="dropdown-item d-flex align-items-center" href="#">
                                            <div class="dropdown-list-image me-3"><img class="rounded-circle" src="assets/img/avatars/avatar3.jpeg">
                                                <div class="bg-warning status-indicator"></div>
                                            </div>
                                            <div class="fw-bold">
                                                <div class="text-truncate"><span>Last month's report looks great, I am very happy with the progress so far, keep up the good work!</span></div>
                                                <p class="small text-gray-500 mb-0">Morgan Alvarez - 2d</p>
                                            </div>
                                        </a><a class="dropdown-item d-flex align-items-center" href="#">
                                            <div class="dropdown-list-image me-3"><img class="rounded-circle" src="assets/img/avatars/avatar5.jpeg">
                                                <div class="bg-success status-indicator"></div>
                                            </div>
                                            <div class="fw-bold">
                                                <div class="text-truncate"><span>Am I a good boy? The reason I ask is because someone told me that people say this to all dogs, even if they aren't good...</span></div>
                                                <p class="small text-gray-500 mb-0">Chicken the Dog · 2w</p>
                                            </div>
                                        </a><a class="dropdown-item text-center small text-gray-500" href="#">Show All Alerts</a>
                                    </div>
                                </div>
                                <div class="shadow dropdown-list dropdown-menu dropdown-menu-end" aria-labelledby="alertsDropdown"></div>
                            </li>
                            <div class="d-none d-sm-block topbar-divider"></div>
                            <li class="nav-item dropdown no-arrow">
                                <div class="nav-item dropdown no-arrow"><a class="dropdown-toggle nav-link" aria-expanded="false" data-bs-toggle="dropdown" href="#"><span class="d-none d-lg-inline me-2 text-gray-600 small"><jsp:include page="facultyName.jsp"/></span><img class="border rounded-circle img-profile" src="assets/img/195-1957039_bapatla-engineering-college-logo-hd-png-download-removebg-preview.png"></a>
                                    <div class="dropdown-menu shadow dropdown-menu-end animated--grow-in"><a class="dropdown-item" href="#"><i class="fas fa-user fa-sm fa-fw me-2 text-gray-400"></i>&nbsp;Profile</a><a class="dropdown-item" href="#"><i class="fas fa-cogs fa-sm fa-fw me-2 text-gray-400"></i>&nbsp;Settings</a><a class="dropdown-item" href="#"><i class="fas fa-list fa-sm fa-fw me-2 text-gray-400"></i>&nbsp;Activity log</a>
                                        <div class="dropdown-divider"></div><a class="dropdown-item" href="facultyLogout"><i class="fas fa-sign-out-alt fa-sm fa-fw me-2 text-gray-400"></i>&nbsp;Logout</a>
                                    </div>
                                </div>
                            </li>
                        </ul>
                    </div>
                </nav>
                <div class="container-fluid">
                    <h3 class="text-dark mb-1">Each Question Statistics</h3>
                </div>
                
            
                <div class="card">
                    <div class="container mt-5">
                    <sql:query dataSource="${db}" var="result1">
                        select count(studentId) studentsCount from ${sessionScope.studentsTableName} where listName=(select listName from exam where examId=?)
                        <sql:param value="${sessionScope.eid}"/>
                    </sql:query>

                    <sql:query dataSource="${db}" var="result2">
                        select questionId,questionName,opt1,opt2,opt3,opt4,isBlankType,ans from ${sessionScope.questionsTableName} where examId=?
                        <sql:param value="${sessionScope.eid}"/>
                    </sql:query>
                    <c:forEach var="qdata" items="${result2.rows}">
                    <div class="jumbotron bg-success">
                        <h3 class="bg-dark text-light rounded my-2">${qdata.questionName}</h3>
                        <h3 class="rounded text-center text-light" style="background-color:royalblue">Correct Option(s): ${qdata.ans}</h3>
                        <form method="post" action="addMarkToAllStudents.jsp">
                            <input type="hidden" name="qid" value="${qdata.questionId}">
                            <input type="submit" value="Add Marks to all students" class="btn btn-secondary">                                
                        </form>
                        <sql:query dataSource="${db}" var="result3">
                            select count(regdNo) correct from ${sessionScope.examSpecialTableName} where marksObtained>0 and qid=?
                            
                            <sql:param value="${qdata.questionId}"/>
                        </sql:query>
                        <sql:query dataSource="${db}" var="result4">
                            select count(regdNo) bothcw from ${sessionScope.examSpecialTableName} where qid=? and marksObtained is not null and selectedOptions is not null;
                            <sql:param value="${qdata.questionId}"/>
                        </sql:query>
                            
                        <sql:query dataSource="${db}" var="result5">
                            select count(regdNo) skippersCount from ${sessionScope.examSpecialTableName} where qid=? and selectedOptions is null;
                            <sql:param value="${qdata.questionId}"/>
                        </sql:query>
                         
         
                        <sql:query dataSource="${db}" var="result6">
                            select count(regdNo) opt1Count from ${sessionScope.examSpecialTableName} where qid=? and selectedOptions like '%1%';
                            <sql:param value="${qdata.questionId}"/>
                        </sql:query>
                        <sql:query dataSource="${db}" var="result7">
                            select count(regdNo) opt2Count from ${sessionScope.examSpecialTableName} where qid=? and selectedOptions like '%2%';
                            <sql:param value="${qdata.questionId}"/>
                        </sql:query>
                        <sql:query dataSource="${db}" var="result8">
                            select count(regdNo) opt3Count from ${sessionScope.examSpecialTableName} where qid=? and selectedOptions like '%3%';
                            <sql:param value="${qdata.questionId}"/>
                        </sql:query>
                        <sql:query dataSource="${db}" var="result9">
                            select count(regdNo) opt4Count from ${sessionScope.examSpecialTableName} where qid=? and selectedOptions like '%4%';
                            <sql:param value="${qdata.questionId}"/>
                        </sql:query>
                        
                          
                        <c:forEach var="r1data" items="${result1.rows}">
                            <c:forEach var="r3data" items="${result3.rows}">
                                <c:forEach var="r4data" items="${result4.rows}">
                                    <c:forEach var="r5data" items="${result5.rows}">
                                        <c:forEach var="r6data" items="${result6.rows}">
                                            <c:forEach var="r7data" items="${result7.rows}">
                                                <c:forEach var="r8data" items="${result8.rows}">
                                                    <c:forEach var="r9data" items="${result9.rows}">
                                                <div class="row">
                                                    <div class="col-lg-7 col-xl-8">
                                                        <span style="font-size: 25px;"><c:out value="${r4data.bothcw}"/></span>
                                                            <c:out value=" no. of students attempted this question"/><br/>
                                                        <span style="font-size: 25px;"><c:out value="${r3data.correct}"/></span>
                                                            <c:out value=" no. of students correctly answered this question"/><br/>    
                                                        <span style="font-size: 25px;"><c:out value="${r4data.bothcw-r3data.correct}"/></span>
                                                            <c:out value=" no. of students wrongly answered this question"/><br/>
                                                        <span style="font-size: 25px;"><c:out value="${r5data.skippersCount}"/></span>
                                                            <c:out value=" no. of students who skipped or unanswered this question"/><br/>
                                                        
                                                        <span style="font-size: 25px;"><fmt:formatNumber type="number" maxFractionDigits="2" minFractionDigits="2" value="${(r3data.correct*100)/r4data.bothcw}"/></span>
                                                        <span style="font-size: 25px;"><c:out value="%"/></span>
                                                            <c:out value=" of students answered correctly"/><br/>
                                                        <span style="font-size: 25px;"><fmt:formatNumber type="number" maxFractionDigits="2" minFractionDigits="2" value="${((r4data.bothcw-r3data.correct)*100)/r4data.bothcw}"/></span>
                                                        
                                                        <span style="font-size: 25px;"><c:out value="%"/></span>
                                                            <c:out value=" of students wrongly answered"/><br/>
                                                        <span style="font-size: 25px;"><c:out value="${r1data.studentsCount-r4data.bothcw-r5data.skippersCount}"/></span>
                                                            <c:out value=" students still need to answer this question"/><br/><br/>
                                                        <c:if test="${qdata.isBlankType==0}">      
                                                            <c:out value="Percentage of students selected "/>
                                                            <span style="font-size: 25px;"><c:out value="${qdata.opt1}"/></span>
                                                            <c:out value="(option1) is: "/>
                                                            <span style="font-size: 25px;"><fmt:formatNumber type="number" maxFractionDigits="2" minFractionDigits="2" value="${((r6data.opt1Count)*100)/r4data.bothcw}"/></span>

                                                            <span style="font-size: 25px;"><c:out value="%"/></span><br/>

                                                            <c:out value="Percentage of students selected "/>
                                                            <span style="font-size: 25px;"><c:out value="${qdata.opt2}"/></span>
                                                            <c:out value="(option2) is: "/>
                                                            <span style="font-size: 25px;"><fmt:formatNumber type="number" maxFractionDigits="2" minFractionDigits="2" value="${((r7data.opt2Count)*100)/r4data.bothcw}"/></span>

                                                            <span style="font-size: 25px;"><c:out value="%"/></span><br/>

                                                            <c:if test='${qdata.opt3!="" && qdata.opt3!=null}'>
                                                                <c:out value="Percentage of students selected "/>
                                                                <span style="font-size: 25px;"><c:out value="${qdata.opt3}"/></span>
                                                                <c:out value="(option3) is: "/>
                                                                <span style="font-size: 25px;"><fmt:formatNumber type="number" maxFractionDigits="2" minFractionDigits="2" value="${((r8data.opt3Count)*100)/r4data.bothcw}"/></span>

                                                                <span style="font-size: 25px;"><c:out value="%"/></span><br/>
                                                            </c:if>
                                                            <c:if test='${qdata.opt4!="" && qdata.opt4!=null}'>
                                                                <c:out value="Percentage of students selected "/>
                                                                <span style="font-size: 25px;"><c:out value="${qdata.opt4}"/></span>
                                                                <c:out value="(option4) is: "/>
                                                                <span style="font-size: 25px;"><fmt:formatNumber type="number" maxFractionDigits="2" minFractionDigits="2" value="${((r9data.opt4Count)*100)/r4data.bothcw}"/></span>

                                                                <span style="font-size: 25px;"><c:out value="%"/></span><br/>
                                                            </c:if>
                                                        </c:if>
                                                        <c:if test="${qdata.isBlankType==1}">
                                                            <c:out value="Correct Answer : "/>
                                                            <span style="font-size: 25px;"><c:out value="${qdata.ans}"/></span> 
                                                        </c:if>
                                                    </div>
                                                    <div class="col-lg-5 col-xl-4">
                                                        <div class="card-body">
                                                            <div class="chart-area"><canvas data-bss-chart="{&quot;type&quot;:&quot;doughnut&quot;,&quot;data&quot;:{&quot;labels&quot;:[&quot;Correct&quot;,&quot;Wrong&quot;,&quot;Unanswered&quot;,&quot;Unseen&quot;],&quot;datasets&quot;:[{&quot;label&quot;:&quot;&quot;,&quot;backgroundColor&quot;:[&quot;#009933&quot;,&quot;#e60000&quot;,&quot;#e69500&quot;,&quot;#00cccc&quot;],&quot;borderColor&quot;:[&quot;#ffffff&quot;,&quot;#ffffff&quot;,&quot;#ffffff&quot;,&quot;#ffffff&quot;],&quot;data&quot;:[&quot;${r3data.correct}&quot;,&quot;${r4data.bothcw-r3data.correct}&quot;,&quot;${r5data.skippersCount}&quot;,&quot;${r1data.studentsCount-r4data.bothcw-r5data.skippersCount}&quot;]}]},&quot;options&quot;:{&quot;maintainAspectRatio&quot;:false,&quot;legend&quot;:{&quot;display&quot;:false,&quot;labels&quot;:{&quot;fontStyle&quot;:&quot;normal&quot;}},&quot;title&quot;:{&quot;fontStyle&quot;:&quot;normal&quot;}}}"></canvas></div>
                                                            <div class="text-center small mt-4"><span class="me-2"><i class="fas fa-circle correct-icon"></i>&nbsp;Correct</span><span class="me-2"><i class="fas fa-circle text-danger"></i>&nbsp;Wrong</span><span class="me-2"><i class="fas fa-circle text-warning"></i>&nbsp;Skipped</span><span class="me-2"><i class="fas fa-circle text-info"></i>&nbsp;Unseen</span></div>
                                                        </div>
                                                    </div>
                                                    
                                                </div>
                                                <c:if test="${qdata.isBlankType==0}">       
                                                    <div class="row">
                                                         <div class="col-lg-10 col-xl-4">
                                                             <div class="card-body">
                                                                 <div class="chart-area"><canvas data-bss-chart="{&quot;type&quot;:&quot;bar&quot;,&quot;data&quot;:{&quot;labels&quot;:[&quot;Option1&quot;,&quot;Option2&quot;,&quot;Option3&quot;,&quot;Option4&quot;],&quot;datasets&quot;:[{&quot;label&quot;:&quot;Answered&quot;,&quot;backgroundColor&quot;:&quot;#4e73df&quot;,&quot;borderColor&quot;:&quot;#4e73df&quot;,&quot;data&quot;:[&quot;${r6data.opt1Count}&quot;,&quot;${r7data.opt2Count}&quot;,&quot;${r8data.opt3Count}&quot;,&quot;${r9data.opt4Count}&quot;]}]},&quot;options&quot;:{&quot;maintainAspectRatio&quot;:false,&quot;legend&quot;:{&quot;display&quot;:false,&quot;labels&quot;:{&quot;fontStyle&quot;:&quot;normal&quot;}},&quot;title&quot;:{&quot;fontStyle&quot;:&quot;normal&quot;},&quot;scales&quot;:{&quot;xAxes&quot;:[{&quot;gridLines&quot;:{&quot;color&quot;:&quot;rgb(234, 236, 244)&quot;,&quot;zeroLineColor&quot;:&quot;rgb(234, 236, 244)&quot;,&quot;drawBorder&quot;:false,&quot;drawTicks&quot;:false,&quot;borderDash&quot;:[&quot;2&quot;],&quot;zeroLineBorderDash&quot;:[&quot;2&quot;],&quot;drawOnChartArea&quot;:false},&quot;ticks&quot;:{&quot;fontColor&quot;:&quot;#858796&quot;,&quot;fontStyle&quot;:&quot;normal&quot;,&quot;padding&quot;:20}}],&quot;yAxes&quot;:[{&quot;gridLines&quot;:{&quot;color&quot;:&quot;rgb(234, 236, 244)&quot;,&quot;zeroLineColor&quot;:&quot;rgb(234, 236, 244)&quot;,&quot;drawBorder&quot;:false,&quot;drawTicks&quot;:false,&quot;borderDash&quot;:[&quot;2&quot;],&quot;zeroLineBorderDash&quot;:[&quot;2&quot;]},&quot;ticks&quot;:{&quot;fontColor&quot;:&quot;#858796&quot;,&quot;fontStyle&quot;:&quot;normal&quot;,&quot;padding&quot;:20}}]}}}"></canvas></div>
                                                             </div>  
                                                             <div class="card-body">
                                                                 <div id="${qdata.questionId}" style="width:600px;max-width:1200px; height:400px;"></div>

                                                                    <script>
                                                                    google.charts.load('current', {'packages':['corechart']});
                                                                    google.charts.setOnLoadCallback(drawChart);

                                                                    function drawChart() {
                                                                    var data = google.visualization.arrayToDataTable([
                                                                      ['Answers', 'Answers'],
                                                                      ['Option1',${r6data.opt1Count}],
                                                                      ['Option2',${r7data.opt2Count}],
                                                                      ['Option3',${r8data.opt3Count}],
                                                                      ['Option4',${r9data.opt4Count}],
                                                                    ]);

                                                                    var options = {
                                                                      title:'Options Opted By Students',
                                                                      backgroundColor: 'transparent',
                                                                    };

                                                                    var chart = new google.visualization.BarChart(document.getElementById('${qdata.questionId}'));
                                                                      chart.draw(data, options);
                                                                    }
                                                                    </script>
                                                             </div>     
                                                         </div>   
                                                    </div>
                                                </c:if>            
                                                    <br/>
                                                    </c:forEach>
                                                </c:forEach>
                                            </c:forEach>
                                        </c:forEach>
                                    </c:forEach>
                                </c:forEach>
                            </c:forEach>
                        </c:forEach>                   
                    </div>
                </c:forEach>
                    
                    
                    
                    
                </div>
            </div>
            <footer class="bg-white sticky-footer">
                <div class="container my-auto">
                    <div class="text-center my-auto copyright"><span>Copyright © BEC 2021</span></div>
                </div>
            </footer>
        </div><a class="border rounded d-inline scroll-to-top" href="#page-top"><i class="fas fa-angle-up"></i></a>
    </div>
    </div>
    <script src="assets\bootstrap\js\bootstrap.min.js"></script>
    <script src="assets\js\chart.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/aos/2.3.4/aos.js"></script>
    <script src="assets\js\script.min.js"></script>
    <script type="text/javascript" src="assets\js\noBack.js"></script>
    
</body>

</html>
