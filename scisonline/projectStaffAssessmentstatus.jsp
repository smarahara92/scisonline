<%-- 
    Document   : projectStaffAssessmentstatus
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

            }

            function check1(temp)
            {
                // alert(temp)   ;
                var cmp1 = document.getElementById(temp).value;
                // alert(cmp1);

                cmp1 = cmp1.replace(/^\s+|\s+$/g, '');

                if (cmp1 < 0 || cmp1 > 60)
                {Marks
                    alert("External Marks range is 0-60.");
                    document.getElementById(temp).focus();
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
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    </head>
    <body bgcolor="E0FFFF">

        <%            //#############################  CS External Assessment  #######################################
            String programmeName = (String) request.getParameter("pgname");

            session.setAttribute("stream", programmeName);

            programmeName = programmeName.replace('-', '_');
        %>

        <form  id="form" method="POST" onsubmit="" action="projectStaffAssessmentstatus1.jsp" >


            <%                PreparedStatement pst = null;
                try {
                    String pyear = request.getParameter("year");
                    String table = programmeName + "_Project_Student_" + pyear;
                    String user = (String) session.getAttribute("user");
                    String streamName = scis.getStreamOfProgramme(programmeName);
                    ResultSet rs1 = null;                  
                    ResultSet rs4 = null;                   
                    ResultSet rs3 = null;
                    Connection con = conn.getConnectionObj();
                    //System.out.println("programme name is" + programmeName);
                    //System.out.println("stream  name is" + streamName);
                   
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
                    <table align="center">
                        <tr bgcolor="#c2000d">
                            <td align="center" class="style12"> <font size="6"><%=programmeName.replace('_', '-')%> Project Status </font> </td>
                        </tr> 
                    </table>     

                    <br>
                    <table align="center" width="100%">
                        <tr>
                            <th>Student ID </th>
                            <th>Student Name </th>
                            <th>Project Title </th>
                            <th>Status </th>
                        </tr>      
                        <%

                            //int i = 1;
                            int totalStud = 0;
                            int projectStud = 0;
                            while (rs1.next()) {
                                totalStud++;
                                String projectTitle = "";
                                String name = "";
                                String studId = rs1.getString(1);
                                studId = studId.toUpperCase();
                                studId = rs1.getString(1);
                                String progTable = programmeName + "_Project_Student_" + pyear;
                                name = scis.studentName(studId);

                                pst = con.prepareStatement("select ProjectTitle from " + streamName.replace('-', '_') + "_Project_" + pyear + " where ProjectId=?");
                                pst.setInt(1, rs1.getInt(2));
                                rs3 = pst.executeQuery();
                                while (rs3.next()) {
                                    projectStud++;
                                    projectTitle = rs3.getString(1);
                                }
                                pst = con.prepareStatement("select Status+0 from " + progTable + " where StudentId=?");
                                pst.setString(1, studId);
                                rs4 = pst.executeQuery();
                                rs4.next();
                        %>
                        <tr>
                            <td>&nbsp;<input type="text" id="stid" name="stid" value="<%=rs1.getString(1)%>"  readonly size="7" onKeyPress="return disableEnterKey(event)"></td>
                            <td>&nbsp;<input type="text" id="sname" name="sname" value="<%=name%>" readonly size="15" onKeyPress="return disableEnterKey(event)"></td> 
                            <td>&nbsp;<input type="text" id="ptitle" name="ptitle" value="<%=projectTitle%>" readonly size="50"  onKeyPress="return disableEnterKey(event)"></td> 
                            <td><select name="status" style=" width: 100%">
                                 <% int status = rs4.getInt(1);
                                 ResultSet rs5 = scis.getStatusList(programmeName);
                                    while(rs5.next() ){
                                        int statusId = rs5.getInt(1);
                                        if(status ==  statusId) {%>
                                        <option value="<%=statusId%>" selected><%=rs5.getString(2)%></option>
                                        <%
                                        } else {%>
                                        <option value="<%=statusId%>"><%=rs5.getString(2)%></option>
                                 <%     }
                                    }
                                 %>
                                </select>    
                            </td>
                            <% 
                            } 
                            %>
                        </tr>
                        <%// i++;
                            if (projectStud != totalStud) {%>
                        <script type="text/javascript" language="javascript">
                            AllocatedCheck();         // testing
                        </script>   
                        <% }
                            conn.closeConnection();
                            con = null;
                            scis.close();
                            } catch (Exception ex) {
                                ex.printStackTrace();
                            } 
                        %>
                        <tr> </tr> <tr> </tr> <tr> </tr> 
                        <tr> </tr> <tr> </tr> <tr> </tr> 
                        <tr> 
                            <td align="center" colspan="8"> 
                                <input type="Submit" id="xx"value="Submit"> </td> 
                        </tr>
                    </table>
        </form>   
    </body>
</html>