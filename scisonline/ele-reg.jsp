<%-- 
    Document   : ele-reg
    Created on : Feb 27, 2012, 4:13:24 PM
    Author     : jagan
--%>

<%@include file="checkValidity.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <table align="center">
            <tr><th>Elective Registration</th></tr>
            <tr>
                <td>MCA-II</td>
                <td>MTech-CS</td>
            </tr>
            <%int i=0;
            while(i<10)
    {
    %>
            <tr>
                <td>subject</td>
                <td>
                    <input type="checkbox" name="checkbox" >
                    <input type="text" name="text" value="" size="5">
                </td>
                <td>
                    <input type="checkbox" name="checkbox" >
                    <input type="text" name="text" value="" size="5">
                </td>
                <td>
                    <input type="checkbox" name="checkbox" >
                    <input type="text" name="text" value="" size="5">
                </td>
                <td>
                    <input type="checkbox" name="checkbox" >
                    <input type="text" name="text" value="" size="5">
                </td>
            </tr>
            <%
            i++;
}
%>
        </table>
    </body>
</html>
