<%-- 
    Document   : adminmain
--%>

<%@include file="checkValidity.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>


<%@page errorPage="error.jsp?msg=Application Generated an error!" %>
<html>
    <head>

        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>

        <script>
            window.history.forward();
            

/*            function setting1()
            {
                if (window.innerWidth && window.innerHeight)
                {
                    var winW = window.innerWidth;
                    var winH = window.innerHeight;
                    document.getElementById("first").height = winH - 46;
                    document.getElementById("first").width = winW - 9;
                }
            }*/
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
            };

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
        <script type="text/javascript" src = "jquery.js" ></script>
        <link rel="stylesheet" type="text/css" href="jkoutlinemenu.css" />
        <script type="text/javascript" src="jkoutlinemenu.js"></script>
        <script type="text/javascript">
            jkoutlinemenu.definemenu("one", "mymenu1", "mouseover", 180);
            jkoutlinemenu.definemenu("two", "mymenu2", "mouseover", 180);
            jkoutlinemenu.definemenu("three", "mymenu3", "mouseover", 180);
            jkoutlinemenu.definemenu("four", "mymenu4", "mouseover", 180);
            jkoutlinemenu.definemenu("five", "mymenu5", "mouseover", 180);
        </script>
    </head>

    <body bgcolor="#CCFFFF" onload="checkValidity();">


        <table width="100%">   
            <tr>
                <td>
                    <div class="header">
                        <div id="menu-container">	
                            <ul id="drop_down_menu">
                                <li><a href="adminmain.jsp"><font color="white">Home</font></a>
                                </li>



                                <li id="one" class="menu">Initialization                                    
                                    <ul id="mymenu1" class="links">                                        
                                        <li><a href="programme_mang.jsp" target="first"> Programme Management</a></li>
                                        <li><a href="subject_database.jsp" target="first">Subject Database</a></li>
                                        <li><a href="faculty_database.jsp" target="first">Faculty Database</a></li>                                            
                                        <li><a href="phd_electives.jsp" target="first">Ph.D </a></li>
                                        <li><a href="project_status.jsp" target="first">Project </a></li>
                                        <li><a href="astaff5.jsp" target="first">Grade Formula</a></li>
<!--                                         <li><a href="userinfo1.jsp" target="first">User Information</a></li>-->
                                   
                                    </ul>  

                                </li>



                                <li class="menu" id="two">Yearly Activities                                    
                                    <ul id="mymenu2" class="links">
                                        <li><a href="newbatchstudentmng.jsp" target="first">NewBatch</a></li>
                                    <li><a href="newbatchinfo.jsp" target="first">Student Information</a></li>

                                    </ul>                                    
                                </li>

                                <li id="three" class="menu">Semester Activities
                                    <ul id="mymenu3" class="links">
                                        <li><a href="test.jsp" target="first">Course Allocation</a></li>
                                        <li><a href="stream_limits_start_page.jsp" target="first">Stream Limits</a></li>
                                        <li><a href="test_course_reg.jsp" target="first">Course Registration</a></li>                                       
                                        <li><a href="readminnew.jsp" target="first">Re-Admission</a></li>
                                        <li><a href="recoursenew.jsp" target="first">Re-Course</a></li>
                                        <li><a href="addstudent.jsp" target="first">Add Student</a></li>
                                        <li><a href="deletestudent.jsp" target="first">Delete Student</a></li>
                                        <li><a href="Sliding.jsp" target="first">Sliding</a></li>
                                        <li><a href="sup_registrationframe.jsp" target="first">Supplementary</a></li>
                                        <li><a href="imp_registration.jsp" target="first">Improvement</a></li>

                                    </ul>
                                </li>

                                <li id="four" class="menu">View
                                    <ul id="mymenu4" class="links">
                                        <li><a href="subject_students.jsp" target="first">Subject-Students List</a></li>
                                        <li><a href="supplementaryframe.jsp" target="first">Supplementary</a></li>
                                        <li><a href="improvementframe.jsp" target="first">Improvement</a></li>
                                    </ul>
                                </li>
                                

                                <% if (session.getAttribute("user") == null) {
                                        String msg = "Session Expired or You are not Logged in";
                                        // response.sendRedirect("error.jsp?msg="+msg);%>
                                <%} else {%>
                                <li id="five" class="menu">Welcome <%=session.getAttribute("user")%>
                                    <ul id="mymenu5" class="links">
                                        <li><a href="logindetailsframe.jsp" target="first">Login Activity</a></li>
<!--                                        <li><a href="loginactivity.jsp" target="first">Login Activity</a></li>-->
                                        <li><a href="changepassword.jsp" target="first">change password</a></li>
                                        <li><a href="ExpireSession.jsp">Sign Out</a></li>


                                    </ul>
                                </li>


                                <li>&nbsp;</li>
                                <li>&nbsp;</li>
                               
                                    <%}
                                        String ip = request.getHeader("X-FORWARDED-FOR");
                                        if (ip == null) {
                                            ip = request.getRemoteAddr();
                                        }
                                    %>

<!--                                <right>Your ip address:<%=ip%></right>-->
                                <%
                                    session.setAttribute("yip", ip);
                                %>


                            </ul>
                        </div>
                    </div>
                </td>

            </tr>


        </table> 
        <iframe  src="hcu.jsp" id="first" frameborder=0 border=0  onload="setting();" name="first" style="color:#CCCCCC" ></iframe>
    </body>
</html>
