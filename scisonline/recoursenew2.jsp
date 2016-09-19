<%-- 
    Document   : recoursenew2
    Created on : Apr 6, 2013, 5:53:40 PM
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
            String selectstream = request.getParameter("pg");
           
        %>
    <frameset rows="30%,*" border="0" frameborder="0">
        <frame src="recoursenew3.jsp?selectstream=<%=selectstream%>" noresize="noresize" scrolling="no"/>
        <frame name="facultyaction1" />

    </frameset>
</head>
<body>

</body>
</html>
