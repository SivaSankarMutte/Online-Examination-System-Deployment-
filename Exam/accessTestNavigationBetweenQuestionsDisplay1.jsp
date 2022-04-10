<%-- 
    Document   : accessTestNavigationBetweenQuestionsDisplay1
    Created on : 20 Feb, 2022, 5:03:32 PM
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
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

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
    
    <div id="wrapper">
        <div class="d-flex flex-column" id="content-wrapper">
            <div id="content" style="border-color: var(--bs-success);">
                
                <form action="LiveResults" method="post" class="form-control">
                
                <nav class="navbar navbar-light navbar-expand bg-white shadow mb-4 topbar static-top" style="background: var(--bs-success);color: var(--bs-success);">
                    <div class="container-fluid"><button class="btn btn-link d-md-none rounded-circle me-3" id="sidebarToggleTop" type="button" style="background: var(--bs-success);"><i class="fas fa-bars"></i></button>
                        <h1>Online Exam Portal</h1><button type="submit" formaction="examNavigationSubmitButtonPressed" class="btn btn-success btn-icon-split" role="button"><span class="text-white-50 icon"><i class="typcn typcn-chevron-right"></i></span><span class="text-white text">Submit</span></button>
                    </div>
                </nav>
                
                            
                            
                            <%
            if(session.getAttribute("examId")!=null && session.getAttribute("regdNo")!=null)
            {  %>
            
                <c:choose>
                    <c:when test='${Integer.parseInt(sessionScope.n)<questionsRecords.size()}'>
                        
                            <div class="container-fluid">
                                <div class="card">
                                    <div class="row">
                                    <div class="col-lg-10">
                            
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
                                <h4 class="card-title" style="user-select: none;"><% out.println(n2+1+"."+q.getQuestionName()); %></h4>
                                <!-- Remove these 4 lines 
                                here 39 denotes index starts with data/imagePath
                                -->
                                <% if(q.getQuestionNameImg()!=null && !q.getQuestionNameImg().equals("")){ %>
                                    <img src="<%= q.getQuestionNameImg() %>" alt="Image Loading" height="200px" width="100%">
                                <% } %>
                                <h6 class="text-muted card-subtitle mb-2">Select from following options</h6>
                                
                                <% if(q.getProvidedAns()==null){ %>
                                    <input type="text" name="blankTypeName" class="form-control" placeholder="Enter your answer here">
                                <% } 
                                    else{ %>
                                        <input type="text" name="blankTypeName" class="form-control" value="<%= q.getProvidedAns() %>" placeholder="Enter your answer here">
                                   <% }
                            } else if(q.getQuestionType()==0) {  %>
                   
                                <div id="overlay">
                                    ${sessionScope.regdNo}&nbsp;&nbsp;${sessionScope.regdNo}&nbsp;&nbsp;${sessionScope.regdNo}<br/>
                                    ${sessionScope.regdNo}&nbsp;&nbsp;${sessionScope.regdNo}&nbsp;&nbsp;${sessionScope.regdNo}<br/>
                                    ${sessionScope.regdNo}&nbsp;&nbsp;${sessionScope.regdNo}&nbsp;&nbsp;${sessionScope.regdNo}<br/>
                                    ${sessionScope.regdNo}&nbsp;&nbsp;${sessionScope.regdNo}&nbsp;&nbsp;${sessionScope.regdNo}<br/>
                                    ${sessionScope.regdNo}&nbsp;&nbsp;${sessionScope.regdNo}&nbsp;&nbsp;${sessionScope.regdNo}<br/>
                                    ${sessionScope.regdNo}&nbsp;&nbsp;${sessionScope.regdNo}&nbsp;&nbsp;${sessionScope.regdNo}
                                </div>
                                
                                
                                
                                <h4 class="card-title" style="user-select: none;"><% out.println(n2+1+"."+q.getQuestionName()); %></h4>
                                <% if(q.getQuestionNameImg()!=null && !q.getQuestionNameImg().equals("")){ %>
                                    <img src="<%= q.getQuestionNameImg() %>" alt="Image Loading" height="200px" width="100%">
                                <% } %>
                                <h6 class="text-muted card-subtitle mb-2">Select from following options</h6>
                                
                                <% if(q.getProvidedAns()==null){ %>
                                
                                <% for(int i=0;i<4;i++)
                                {
                                    if((q.getOptions().get(i)!=null && !q.getOptions().get(i).equals("")) || (q.getOptionsImages().get(i)!=null && !q.getOptionsImages().get(i).equals("")))
                                    {
                                        %>
                                        <div class="form-check"><input class="form-check-input" type="radio" name="radioName" value="<%= q.getOptionNumbers().get(i) %>" id="formCheck-<%= q.getOptionNumbers().get(i) %>"><label class="form-check-label" for="formCheck-<%= q.getOptionNumbers().get(i) %>">
                                        <%
                                    
                                        if(q.getOptions().get(i)!=null && !q.getOptions().get(i).equals(""))
                                        { %>
                                            <% out.println(q.getOptions().get(i)); %> 
                                            <%
                                        }
                                        if(q.getOptionsImages().get(i)!=null && !q.getOptionsImages().get(i).equals(""))
                                        { %>
                                        <br/><img src="<%= q.getOptionsImages().get(i) %>" alt="Image Loading" height="200px" width="100%">
                                            <%
                                        }
                                        %> </label></div> <%
                                    }
                                } %>
                                
                             


                                    <% }
                                else {
                                    if(q.getProvidedAns()!=null && q.getProvidedAns().equals("1")){ %>
                                        <% for(int i=0;i<4;i++)
                                        {
                                            if((q.getOptions().get(i)!=null && !q.getOptions().get(i).equals("")) || (q.getOptionsImages().get(i)!=null && !q.getOptionsImages().get(i).equals("")))
                                            {
                                                if(q.getOptions().get(i).equals(q.getOpt1()))
                                                {
                                                %>
                                                
                                                <div class="form-check"><input class="form-check-input" type="radio" name="radioName" value="<%= q.getOptionNumbers().get(i) %>" id="formCheck-<%= q.getOptionNumbers().get(i) %>" checked><label class="form-check-label" for="formCheck-<%= q.getOptionNumbers().get(i) %>">
                                                <%
                                                }
                                                else
                                                {
                                                    
                                                %>
                                                
                                                <div class="form-check"><input class="form-check-input" type="radio" name="radioName" value="<%= q.getOptionNumbers().get(i) %>" id="formCheck-<%= q.getOptionNumbers().get(i) %>"><label class="form-check-label" for="formCheck-<%= q.getOptionNumbers().get(i) %>">
                                                <%
                                                }
                                                if(q.getOptions().get(i)!=null && !q.getOptions().get(i).equals(""))
                                                { %>
                                                    <% out.println(q.getOptions().get(i)); %>
                                                    <%
                                                }
                                                if(q.getOptionsImages().get(i)!=null && !q.getOptionsImages().get(i).equals(""))
                                                { %>
                                                <br/><img src="<%= q.getOptionsImages().get(i) %>" alt="Image Loading" height="200px" width="100%">
                                                    <%
                                                }
                                                %> </label></div> <%
                                            }
                                        } %>
                                    <% }else if(q.getProvidedAns()!=null && q.getProvidedAns().equals("2")){ %>
                                        <% for(int i=0;i<4;i++)
                                        {
                                            if((q.getOptions().get(i)!=null && !q.getOptions().get(i).equals("")) || (q.getOptionsImages().get(i)!=null && !q.getOptionsImages().get(i).equals("")))
                                            {
                                                if(q.getOptions().get(i).equals(q.getOpt2()))
                                                {
                                                %>
                                                
                                                <div class="form-check"><input class="form-check-input" type="radio" name="radioName" value="<%= q.getOptionNumbers().get(i) %>" id="formCheck-<%= q.getOptionNumbers().get(i) %>" checked><label class="form-check-label" for="formCheck-<%= q.getOptionNumbers().get(i) %>">
                                                <%
                                                }
                                                else
                                                {
                                                    
                                                %>
                                                
                                                <div class="form-check"><input class="form-check-input" type="radio" name="radioName" value="<%= q.getOptionNumbers().get(i) %>" id="formCheck-<%= q.getOptionNumbers().get(i) %>"><label class="form-check-label" for="formCheck-<%= q.getOptionNumbers().get(i) %>">
                                                <%
                                                }
                                                if(q.getOptions().get(i)!=null && !q.getOptions().get(i).equals(""))
                                                { %>
                                                    <% out.println(q.getOptions().get(i)); %>
                                                    <%
                                                }
                                                if(q.getOptionsImages().get(i)!=null && !q.getOptionsImages().get(i).equals(""))
                                                { %>
                                                <br/><img src="<%= q.getOptionsImages().get(i) %>" alt="Image Loading" height="200px" width="100%">
                                                    <%
                                                }
                                                %> </label></div> <%
                                            }
                                        } %>

                                    
                                    <% }else if(q.getProvidedAns()!=null && q.getProvidedAns().equals("3")){ %>
                                        <% for(int i=0;i<4;i++)
                                        {
                                            if((q.getOptions().get(i)!=null && !q.getOptions().get(i).equals("")) || (q.getOptionsImages().get(i)!=null && !q.getOptionsImages().get(i).equals("")))
                                            {
                                                if(q.getOptions().get(i).equals(q.getOpt3()))
                                                {
                                                %>
                                                
                                                <div class="form-check"><input class="form-check-input" type="radio" name="radioName" value="<%= q.getOptionNumbers().get(i) %>" id="formCheck-<%= q.getOptionNumbers().get(i) %>" checked><label class="form-check-label" for="formCheck-<%= q.getOptionNumbers().get(i) %>"> 
                                                <%
                                                }
                                                else
                                                {
                                                    
                                                %>
                                                
                                                <div class="form-check"><input class="form-check-input" type="radio" name="radioName" value="<%= q.getOptionNumbers().get(i) %>" id="formCheck-<%= q.getOptionNumbers().get(i) %>"><label class="form-check-label" for="formCheck-<%= q.getOptionNumbers().get(i) %>">
                                                <%
                                                }
                                                if(q.getOptions().get(i)!=null && !q.getOptions().get(i).equals(""))
                                                { %>
                                                    <% out.println(q.getOptions().get(i)); %> 
                                                    <%
                                                }
                                                if(q.getOptionsImages().get(i)!=null && !q.getOptionsImages().get(i).equals(""))
                                                { %>
                                                <br/><img src="<%= q.getOptionsImages().get(i) %>" alt="Image Loading" height="200px" width="100%">
                                                    <%
                                                }
                                                %> </label></div> <%
                                            }
                                        } %>

                                    
                                    <% }
                                    else if(q.getProvidedAns()!=null && q.getProvidedAns().equals("4")){ %>
                                        <% for(int i=0;i<4;i++)
                                        {
                                            if((q.getOptions().get(i)!=null && !q.getOptions().get(i).equals("")) || (q.getOptionsImages().get(i)!=null && !q.getOptionsImages().get(i).equals("")))
                                            {
                                                if(q.getOptions().get(i).equals(q.getOpt4()))
                                                {
                                                %>
                                                
                                                <div class="form-check"><input class="form-check-input" type="radio" name="radioName" value="<%= q.getOptionNumbers().get(i) %>" id="formCheck-<%= q.getOptionNumbers().get(i) %>" checked><label class="form-check-label" for="formCheck-<%= q.getOptionNumbers().get(i) %>">
                                                <%
                                                }
                                                else
                                                {
                                                    
                                                %>
                                                
                                                <div class="form-check"><input class="form-check-input" type="radio" name="radioName" value="<%= q.getOptionNumbers().get(i) %>" id="formCheck-<%= q.getOptionNumbers().get(i) %>"><label class="form-check-label" for="formCheck-<%= q.getOptionNumbers().get(i) %>">
                                                <%
                                                }
                                                if(q.getOptions().get(i)!=null && !q.getOptions().get(i).equals(""))
                                                { %>
                                                    <% out.println(q.getOptions().get(i)); %>
                                                    <%
                                                }
                                                if(q.getOptionsImages().get(i)!=null && !q.getOptionsImages().get(i).equals(""))
                                                { %>
                                                <br/><img src="<%= q.getOptionsImages().get(i) %>" alt="Image Loading" height="200px" width="100%">
                                                    <%
                                                }
                                                %> </label></div> <%
                                            }
                                        } %>

                                    
                                    <% }
                                    }
                                }
   
                                else {  %>
                    
                                        <div id="overlay">
                                            ${sessionScope.regdNo}&nbsp;&nbsp;${sessionScope.regdNo}&nbsp;&nbsp;${sessionScope.regdNo}<br/>
                                            ${sessionScope.regdNo}&nbsp;&nbsp;${sessionScope.regdNo}&nbsp;&nbsp;${sessionScope.regdNo}<br/>
                                            ${sessionScope.regdNo}&nbsp;&nbsp;${sessionScope.regdNo}&nbsp;&nbsp;${sessionScope.regdNo}<br/>
                                            ${sessionScope.regdNo}&nbsp;&nbsp;${sessionScope.regdNo}&nbsp;&nbsp;${sessionScope.regdNo}<br/>
                                            ${sessionScope.regdNo}&nbsp;&nbsp;${sessionScope.regdNo}&nbsp;&nbsp;${sessionScope.regdNo}<br/>
                                            ${sessionScope.regdNo}&nbsp;&nbsp;${sessionScope.regdNo}&nbsp;&nbsp;${sessionScope.regdNo}
                                        </div>

                                        <h4 class="card-title" style="user-select: none;"><% out.println(n2+1+"."+q.getQuestionName()); %></h4>
                                        <% if(q.getQuestionNameImg()!=null && !q.getQuestionNameImg().equals("")){ %>
                                            <img src="<%= q.getQuestionNameImg() %>" alt="Image Loading" height="200px" width="100%">
                                        <% } %>
                                        <h6 class="text-muted card-subtitle mb-2">Select from following options</h6>
                                        <% if((q.getCheckboxOptionsGiven()==null) || (q.getCheckboxOptionsGiven()[0]==null && q.getCheckboxOptionsGiven()[1]==null && q.getCheckboxOptionsGiven()[2]==null && q.getCheckboxOptionsGiven()[3]==null))
                                            { %>
                                            
                                            
                                            <% for(int i=0;i<4;i++)
                                            {
                                                if((q.getOptions().get(i)!=null && !q.getOptions().get(i).equals("")) || (q.getOptionsImages().get(i)!=null && !q.getOptionsImages().get(i).equals("")))
                                                {
                                                    %>
                                                    <div class="form-check"><input class="form-check-input" type="checkbox" name="checkboxname" value="<%= q.getOptionNumbers().get(i) %>" id="formCheck-<%= q.getOptionNumbers().get(i) %>"><label class="form-check-label" for="formCheck-<%= q.getOptionNumbers().get(i) %>">
                                                    <%

                                                    if(q.getOptions().get(i)!=null && !q.getOptions().get(i).equals(""))
                                                    { %>
                                                        <% out.println(q.getOptions().get(i)); %>
                                                        <%
                                                    }
                                                    if(q.getOptionsImages().get(i)!=null && !q.getOptionsImages().get(i).equals(""))
                                                    { %>
                                                    <br/><img src="<%= q.getOptionsImages().get(i) %>" alt="Image Loading" height="200px" width="100%">
                                                        <%
                                                    }
                                                    %> </label></div> <%
                                                }
                                            } %>
                                            
                                            

                                        <% } 
                                            else {

                                                for(int i=0;i<4;i++)
                                                {
                                                    if(q.getOptionNumbers().get(i).equals("1"))
                                                    {
                                                        if((q.getOptions().get(i)!=null && !q.getOptions().get(i).equals("")) || (q.getOptionsImages().get(i)!=null && !q.getOptionsImages().get(i).equals("")))
                                                        {
                                                            if(Arrays.asList(q.getCheckboxOptionsGiven()).contains("1"))
                                                            {
                                                                %><div class="form-check"><input class="form-check-input" type="checkbox" name="checkboxname" value="<%= q.getOptionNumbers().get(i) %>" id="formCheck-<%= q.getOptionNumbers().get(i) %>" checked><label class="form-check-label" for="formCheck-<%= q.getOptionNumbers().get(i) %>">
                                                           <%

                                                                if(q.getOptions().get(i)!=null && !q.getOptions().get(i).equals(""))
                                                                { %>
                                                                    <% out.println(q.getOptions().get(i)); %>
                                                                    <%
                                                                }
                                                                if(q.getOptionsImages().get(i)!=null && !q.getOptionsImages().get(i).equals(""))
                                                                { %>
                                                                    <br/><img src="<%= q.getOptionsImages().get(i) %>" alt="Image Loading" height="200px" width="100%">
                                                                    <%
                                                                }
                                                                %></label></div><%
                                                            
                                                            }
                                                            else
                                                            {
                                                                %><div class="form-check"><input class="form-check-input" type="checkbox" name="checkboxname" value="<%= q.getOptionNumbers().get(i) %>" id="formCheck-<%= q.getOptionNumbers().get(i) %>"><label class="form-check-label" for="formCheck-<%= q.getOptionNumbers().get(i) %>">
                                                               <%

                                                                    if(q.getOptions().get(i)!=null && !q.getOptions().get(i).equals(""))
                                                                    { %>
                                                                        <% out.println(q.getOptions().get(i)); %>
                                                                        <%
                                                                    }
                                                                    if(q.getOptionsImages().get(i)!=null && !q.getOptionsImages().get(i).equals(""))
                                                                    { %>
                                                                        <br/><img src="<%= q.getOptionsImages().get(i) %>" alt="Image Loading" height="200px" width="100%">
                                                                        <%
                                                                    }
                                                                %></label></div><%
                                                            }

                                                        }
                                                    }

                                                    if(q.getOptionNumbers().get(i).equals("2"))
                                                    {
                                                        if((q.getOptions().get(i)!=null && !q.getOptions().get(i).equals("")) || (q.getOptionsImages().get(i)!=null && !q.getOptionsImages().get(i).equals("")))
                                                        {
                                                            if(Arrays.asList(q.getCheckboxOptionsGiven()).contains("2"))
                                                            {
                                                                %><div class="form-check"><input class="form-check-input" type="checkbox" name="checkboxname" value="<%= q.getOptionNumbers().get(i) %>" id="formCheck-<%= q.getOptionNumbers().get(i) %>" checked><label class="form-check-label" for="formCheck-<%= q.getOptionNumbers().get(i) %>">
                                                           <%

                                                                if(q.getOptions().get(i)!=null && !q.getOptions().get(i).equals(""))
                                                                { %>
                                                                    <% out.println(q.getOptions().get(i)); %>
                                                                    <%
                                                                }
                                                                if(q.getOptionsImages().get(i)!=null && !q.getOptionsImages().get(i).equals(""))
                                                                { %>
                                                                    <br/><img src="<%= q.getOptionsImages().get(i) %>" alt="Image Loading" height="200px" width="100%">
                                                                    <%
                                                                }
                                                                %></label></div><%
                                                            
                                                            }
                                                            else
                                                            {
                                                                %><div class="form-check"><input class="form-check-input" type="checkbox" name="checkboxname" value="<%= q.getOptionNumbers().get(i) %>" id="formCheck-<%= q.getOptionNumbers().get(i) %>"><label class="form-check-label" for="formCheck-<%= q.getOptionNumbers().get(i) %>">
                                                               <%

                                                                    if(q.getOptions().get(i)!=null && !q.getOptions().get(i).equals(""))
                                                                    { %>
                                                                        <% out.println(q.getOptions().get(i)); %>
                                                                        <%
                                                                    }
                                                                    if(q.getOptionsImages().get(i)!=null && !q.getOptionsImages().get(i).equals(""))
                                                                    { %>
                                                                        <br/><img src="<%= q.getOptionsImages().get(i) %>" alt="Image Loading" height="200px" width="100%">
                                                                        <%
                                                                    }
                                                                %></label></div><%
                                                            }

                                                        }
                                                    }

                                                    


                                                    if(q.getOptionNumbers().get(i).equals("3"))
                                                    {
                                                        if((q.getOptions().get(i)!=null && !q.getOptions().get(i).equals("")) || (q.getOptionsImages().get(i)!=null && !q.getOptionsImages().get(i).equals("")))
                                                        {
                                                            if(Arrays.asList(q.getCheckboxOptionsGiven()).contains("3"))
                                                            {
                                                                %><div class="form-check"><input class="form-check-input" type="checkbox" name="checkboxname" value="<%= q.getOptionNumbers().get(i) %>" id="formCheck-<%= q.getOptionNumbers().get(i) %>" checked><label class="form-check-label" for="formCheck-<%= q.getOptionNumbers().get(i) %>">
                                                           <%

                                                                if(q.getOptions().get(i)!=null && !q.getOptions().get(i).equals(""))
                                                                { %>
                                                                    <% out.println(q.getOptions().get(i)); %>
                                                                    <%
                                                                }
                                                                if(q.getOptionsImages().get(i)!=null && !q.getOptionsImages().get(i).equals(""))
                                                                { %>
                                                                    <br/><img src="<%= q.getOptionsImages().get(i) %>" alt="Image Loading" height="200px" width="100%">
                                                                    <%
                                                                }
                                                                %></label></div><%
                                                            
                                                            }
                                                            else
                                                            {
                                                                %><div class="form-check"><input class="form-check-input" type="checkbox" name="checkboxname" value="<%= q.getOptionNumbers().get(i) %>" id="formCheck-<%= q.getOptionNumbers().get(i) %>"><label class="form-check-label" for="formCheck-<%= q.getOptionNumbers().get(i) %>">
                                                               <%

                                                                    if(q.getOptions().get(i)!=null && !q.getOptions().get(i).equals(""))
                                                                    { %>
                                                                        <% out.println(q.getOptions().get(i)); %>
                                                                        <%
                                                                    }
                                                                    if(q.getOptionsImages().get(i)!=null && !q.getOptionsImages().get(i).equals(""))
                                                                    { %>
                                                                        <br/><img src="<%= q.getOptionsImages().get(i) %>" alt="Image Loading" height="200px" width="100%">
                                                                        <%
                                                                    }
                                                                %></label></div><%
                                                            }

                                                        }
                                                    }



                                                        
                                                    if(q.getOptionNumbers().get(i).equals("4"))
                                                    {
                                                        if((q.getOptions().get(i)!=null && !q.getOptions().get(i).equals("")) || (q.getOptionsImages().get(i)!=null && !q.getOptionsImages().get(i).equals("")))
                                                        {
                                                            if(Arrays.asList(q.getCheckboxOptionsGiven()).contains("4"))
                                                            {
                                                                %><div class="form-check"><input class="form-check-input" type="checkbox" name="checkboxname" value="<%= q.getOptionNumbers().get(i) %>" id="formCheck-<%= q.getOptionNumbers().get(i) %>" checked><label class="form-check-label" for="formCheck-<%= q.getOptionNumbers().get(i) %>">
                                                           <%

                                                                if(q.getOptions().get(i)!=null && !q.getOptions().get(i).equals(""))
                                                                { %>
                                                                    <% out.println(q.getOptions().get(i)); %>
                                                                    <%
                                                                }
                                                                if(q.getOptionsImages().get(i)!=null && !q.getOptionsImages().get(i).equals(""))
                                                                { %>
                                                                    <br/><img src="<%= q.getOptionsImages().get(i) %>" alt="Image Loading" height="200px" width="100%">
                                                                    <%
                                                                }
                                                                %></label></div><%
                                                            
                                                            }
                                                            else
                                                            {
                                                                %><div class="form-check"><input class="form-check-input" type="checkbox" name="checkboxname" value="<%= q.getOptionNumbers().get(i) %>" id="formCheck-<%= q.getOptionNumbers().get(i) %>"><label class="form-check-label" for="formCheck-<%= q.getOptionNumbers().get(i) %>">
                                                               <%

                                                                    if(q.getOptions().get(i)!=null && !q.getOptions().get(i).equals(""))
                                                                    { %>
                                                                        <% out.println(q.getOptions().get(i)); %>
                                                                        <%
                                                                    }
                                                                    if(q.getOptionsImages().get(i)!=null && !q.getOptionsImages().get(i).equals(""))
                                                                    { %>
                                                                        <br/><img src="<%= q.getOptionsImages().get(i) %>" alt="Image Loading" height="200px" width="100%">
                                                                        <%
                                                                    }
                                                                %></label></div><%
                                                            }

                                                        }
                                                    }




                                                }
                                            }

                                        }    
                                %> 
                                  
                                <% 
                             if(n2!=0){ %>
                                <input type="submit" value="Prev" class="btn btn-success" formaction="goToPrevQuestion">
                            <% } %>
                            <% if(n2<(questionsRecords.size()-1)){ %>
                                <input type="submit" value="Next" class="btn btn-info" name="next">
                            <% } %>
                            <% if(n2==(questionsRecords.size()-1)){ %>
                            <br/><center><input type="submit" value="Submit" class="btn btn-success" name="Submit" formaction="examNavigationSubmitButtonPressed" style="height:50px;"></center>
                            <% } %>
                            </div>
                        
                            
                            <div class="col-lg-2">
                            <div class="jumbotron">
                                <c:forEach var="qno" begin="1" end="${questionsRecords.size()}">
                                    <c:choose>
                                        <c:when test='${Integer.parseInt(sessionScope.n)+1==qno}'>
                                            <input type="submit" value="${qno}" name="questionNumber" class="btn btn-info" formaction="GoToAskingQuestion"> 
                                        </c:when>
                                        <c:when test='${((questionsRecords.get(qno-1).questionType==0 || questionsRecords.get(qno-1).questionType==1) && questionsRecords.get(qno-1).getProvidedAns()==null) || (questionsRecords.get(qno-1).questionType==2 && questionsRecords.get(qno-1).checkboxOptionsGiven[0]==null)}'>   <!--included after deploymnet  (questionsRecords.get(qno-1).haveMultipleAns==1 && -->
											<input type="submit" value="${qno}" name="questionNumber" class="btn btn-outline-danger" formaction="GoToAskingQuestion"> 
                                        </c:when>
                                        <c:otherwise>
                                           <input type="submit" value="${qno}" name="questionNumber" class="btn btn-outline-success" formaction="GoToAskingQuestion"> 
                                        </c:otherwise>
                                    </c:choose>
                                </c:forEach>
                                <br/>
                                <input type="submit" value="Submit" class="btn btn-success form-control" name="Submit" formaction="examNavigationSubmitButtonPressed">
                            </div>
                           </div>
                            </div>
                    </div>
                </div>
                        </form>
                    </c:when>
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







