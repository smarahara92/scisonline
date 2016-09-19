<%-- 
    Document   : Q_getSubject2_15
    Created on : 19 Apr, 2015, 7:10:51 PM
    Author     : richa
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
        String StudentId = request.getParameter("pname");
        out.println(StudentId);
        %>
    </body>
</html>
