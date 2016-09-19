<%-- 
    Document   : newjsp1
    Created on : Sep 14, 2011, 1:57:49 PM
    Author     : admin
--%>

<%@page import ="javax.sql.*" %>
<%@page import="java.sql.*" %>
<%@include file="checkValidity.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page errorPage="error.jsp?msg=Application Generated an error!" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script 
        language="javascript" src="newjavascript.js"></script>
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
            jkoutlinemenu.definemenu("one", "mymenu1", "mouseover", 180)
            jkoutlinemenu.definemenu("two", "mymenu2", "mouseover", 180)
            jkoutlinemenu.definemenu("two1", "mymenu21", "mouseover", 180)
            jkoutlinemenu.definemenu("three", "mymenu3", "mouseover", 180)
            jkoutlinemenu.definemenu("four", "mymenu4", "mouseover", 180)

        </script>
    </head>
    <body bgcolor="#CCFFFF" onload="checkvalidity()">
        <%! String fname = "";%>

        <table>
            <tr>
                <td>

                    <div class="header">
                        <div id="menu-container">	
                            <ul id="drop_down_menu">
                                <li><a href="facultymain.jsp"><font color="white">Home</font></a>

                                </li>
                                <li id="one" class="menu">Attendance
                                    <ul id="mymenu1" class="links">
                                        <li><a href="subject_students.jsp" target="first">List of Students</a></li>
                                        <li><a href="faculty.jsp" target="first">Update</a></li>
                                        <li><a href="faculty1.jsp" target="first">View</a></li>
                                        <li><a href="faculty3.jsp" target="first">Summary</a></li>
                                    </ul>
                                </li>

                                <li id="two" class="menu">Assessment
                                    <ul id="mymenu2" class="links">
                                        <li><a href="UpdateMarks.jsp" target="first">Update</a></li>
                                        <li><a href="facultyviewframe.jsp" target="first">View</a></li>
                                        <li><a href="facultysummaryframe.jsp" target="first">Summary</a></li>
                                        <li><a href="sup-assessment.jsp" target="first">Supplementary<br>/Improvement</a></li>
                                    </ul>
                                </li>

                                <li id="two1" class="menu">Project
                                    <ul id="mymenu21" class="links">
                                        <li><a href="projectRegistrationFacultySelect.jsp" target="first">Project Registration</a></li>
                                        <li><a href="projectFacultyViewFrame.jsp" target="first">View</a></li>
                                        <li><a href="projectFacultyModifyFrame.jsp" target="first">Modify</a></li>

                                    </ul>
                                </li>
                                <li id="three" class="menu">Ph.D
                                    <ul id="mymenu3" class="links">

                                        <li><a href="drc_membership.jsp" target="first">DRC Membership</a></li>
                                        <li><a href="thesistitle.jsp" target="first">Thesis Title</a></li>
                                        <li><a href="allocatedrc.jsp" target="first">Allocate DRC</a></li>
                                        <!--<li><a href="drcview.jsp" target="first">DRC View</a></li-->
                                        <li><a href="latestdrc.jsp" target="first">Latest DRC</a></li> 
                                        <li><a href="basicframeforviews.jsp" target="first">Complete Record </a></li> 
                                     

                                    </ul>
                                </li>   

                                <li id="four" class="menu">Welcome <%=session.getAttribute("user")%>
                                    <ul id="mymenu4" class="links">
                                        <li><a href="logindetailsframe.jsp" target="first">Login Activity</a></li>
                                        <!--                                        <li><a href="loginactivity.jsp" target="first">Login Activity</a></li>-->
                                        <li><a href="changepassword.jsp" target="first">change password</a></li>
                                        <li><a href="ExpireSession.jsp">Sign Out</a></li>

                                    </ul>
                                </li>
                                <li>&nbsp;</li>
                                <li>&nbsp;</li>
                                <li>&nbsp;</li>
                                <%String ip = request.getHeader("X-FORWARDED-FOR");
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
                </td>

            </tr>


        </table>

        <iframe  src="hcu.jsp" id="first" frameborder=0 border=0  onload="setting1();" name="first" style="color:#CCCCCC" >


    </body>
</html>