<%-- 
    Document   : userinfo2
    Created on : May 27, 2014, 4:30:26 PM
    Author     : veeru
--%>
<%@ include file="dbconnection.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <form action="userinfo.jsp" target="userinfo">
            <table>
            <caption><h3>User Id:</h3></caption>
            <tr>
                <td><input type="text" size="10%" name="userId"></td>
            </tr>
        </table>
        </form>        
    </body>
</html>
