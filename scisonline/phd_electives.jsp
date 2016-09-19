<%-- 
    Document   : phd_electives
    Created on : Jun 4, 2013, 10:39:51 AM
    Author     : root
--%>

<%@page import="java.io.*"%>
<%@page import ="javax.sql.*" %>
<%@page import="java.sql.*" %>
<%@include file="dbconnection.jsp"%> 
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="checkValidity.jsp"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <form action="Commonsfileuploadservlet1" enctype="multipart/form-data" method="POST">
                    <input type="hidden" name="check" value="6" />
                    <table align="center" border="0" cellpadding="5" cellspacing="5">
                       
                      
                        <tr><td align="center"><font size="5"><b>Upload the PhD elective file(.csv)</b></font></td></tr>
                    <tr><td colspan="2" align="center"><input type="file" name="file1" />
			<input type="Submit" value="Upload File"/><br></td></tr>
                    </table>
		</form>
    
     
   </body> 
</html>