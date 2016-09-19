<%-- 
    Document   : projectStaffNewInternship
    Created on : 28 Mar, 2013, 4:30:11 AM
    Author     : varun
--%>
<%@include file="checkValidity.jsp"%>
<%@page import="com.hcu.mysql.connection.ConnectionDemo1"%>
<%@page import="java.sql.*"%>
<%@include file="programmeRetrieveBeans.jsp"%>
<%@page import="java.util.*"%>
<%@include file="connectionBean.jsp"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script type="text/javascript">
            window.history.forward();
            function check2(q)
            {
                var StudId = q;
                alert(StudId + " is not assigned any Project.");
                history.back();
            }

            function check1(q)
            {
                var StudId = q;
                alert(StudId + " is an Internship Student.");
                history.back();


            }

            function validate1()
            {

                var org = document.getElementById("orgname").value;
                var pTid = document.getElementById("projtitle").value;
                var iSup = document.getElementById("sel3").value;
                var orgSup = document.getElementById("sid").value;
                //alert(oldpid);
                if (org === "")
                {
                    alert("Please enter an Orgainization Name.");
                    return false;
                }

                if (pTid === "")
                {
                    alert("Please enter a Project Title.");
                    return false;
                }

                if (iSup === "none")
                {
                    alert("Please enter an Internal Supervisor.");
                    return false;
                }

                if (orgSup === "")
                {
                    alert("Please enter an Orgainization Supervisor.");
                    return false;
                }
                return true;
            }

        </script>
    </head>
    <body bgcolor="E0FFFF">
        <%            try {
                String val = request.getParameter("r");
                String StudId = request.getParameter("studentId");
                String streamName = (String) session.getAttribute("projectStreamName");
                streamName = streamName.replace('-', '_');
                String programmeName = scis.studentProgramme(StudId);
                programmeName = programmeName.replace('-', '_');

                Calendar now = Calendar.getInstance();
                int curYear = now.get(Calendar.YEAR);
                int month = now.get(Calendar.MONTH)+1;
                int year = curYear;
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
                Statement st2 = con.createStatement();
                Statement st3 = con.createStatement();
                Statement st5 = con.createStatement();

                ResultSet rs = scis.facultyList();
                ResultSet rs2 = null;

                try {
                    rs2 = (ResultSet) st2.executeQuery("select * from  " + streamName + "_project" + "_" + pyear + " where Organization<>'uoh'");
                } catch (Exception ex) {%>
        `		   <center><h2>The required Project Master Tables does not exists in Database. <br>
            Please follow a sequential order.</h2></center>
            <%
                    ex.printStackTrace();
                    return;
                }

                ResultSet rs5 = (ResultSet) st3.executeQuery("select * from  " + streamName + "_project" + "_" + pyear + " as a where a.ProjectId in(Select b.ProjectId from " + programmeName + "_Project_Student_" + pyear + " as b where b.StudentId='" + StudId + "' ) and a.Organization<>'uoh'");
                ResultSet rs6 = (ResultSet) st5.executeQuery("select * from  " + streamName + "_project" + "_" + pyear + " as a where a.ProjectId in(Select b.ProjectId from " + programmeName + "_Project_Student_" + pyear + " as b where b.StudentId='" + StudId + "') and a.Organization='uoh'");
                int byear1 = scis.studentBatchYear(StudId);
                String byear = Integer.toString(byear1);
                session.setAttribute("cpyear", byear);
                String Name = scis.studentName(StudId);

                if (rs5.next()) {%>
    <script type="text/javascript" language="javascript">

        check1('<%=StudId%>');

    </script>   

    <%} else if (rs6.next() != true) {%>
    <script type="text/javascript" language="javascript">
        //alert("hiiii");
        check2('<%=StudId%>');

    </script>

    <%}
    %>

    <form  id="form" method="POST" onsubmit="return validate1();" action="projectStaffNewInternship1.jsp">

        <table align="center">
            <tr bgcolor="#c2000d">
                <td align="center" class="style12"> <font size="6"> Modify Project </font> </td>
            </tr> 
        </table>     
        <input type="hidden" name="streamName" value="<%=streamName%>">
        <input type="hidden" name="programmeName" value="<%=programmeName%>">
        <br>
        <table align="center" >
            <tr>

                <th>Student ID </th> 
                <th>Student Name</th>
                <th>Organization</th>
                <th>Project Title</th>
                <th>Internal Supervisor</th>
                <th>Organization Supervisor</th>
            <br>   
            </tr>


            <tr>

                <td>&nbsp;<input type="text" id="stid" name="stid" value="<%=StudId%>" readonly size="8" maxlength="8"></td>
                <td>&nbsp;<input type="text" id="sid1" name="sname" value="<%=Name%>" readonly size="25"></td>

                <td>&nbsp;<input type="text" id="orgname" name="orgname"  size="20"></td>
                <td>&nbsp;<input type="text" id="projtitle" name="projtitle"  size="20"></td> 

                <td>&nbsp;<select id="sel3" name="sel3"> 
                        <option value="none">none</option>
                        <% while (rs.next()) {%>

                        <option value="<%=rs.getString(1)%>"> <%=rs.getString(2)%> </option>
                        <%}
                        %>
                    </select></td>  

                <td>&nbsp;<input type="text" id="sid" name="orgsup" value=""  size="15" ></td>  
            </tr>        
            <tr><td>          </td></tr>
            <tr><td>          </td></tr>
            <tr><td>          </td></tr>
            <tr><td>          </td></tr>
            <tr>
                <td  colspan="8" align="center"><input type="submit" value="submit"/></td>

            </tr>
        </table>


    </form>
    <%      st2.close();
            st3.close();
            st5.close();
            rs.close();
            rs2.close();
            rs6.close();
            rs5.close();
            conn.closeConnection();
            con = null;
        } catch (Exception ex) {
            
        }
  
    %>
</body>
</html>
