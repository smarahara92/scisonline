<%-- 
    Document   : UpdateMarksStaff
    Created on : 8 May, 2015, 3:42:53 PM
    Author     : nwlab
--%>

<%@include file="checkValidity.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <frameset cols="20%,*">
            <frameset rows="20%,*" frameborder="0">
               <frame src="list1staff.jsp" noresize="noresize" scrolling="no"/>
               <frame name="triggering" />
            </frameset>
            <frame name="facultyaction" />

        </frameset>

    </head>
    <body>
        <h1>Hello World!</h1>
    </body>
</html>
