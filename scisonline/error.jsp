<%-- 
    Document   : error
--%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<%@page isErrorPage="true" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Error Page!</title>
    <script>
        function gotoindex()
        {
           window.close();
            window.open("login.jsp",'start','toolbar=1');
            
            
        }
    </script>
    </head>
    <body bgcolor="#99CCFF">
	 <%
         String msg=request.getParameter("msg");
		if(msg!=null){%>
		<h2><font color=red><%=msg %></font></h2>
	    <%}%>
	<a href="javascript:gotoindex()" >Login Again</a> 
    </body>
</html>
