<%-- 
    Document   : questions
    Created on : 3 Dec, 2021, 12:22:29 PM
    Author     : SIVASANKAR
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
    <title>Questions</title>
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
        HttpSession ses3=request.getSession();
        String questionsTableName = "questions"+ses3.getAttribute("fid").toString(); 
        ses3.setAttribute("questionsTableName", questionsTableName);
    %>
    
    <sql:setDataSource var="db" driver="com.mysql.jdbc.Driver" url="jdbc:mysql://localhost:3306/demo2?useSSL=false&allowPublicKeyRetrieval=true" user="siva" password="0000"/>
        <sql:query dataSource="${db}" var="result">
            select * from exam where facultyId=?
            <sql:param value="${sessionScope.fid}"/>
        </sql:query>
            
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
                    <li class="nav-item"><a class="nav-link" href="deleteExam.jsp"><i class="far fa-user-circle"></i><span>Delete Exam</span></a></li>
                    <li class="nav-item"><a class="nav-link" href="addStudentAndSendExamLink.jsp"><i class="fas fa-user-circle"></i><span>Add a new Student and Send Exam Link</span></a></li>
                    <li class="nav-item"></li>
                    <li class="nav-item"><a class="nav-link" href="uploadQuestionsFile.jsp"><i class="icon ion-pie-graph"></i>Upload Questions CSV</a></li>
                       <li class="nav-item">
                            <form method="post" action="sendMailToStudentsYesOrNo.jsp" class="nav-link">
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
                    <h3 class="text-dark mb-1">Added Questions</h3>
                </div>
                <div class="container mt-5">
            <c:choose>
                <c:when test="${sessionScope.message==null}">
                    
                </c:when>
                
                <c:when test="${sessionScope.message=='success'}">
                    <div class="alert alert-dismissible bg-success fade show" id="dismiss">
                        <div><strong>Success! </strong>Question updated Successfully</div>
                        <a href="#" class="close" data-dismiss="alert" id="x" aria-label="close">&times;</a>
                    </div>
                    <c:remove var="message" scope="session"/>
                </c:when>
                <c:otherwise>
                    <div class="alert alert-dismissible bg-danger fade show" id="dismiss">
                        <div><strong>Failed! </strong>Question failed to update</div>
                        <a href="#" class="close" data-dismiss="alert" id="x" aria-label="close">&times;</a>
                    </div>
                    <c:remove var="message" scope="session"/>
                </c:otherwise>
                 
            </c:choose>
            
            <div class="container rounded bg-success">
                <sql:query dataSource="${db}" var="totalMarksResult">
                    select count(questionName) qcount,sum(questionMarks) marksAssignedTillNow from ${sessionScope.questionsTableName} where examId=?
                        <sql:param value="${sessionScope.eid}"/>
                    </sql:query>
                    <c:forEach var="row" items="${totalMarksResult.rows}">
                        <c:out value="No. of Questions added till now: "/>
                        <span style="font-size: 25px;"><c:out value="${row.qcount}"/></span><br/>
                        <c:choose>
                            <c:when test="${Integer.parseInt(sessionScope.totalMarks)-row.marksAssignedTillNow>0}">
                                <c:out value="Still need to assign "/>
                                <span style="font-size: 25px;"><c:out value="${Integer.parseInt(sessionScope.totalMarks)-row.marksAssignedTillNow}"/></span>
                                <c:out value=" more marks"/>
                            </c:when>
                            <c:when test="${Integer.parseInt(sessionScope.totalMarks)-row.marksAssignedTillNow<0}">
                                <c:out value="You have given some "/>
                                <span style="font-size: 25px;"><c:out value="${row.marksAssignedTillNow-Integer.parseInt(sessionScope.totalMarks)}"/></span>
                                <c:out value=" more marks than you think"/><br/>
                            </c:when>
                            <c:otherwise>
                                <c:out value="Marks are perfectly equal to total marks"/>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>              
            </div>
                
                    <sql:query dataSource="${db}" var="result">
                        select * from ${questionsTableName} where examId=?
                        <sql:param value="${sessionScope.eid}"/>
                    </sql:query>
                    <div class="container-fluid">
                    <h3 class="text-dark mb-4">Questions</h3>
                    <div class="card shadow">
                        <div class="card-body">
                            <div class="row">
                                <div class="col-md-6 text-nowrap">
                                    <div id="dataTable_length" class="dataTables_length" aria-controls="dataTable"><label class="form-label">Show&nbsp;<select class="d-inline-block form-select form-select-sm">
                                                <option value="10" selected="">10</option>
                                                <option value="25">25</option>
                                                <option value="50">50</option>
                                                <option value="100">100</option>
                                            </select>&nbsp;</label></div>
                                </div>
                                <div class="col-md-6">
                                    <div class="text-md-end dataTables_filter" id="dataTable_filter"><label class="form-label"><input type="search" class="form-control form-control-sm" aria-controls="dataTable" placeholder="Search"></label></div>
                                </div>
                            </div>
                            <div class="table-responsive table mt-2" id="dataTable" role="grid" aria-describedby="dataTable_info">
                                <table class="table my-0" id="dataTable">
                                    <thead>
                                        <tr>
                                            <th>Serial Number</th>
                                            <th>Question</th>
                                            <th>Option 1</th>
                                            <th>Option 2</th>
                                            <th>Option 3</th>
                                            <th>Option 4</th>
                                            <th>Answer</th>
                                            <th>Marks</th>
                                            <th>Negative Marks</th>
                                           
                                            <th>Update</th>
                                            <th>Delete</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="row" items="${result.rows}" varStatus="loop">
                                            <tr>
                                                <td>${loop.count}</td>
                                                <td>${row.questionName}</td>
                                                <td>${row.opt1}</td>
                                                <td>${row.opt2}</td>
                                                <td>${row.opt3}</td>
                                                <td>${row.opt4}</td>
                                                <td>${row.ans}</td>
                                                <td>${row.questionMarks}</td>
                                                <td>${row.negativeMarks}</td>

                                                <td>
                                                    <a href="updateQuestionAlongWithImages.jsp?questionIdurl=${row.questionId}" class="btn btn-outline-warning my-2">Update</a>
                                                </td>
                                                <td>
                                                    <a href="removeQuestionYesNo.jsp?questionIdurl=${row.questionId}" class="btn btn-outline-danger my-2">Delete</a>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                        
                                    </tbody>
                                    <tfoot>
                                        <tr>
                                            <td><strong>Serial Number</strong></td>
                                            <td><strong>Question</strong></td>
                                            <td><strong>Option 1</strong></td>
                                            <td><strong>Option 2</strong></td>
                                            <td><strong>Option 3</strong></td>
                                            <td><strong>Option 4</strong></td>
                                            <td><strong>Answer</strong></td>
                                            <td><strong>Marks</strong></td>
                                            <td><strong>Negative Marks</strong></td>
                                          
                                            <td><strong>Update</strong></td>
                                            <td><strong>Delete</strong></td>
                                        </tr>
                                    </tfoot>
                                </table>
                            </div>
                            <div class="row">
                                <div class="col-md-6 align-self-center">
                                    <c:forEach var="row2" items="${result2.rows}">
                                        <p id="dataTable_info" class="dataTables_info" role="status" aria-live="polite">Showing 1 to 10 of ${row2.studentsCount}</p>
                                    </c:forEach>
                                </div>
                                <div class="col-md-6">
                                    <nav class="d-lg-flex justify-content-lg-end dataTables_paginate paging_simple_numbers">
                                        <ul class="pagination">
                                            <li class="page-item disabled"><a class="page-link" href="#" aria-label="Previous"><span aria-hidden="true">«</span></a></li>
                                            <li class="page-item active"><a class="page-link" href="#">1</a></li>
                                            <li class="page-item"><a class="page-link" href="#">2</a></li>
                                            <li class="page-item"><a class="page-link" href="#">3</a></li>
                                            <li class="page-item"><a class="page-link" href="#" aria-label="Next"><span aria-hidden="true">»</span></a></li>
                                        </ul>
                                    </nav>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>  
                 
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