<%-- 
    Document   : projectFacultyModifyMCA
    Created on : 27 May, 2013, 7:14:25 AM
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
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script type="text/javascript">
            function check1(a) {
                var k = a.substring(a.length - 1, a.length);
               
                var fromField = document.getElementById("sel1" + k).value;
              
                var toField = document.getElementById("sel2" + k).value;
               
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
            
             function disableEnterKey(e) {
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
            String user = (String) session.getAttribute("user");
            
            String pname = request.getParameter("pgname");
            String pyear = request.getParameter("year");
            String tablename = pname + "_Project_" + pyear;
            int count = 0;
            int check1 = 0;
            int j = 0;
            Statement st1 = con.createStatement();
            Statement st2 = con.createStatement();
            Statement st3 = con.createStatement();
            Statement st4 = con.createStatement();
            Statement st5 = con.createStatement();
            Statement st6 = con.createStatement();
            Statement st7 = con.createStatement();
            Statement st8 = con.createStatement();
            ResultSet rs = null;
            ResultSet rs1 = null;
            ResultSet rs2 = null;
            ResultSet rs5 = null;
            ResultSet rs11 = null;
            ResultSet rs3 = null;

            try {
                rs5 = (ResultSet) st1.executeQuery("select * from  "  + tablename + " as a where (a.SupervisorId1='" + user + "' or a.SupervisorId2='" + user + "' or a.SupervisorId3='" + user + "') and a.Organization<>'uoh' ");
            } catch (Exception ex) {%>
        `		   <center><h2>The Projects are not yet allocated.</h2></center>
        <%
                ex.printStackTrace();
                return;
            }
            try {
                if (rs5.next() == false) {
                    check1 = 1;
                }
              
                if (check1 == 0) {

        %>
    <form  id="form" method="POST" onsubmit="" action="projectFacultyModifyMCA1.jsp">


        <table align="center">
            <tr bgcolor="#c2000d">
                <td align="center" class="style12"> <font size="6"> List of Projects </font> </td>
            </tr> 
        </table>     

        <br>
        <table align="center" >

            <th> </th>
            <th>Project Title </th> 
            <th>Supervisor 2</th>
            <th>Supervisor 3</th>
            <th>Student ID </th>
            <th>Student Name </th> 

            <%
                rs1 = (ResultSet) st2.executeQuery("select * from  " + tablename + " where (SupervisorId1='" + user + "' or SupervisorId2='" + user + "' or SupervisorId3='" + user + "') and Organization='uoh' ");

                rs = scis.facultyList();
                while (rs1.next()) {

                    String supervisor1 = "", supervisor2 = "";
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

                   // st4.executeUpdate("create table if not exists MCA_Project_Student_" + pyear + " (StudentId varchar(10)NOT NULL,ProjectId int(5),PanelMarks1 varchar(6),AdvisorMarks1 varchar(6),AverageMarks1 varchar(6),PanelMarks2 varchar(6),AdvisorMarks2 varchar(6),AverageMarks2 varchar(6),TotalMarks varchar(6),Grade varchar(10),primary key(StudentId))");

                    rs2 = (ResultSet) st5.executeQuery("select * from  " + pname +"_Project_Student_" + pyear + " as a where (a.ProjectId='" + rs1.getString(1) + "') ");

                    if (rs2.next()) {

                        String Name = scis.studentName(rs2.getString(1));

                        if (rs1.getString(6).equals("uoh")) {
            %>

            <tr>
                <td>&nbsp;<input type="text" id="pid" name="pid" value="<%=rs1.getString(1)%>" hidden size="3" onKeyPress="return disableEnterKey(event)"></td>
                <td>&nbsp;<input type="text" id="ptid" name="ptid" value="<%=rs1.getString(2)%>" size="25" onKeyPress="return disableEnterKey(event)"></td>

                <td>&nbsp;<select style="width:140px" id="sel2<%=j%>" name="sel2" onchange="check1(this.id)" >
                        <option value="None">None</option>
                        <%
                            while (rs.next()) {
                                if (rs1.getString(4) != null && rs.getString(1).equals(supervisor1)) {%>
                        <option value="<%=rs.getString(1)%>" selected="selected"><%=rs.getString(2)%></option><%
                        } else {
                        %>
                        <option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option>
                        <% }
                            }
                            rs.beforeFirst();
                        %>
                        </select>
                </td>

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
                        </select>
                </td>

                <% // -----------Modified----------------%>  

                <td>&nbsp;<input type="text" id="stid" name="stid" value="<%=rs2.getString(1)%>" readonly size="8"  onKeyPress="return disableEnterKey(event)"></td>
                <td>&nbsp;<input type="text" id="sname" name="sname" value="<%=Name%>" readonly size="25"  onKeyPress="return disableEnterKey(event)"></td>

            </tr>   
            <% }// If close

                j++;
            } //  outer if closing  
            //---------------------------------
            else {
            %>

            <tr>
                <td>&nbsp;<input type="text" id="pid" name="pid" value="<%=rs1.getString(1)%>" hidden size="3"  onKeyPress="return disableEnterKey(event)"></td>
                <td>&nbsp;<input type="text" id="ptid" name="ptid" value="<%=rs1.getString(2)%>" size="25"  onKeyPress="return disableEnterKey(event)"></td>

                <td>&nbsp;<select style="width:140px" id="sel2<%=j%>" name="sel2" onchange="check1(this.id)">
                        <option value="None">None</option>
                        <%
                            while (rs.next()) {
                                if (rs1.getString(4) != null && rs.getString(1).equals(supervisor1)) {%>
                        <option value="<%=rs.getString(1)%>" selected="selected"><%=rs.getString(2)%></option><%
                        } else {

                        %>
                        <option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option>
                        <% }
                            }
                            rs.beforeFirst();
                        %>
                    </select></td>

                <% // -----------Modified----------------%> 

                <td>&nbsp;<select id="sel3<%=j%>" style="width:140px" name="sel3" onchange="check1(this.id)" >
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

                <td>&nbsp;<input type="text" id="stid" name="stid" value="" readonly size="8" onKeyPress="return disableEnterKey(event)"></td>
                <td>&nbsp;<input type="text" id="sname" name="sname" value="" readonly size="25"  onKeyPress="return disableEnterKey(event)"></td>

            </tr>

            <%
                        j++;
                    }

                    //------------------------------------	   
                }      // outer while closing

            } else {%>
            <h2>No Projects are currently allocated.</h2>
            <% return;
                }%>

            

            <%	} catch (Exception ex) {
                    ex.printStackTrace();
                }
                //rs1.close();
                //rs.close();
                //rs2.close();
                //rs3.close();
                //rs5.close();
                //rs11.close();
                st1.close();
                st2.close();
                st3.close();
                st4.close();
                st5.close();
                st6.close();
                st7.close();
                st8.close();
                scis.close();
                conn.closeConnection();
                con = null;

            %>		 
        </table>
        <br>&nbsp;
        <table align="center">
            <tr>
                <td colspan="8" align="center"><input type="submit" value="submit"/></td>

            </tr>
        </table>
    </form>
</body>
</html>

