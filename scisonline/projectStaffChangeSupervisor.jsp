<%-- 
    Document   : projectStaffChangeSupervisor
    Created on : 18 Mar, 2013, 8:11:35 PM
    Author     : varun
--%>
<%@include file="checkValidity.jsp"%>
<%@page import="com.hcu.mysql.connection.ConnectionDemo1"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@include file="programmeRetrieveBeans.jsp"%>
<%@include file="connectionBean.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style>
            <%--body {color:white}--%>
            .style11 {color :red}
            .style12 {color :white}
            .style13 {color :yellow}


        </style>

        <link rel="stylesheet" type="text/css" href="table_css1.css">

        <script type="text/javascript">
            window.history.forward();
            function validate()
            {
                var test = document.getElementById("hidd").value;
                var x = document.getElementById("rb").value;
                if (test === "")
                {
                    alert("Please Choose a Project.");
                    return false;
                }

                return true;
            }


            function rtuoh(q)
            {
                var x = document.getElementById("sel1").value;
                // alert(x);
                if (x === "none")
                {
                    alert("Please select a new Supervisor.");
                    return false;
                }
                else
                {
                    parent.act_area.location = "./projectStaffChangeSupervisor1.jsp?fid=" + x;
                }
                return true;

            }

            function ChangeSupRB()
            {

                var val = document.getElementById("rb").value;
                if (val === (""))
                {
                    alert("Please Choose a Project.");
                    return false;
                }

            }
            function changeval()
            {
                document.getElementById("hidd").value = "1";
            }


        </script>    
    </head>
    <body>

        <%            String cBox = request.getParameter("r");         // 1. Change Sup // 2. New Internship // 3. Return from Internship
            session.setAttribute("Combo", cBox);
            String streamName = (String) session.getAttribute("projectStreamName");
            streamName = streamName.replace('-', '_');

            String StudId = request.getParameter("studentId");
            String programmeName = scis.studentProgramme(StudId);
            programmeName = programmeName.replace('-', '_');

            Calendar now = Calendar.getInstance();
            int year = now.get(Calendar.YEAR);
            int month = now.get(Calendar.MONTH) + 1;
            int pyear = year;
            String semester = null;
            if (streamName.equalsIgnoreCase("MCA") == true) {
                if (month <= 6) {
                    semester = "Winter";
                    pyear = year;
                } else {
                    semester = "Monsoon";
                    pyear = year - 1;
                }
            } else {
                if (month > 3) {
                    pyear = year;
                } else {
                    pyear = year - 1;
                }
            }
             Connection con = conn.getConnectionObj();
             
            Statement st1 = con.createStatement();
            Statement st2 = con.createStatement();
            Statement st7 = con.createStatement();
            Statement st8 = con.createStatement();

            String table1 = "";
            String table2 = "";

            int streamYear = 0;

            ResultSet rs2 = null;

            table1 = streamName + "_project_" + pyear;
            table2 = programmeName + "_Project_Student_" + pyear;
            session.setAttribute("cpstreamName", streamName);
            session.setAttribute("cpprogrammeName", programmeName);

            try {

                rs2 = (ResultSet) st1.executeQuery("select * from " + table1 + " as a where a.ProjectId in(Select b.ProjectId from " + table2 + " as b where b.StudentId='" + StudId + "')");    // Indicates some project is allocated to this studentId.

            } catch (Exception ex) {%>
        `		   <center><h2>The Projects are not yet allocated.</h2></center>
        <%
                ex.printStackTrace();
                return;
            }

            int rowsCount = scis.programmeDuration(programmeName);
            int rowsCount1 = rowsCount - 1;
            streamYear = year - rowsCount1;

            String byear = Integer.toString(streamYear);
            session.setAttribute("cpyear", byear);
            String Name = scis.studentName(StudId);

            ResultSet rs5 = (ResultSet) st7.executeQuery("select * from  " + table1 + " as a where a.ProjectId in(Select b.ProjectId from " + table2 + " as b where b.StudentId='" + StudId + "') and a.Organization='uoh'");  // Student doing project in Univ.

            // Checking if a student is doing project in university for Return from Internship case.         
            if (rs5.next() == true && "rtuoh".equals(cBox)) {
                out.println(StudId + " is already doing a project in University.");

            }

            // Checking if a Student is not allocated any project for both change sup and return from internship.                                                   
            if ("rtuoh".equals(cBox) || "cs".equals(cBox)) {              // Using same form for Change Supervisor and Return from Internship
                if (rs2.next() != true) {
                    out.println(StudId + " is not assigned any project.");

                }
            }

            rs2.beforeFirst();

            ResultSet rs6 = (ResultSet) st2.executeQuery("select * from   " + table1 + " as a where a.Allocated='no' and a.Organization='uoh'");  // List of Unallocated Projects
            while (rs2.next()) {

                session.setAttribute("ProjectIdOld", rs2.getString(1));

                // Checking for an internship doing student for Change Supervisor         
                if (!rs2.getString(6).equals("uoh") && "cs".equals(cBox)) {

                    out.println(StudId + " is an Internship Student.");

                } //**************************Logic for Change Supervisor***********************************
                else if ("cs".equals(cBox)) {
                    if (rs2.getString(6).equals("uoh")) {

        %>

    <form  id="form" method="POST" onsubmit="return validate();" action="projectStaffChangeSupervisor2.jsp">
        <table align="center">
            <tr bgcolor="#c2000d">
                <td align="center" class="style12"> <font size="6"> Modify Project </font> </td>
            </tr> 
        </table>     
        &nbsp;&nbsp;&nbsp;&nbsp;

        <table align="center" >

            <th>Student ID </th> 
            <th>Student Name</th>
            <tr>

                <td><input type="text" id="stid" name="stid"  readonly value="<%=StudId%>" size="8" maxlength="8"></td>
                <td><input type="text" id="sid1" name="sname" readonly value="<%=Name%>" size="25"></td>
            </tr>

        </table>         


        <%}
        %>     
        <table align="center">
            <caption><h3 style=" color: #B40404">Unallocated Projects</h3></caption>  



            <%
                //----------New Modification---------
                if (!rs6.next() == true) {
                    out.println("There are no Unallocated Projects currently.");

                }

                rs6.beforeFirst();

                //----------END--------
                while (rs6.next()) {
                    System.out.println("New Supervisor " + rs6.getString(3));
                    session.setAttribute("newSupervisor", rs6.getString(3));

            %>

            <tr>

                <td>
                    <%                        String facName = scis.facultyName(rs6.getString(3));
                        if (facName != null) {
                    %>

                    <input type="radio" id="rb" name="rb"  onclick="changeval();" value="<%=rs6.getString(1)%>"><%=facName%>
                </td>
                <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <%=rs6.getString(2)%>
                </td>
                <%} else {%>

            <input type="radio" id="rb" name="rb" onclick="changeval();" value="<%=rs6.getString(1)%>"><%=rs6.getString(3)%>
            </td>&nbsp;&nbsp;
            <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <%=rs6.getString(2)%>
            </td>
            <%}%>

            </tr> 
            <%   }
            %>

        </table><br><br>&nbsp;&nbsp;
         <input type="hidden" id="hidd" value="">
        <div align="center">
            <input type="submit" value="Submit" class="Button">
        </div>

        &nbsp;&nbsp;

    </form>
    <%
    } //*************************** Logic for Return from University******************************
    else if (!rs2.getString(6).equals("uoh") && "rtuoh".equals(cBox)) {
        if ("rtuoh".equals(cBox)) {
            ResultSet rs4 = (ResultSet) st8.executeQuery("select * from " + table1 + " as a where a.ProjectId in(Select b.ProjectId from " + table2 + " as b where b.StudentId='" + StudId + "' ) and a.Organization<>'uoh'"); // Student doing Internship.

            if (rs4.next() == true) {
                rs4.beforeFirst();


    %>

    <form  id="form" method="POST" onsubmit="return validate();" action="projectStaffChangeSupervisor2.jsp">
        <table align="center">
            <tr bgcolor="#c2000d">
                <td align="center" class="style12"> <font size="6"> Modify Project </font> </td>
            </tr> 
        </table>  
        &nbsp;&nbsp;
        <table align="center" >
            <tr>
                <th>Student ID </th> 
                <th>Student Name</th>
            <tr>

                <td>&nbsp;&nbsp;&nbsp;<input type="text" id="stid" name="stid"  readonly value="<%=StudId%>" size="8" maxlength="8"></td>
                <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" id="sid1" name="sname" readonly value="<%=Name%>" size="25"></td>
            </tr>

        </table>         
        &nbsp;&nbsp;
        <table align="center" > 

            <caption><h3 style=" color: #B40404">Unallocated Projects</h3></caption>  

            <% if (!rs6.next() == true) {
                    out.println("There are no Unallocated Projects currently.");

                }

                rs6.beforeFirst();

                //----------END--------
                while (rs6.next()) {
            %>

            <tr>
                <td>
                    <%
                        String facName = scis.facultyName(rs6.getString(3));
                        if (facName != null) {
                    %>

                    <input type="radio" id="rb" name="rb" onclick="changeval();"  value="<%=rs6.getString(1)%>"><%=facName%>
                </td>
                <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <%=rs6.getString(2)%>
                </td>
                <%} else {%>

            <input type="radio" id="rb" name="rb" onclick="changeval();"  value="<%=rs6.getString(1)%>"><%=rs6.getString(3)%>
            </td>
            <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <%=rs6.getString(2)%>
            </td>
            <%}%>

            </tr> 


            <% }
            %>

        </table><br>&nbsp;
        <input type="hidden" id="hidd" value="">
        <div align="center">
            <input type="submit" value="Submit" class="Button">
        </div>
        &nbsp;&nbsp;
    </form>
    <%
                    }
                    rs4.close();
                }

            }
        }
            st1.close();
            st2.close();
            st7.close();
            st8.close();
            rs2.close();
            rs5.close();
            rs6.close();
            conn.closeConnection();
            con = null;
    %>
</body>
</html>
