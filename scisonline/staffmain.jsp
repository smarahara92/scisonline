<%-- 
    Document   : newjsp1
    Created on : Sep 14, 2011, 1:57:49 PM
    Author     : admin
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
            jkoutlinemenu.definemenu("five", "mymenu5", "mouseover", 180);
            jkoutlinemenu.definemenu("six", "mymenu6", "mouseover", 180);

        </script>
    </head>

    <body bgcolor="#CCFFFF" onload="checkvalidity()">

        <table>   
            <tr>
                <td>
                    <div class="header">
                        <div id="menu-container">	
                            <ul id="drop_down_menu">
                                <li><a href="staffmain.jsp"><font color="white">Home</font></a>

                                </li>


                                <li id="one" class="menu">Attendance
                                    <ul id="mymenu1" class="links">
                                        <li><a href="staffupdate.jsp" target="first">Update</a></li>
                                        <li><a href="staff1.jsp" target="first">Student</a></li>
                                        <li><a href="staff2.jsp" target="first">Subject</a></li>
                                        <li><a href="staff3.jsp" target="first">Stream</a></li>
                                        <li><a href="staff4.jsp" target="first">Summary</a></li>
                                        
                                    </ul>
                                </li>
                                <li id="two" class="menu">Assessment
                                    <ul id="mymenu2" class="links">
                                        <li><a href="UpdateMarksStaff.jsp" target="first">Update</a></li>
                                        <!-- <li><a href="projectStaffAssessment.jsp" target="first">Project</a></li>-->
                                        <li><a href="projectstaffassessment.jsp" target="first">Project</a></li>
                                        <!--                                        <li><a href="projectStaffSummary.jsp" target="first">Project Summary</a></li>
                                                                                <li><a href="projectStaffView.jsp" target="first">Project View</a></li>-->
                                        <!--                                        <li><a href="degree_awarded.jsp" target="first">Degree Awarded</a></li>-->
                                        <!--                                        <li><a href="astaff3.jsp" target="first">Student</a></li>-->
                                        <li><a href="staffstudentframe.jsp" target="first">Student</a></li>
                                        <!--                                <li><a href="astaff1.jsp" target="first">Stream</a></li>                                        -->
                                        <li><a href="staffstream.jsp" target="first">Stream</a></li>   
                                        <!--                                        <li><a href="astaff4.jsp" target="first">Subject</a></li>-->
                                        <li><a href="staffsubject.jsp" target="first">Subject</a></li>
<!--                                        <li><a href="staffImprovementSupplementary.jsp" target="first">Supplementary/<br>Improvement</a></li>-->
                                        <li><a href="staffsupimpframe.jsp" target="first">Supplementary/<br>Improvement</a></li>
                                    </ul>
                                </li>

                                <li id="three" class="menu">Project
                                    <ul id="mymenu3" class="links">
                                        <li><a href="proj_reg_staff.jsp" target="first">Project Allocation</a></li>
                                        <li><a href="projectRegistrationInterns.jsp" target="first">Internship Project Allocation</a></li>
                                        <li><a href="projectStaffViewFrame.jsp" target="first">View</a></li>
                                        <li><a href="projectStaffModifyFrame.jsp" target="first">Modify</a></li>
                                    </ul>
                                </li>

                                <!--     <li><a href="queries.jsp" target="first"><font color="white">Queries</font></a>
                                             
                                     </li>
                                     
                                <!--	<li class="menu">Admin
                                                <ul class="links">
                                                        <li><a href="subjectinfo.jsp" target="first">Subject Database</a></li>
                                                        <li><a href="facultyinfo.jsp" target="first">Faculty Database</a></li>
                                                        <li><a href="sFile.jsp" target="first">NewBatch</a></li>
                                                        <li><a href="addstudent.jsp" target="first">Add student</a></li>
                                                         <li><a href="deletestudent.jsp" target="first">Delete student</a></li>
                                                        <li><a href="sub-faconline.jsp" target="first">Subject-Faculty Registration</a></li>
                                                        <li><a href="elective_streamlimits.jsp" target="first">Elective-Stream Limits</a></li>
                                                        <li><a href="ele_reg.jsp" target="first">Course Registration</a></li>
                                                        <li><a href="readmin.jsp" target="first">Re-Admin</a></li>
                                                        <li><a href="recoursemodify.jsp" target="first">Re-Course</a></li>
                                                        <li><a href="addSubject.jsp" target="first">Add Subject</a></li>
                                                        <li><a href="addFaculty.jsp" target="first">Add Faculty</a></li>
                                                        <li><a href="deleteSubject.jsp" target="first">Delete Subject</a></li>
                                                        <li><a href="deleteFaculty.jsp" target="first">Delete Faculty</a></li>
                                                       
                                                </ul>
                                        </li>-->

                                <li id="four" class="menu">Ph.D
                                    <ul id="mymenu4" class="links">
                                        <li><a href="phd_projectallocation.jsp" target="first">Supervisor Allocation</a></li> 
                                        <li><a href="drc_membership.jsp" target="first">DRC Registration</a></li>  
                                        <li><a href="phd_ele_reg.jsp" target="first">Comprehensive Registration</a></li>
                                        <li><a href="cmp_assessment.jsp" target="first">Comprehensive Assessment</a></li> 
                                        <li><a href="student_status_update1.jsp"target="first"><font color="white">Student Status</font></a>
                                        <li><a href="allocatedrc.jsp" target="first">DRC Report </a></li>  
                                        <!--li><a href="Queries.jsp" target="first">Queries</a></li--> 
                                        <!--<li><a href="cmp_assessment.jsp" target="first">Comprehensive Assessment</a></li>--> 

                                    </ul>
                                </li>   
                                
                                <li id="six" class="menu">Queries
                                    <ul id="mymenu6" class="links">
                                        <li><a href="query_list_assessment.jsp" target="first">Assessment</a></li>
                                        <li><a href="query_list_attendance.jsp" target="first">Attendance</a></li>
                                        <li><a href="query_list_courseMNG.jsp" target="first">Course Management</a></li>
                                        <li><a href="query_list_curr_prgm.jsp" target="first">Curriculum/<br/>Programme</a></li>
                                        <li><a href="query_list_facultyDB.jsp" target="first">Faculty Database</a></li>
                                        <li><a href="query_list_phd.jsp" target="first">Ph.D</a></li>
                                        <li><a href="query_list_project.jsp" target="first">Project</a></li>
                                        <li><a href="query_list_recourse_readmission.jsp" target="first">Re-admission/<br/>Recourse</a></li>
                                        <li><a href="query_list_student.jsp" target="first">Student Database</a></li>
                                    </ul>
                                </li>
                                
                                <% if (session.getAttribute("user") == null) {
                                        String msg = "Session Expired or You are not Logged in";
                                        // response.sendRedirect("error.jsp?msg="+msg);%>
                                <%--<jsp:forward page="error.jsp"/>--%>
                                <%} else {%>
                                <li id="five" class="menu">Welcome <%=session.getAttribute("user")%>
                                    <ul id="mymenu5" class="links">
<!--                                        <li><a href="loginactivity.jsp" target="first">Login Activity</a></li>-->
                                        <li><a href="logindetailsframe.jsp" target="first">Login Activity</a></li>
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

        <iframe  src="hcu.jsp" id="first" frameborder=0 border=0  onload="setting1();" name="first" style="color:#CCCCCC" >

    </body>
</html>
