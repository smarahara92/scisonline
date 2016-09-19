<%@ page import="net.tanesha.recaptcha.ReCaptcha" %>
<%@ page import="net.tanesha.recaptcha.ReCaptchaFactory" %>
<%@ include file="dbconnection.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>SCIS ONLINE web page</title>
        <style>
            #bold{
                font-weight: bold;
                color: black;
            }
            .style1{
                color: red;
            }

            body
            {
                background-image:url('university1.jpg');
                background-size:1750px,800px;
                background-repeat:no-repeat;
            } 
            .table
            {   
                color:black;
                background-color: #99CCFF;
                opacity:0.8;
                filter:alpha(opacity=60);
                vertical-align: central;
                object-position: 50%;
                width: 300px;
                height: 130px;
                padding: 10px;
                position: absolute;
                top: 50%; left: 50%;
                margin-left: -170px; 
                margin-top: -120px; 

            }
            .body{
                background-color: #99CCFF;

            }

        </style>
        <script>
            window.history.forward();
            function validate()
            {
                var flag = 0;
                document.getElementById("cap").innerHTML = "";
            <%                if (session.getAttribute("user") != null) {
                    String fwdpage = session.getAttribute("role") + "main.jsp";
                    response.sendRedirect(fwdpage);
                    return;
                }
            %>

                var username = document.getElementById("user").value;
                var password = document.getElementById("password").value;
                if (username === "") {
                    alert("Please Enter Username");
                    document.forms["frm"].user.focus();
                    return false;
                }
                else if (password === "") {
                    alert("Please Enter Password");
                    document.forms["frm"].password.focus();
                    return false;
                }



            }
            function check()
            {

                document.getElementById("cap").innerHTML = "";
            }
        </script>

    </head>
    <body class="body" onkeydown="return (event.keyCode != 116)" onload="document.forms['frm'].user.focus();">
        <form action="auth.jsp" method="POST" id="frm" onsubmit="return validate();">
            <%
                ResultSet rs = null;
                int flag = 0;
                try {
                    int fail = 0;
                    String previouslyLoggedUser = (String) session.getAttribute("loginuseriiiiiiiii");
                    PreparedStatement ps = null;
                    String sqlOption = "SELECT * FROM loginactivity where userid=? ";
                    ps = con.prepareStatement(sqlOption);
                    ps.setString(1, previouslyLoggedUser);
                    rs = ps.executeQuery();
                    if (rs.next()) {
                        fail = rs.getInt("failedattempts");
                        if (fail >= 3) {
                            flag++;
                        }
                    }
                } catch (Exception e) {
                }
            %>
            <table class="table">
                <tr>
                    <td>
                        <b>Username</b>
                        <input type="text" name="user" id="user" size="25" onclick="check();" /><br />
                        <b>Password</b>
                        <input type="password" name="password" id="password" size="25" />
                        
                        <p>
                            <%
                                if (flag > 0) {
                                    ReCaptcha c = ReCaptchaFactory.newReCaptcha(
                                            "6LePSPQSAAAAAB5MKyp3gUJZxAuFI3j6U4LDhYb7",
                                            "6LePSPQSAAAAAC5LY-korz96f5c_x8cz7Kv3GDU5", false);
                                    out.print(c.createRecaptchaHtml(null, null));
                                }

                            %>

                        </p>    
                        <%String msg = request.getParameter("msg");
                            if (msg != null) {%>
                        <p class="style1" id="cap" style=" font-size: 15px"><%=msg%>...</p>
                        <%}%>

                        <input type="submit" value="Login"  name="submit" id="bold"/>


                    </td>
                </tr>

            </table>
        </form>
    </body>
</html>
