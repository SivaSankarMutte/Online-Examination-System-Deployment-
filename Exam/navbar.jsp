<%-- 
    Document   : navbar
    Created on : 11 Dec, 2021, 6:54:57 PM
    Author     : SIVASANKAR
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<nav class="navbar navbar-expand bg-dark navbar-dark" id="navbar">
  
  <a class="navbar-brand" href="index.jsp">
    Exam
  </a>
 
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#collapsibleNavbar">
    <span class="navbar-toggler-icon"></span>
  </button>

 
  <div class="collapse navbar-collapse" id="collapsibleNavbar">

    <ul class="navbar-nav ml-auto">
      <li class="nav-item">
        <a class="nav-link text-light" style="font-weight: 600" href="index.jsp">HOME</a>
      </li>
      
      <% 
            if(session.getAttribute("sid")==null)
            {
                %>
                <li class="nav-item">
                    <a class="nav-link text-light" style="font-weight: 600" href="superAdminLogin.jsp">SUPER ADMIN LOGIN</a>
                </li>
                <%
            }
            else
            {
                %>
                <li class="nav-item">
                    <a class="nav-link text-light" style="font-weight: 600" href="superAdminLogout">SUPER ADMIN LOGOUT</a>
                </li>
                <%
            }
      %>
      
      
      
      <% 
            if(session.getAttribute("aid")==null)
            {
                %>
                <li class="nav-item">
                    <a class="nav-link text-light" style="font-weight: 600" href="adminLogin.jsp">ADMIN LOGIN</a>
                </li>
                <%
            }
            else
            {
                %>
                <li class="nav-item">
                    <a class="nav-link text-light" style="font-weight: 600" href="adminLogout">ADMIN LOGOUT</a>
                </li>
                <%
            }
      %>
  
      
      
      
      
      
      <% 
            if(session.getAttribute("fid")==null)
            {
                %>
                <li class="nav-item">
                    <a class="nav-link text-light" style="font-weight: 600" href="facultyLogin.jsp">FACULTY LOGIN</a>
                </li>
                <%
            }
            else
            {
                %>
                <li class="nav-item">
                    <a class="nav-link text-light" style="font-weight: 600" href="facultyLogout">FACULTY LOGOUT</a>
                </li>
                <%
            }
      %>
      
    </ul>
  </div>
</nav>
