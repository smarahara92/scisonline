<%-- 
    Document   : prelogin
    Created on : Apr 18, 2012, 3:43:38 PM
    Author     : lokesh
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <title>pre-login</title>
        <noscript>
    <h3> JavaScript must be enabled in order for you to use DCISONLINE.</h3>
    <h3>However, it seems JavaScript is either disabled or not supported by your browser. </h3>
    <h3>Enable JavaScript by changing your browser options, then try again. </h3>
    <p>Don't know how to enable javascript <a href="help-js.jsp">click here</a> </p>
    </noscript>
    <script>
        function fun() {
            if (true) {
                // parent.frame["header"].location.reload();
                window.open('login.jsp', '_self', '');

            }
        }
    </script>

</head>
<body bgcolor="#CCFFFF" onload="fun();">

</body>
</html>
