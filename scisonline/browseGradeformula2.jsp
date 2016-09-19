<%-- 
    Document   : browseGradeformula2
    Created on : 4 Apr, 2012, 2:11:53 PM
    Author     : khushali
--%>

<%@include file="checkValidity.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<HTml>
<HEAD><TITLE>Display file upload form to the user</TITLE></HEAD> 

<BODY>
    <%
         String stream=request.getParameter("streamname");
         System.out.println("stream name is:"+stream);
         session.setAttribute("stream1",stream);
         // System.out.println("stream1 name is:"+stream);
    %>
<FORM ENCTYPE="multipart/form-data" ACTION=
"updateGradeformula2.jsp" METHOD=POST>
<br><br><br>
<center>
    <table border="2" >
<tr>
 
    <td colspan="2"><p align=
"center"><B>UPLOAD THE FILE FOR GRADE FORMULA</B><center></td></tr>
<tr><td><b>Choose the file To Upload:</b>
</td>
<td><INPUT NAME="file" TYPE="file"></td></tr>
<tr><td colspan="2">
<p align="right"><INPUT TYPE="submit" VALUE="Send File" ></p></td></tr>
<table>
</center> 
</FORM>
</BODY>
</HTML>
