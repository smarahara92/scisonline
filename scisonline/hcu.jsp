<%-- 
    Document   : hcu
    Created on : Oct 31, 2011, 7:55:14 AM
    Author     : admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="table_css.css">

        <title>JSP Page</title>
        <script>
            function onload1() {

                window.open("header.jsp", "header1");


            }
        </script>
    </head>
    <body onload="onload1();">


        <%
            try {
                //if user already login and if one more user want to login..
                String checkUserLogin = "";
                String alreadyLoggedin = "";
                try {
                    if (session.getAttribute("checkUserLogin") != null) {
                        checkUserLogin = (String) session.getAttribute("checkUserLogin");
                        session.setAttribute("checkUserLogin", "no");
                    }
                } catch (Exception e) {

                }
                try {
                    if (session.getAttribute("alreadylogin") != null) {
                        alreadyLoggedin = (String) session.getAttribute("alreadylogin");
                        session.setAttribute("alreadylogin", "no");
                    }
                } catch (Exception e) {
                }
                if (checkUserLogin.equalsIgnoreCase("yes")) {

                    checkUserLogin = "";

        %>
        <table align="center" border="1">
            <tr>
                <td style=" color: red; width: 100%"><p>Sorry we could not proceed your request! please try again later.</p></td>
            </tr>
        </table>

        <%return;

        } else if (alreadyLoggedin.equalsIgnoreCase("yes")) {

            String when = (String) session.getAttribute("alreadyloginlost");
            String ip = (String) session.getAttribute("alreadyloginip");
            String mac = (String) session.getAttribute("alreadyloginmack");
            String sys = (String) session.getAttribute("alreadyloginsystem");
            String agent = (String) session.getAttribute("alreadyloginagent");
            System.out.println(when + ip + mac + sys + agent);
        %>
        <table align="center" border="1">
            <tr>
                <td>
                    <p><h3 style=" color: #B40404">You already logged at..</h3></p>
                    
                    <p><font style=" color: blue">Ip Address :</font><%=ip%></p>
                    <p><font style=" color: blue">MAC Address:</font><%=mac%></p>
                    <p><font style=" color: blue">System Name:</font><%=sys%></p>
                    <p><font style=" color: blue">Agent      :</font><%=agent%></p>
                    <p><font style=" color: blue">Date & Time:</font><%=when%></p>


                </td>
            </tr>
        </table>

        <%return;

                }

            } catch (Exception e) {
                System.out.println(e);
            }
        %>
    <center>
        <h1><center>Welcome to University of Hyderabad</center></h1></center>

</body>
</html>
