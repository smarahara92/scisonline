<%-- 
    Document   : login
    Created on : 9 Aug, 2012, 3:22:48 PM
    Author     : laxman
--%>

<%@include file="checkValidity.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body body bgcolor="#CCFFFF" onload="document.forms['frm'].user.focus();">
         <form action="addstudent1.jsp" target="staffaction" method="POST">
        <table align="center">
            <tr align="center">
                <input type="radio" name="radio_1" id="radio1"/>
                <b>ADD STUDENT</b>
        </tr><br /><br/>
        <tr>
                <input type="radio" name="radio_1" id="radio2" />
                <b>DELETE STUDENT</b>
            </tr>
        </table>
    </body>
</html>
