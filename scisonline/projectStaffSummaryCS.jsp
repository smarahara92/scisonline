<%-- 
    Document   : projectStaffSummaryCS
    Created on : 2 May, 2013, 9:47:12 AM
    Author     : varun
--%>
<%@include file="checkValidity.jsp"%>
<%@include file="connectionBean.jsp"%>
<%@include file="programmeRetrieveBeans.jsp"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" type="text/css"  href="table_css.css">
        <script type="text/javascript">

            function AllocatedCheck()
            {
                alert("Some Students are not allocated Projects.");

            }

        </script>

    </head>
    <body>
            <%                
                String programmeName = (String) request.getParameter("pgname");
                programmeName = programmeName.replace('-', '_');
                String pyear = (String) request.getParameter("year");

                String table = programmeName + "_Project_Student_" + pyear;
                String streamName = scis.getStreamOfProgramme(programmeName);
                Connection con = conn.getConnectionObj();

                Statement st1 = con.createStatement();
                Statement st2 = con.createStatement();
                Statement st3 = con.createStatement();
                Statement st4 = con.createStatement();
                Statement st5 = con.createStatement();
                Statement st6 = con.createStatement();
                Statement st7 = con.createStatement();
                Statement st8 = con.createStatement();
                Statement st9 = con.createStatement();

                ResultSet rs1 = null;
                ResultSet rs4 = null;
                ResultSet rs5 = null;
                ResultSet rss11 = null;
                ResultSet rs12 = null;
                ResultSet rs2 = null;
                ResultSet rs3 = null;
                ResultSet rss1 = null;
                try {
                    rs1 = (ResultSet) st1.executeQuery("select * from " + table + " ");
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
                    <table align="center" border="1">
                        <caption>
                            <h2>Projects Summary</h2>
                        </caption>
                        <tr>
                            <th>Student ID </th>
                            <th>Student Name </th>
                            <th>Project Title </th>
                            <th>Mid Term </th>
                            <th>Final </th>
                            <th>Total </th>
                            <th>Grade </th>

                        </tr>      
                        <%
                            try {
                                int totalStud = 0;
                                int projectStud = 0;
                                while (rs1.next()) {
                                    totalStud++;
                                    String projectTitle = "";
                                    String name = "";
                                    String studId = rs1.getString(1);
                                    studId = rs1.getString(1);
                                    name = scis.studentName(studId);
                                    rs3 = (ResultSet) st3.executeQuery("select ProjectTitle from " + streamName.replace('-', '_') + "_Project_" + pyear + " where ProjectId=" + rs1.getInt(2) + "");
                                    while (rs3.next()) {
                                        projectStud++;
                                        projectTitle = rs3.getString(1);
                                    }

                                    rs4 = (ResultSet) st4.executeQuery("select * from " + table + " where StudentId='" + studId + "'");
                                    rs4.next();
                                    
                                    rss1 = (ResultSet) st9.executeQuery("select * from " + table + " where(PanelMarks1 IS NOT NULL and AdvisorMarks1 IS NOT NULL and PanelMarks2 IS NOT NULL and AdvisorMarks2 IS NOT NULL and  StudentId='" + studId + "')");

                                    if (rs4.getString(3) == null || rs4.getString(6) == null) // Staff hasn't entered either Panel or External Marks for a Student.
                                    {
                        %>
                        <tr >
                            <td><%=rs1.getString(1)%></td>
                            <td><%=name%></td> 
                            <td><%=projectTitle%></td> 
                            <%if (rs1.getString(5) != null) {%>
                            <td style="background-color:yellow"><%=rs1.getString(5)%></td> 
                            <%} else {%>  
                            <td></td> 
                            <% }
                            %>

                            <%if (rs1.getString(8) != null) {%>
                            <td><%=rs1.getString(8)%></td> 
                            <%} else {%>  
                            <td></td> 
                            <% }
                            %>

                            <%if (rs1.getString(9) != null) {%>
                            <td><%=rs1.getString(9)%></td> 
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
                            %>
                        </tr>
                        <%
                        } // if close- Staff Checked
                        else if (rs4.getString(4) == null || rs4.getString(7) == null) // Faculty hasn't entered either Advisor Marks1 or Advisor Marks2
                        {%>
                        <tr>
                            <td><%=rs1.getString(1)%></td>
                            <td><%=name%></td> 
                            <td><%=projectTitle%></td> 

                            <%if (rs1.getString(5) != null) {%>
                            <td  style="background-color:red"><%=rs1.getString(5)%></td>                     
                            <%} else {%>  
                            <td></td>                        <% }
                            %>

                            <%if (rs1.getString(8) != null) {%>
                            <td><%=rs1.getString(8)%></td> 
                            <%} else {%>  
                            <td></td>  
                            <% }
                            %>

                            <%if (rs1.getString(9) != null) {%>
                            <td><%=rs1.getString(9)%></td> 
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
                            %>
                        </tr>
                        <%} // if close- Faculty Checked  
                        else if (rs4.getString(4) != null && rs4.getString(7) != null && rs4.getString(3) != null && rs4.getString(6) != null) // Every Marks Have been entered.
                        {%>
                        <tr>
                            <td><%=rs1.getString(1)%></td>
                            <td><%=name%></td> 
                            <td><%=projectTitle%></td> 

                            <%if (rs1.getString(5) != null) {%>
                            <td><%=rs1.getString(5)%></td>            
                            <%} else {%>  
                            <td></td>              
                            <% }
                            %>

                            <%if (rs1.getString(8) != null) {%>
                            <td><%=rs1.getString(8)%></td> 
                            <%} else {%>  
                            <td></td> 
                            <% }
                            %>

                            <%if (rs1.getString(9) != null) {%>
                            <td><%=rs1.getString(9)%></td> 
                            <%} else {%>  
                            <td></td> 
                            <% }
                            %>

                            <%if (rs1.getString(10) != null) {%>
                            <td><%=rs1.getString(10)%></td> 
                            <%} else {%>  
                            <td></td> 
                            <% }
                            %>


                        </tr>


                        <%}      // if close- No fault from Faculty or Staff Side 

                            }  // End of While


                            if (projectStud != totalStud) {%>
                        <script type="text/javascript" language="javascript">
                            AllocatedCheck();         // testing
                        </script>   
                        <%                                                       }
                            } catch (Exception ex) {
                                ex.printStackTrace();
                            }

                            rs1.close();
                            rs2.close();
                            rs3.close();
                            rs4.close();
                            rs5.close();
                            rs12.close();
                            rss11.close();
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
    </body>
</html>
