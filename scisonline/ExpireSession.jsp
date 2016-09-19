<%@ include file="dbconnection.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Logout page</title>
        <script>
            function onload1() {

                window.open("header.jsp", "header1");


            }
        </script>
    </head>
    <body bgcolor="#99CCFF" onload="onload1();">
        <%
            try {
                String user = (String) session.getAttribute("user");
                PreparedStatement pstmt = con.prepareStatement("UPDATE loginactivity set status=? where userid=?");
                pstmt.setInt(1, 0);
                pstmt.setString(2, user);
                pstmt.executeUpdate();
            } catch (Exception e) {
            }
            session.removeAttribute("user");
            session.invalidate();%>
        <h1>Thank You !</h1>
        <p>You have been successfully logged out from dcisonline. </p>
        <a href="login.jsp" target="start">Login Again</a>
    </body>
</html>
