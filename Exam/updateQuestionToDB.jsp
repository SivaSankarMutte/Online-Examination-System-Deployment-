<%-- 
    Document   : updateQuestionToDB
    Created on : 3 Dec, 2021, 8:37:39 PM
    Author     : SIVASANKAR
--%>

<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<html>
    <head>
        <title>Updating Question</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" type="text/css" href="bootstrap.min.css">
        <link rel="icon" type="text/css" href="images/test.png">
    </head>
    <body>
        
        <sql:setDataSource var="db" driver="com.mysql.jdbc.Driver" url="jdbc:mysql://localhost:3306/demo2?useSSL=false&allowPublicKeyRetrieval=true" user="siva" password="0000"/>
        
        
        
        <sql:query dataSource="${db}" var="mode">
            select mode from exam where examId=?
        <sql:param value="${sessionScope.eid}"/>
        </sql:query>
        <c:forEach var="row2" items="${mode.rows}">
        <c:choose>
            <c:when test="${row2.mode==4}">
                 
                
                <c:choose>
                    <c:when test='${param.formQuestionType=="1"}'>
                        <sql:update dataSource="${db}" var="add">
                            update ${sessionScope.questionsTableName} set questionName=?,opt1=?,opt2=?,opt3=?,opt4=?,ans=?,questionMarks=?,negativeMarks=?,questionType=?,questionTimeMinutes=?,questionTimeSeconds=? where questionId=?
                            <sql:param value="${param.formQuestionName}"/>
                            <sql:param value="${param.formOpt1}"/>
                            <sql:param value="${param.formOpt2}"/>
                            <sql:param value="${param.formOpt3}"/>
                            <sql:param value="${param.formOpt4}"/>
                            <sql:param value="${param.formAns}"/>
                            <sql:param value="${param.formQuestionMarks}"/>
                            <sql:param value="${param.formNegativeMarks}"/>
                            <sql:param value="${param.formQuestionType}"/>
                            
                            <sql:param value="${param.formQuestionTimeLimitMinutes}"/>
                            <sql:param value="${param.formQuestionTimeLimitSeconds}"/>
                            
                            <sql:param value="${sessionScope.sessionQuestionId}"/>
                        </sql:update>  
                        <c:choose>
                            <c:when test='${add>=1}'>
                                <% session.removeAttribute("sessionQuestionId"); %>
                                <c:redirect url="addQuestionForm.jsp"/>
                            </c:when>

                             <c:otherwise>
                                <% session.removeAttribute("sessionQuestionId"); %>
                                <c:redirect url="questionFailedToUpdate.jsp"/>
                            </c:otherwise>
                        </c:choose>
                    </c:when>
                    <c:when test='${param.formQuestionType=="0"}'>
                        <c:choose>
                            <c:when test='${param.formAns!="1" && param.formAns!="2" && param.formAns!="3" && param.formAns!="4"}'>
                                <c:redirect url="questionFailedToUpdate.jsp"/>
                            </c:when>
                            <c:otherwise>
                                <c:choose>
                                    <c:when test='${param.formOpt3=="" || param.formOpt4==""}'>
                                        <c:choose>
                                            <c:when test='${param.formAns=="1" || param.formAns=="2"}'>
                                                <sql:update dataSource="${db}" var="add">
                                                    update ${sessionScope.questionsTableName} set questionName=?,opt1=?,opt2=?,opt3=?,opt4=?,ans=?,questionMarks=?,negativeMarks=?,questionType=?,questionTimeMinutes=?,questionTimeSeconds=? where questionId=?

                                                        <sql:param value="${param.formQuestionName}"/>
                                                        <sql:param value="${param.formOpt1}"/>
                                                        <sql:param value="${param.formOpt2}"/>
                                                        <sql:param value="${param.formOpt3}"/>
                                                        <sql:param value="${param.formOpt4}"/>
                                                        <sql:param value="${param.formAns}"/>
                                                        <sql:param value="${param.formQuestionMarks}"/>
                                                        <sql:param value="${param.formNegativeMarks}"/>
                                                        <sql:param value="${param.formQuestionType}"/>
                                                        <sql:param value="${param.formQuestionTimeLimitMinutes}"/>
                                                        <sql:param value="${param.formQuestionTimeLimitSeconds}"/>
                                                        <sql:param value="${sessionScope.sessionQuestionId}"/>
                                                </sql:update>  
                                                <c:choose>
                                                    <c:when test='${add>=1}'>
                                                        <% session.removeAttribute("sessionQuestionId"); %>
                                                        <c:redirect url="addQuestionForm.jsp"/>
                                                    </c:when>

                                                    <c:otherwise>
                                                        <% session.removeAttribute("sessionQuestionId"); %>
                                                        <c:redirect url="questionFailedToUpdate.jsp"/>
                                                    </c:otherwise>
                                                </c:choose>
                                            </c:when>

                                            <c:otherwise>
                                                <% session.removeAttribute("sessionQuestionId"); %>
                                                <c:redirect url="questionFailedToUpdate.jsp"/>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:when>


                                    <c:when test='${param.opt4==""}'>
                                        <c:choose>
                                            <c:when test='${param.formAns=="1" || param.formAns=="2" || param.formAns=="3"}'>
                                                <sql:update dataSource="${db}" var="add">
                                                    update ${sessionScope.questionsTableName} set questionName=?,opt1=?,opt2=?,opt3=?,opt4=?,ans=?,questionMarks=?,negativeMarks=?,questionType=?,questionTimeMinutes=?,questionTimeSeconds=? where questionId=?

                                                        <sql:param value="${param.formQuestionName}"/>
                                                        <sql:param value="${param.formOpt1}"/>
                                                        <sql:param value="${param.formOpt2}"/>
                                                        <sql:param value="${param.formOpt3}"/>
                                                        <sql:param value="${param.formOpt4}"/>
                                                        <sql:param value="${param.formAns}"/>
                                                        <sql:param value="${param.formQuestionMarks}"/>
                                                        <sql:param value="${param.formNegativeMarks}"/>
                                                        <sql:param value="${param.formQuestionType}"/>
                                                        <sql:param value="${param.formQuestionTimeLimitMinutes}"/>
                                                        <sql:param value="${param.formQuestionTimeLimitSeconds}"/>
                                                        <sql:param value="${sessionScope.sessionQuestionId}"/>
                                                </sql:update>  
                                                <c:choose>
                                                    <c:when test='${add>=1}'>
                                                        <% session.removeAttribute("sessionQuestionId"); %>
                                                        <c:redirect url="addQuestionForm.jsp"/>
                                                    </c:when>

                                                    <c:otherwise>
                                                        <% session.removeAttribute("sessionQuestionId"); %>
                                                        <c:redirect url="questionFailedToUpdate.jsp"/>
                                                    </c:otherwise>
                                                </c:choose>
                                            </c:when>

                                            <c:otherwise>
                                                <% session.removeAttribute("sessionQuestionId"); %>
                                                <c:redirect url="questionFailedToUpdate.jsp"/>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:when>

                                    <c:when test='${param.opt3==""}'>
                                        <% session.removeAttribute("sessionQuestionId"); %>
                                        <c:redirect url="questionFailedToUpdate.jsp"/>
                                    </c:when>

                                    <c:otherwise>
                                        <sql:update dataSource="${db}" var="add">
                                            update ${sessionScope.questionsTableName} set questionName=?,opt1=?,opt2=?,opt3=?,opt4=?,ans=?,questionMarks=?,negativeMarks=?,questionType=?,questionTimeMinutes=?,questionTimeSeconds=? where questionId=?
                                            <sql:param value="${param.formQuestionName}"/>
                                            <sql:param value="${param.formOpt1}"/>
                                            <sql:param value="${param.formOpt2}"/>
                                            <sql:param value="${param.formOpt3}"/>
                                            <sql:param value="${param.formOpt4}"/>
                                            <sql:param value="${param.formAns}"/>
                                            <sql:param value="${param.formQuestionMarks}"/>
                                            <sql:param value="${param.formNegativeMarks}"/>
                                            <sql:param value="${param.formQuestionType}"/>
                                            <sql:param value="${param.formQuestionTimeLimitMinutes}"/>
                                            <sql:param value="${param.formQuestionTimeLimitSeconds}"/>
                                            <sql:param value="${sessionScope.sessionQuestionId}"/>
                                        </sql:update> 
                                        <c:choose>
                                            <c:when test='${add>=1}'>
                                                <% session.removeAttribute("sessionQuestionId"); %>
                                                <c:redirect url="addQuestionForm.jsp"/>
                                            </c:when>

                                            <c:otherwise>
                                                <% session.removeAttribute("sessionQuestionId"); %>
                                                <c:redirect url="questionFailedToUpdate.jsp"/>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:otherwise>
                                </c:choose>     
                            </c:otherwise>
                        </c:choose>
                    </c:when>



                    <c:otherwise>


                        <%
                            try{
                                String opts[]=(request.getParameter("formAns").toString()).split("&");
                                int isValidOpts=1;
                                for(int i=0;i<opts.length;i++)
                                {
                                    if(!((opts[i].equals("1") && !request.getParameter("formOpt1").equals("")) || (opts[i].equals("2") 
                                            && !request.getParameter("formOpt2").equals("")) || (opts[i].equals("3") && !request.getParameter("formOpt3").equals(""))
                                            || (opts[i].equals("4") && !request.getParameter("formOpt4").equals("")) ))
                                    {
                                        isValidOpts=0;
                                    }
                                }
                                if(isValidOpts==1){
                                %>
                                    <sql:update dataSource="${db}" var="add">
                                            update ${sessionScope.questionsTableName} set questionName=?,opt1=?,opt2=?,opt3=?,opt4=?,ans=?,questionMarks=?,negativeMarks=?,questionType=?,questionTimeMinutes=?,questionTimeSeconds=? where questionId=?
                                            <sql:param value="${param.formQuestionName}"/>
                                            <sql:param value="${param.formOpt1}"/>
                                            <sql:param value="${param.formOpt2}"/>
                                            <sql:param value="${param.formOpt3}"/>
                                            <sql:param value="${param.formOpt4}"/>
                                            <sql:param value="${param.formAns}"/>
                                            <sql:param value="${param.formQuestionMarks}"/>
                                            <sql:param value="${param.formNegativeMarks}"/>
                                            <sql:param value="${param.formQuestionType}"/>
                                            <sql:param value="${param.formQuestionTimeLimitMinutes}"/>
                                            <sql:param value="${param.formQuestionTimeLimitSeconds}"/>
                                            <sql:param value="${sessionScope.sessionQuestionId}"/>
                                        </sql:update> 
                                        <c:choose>
                                            <c:when test='${add>=1}'>
                                                <% session.removeAttribute("sessionQuestionId"); %>
                                                <c:redirect url="addQuestionForm.jsp"/>
                                            </c:when>

                                            <c:otherwise>
                                                <% session.removeAttribute("sessionQuestionId"); %>
                                                <c:redirect url="questionFailedToUpdate.jsp"/>
                                            </c:otherwise>
                                        </c:choose>
                                <%
                                }
                                else
                                {
                                    %>
                                        <c:redirect url="addQuestionForm.jsp"/>
                                    <%
                                }
                            }
                            catch(Exception e)
                            {
                                %>
                                <c:redirect url="addQuestionForm.jsp"/>
                                <%
                            }


                        %>


                    </c:otherwise>
                </c:choose>
                
            </c:when>
            <c:otherwise>
                
                
                
                
                
                <c:choose>
                    <c:when test='${param.formQuestionType=="1"}'>
                        <sql:update dataSource="${db}" var="add">
                            update ${sessionScope.questionsTableName} set questionName=?,opt1=?,opt2=?,opt3=?,opt4=?,ans=?,questionMarks=?,negativeMarks=?,questionType=? where questionId=?
                            <sql:param value="${param.formQuestionName}"/>
                            <sql:param value="${param.formOpt1}"/>
                            <sql:param value="${param.formOpt2}"/>
                            <sql:param value="${param.formOpt3}"/>
                            <sql:param value="${param.formOpt4}"/>
                            <sql:param value="${param.formAns}"/>
                            <sql:param value="${param.formQuestionMarks}"/>
                            <sql:param value="${param.formNegativeMarks}"/>
                            <sql:param value="${param.formQuestionType}"/>
                            
                            <sql:param value="${sessionScope.sessionQuestionId}"/>
                        </sql:update>  
                        <c:choose>
                            <c:when test='${add>=1}'>
                                <% session.removeAttribute("sessionQuestionId"); %>
                                <c:redirect url="addQuestionForm.jsp"/>
                            </c:when>

                             <c:otherwise>
                                <% session.removeAttribute("sessionQuestionId"); %>
                                <c:redirect url="questionFailedToUpdate.jsp"/>
                            </c:otherwise>
                        </c:choose>
                    </c:when>
                    <c:when test='${param.formQuestionType=="0"}'>
                        <c:choose>
                            <c:when test='${param.formAns!="1" && param.formAns!="2" && param.formAns!="3" && param.formAns!="4"}'>
                                <c:redirect url="questionFailedToUpdate.jsp"/>
                            </c:when>
                            <c:otherwise>
                                <c:choose>
                                    <c:when test='${param.formOpt3=="" || param.formOpt4==""}'>
                                        <c:choose>
                                            <c:when test='${param.formAns=="1" || param.formAns=="2"}'>
                                                <sql:update dataSource="${db}" var="add">
                                                    update ${sessionScope.questionsTableName} set questionName=?,opt1=?,opt2=?,opt3=?,opt4=?,ans=?,questionMarks=?,negativeMarks=?,questionType=? where questionId=?

                                                        <sql:param value="${param.formQuestionName}"/>
                                                        <sql:param value="${param.formOpt1}"/>
                                                        <sql:param value="${param.formOpt2}"/>
                                                        <sql:param value="${param.formOpt3}"/>
                                                        <sql:param value="${param.formOpt4}"/>
                                                        <sql:param value="${param.formAns}"/>
                                                        <sql:param value="${param.formQuestionMarks}"/>
                                                        <sql:param value="${param.formNegativeMarks}"/>
                                                        <sql:param value="${param.formQuestionType}"/>
                                                       
                                                        <sql:param value="${sessionScope.sessionQuestionId}"/>
                                                </sql:update>  
                                                <c:choose>
                                                    <c:when test='${add>=1}'>
                                                        <% session.removeAttribute("sessionQuestionId"); %>
                                                        <c:redirect url="addQuestionForm.jsp"/>
                                                    </c:when>

                                                    <c:otherwise>
                                                        <% session.removeAttribute("sessionQuestionId"); %>
                                                        <c:redirect url="questionFailedToUpdate.jsp"/>
                                                    </c:otherwise>
                                                </c:choose>
                                            </c:when>

                                            <c:otherwise>
                                                <% session.removeAttribute("sessionQuestionId"); %>
                                                <c:redirect url="questionFailedToUpdate.jsp"/>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:when>


                                    <c:when test='${param.opt4==""}'>
                                        <c:choose>
                                            <c:when test='${param.formAns=="1" || param.formAns=="2" || param.formAns=="3"}'>
                                                <sql:update dataSource="${db}" var="add">
                                                    update ${sessionScope.questionsTableName} set questionName=?,opt1=?,opt2=?,opt3=?,opt4=?,ans=?,questionMarks=?,negativeMarks=?,questionType=? where questionId=?

                                                        <sql:param value="${param.formQuestionName}"/>
                                                        <sql:param value="${param.formOpt1}"/>
                                                        <sql:param value="${param.formOpt2}"/>
                                                        <sql:param value="${param.formOpt3}"/>
                                                        <sql:param value="${param.formOpt4}"/>
                                                        <sql:param value="${param.formAns}"/>
                                                        <sql:param value="${param.formQuestionMarks}"/>
                                                        <sql:param value="${param.formNegativeMarks}"/>
                                                        <sql:param value="${param.formQuestionType}"/>
                                                       
                                                        <sql:param value="${sessionScope.sessionQuestionId}"/>
                                                </sql:update>  
                                                <c:choose>
                                                    <c:when test='${add>=1}'>
                                                        <% session.removeAttribute("sessionQuestionId"); %>
                                                        <c:redirect url="addQuestionForm.jsp"/>
                                                    </c:when>

                                                    <c:otherwise>
                                                        <% session.removeAttribute("sessionQuestionId"); %>
                                                        <c:redirect url="questionFailedToUpdate.jsp"/>
                                                    </c:otherwise>
                                                </c:choose>
                                            </c:when>

                                            <c:otherwise>
                                                <% session.removeAttribute("sessionQuestionId"); %>
                                                <c:redirect url="questionFailedToUpdate.jsp"/>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:when>

                                    <c:when test='${param.opt3==""}'>
                                        <% session.removeAttribute("sessionQuestionId"); %>
                                        <c:redirect url="questionFailedToUpdate.jsp"/>
                                    </c:when>

                                    <c:otherwise>
                                        <sql:update dataSource="${db}" var="add">
                                            update ${sessionScope.questionsTableName} set questionName=?,opt1=?,opt2=?,opt3=?,opt4=?,ans=?,questionMarks=?,negativeMarks=?,questionType=? where questionId=?
                                            <sql:param value="${param.formQuestionName}"/>
                                            <sql:param value="${param.formOpt1}"/>
                                            <sql:param value="${param.formOpt2}"/>
                                            <sql:param value="${param.formOpt3}"/>
                                            <sql:param value="${param.formOpt4}"/>
                                            <sql:param value="${param.formAns}"/>
                                            <sql:param value="${param.formQuestionMarks}"/>
                                            <sql:param value="${param.formNegativeMarks}"/>
                                            <sql:param value="${param.formQuestionType}"/>
                                            
                                            <sql:param value="${sessionScope.sessionQuestionId}"/>
                                        </sql:update> 
                                        <c:choose>
                                            <c:when test='${add>=1}'>
                                                <% session.removeAttribute("sessionQuestionId"); %>
                                                <c:redirect url="addQuestionForm.jsp"/>
                                            </c:when>

                                            <c:otherwise>
                                                <% session.removeAttribute("sessionQuestionId"); %>
                                                <c:redirect url="questionFailedToUpdate.jsp"/>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:otherwise>
                                </c:choose>     
                            </c:otherwise>
                        </c:choose>
                    </c:when>



                    <c:otherwise>


                        <%
                            try{
                                String opts[]=(request.getParameter("formAns").toString()).split("&");
                                int isValidOpts=1;
                                for(int i=0;i<opts.length;i++)
                                {
                                    if(!((opts[i].equals("1") && !request.getParameter("formOpt1").equals("")) || (opts[i].equals("2") 
                                            && !request.getParameter("formOpt2").equals("")) || (opts[i].equals("3") && !request.getParameter("formOpt3").equals(""))
                                            || (opts[i].equals("4") && !request.getParameter("formOpt4").equals("")) ))
                                    {
                                        isValidOpts=0;
                                    }
                                }
                                if(isValidOpts==1){
                                %>
                                    <sql:update dataSource="${db}" var="add">
                                            update ${sessionScope.questionsTableName} set questionName=?,opt1=?,opt2=?,opt3=?,opt4=?,ans=?,questionMarks=?,negativeMarks=?,questionType=? where questionId=?
                                            <sql:param value="${param.formQuestionName}"/>
                                            <sql:param value="${param.formOpt1}"/>
                                            <sql:param value="${param.formOpt2}"/>
                                            <sql:param value="${param.formOpt3}"/>
                                            <sql:param value="${param.formOpt4}"/>
                                            <sql:param value="${param.formAns}"/>
                                            <sql:param value="${param.formQuestionMarks}"/>
                                            <sql:param value="${param.formNegativeMarks}"/>
                                            <sql:param value="${param.formQuestionType}"/>
                                            
                                            <sql:param value="${sessionScope.sessionQuestionId}"/>
                                        </sql:update> 
                                        <c:choose>
                                            <c:when test='${add>=1}'>
                                                <% session.removeAttribute("sessionQuestionId"); %>
                                                <c:redirect url="addQuestionForm.jsp"/>
                                            </c:when>

                                            <c:otherwise>
                                                <% session.removeAttribute("sessionQuestionId"); %>
                                                <c:redirect url="questionFailedToUpdate.jsp"/>
                                            </c:otherwise>
                                        </c:choose>
                                <%
                                }
                                else
                                {
                                    %>
                                        <c:redirect url="addQuestionForm.jsp"/>
                                    <%
                                }
                            }
                            catch(Exception e)
                            {
                                %>
                                <c:redirect url="addQuestionForm.jsp"/>
                                <%
                            }


                        %>


                    </c:otherwise>
                </c:choose>


            </c:otherwise>
        </c:choose>
        </c:forEach>
        <script type="text/javascript" src="assets\js\noBack.js"></script>
    </body>
</html>
