<%-- 
    Document   : sup-assessmentchecked
    Created on : May 28, 2013, 7:32:33 AM
    Author     : root
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
         <%
        String sname=request.getParameter("subjectname");
          String sid=request.getParameter("subjectid");
          String fid=request.getParameter("fid");
        
        %>
        <frameset rows="20%,*" border="0">
            <frame src="sup-assessmentchecked1.jsp?subjectname=<%=sname%>&subjectid=<%=sid%>&fid=<%=fid%>" noresize="noresize" scrolling="no"/>
            <frame name="facultyaction1" />

        </frameset>
    </head>
   
       
         <body>
    </body>
</html>
