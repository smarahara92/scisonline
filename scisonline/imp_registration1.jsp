<%-- 
    Document   : imp_registration1
    Created on : May 20, 2013, 10:05:14 AM
    Author     : root
--%>

<%@include file="checkValidity.jsp"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script>



            function check()
            {
                var val = document.getElementById("sid").value;

                parent.facultyaction.location = "./imp_registration2.jsp?sid=" + val;
            }
        </script>   
    </head>
    <form name="frm"   method="POST">
        <body><br><br>
        <center><b> Student Id </b>
            <input type="text" name="sname" id="sid" onchange="check();">
            </body>
            </form>
            </html>
