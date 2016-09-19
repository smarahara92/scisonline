<%-- 
    Document   : cFile
    Created on : Mar 8, 2012, 9:49:00 AM
    Author     : admin
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
        <form action="Commonsfileuploadservlet1" enctype="multipart/form-data" method="POST">
                    <input type="hidden" name="check" value="1" />
                    <table align="center" border="0" cellpadding="5" cellspacing="5">
                        <tr> <th> <p><h1>Upload Curriculum File</h1></p> </th></tr>
                        <tr><td align="center"><select name="text1" style="width:200px;">
                        <option>MTech-CS</option>
                        <option>MTech-AI</option>
                        <option>MTech-IT</option>
                        <option>MCA</option>
                        <option>Ph.D</option>
                    </select> </td>
                        
                     </tr>
                        <tr></tr>
                    <tr><td><input type="file" name="file1" />
			<input type="Submit" value="Upload File"><br></td></tr>
                    </table>
		</form>
    </body>
</html>
