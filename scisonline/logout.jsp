<%@include file="checkValidity.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Logout page</title>
    </head>
    <body bgcolor="#99CCFF">
        <%            session.invalidate();%>
        <h1>Thank You !</h1>
        <p>You have been successfully loged out form dcisonline. </p>
        <a href="login.jsp">Login Again</a>
    </body>
</html>
