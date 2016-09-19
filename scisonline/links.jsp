<%-- 
    Document   : links
    Created on : Aug 30, 2011, 5:40:31 AM
    Author     : admin
--%>
<%@include file="checkValidity.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script>
            var count=0;
            function page()
            {
                count++;
                if(count%2==0)
                    {
                document.getElementById('xyz').innerHTML='<a href="streamwise.jsp" target="result"> M.Tech-CS-2011 </a><br/>\
                                                             M.Tech-AI-2011<br/>\
                                                             M.Tech-IT-2011<br/>';
            }
            else
                       document.getElementById('xyz').innerHTML="";
            }
        </script>
        
    </head>
    <body bgcolor="#FFCCFF">
        <table>
 
            <tr><td><a href="students.jsp" target="result"><font size="4">Student</font></a><br></td></tr>
            <tr><td><a href="subjectwise.jsp" target="result"><font size="4">Subject</font></a><br></td></tr>
            <tr><td><a href="#" onclick="page();"><font size="4">Stream</font></a><div id="xyz"></div></td></tr>
        </table>
    </body>
</html>
