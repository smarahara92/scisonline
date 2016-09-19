<%-- 
    Document   : session_test
    Created on : Oct 17, 2013, 10:58:43 AM
    Author     : sri
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello World!</h1>
        <%=request.getParameter("given_session")%>
        
       
        <%=request.getParameter("given_year")%>
     
        
        
        
    </body>
</html>
