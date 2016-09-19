<%-- 
    Document   : assessmentview
    Created on : May 6, 2013, 8:03:48 PM
    Author     : root
--%>

<%@include file="checkValidity.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
         <%
          String sname=request.getParameter("subjectname");
          String subjectid=request.getParameter("subjectid");
        %>
         <frameset rows="20%,*" border="0" frameborder="0">
            <frame src="assessmentcheckboxes.jsp?subjectname=<%=sname%>&subjectid=<%=subjectid%>" noresize="noresize" scrolling="no"/>
            <frame name="facultyaction1" />

        </frameset>
    </head>
    <body>
        <h1>Hello World!</h1>
    </body>
</html>
