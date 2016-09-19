<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Welcome Page </title>
    </head>
    <body bgcolor="#99CCFF">
	<h2><%String user=(String)session.getAttribute("user");%>
 		<p>Welcome  <%= user%> !!! </p>
	</h2>
	</body>
</html>
