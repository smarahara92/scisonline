<%-- 
    Document   : addstudentview
    Created on : Nov 9, 2013, 5:56:30 PM
    Author     : veeru
--%>

<%@include file="checkValidity.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            String year=(String)request.getAttribute("yr");
            String  stream=(String)request.getAttribute("sm");
            out.println(stream);
        %>
    </body>
</html>
