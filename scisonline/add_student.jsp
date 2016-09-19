<%-- 
    Document   : add_student
--%>
<%@include file="checkValidity.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
    <style>
.style30 {color: red}
.style31 {color: white}
.style32 {color: green}
</style>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script>
            function check()
            {
            	var count =0;
            	for(var j=1; j<=10; j++)
                {
                	var sid = document.getElementById("s"+j).value;
                	var sname = document.getElementById("sn"+j).value;
                	if(sid != "" && sname != "")
                		count++;
                	
                }
            	if(count>0)
            		return true;
            	else
            	{
            		alert("Please write valid Student Id and Name.");
            		return false;
            	}
            }
        </script>
    </head>
    <body bgcolor="#CCFFFF">
        <form name="frm" action="add_student_link.jsp" method="POST" onsubmit="return check();">
        <table align="center" border="1">
            <tr  bgcolor="#c2000d">
            	<td align="center" class="style31"><font size="6">New Student Registration</font></td>
            </tr>
        </table>
        <table align="center" border="1">
          	<tr>
            		<td align="center" class="style30">Student Id</td>
            		<td align="center" class="style30">Student Name</td>
           	</tr>
            <%
            for(int i=1; i<=10; i++)
            {
            	%>
            	<tr>
            		<td align="center"><input type="text" id="s<%=i %>" name="sid" value="" size="8"></td>
            		<td align="center"><input type="text" id="sn<%=i %>" name="sname" value="" size="30"></td>
            	</tr>
            	<%
            }
            %>
            
        </table>
        <table align="center" border="1">
            <tr  bgcolor="#c2000d">
            	<td align="center"><input type="submit" name="submit" value="submit" /></td>
            </tr>
        </table>
        </form>
    </body>
</html>
