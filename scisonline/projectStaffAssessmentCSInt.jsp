<%-- 
    Document   : projectStaffAssessmentCSInt
    Created on : 29 Apr, 2013, 2:35:02 PM
    Author     : varun
--%>
<%@include file="programmeRetrieveBeans.jsp"%>
<%@include file="connectionBean.jsp"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <style>
            <%--body {color:white}--%>
            .style11 {color :red}
            .style12 {color :white}
            .style13 {color :yellow}
        </style>
        <script type="text/javascript">
            function AllocatedCheck()
            {
                alert("Some Students are not allocated Projects.");
                return false;
            }
            function check1(temp)
            {
                var cmp1 = document.getElementById(temp).value;
                var res = temp.substring(5);
                var ptitle = document.getElementById("ptitle" + res).value;
                var pmark = document.getElementById(temp).value;

                if (ptitle === "" && pmark !== "")
                {
                    document.getElementById(temp).value = "";
                    alert("Project is not allocated to this student.");
                    return;

                }
                cmp1 = cmp1.replace(/^\s+|\s+$/g, '');
                if (cmp1 < 0 || cmp1 > 40)
                {
                    alert("Internal Marks Range is 0-40.");
                    document.getElementById(temp).focus();
                    document.getElementById(temp).style.color = 'red';
                    document.getElementById("xx").disabled = true;
                    return;
                }
                if (cmp1.length === 0)
                {
                    //document.getElementById(temp).value='0';
                    document.getElementById(temp).style.color = 'black';

                    document.getElementById("xx").disabled = false;
                    return;
                }
                var i = 0, j = 0;
                for (i = 0; i < cmp1.length; i++)
                {
                    //alert(cmp1.charCodeAt(i));		
                    if (cmp1.charCodeAt(i) < 48 || cmp1.charCodeAt(i) > 57)
                    {
                        alert("Please enter a valid Input.");
                        document.getElementById("xx").disabled = true;
                        document.getElementById(temp).style.color = 'red';
                        document.getElementById(temp).focus();
                        return;
                    }
                }
                document.getElementById(temp).value = cmp1;
                document.getElementById(temp).style.color = 'black';
                document.getElementById("xx").disabled = false;
            }
            function check() {

                var val = document.getElementById("count").value;
                var flag = 0;
                for (var i = 1; i <= val; i++)
                {
                    if (document.getElementById("marks" + i).value !== "")
                    {
                        flag++;
                    }
                }
                if (flag == 0)
                {
                    alert("Please enter atleast one studnet marks.");
                    return false;
                }
            }
            
            function disableEnterKey(e)
            {
                var key;
	 
                if(window.event)
	          key = window.event.keyCode;     //IE
                else
                  key = e.which;     //firefox
	 	
                if(key === 13)
	          return false;
                else
	          return true;
            }
        </script>    

        <link rel="stylesheet" type="text/css" href="table_css.css"> </head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>JSP Page</title>
</head>
<body bgcolor="E0FFFF">


    <%            //#############################  CS Internal Assessment  #######################################
        PreparedStatement pst = null;
        try {
            String programmeName = (String) request.getParameter("pgname");
                if(programmeName.substring(0,2).equals("MT"))
                {
                    session.setAttribute("stream", programmeName);
                    session.setAttribute("programmeName","MTech");
                }
                else
                {
                    session.setAttribute("stream", programmeName);
                    session.setAttribute("programmeName", programmeName);
                }

            programmeName = programmeName.replace('-', '_');
    %>

    <form  id="form" method="POST" onsubmit="return check();" action="projectStaffAssessmentCSInt1.jsp" >
        <%
            String streamName = null;
            ResultSet rs1 = null;
            ResultSet rs4 = null;
            ResultSet rs3 = null;
            Connection con = conn.getConnectionObj();
            String pyear = request.getParameter("year");
            String table = programmeName + "_Project_Student_" + pyear;

            try {
                pst = con.prepareStatement("select * from " + table + " ");
                rs1 = pst.executeQuery();
            } catch (Exception ex) {%>
        `		   <center><h2>The Projects are not yet allocated.</h2></center>
            <%
                    ex.printStackTrace();
                    return;
                }

                if (!rs1.next()) {%>
        <h1><center>There are no Project Students currently.</center><h1> 
                <%return;
                    }

                    rs1.beforeFirst();

                %>
                <br>
                <table align="center"  border="1">
                    <caption><h2> <%=programmeName.replace('_', '-')%> Project Mid-Term Marks </h2></caption>
                    <th>Student ID </th>
                    <th>Student Name </th>
                    <th>Project Title </th>
                    <th>Panel Marks </th>
                    <%
                        try {

                            int i = 1;
                            int totalStud = 0;
                            int projectStud = 0;
                            int flag = 0;
                            while (rs1.next()) {
                                totalStud++;
                                flag++;
                                String projectTitle = "";
                                String name = "";
                                String studId = rs1.getString(1);
                                name=scis.studentName(studId);
                                streamName=scis.getStreamOfProgramme(programmeName);
                                
                                pst = con.prepareStatement("select ProjectTitle from " + streamName.replace('-', '_') + "_Project_" + pyear + " where ProjectId=?");
                                pst.setInt(1, rs1.getInt(2));
                                rs3 = pst.executeQuery();
                                while (rs3.next()) {

                                    projectStud++;
                                    projectTitle = rs3.getString(1);
                                }
                                pst = con.prepareStatement("select PanelMarks1 from " + programmeName.replace('-', '_') + "_Project_Student_" + pyear + " where StudentId=?");
                                pst.setString(1, studId);
                                rs4 = pst.executeQuery();
                                rs4.next();

                            
                    %>
                    <tr>
                        <td>&nbsp;<input type="text" id="stid" name="stid" value="<%=rs1.getString(1)%>"  readonly size="9" onKeyPress="return disableEnterKey(event)"></td>
                        <td>&nbsp;<input type="text" id="sname" name="sname" value="<%=name%>" readonly size="20" onKeyPress="return disableEnterKey(event)"></td> 
                        <td>&nbsp;<input type="text" id="ptitle<%=i%>" name="ptitle" value="<%=projectTitle%>" readonly size="30"  onKeyPress="return disableEnterKey(event)"></td> 


                        <% if (rs4.getString(1) == null) {%>
                        <td>&nbsp;<input type="text" id="marks<%=i%>" name="marks" value=""  size="6" onchange="check1(this.id)" onKeyPress="return disableEnterKey(event)"></td>
                            <%} else {%>
                        <td>&nbsp;<input type="text" id="marks<%=i%>" name="marks" value="<%=rs4.getString(1)%>"  size="6" onchange="check1(this.id)" onKeyPress="return disableEnterKey(event)"></td>
                            <% }%>
                    </tr>

                    <% i++;
                        }
                    
                        if (projectStud != totalStud) {%>
                    <script type="text/javascript" language="javascript">
                        AllocatedCheck();         // testing
                    </script>   
                    <input type="hidden" id="count" value="<%=flag%>">
                    <%  }

                            } catch (Exception ex) {
                                ex.printStackTrace();
                            }
                        rs1.close();
                        rs3.close();
                        rs4.close();
                        conn.closeConnection();
                        con.close();
                        scis.close();
                        pst.close();
                        } catch (Exception e) {
                            e.printStackTrace();
                        } 
                    %>

                </table>
                <br>
                <div align="center"><input type="Submit" id="xx"value="Submit"> </td></div>

                </form> 

                </body>

                </html>
