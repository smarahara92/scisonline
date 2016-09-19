<%-- 
    Document   : newjspstudent
    Created on : Dec 28, 2011, 3:28:32 PM
    Author     : jagan
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@include file="checkValidity.jsp"%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script language="javascript" src="newjavascript.js"></script>
        <script type="text/javascript" src = "jquery.js" ></script>

        <script>
            window.history.forward();
            function setting1()
            {
                if (window.innerWidth && window.innerHeight)
                {
                    var winW = window.innerWidth;
                    var winH = window.innerHeight;
                    document.getElementById("first").height = winH - 46;
                    document.getElementById("first").width = winW - 9;
                }
            }
            function setting()
            {
                if (window.innerWidth && window.innerHeight)
                {
                    var winW = window.innerWidth;
                    var winH = window.innerHeight;
                    document.getElementById("first").height = winH - 46;
                    document.getElementById("first").width = winW - 9;
                }
            }

            window.onresize = function()
            {
                setting();
            }

        </script>
        <style type="text/css" media="screen">

            body { font-family:Arial, Helvetica, sans-serif; }
            div.header { display:block; position:static; height:30px; }
            #menu-container { display:block; position:static; width:100%; margin:0px;  font-size:10px;left:0px; }
            #drop_down_menu { display:block; position:absolute; clear:both; margin:0px; padding:0px; text-align:center; list-style-type:none; text-align:center; width:1400px; float:none; left:0px; top:0px; }
            #drop_down_menu li { font-size:14px; font-weight:bold; float:left; color:white; padding:5px; cursor:pointer; background:#003399; width:140px; }
            #drop_down_menu li ul { margin:0px; padding:0px; list-style-type:none; padding-top:10px; }
            #drop_down_menu li ul li { display:block; float:none; clear:both;  }
            #drop_down_menu li ul li a { color:white; font-weight:normal; text-decoration:none; display:block; }
            #drop_down_menu li ul li a:HOVER { text-decoration:underline; color:red; }
        </style>
        <!--        <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.2.6/jquery.min.js"></script>-->

        <link rel="stylesheet" type="text/css" href="jkoutlinemenu.css" />

        <script type="text/javascript" src="jkoutlinemenu.js"></script>
        <script type="text/javascript">
            jkoutlinemenu.definemenu("one", "mymenu1", "mouseover", 180);
            jkoutlinemenu.definemenu("two", "mymenu2", "mouseover", 180);
            jkoutlinemenu.definemenu("three", "mymenu3", "mouseover", 180);
            jkoutlinemenu.definemenu("four", "mymenu4", "mouseover", 180);

        </script>
    </head>
    <body bgcolor="#CCFFFF" onload="checkvalidity();" onclick="checkvalidity();">
        <% try {
        %>
        <div class="header">
            <div id="menu-container">	
                <ul id="drop_down_menu">
                    <li><a href="studentmain.jsp"><font color="white">Home</font></a>

                    </li>


                    <li id="one" class="menu">Attendance
                        <ul id="mymenu1" class="links">
                            <li><a href="student1.jsp" target="first">View</a></li>

                        </ul>
                    </li>
                    <li id="two" class="menu">Assessment
                        <ul id="mymenu2" class="links">
                            <!--                            <li><a href="studentMarks.jsp" target="first">View</a></li>
                                                        <li><a href="detailStudentwise.jsp" target="first">Detailed View</a></li>-->
                            <li><a href="student.jsp" target="first">Project</a></li>
                            <li><a href="studentsubject.jsp" target="first">Subject</a></li>

                        </ul>
                    </li>
                    <li id="three" class="menu">Project
                        <ul id="mymenu3" class="links">
                            <li><a href="student_projects2.jsp" target="first"><font style=" font-size: 11px">View Unallocated Projects</font></a></li>


                        </ul>
                    </li>
                    <div id="d1">
                        <li id="four" class="menu">Welcome <%=session.getAttribute("user")%>
                            <ul id="mymenu4" class="links">
                                <li><a href="logindetailsframe.jsp" target="first">Login Activity</a></li>
                                <li><a href="changepassword.jsp" target="first">change password</a></li>
                                <li><a href="ExpireSession.jsp">Sign Out</a></li>

                            </ul>
                        </li>
                    </div>

                    <li>&nbsp;</li>
                    <li>&nbsp;</li>
                    <li>&nbsp;</li>
                    <li>&nbsp;</li>
                        <%
                            String ip = request.getHeader("X-FORWARDED-FOR");
                            if (ip == null) {
                                ip = request.getRemoteAddr();
                            }
                        %>

                    <%
                        session.setAttribute("yip", ip);
                    %>


                </ul>
            </div>
        </div>


        <iframe  src="hcu.jsp" id="first" frameborder=0 border=0 onload="setting1();" name="first" style="color:#CCCCCC" >

    </body>
</html>
<%} catch (Exception e) {
        e.printStackTrace();
    }%>