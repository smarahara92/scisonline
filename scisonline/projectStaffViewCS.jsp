<%-- 
    Document   : projectStaffViewCS
    Created on : 10 May, 2013, 5:41:02 PM
    Author     : varun
--%>

<%@include file="checkValidity.jsp"%>
<%@include file="connectionBean.jsp"%>
<%@page import="java.sql.*"%>
<%@include file="programmeRetrieveBeans.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href="table_css.css" type="text/css">
        <script type="text/javascript">
            function AllocatedCheck()
            {
                alert("Some Students are not allocated Projects.");

            }
        </script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    </head>
    <body bgcolor="EOFFFF">
            <%                
                String programmeName = (String) request.getParameter("pgname");
                programmeName = programmeName.replace('-', '_');
                String pyear = request.getParameter("year");
               
                String user = (String) session.getAttribute("user");
                
                String table = programmeName + "_Project_Student_" + pyear;
                String projTable = null;
                Connection con = conn.getConnectionObj();
                
                Statement st1 = con.createStatement();
                Statement st2 = con.createStatement();
                Statement st3 = con.createStatement();
                Statement st8 = con.createStatement();
                Statement st9 = con.createStatement();

                ResultSet rs1 = null;
                ResultSet rs4 = null;
                ResultSet rs3 = null;
                ResultSet rss1 = null;

                int totalStud = 0;
                int projectStud = 0;

                try {
                    rs1 = (ResultSet) st1.executeQuery("select * from " + table + " ");
                } catch (Exception ex) {%>
            `		   <center><h2>The Projects are not yet allocated.</h2></center>
                <%
                        ex.printStackTrace();
                        return;
                    }

                    while (rs1.next()) {
                        totalStud++;            // Total count of the Students in CS(for checking against the actual project students.)
                    }

                    ResultSet rs = null;
                    rs4 = (ResultSet) st2.executeQuery("select Programme_group from programme_table where Programme_name='" + programmeName.replace('_', '-') + "'");
                    if (rs4.next()) {
                        projTable = rs4.getString(1).replace('-', '_') + "_Project_" + pyear;
                    }
                    try {
                        rs = (ResultSet) st3.executeQuery("select StudentId,a.ProjectId,ProjectTitle,AdvisorMarks1,PanelMarks1,AverageMarks1,AdvisorMarks2,PanelMarks2,AverageMarks2,TotalMarks,Grade,Status from " + projTable + " as a, " + table + " as b where a.ProjectId=b.ProjectId ");
                    } catch (Exception ex) // To deal with the exception when query trying to access MCA Proj Student table but it don't exists.
                    {%>
            <center> <h1>No Projects are currently floated by Faculty.</h1></center>   
                <%return;

                    }

                    if (!rs.next()) {%>
            <h1> <center>There are no Project Students currently.</center></h1>
                    <%return;
                        }

                        rs.beforeFirst();
                    %>

            <br>
            <table align="center" border="1" >
                <caption><h3><%=programmeName.replace('_', '-')%>&nbsp;Projects</h3></caption>
                <tr bgcolor="red"> 
                    <td rowspan="2" align="center" style=" background-color: #c2000d; color: white;font-weight: bold">Student Id</td>
                    <td rowspan="2" align="center" style=" background-color: #c2000d;color: white;font-weight: bold">Student Name</td>
                    <td rowspan="2" align="center" style=" background-color: #c2000d;color: white;font-weight: bold">Project Title</td>
                    <td colspan="2" align="center" style=" background-color: #c2000d;color: white;font-weight: bold">Mid Term</td>
                    <td rowspan="2" align="center" style=" background-color: #c2000d;color: white;font-weight: bold">Internal</td>
                    <td colspan="2" align="center" style=" background-color: #c2000d;color: white;font-weight: bold">Major</td>
                    <td rowspan="2" align="center" style=" background-color: #c2000d;color: white;font-weight: bold">Final</td>
                    <td rowspan="2" align="center" style=" background-color: #c2000d;color: white;font-weight: bold">Total</td>
                    <td rowspan="2" align="center" style=" background-color: #c2000d;color: white;font-weight: bold">Grade</td>
                    <td rowspan="2" align="center" style=" background-color: #c2000d;color: white;font-weight: bold">Status</td>
                </tr>

                <tr> 
                    <td align="center" style=" background-color: #c2000d;color: white;font-weight: bold">Supervisor</td>
                    <td align="center" style=" background-color: #c2000d;color: white;font-weight: bold">Panel</td>
                    <td align="center" style=" background-color: #c2000d;color: white;font-weight: bold">Supervisor</td>
                    <td align="center" style=" background-color: #c2000d;color: white;font-weight: bold">External</td>
                </tr>

                <%
                    try {

                        while (rs.next()) {

                            String projectTitle = "";
                            String name = "";
                            String studId = rs.getString(1);
                            studId = rs.getString(1);
                            name = scis.studentName(studId);

                            rs3 = (ResultSet) st8.executeQuery("select ProjectTitle from " + projTable + " where ProjectId=" + rs.getInt(2) + "");
                            while (rs3.next()) {
                                projectStud++;
                                projectTitle = rs3.getString(1);
                            }

                            //////////////////////////////////
                            rss1 = (ResultSet) st9.executeQuery("select * from " + table + " where(PanelMarks1 IS NOT NULL and AdvisorMarks1 IS NOT NULL and PanelMarks2 IS NOT NULL and AdvisorMarks2 IS NOT NULL and  StudentId='" + studId + "')");

                %>

                <tr >
                    <td><%=rs.getString(1)%></td>
                    <td><%=name%></td> 
                    <td><%=projectTitle%></td> 

                    <%if (rs.getString(4) != null) {%>
                    <td><%=rs.getString(4)%></td> 
                    <%} else {%>  
                    <td></td> 
                    <% }
                    %>

                    <%if (rs.getString(5) != null) {%>
                    <td><%=rs.getString(5)%></td> 
                    <%} else {%>  
                    <td></td> 
                    <% }
                    %>

                    <%if (rs.getString(6) != null) {%>
                    <td><%=rs.getString(6)%></td> 
                    <%} else {%>  
                    <td></td> 
                    <% }
                    %>

                    <%if (rs.getString(7) != null) {%>
                    <td><%=rs.getString(7)%></td> 
                    <%} else {%>  
                    <td></td> 
                    <% }
                    %>

                    <%if (rs.getString(8) != null) {%>
                    <td><%=rs.getString(8)%></td> 
                    <%} else {%>  
                    <td></td> 
                    <% }
                    %>


                    <%if (rs.getString(9) != null) {%>
                    <td><%=rs.getString(9)%></td> 
                    <%} else {%>  
                    <td></td> 
                    <% }
                    %>

                    <%if (rs.getString(10) != null) {%>
                    <td><%=rs.getString(10)%></td> 
                    <%} else {%>  
                    <td></td> 
                    <% }
                    %>

                    <%
                        if (rss1.next()) {
                            if (rss1.getString(10) != null) {%>
                    <td><%=rss1.getString(10)%></td> 
                    <%} else {%>  
                    <td></td> 
                    <% }
                    } else {
                    %>
                    <td></td> 
                    <%
                        }
                        if (rs.getString(12).equalsIgnoreCase("Allocated")) {
                    %>
                    <td>Allocated</td>
                    <%} else if (rs.getString(12).equalsIgnoreCase("Mid")) {
                    %>
                    <td>Mid Term over</td>  
                    <%
                    } else if (rs.getString(12).equalsIgnoreCase("Viva")) {
                    %>
                    <td>Viva over</td>  
                    <%
                    } else if (rs.getString(12).equalsIgnoreCase("DegreeAwarded")) {
                    %>
                    <td>Degree Awarded</td>  
                    <%
                    } else if (rs.getString(12).equalsIgnoreCase("report")) {
                    %>
                    <td>Report submitted</td>  
                    <%
                    } else if (rs.getString(12).equalsIgnoreCase("extend")) {
                    %>
                    <td>Extended</td>  
                    <%
                        }

                    %>
                </tr>

                <%                    }  // Close of While

                    System.out.println("Project Students " + projectStud);
                    System.out.println("Total Students " + totalStud);

                    if (projectStud != totalStud) {%>
                <script type="text/javascript" language="javascript">
                    AllocatedCheck();         // testing
                </script>   
                <%                                                       }
                    rs1.close();
                    rs.close();
                    rs3.close();
                    rs4.close();
                    st1.close();
                    st2.close();
                    st3.close();
                    st8.close();
                    st9.close();
                    scis.close();
                    conn.closeConnection();
                    con = null;
                    } 
                    catch (Exception ex) {
                       System.out.println(ex); 
                        //ex.printStackTrace();
                    }
                %>
            </table>
    </body>
</html>




