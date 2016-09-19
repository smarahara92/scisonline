<%-- 
    Document   : projectFacultyModifyMtech
    Created on : 15 Mar, 2013, 4:28:17 PM
    Author     : varun
--%>
<%@include file="connectionBean.jsp"%>
<%@include file="programmeRetrieveBeans.jsp"%>
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
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script type="text/javascript">
            function check1(a)
            {

                var k = a.substring(a.length - 1, a.length);
                //alert(k);
                var fromField = document.getElementById("sel1" + k).value;
                //alert(fromField);
                var toField = document.getElementById("sel2" + k).value;
                //alert(toField);
                var midField = document.getElementById("sel3" + k).value;

                if (fromField == toField)
                {
                    alert("Two supervisors cannot hava same names");
                    document.getElementById(a).value = "None";
                    return false;
                }
                if (toField == midField)
                {
                    alert("Two supervisors can not hava same names");
                    document.getElementById(a).value = "None";
                    return false;
                }
                if (midField == fromField)
                {
                    alert("Two supervisors can not hava same names");
                    document.getElementById(a).value = "None";
                    return false;
                }
                return true;

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
    </head>
    <body bgcolor="#CCFFFF">

        <%  
            Connection con = conn.getConnectionObj();
            String pname = request.getParameter("pgname");
            String pyear = request.getParameter("year");
            int count = 0;
            int check1 = 0;
            int j = 0;
            int curriculumYear = 0;
            int latestYear = 0;
            int streamYear = 0;

            String programmeName = "";
            String supervisor1 = "", supervisor2 = "";
            String user = (String) session.getAttribute("user");
            //String stream = request.getParameter("branch");
            //stream = stream.replace('-', '_');

            Statement st1 = con.createStatement();
            Statement st2 = con.createStatement();
            Statement st3 = con.createStatement();
            Statement st4 = con.createStatement();
            Statement st5 = con.createStatement();
            Statement st6 = con.createStatement();
            Statement st7 = con.createStatement();
            Statement st8 = con.createStatement();
            Statement st9 = con.createStatement();
            Statement st10 = con.createStatement();

            ResultSet rs1 = null;
            ResultSet rs = null;
            ResultSet rs21 = null;
            ResultSet rs2 = null;
            ResultSet rs10 = null;
            ResultSet rs11 = null;
           // ResultSet rs3 = null;
            ResultSet rs4 = null;
            ResultSet rss = null;

            try {

                rs1 = (ResultSet) st1.executeQuery("select * from  " + pname + "_Project" + "_" + pyear + " where (SupervisorId1='" + user + "' or SupervisorId2='" + user + "' or SupervisorId3='" + user + "') and Organization='uoh' ");

                //--------New Modified------------
                if (!rs1.next() == true) {%>
        `		   <center><h2>The Projects are not yet allocated.</h2></center>
        <% return;

            }
            rs1.beforeFirst();
            //-----------END ---------------
        %>
    <form  id="form" method="POST" onsubmit="" action="projectFacultyModifyMtech1.jsp">


        <table align="center">
            <tr bgcolor="#c2000d">
                <td align="center" class="style12"> <font size="6"> List of Projects </font> </td>
            </tr> 
        </table>     
        <input type="hidden" name="streamName" value="<%=pname%>">
        <br>
        <table align="center" >

            <th> </th>

            <th>Project Title </th> 
            <th>Supervisor 2</th>
            <th>Supervisor 3</th>
            <th>Student ID </th>
            <th>Student Name </th>

            <%

               
                rs =scis.facultyList();
                while (rs1.next()) {
                    int fid1 = 0, fid2 = 0, fid3 = 0;

                    if (user.equals(rs1.getString(3))) {
                        fid1 = 1;
                        supervisor1 = rs1.getString(4);
                        supervisor2 = rs1.getString(5);
                    } else if (user.equals(rs1.getString(4))) {
                        fid2 = 1;
                        supervisor1 = rs1.getString(3);
                        supervisor2 = rs1.getString(5);
                    } else if (user.equals(rs1.getString(5))) {
                        fid3 = 1;
                        supervisor1 = rs1.getString(3);
                        supervisor2 = rs1.getString(4);
                    }

                    rs21 = scis.getProgramme(pname, 1);

                    while (rs21.next()) {
                        programmeName = rs21.getString(1).replace('-', '_');
                        rs2 = (ResultSet) st4.executeQuery("select * from  " + programmeName + "_Project_Student_" + pyear + " as a where a.ProjectId<>'null' and ('" + rs1.getString(1) + "'=a.ProjectId)");

                        if (rs2.next()) {

                            String Name = "";
                            String table = "";
                            String studId = rs2.getString(1);

                            
                                Name = scis.studentName(studId);
                            
                            if (rs1.getString(6).equals("uoh")) {
            %>

            <tr>
                <td>&nbsp;<input type="text" id="pid" name="pid" value="<%=rs1.getString(1)%>" hidden size="3" onKeyPress="return disableEnterKey(event)"></td>
                <td>&nbsp;<input type="text" id="ptid" name="ptid" value="<%=rs1.getString(2)%>" size="25"  onKeyPress="return disableEnterKey(event)"></td>
                <input type="hidden" name="pyear" value="<%=pyear%>">

                </select></td>

                <td>&nbsp;<select style="width:140px" id="sel2<%=j%>" name="sel2" onchange="check1(this.id)" >
                        <option value="None">None</option>
                        <%
                            while (rs.next()) {
                                if (rs1.getString(4) != null && rs.getString(1).equals(supervisor1)) {%>
                        <option value="<%=rs.getString(1)%>" selected="selected"><%=rs.getString(2)%></option><%
                        } else {%>
                        <option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option>
                        <% }
                            }
                            rs.beforeFirst();
                        %>
                    </select></td>

                <% // -----------Modified----------------%> 

                <td>&nbsp;<select id="sel3<%=j%>" style="width:140px" name="sel3"  onchange="check1(this.id)">
                        <option value="None">None</option>
                        <%
                            while (rs.next()) {
                                if (rs1.getString(5) != null && rs.getString(1).equals(supervisor2)) {%>
                        <option value="<%=rs.getString(1)%>" selected="selected"><%=rs.getString(2)%></option><%
                        } else {%>
                        <option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option>
                        <% }

                            }
                            rs.beforeFirst();
                        %>
                    </select></td>

                <% // -----------Modified----------------%>  

                <td>&nbsp;<input type="text" id="stid" name="stid" value="<%=rs2.getString(1)%>" readonly size="8" onKeyPress="return disableEnterKey(event)"></td>
                <td>&nbsp;<input type="text" id="sname" name="sname" value="<%=Name%>" readonly size="25"  onKeyPress="return disableEnterKey(event)"></td>
            </tr>
            <%
                            }// If close
                            j++;

                        } // inner if closing      
                        //---------------------------------
                    }
                }
                rs4 = (ResultSet) st9.executeQuery("select * from  " + pname + "_Project" + "_" + pyear + " where (SupervisorId1='" + user + "' or SupervisorId2='" + user + "' or SupervisorId3='" + user + "') and Organization='uoh' and Allocated='no'");
                while (rs4.next()) {
                    rss = (ResultSet) st10.executeQuery("select * from  faculty_data order By Faculty_Name");

                  
                    int fid1 = 0, fid2 = 0, fid3 = 0;

                    if (user.equals(rs4.getString(3))) {
                        fid1 = 1;
                        supervisor1 = rs4.getString(4);
                        supervisor2 = rs4.getString(5);
                    } else if (user.equals(rs4.getString(4))) {
                        fid2 = 1;
                        supervisor1 = rs4.getString(3);
                        supervisor2 = rs4.getString(5);
                    } else if (user.equals(rs4.getString(5))) {
                        fid3 = 1;
                        supervisor1 = rs4.getString(3);
                        supervisor2 = rs4.getString(4);
                    }
            %>

            <tr>
                <td>&nbsp;<input type="text" id="pid" name="pid" value="<%=rs4.getString(1)%>" hidden size="3"  onKeyPress="return disableEnterKey(event)"></td>
                <td>&nbsp;<input type="text" id="ptid" name="ptid" value="<%=rs4.getString(2)%>" size="25" onKeyPress="return disableEnterKey(event)"></td>


                </select></td>

                <td>&nbsp;<select style="width:140px" id="sel2<%=j%>" name="sel2" onchange="check1(this.id)">
                        <option value="None">None</option>
                        <%
                            while (rss.next()) {
                                if (rs4.getString(4) != null && rss.getString(1).equals(supervisor1)) {%>
                        <option value="<%=rss.getString(1)%>" selected="selected"><%=rss.getString(2)%></option><%
                        } else {%>
                        <option value="<%=rss.getString(1)%>"><%=rss.getString(2)%></option>
                        <% }
                            }
                            rss.beforeFirst();
                        %>
                    </select></td>

                <% // -----------Modified----------------%> 

                <td>&nbsp;<select id="sel3<%=j%>" style="width:140px" name="sel3" onchange="check1(this.id)" >
                        <option value="None">None</option>
                        <%
                            while (rss.next()) {
                                if (rs4.getString(5) != null && rss.getString(1).equals(supervisor2)) {%>
                        <option value="<%=rss.getString(1)%>" selected="selected"><%=rss.getString(2)%></option><%
                        } else {%>
                        <option value="<%=rss.getString(1)%>"><%=rss.getString(2)%></option>
                        <% }
                            }
                            rss.beforeFirst();
                        %>
                    </select></td>

                <% // -----------Modified----------------%>  

                <td>&nbsp;<input type="text" id="stid" name="stid" value="" readonly size="8" onKeyPress="return disableEnterKey(event)"></td>
                <td>&nbsp;<input type="text" id="sname" name="sname" value="" readonly size="25" onKeyPress="return disableEnterKey(event)"></td>
            </tr>

            <%
                    j++;
                    //------------------------------------				  			  			  			  			  		  
                }   // Result Set rs1 closing

            %>
            </br>
            </br>
            <tr>
                <td colspan="8" align="center"><input type="submit" value="submit"/></td>

            </tr>

            <%  } catch (Exception ex) { %>
                    <center><h2>The Projects are not yet allocated.</h2></center>
            <%    }

                //rs1.close();
                //rs.close();
                //rs21.close();
                //rs2.close();
                //rs10.close();
                //rs11.close();
                //rs4.close();
                st1.close();
                st2.close();
                st3.close();
                st4.close();
                st5.close();
                st6.close();
                st7.close();
                st8.close();
                st9.close();
                st10.close();
                scis.close();
                conn.closeConnection();
                con = null;

            %>
        </table>

    </form>

</body>
</html>
