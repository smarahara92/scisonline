<%-- 
    Document   : students
    Created on : Sep 2, 2011, 10:35:43 AM
    Author     : admin
--%>
<%@include file="checkValidity.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style type="text/css">
        center
        {
        visibility:hidden;
        }
        </style>
    </head>
    
      <body bgcolor="#FFE0FF">
          <center>University of Hyderabad</center>
        <center>Department of Computer and Information Sciences</center>
        <center> Attendance of the Student:10MCMT62</center>
        <form action="student.jsp" method="POST">
        <table align="center">
            <tr>
                <td>StudentID:<input type="text" name="studentid" onchange="submit();"></td>
            </tr>
        </table>
            
        </form>
        <% 
        String sid=request.getParameter("studentid");
        System.out.println(sid);
        if(sid!=null)
        out.println("<html><body>"+sid+"</body></html>");
%>
<table border="1" cellspacing="10" cellpadding="10" style="color:blue;background-color:#CCFFFF;">
    <tr>
        <th>Subject</th>
        <th>July15-Aug14</th>
        <th>Aug15-Sep14</th>
        <th>Sep15-Oct14</th>
        <th>Oct15-Nov14</th>
        <th>Overall Percentage</th>
    </tr>
    <tr>
        <td>Algorithm</td>
        <td>21</td>
        <td>19</td>
        <td>17</td>
        <td>10</td>
        <td>75%</td>
    </tr>
</table>
        <div align="center">
		<input type="button" value="Print"
			style="width: 50px; color: white; background-color: #6d77d9; border-color: red;"
                    onclick="window.print();" />
    </body>
</html>
