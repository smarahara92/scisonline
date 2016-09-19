<%-- 
    Document   : loginactivity2
    Created on : May 29, 2014, 11:27:30 PM
    Author     : veeru
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script>
            function check(value)
            {
                if (value === "one")
                {
                    document.prgmfrm.action = "loginactivity3.jsp";
                    document.prgmfrm.submit();
                }
                else if (value === "two") {
                    document.prgmfrm.action = "loginactivity1.jsp?check=2";
                    document.prgmfrm.submit();
                }
            }
        </script>
    </head>
    <body>
        <form name="prgmfrm" method="POST" target="loginactivity">
            <table align="right">
                <tr>
                    <td align="left">
                        <input type="radio" value="one" id="ll" name="ll" onclick="check(this.value);">Logins&nbsp;&nbsp;&nbsp;&nbsp;
                        <input type="radio" name="ll" id="ll" value="two" onclick="check(this.value)">Last failed login
                    </td>
                </tr>
            </table>
        </form>
    </body>
</html>
