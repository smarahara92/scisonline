<%@include file="checkValidity.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <frameset cols="15%,*">
            <frame src="subjects_students1.jsp">
            <frame name="facultyaction">
        </frameset>
    </head>
    <body onload="checkvalidity();">
        <h1>Hello World!</h1>
    </body>
</html>