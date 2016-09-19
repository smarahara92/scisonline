<%-- 
    Document   : subjectinfo
--%>

<%@page import="java.io.*"%>
<%@page import ="javax.sql.*" %>
<%@page import="java.sql.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="checkValidity.jsp"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    </head>
    <body>
        <form action="Commonsfileuploadservlet" enctype="multipart/form-data" method="POST">
            <input type="hidden" name="check" value="3" />
            <table align="center" border="0" cellpadding="5" cellspacing="5">
                <tr> <th colspan="2"><font size="6">Subject Information </font></th></tr>
                <tr><td align="center"><font size="5">Upload the subject file(.csv)</font></td></tr>
                <tr><td colspan="2" align="center"><input type="file" name="file1" />
                        <input type="Submit" value="Upload File"/><br>
                    </td>
                </tr>
            </table>
        </form>
    </body> 
</html>