<%-- 
    Document   : projectFacultyAssessmentViewMtech
--%>

<%@include file="connectionBean.jsp"%>
<%@page import="java.sql.*"%>
<%@include file="programmeRetrieveBeans.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link type="text/css" rel="stylesheet" href="table_css.css">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    </head>
    <body bgcolor="EOFFFF">
    <%
        String curYear = request.getParameter("year");
        String user = (String) session.getAttribute("user");
        String streamName = (String) request.getParameter("pgname").replace('-', '_');
                    
        Connection con = conn.getConnectionObj();
        Statement st2 = con.createStatement();
        Statement st4 = con.createStatement();
        Statement st5 = con.createStatement();
        Statement st7 = con.createStatement();
        Statement st8 = con.createStatement();
        Statement st9 = con.createStatement();

        String projectTable1 = streamName + "_Project_" + curYear;
        String projectStudnetTable = null;

        ResultSet rs = null;
        ResultSet rss2 = null;
        ResultSet rss3 = null;
        String studId = null;
                   
        
        try {
            rs = (ResultSet) st2.executeQuery("select * from " + projectTable1 + " where(SupervisorId1='" + user + "' or SupervisorId2='" + user + "' or SupervisorId3='" + user + "') and Allocated='yes' ");
        } catch (Exception ex) {
    %>
            <center><h2>The Projects are not yet allocated.</h2></center>
    <%
            ex.printStackTrace();
            return;
        }
        if(!rs.next()) {
            %>
                <center><h2>The Projects are not yet allocated.</h2></center>
            <%
            return;
        }
    %>
        <table align="center" border="1" >
            <caption><h2>Projects View</h2></caption>
            <tr> 
                <td rowspan="2" align="center" style="color: white;background-color: #c2000d; font-weight: bold">Student ID</td>
                <td rowspan="2" align="center" style="color: white;background-color: #c2000d; font-weight: bold">Student Name</td>
                <td rowspan="2" align="center" style="color: white;background-color: #c2000d; font-weight: bold">Project Title</td>
                <td colspan="2" align="center" style="color: white;background-color: #c2000d; font-weight: bold">Mid Term</td>
                <td rowspan="2" align="center" style="color: white;background-color: #c2000d; font-weight: bold">Internal</td>
                <td colspan="2" align="center" style="color: white;background-color: #c2000d; font-weight: bold">Major</td>
                <td rowspan="2" align="center" style="color: white;background-color: #c2000d; font-weight: bold">Final</td>
                <td rowspan="2" align="center" style="color: white;background-color: #c2000d; font-weight: bold">Total</td>
                <td rowspan="2" align="center" style="color: white;background-color: #c2000d; font-weight: bold">Grade</td>
                <td rowspan="2" align="center" style="color: white;background-color: #c2000d; font-weight: bold">Status</td>
            </tr>
            <tr> 
                <td align="center" style="color: white;background-color: #c2000d; font-weight: bold">Supervisor</td>
                <td align="center" style="color: white;background-color: #c2000d; font-weight: bold">Panel</td>
                <td align="center" style="color: white;background-color: #c2000d; font-weight: bold">Supervisor</td>
                <td align="center" style="color: white;background-color: #c2000d; font-weight: bold">External</td>
            </tr>
    <%
                do {
                    rss2 = scis.getProgramme(streamName, 1);
                        while (rss2.next()) {
                           // out.println(rss2.getString(1));
  
                            projectStudnetTable = rss2.getString(1).replace('-', '_') + "_Project_Student_" + curYear;
                            //out.println("Allocation table name is :" +projectStudnetTable);

                            rss3 = (ResultSet) st4.executeQuery("select * from " + projectStudnetTable + " where ProjectId='" + rs.getString(1) + "'");
                                
                            while(rss3.next()) {
                                studId = rss3.getString(1);
                                try {
                                    String projectTitle = "";
                                    String name = scis.studentName(studId);
                                    //scis.close();

                                    ResultSet rs3 = (ResultSet) st9.executeQuery("select ProjectTitle from " + projectTable1 + " where ProjectId=" + rs.getInt(1) + "");
                                    while (rs3.next()) {
                                        projectTitle = rs3.getString(1);
                                        System.out.println("projecttitle is:" + projectTitle);
                                    }
    %>
                                <tr>
                                    <td><%=rss3.getString(1)%></td>
                                    <td><%=name%></td> 
                                    <td><%=projectTitle%></td> 
    <%
                                    if (rss3.getString(4) != null) { 
    %>
                                        <td><%=rss3.getString(4)%></td>
    <%
                                    } else {
    %>
                                        <td></td>
    <%
                                    }
                                    if (rss3.getString(3) != null) {
    %>
                                        <td><%=rss3.getString(3)%></td> 
    <%
                                    } else {
    %>  
                                        <td></td> 
    <%
                                    }
                                    if (rss3.getString(5) != null) {
    %>
                                        <td><%=rss3.getString(5)%></td> 
    <%
                                    } else {
    %>  
                                        <td></td> 
    <%
                                    }
                                    if (rss3.getString(7) != null) {
    %>
                                        <td><%=rss3.getString(7)%></td> 
    <%
                                    } else {%>  
                                        <td></td>
    <%
                                    }
                                    if (rss3.getString(6) != null) {
    %>
                                        <td><%=rss3.getString(6)%></td> 
    <%
                                    } else {%>  
                                        <td></td> 
    <%
                                    }
                                    if (rss3.getString(8) != null) {%>
                                        <td><%=rss3.getString(8)%></td> 
                        <%
                                    } else {%>
                                        <td></td> 
                        <% 
                                    }
                                    if (rss3.getString(9) != null) {%>
                                        <td><%=rss3.getString(9)%></td> 
                        <%
                                    } else {%> 
                                        <td></td> 
                        <%
                                    }
                                    if (rss3.getString(10) != null) {%>
                                        <td><%=rss3.getString(10)%></td> 
                        <%
                                    } else {%>  
                                        <td></td> 
                        <% 
                                    }
                                    if (rss3.getString(11).equalsIgnoreCase("Allocated")) {
                    %>
                                        <td>Allocated</td>
                        <%
                                    } else if (rss3.getString(11).equalsIgnoreCase("Mid")){ %>
                                        <td>Mid Term over</td>  
                    <%    
                                    } else if (rss3.getString(11).equalsIgnoreCase("Viva")){ %>
                                        <td>Viva over</td>  
                    <%
                                    } else if (rss3.getString(11).equalsIgnoreCase("degaward")){ %>
                                        <td>Degree Awarded</td>  
                    <%    
                                    }
                        %>
                                </tr>
                    <%
                            } catch (Exception ex) {
                                ex.printStackTrace();
                            }
                        }
                    }
                } while (rs.next());
                    //rss2.beforeFirst();
                     rs.close();
                     //rss2.close();
                     //rss3.close();
                     st2.close();
                     st4.close();
                     st5.close();
                     st7.close();
                     st8.close();
                     st9.close();
                     scis.close();
                     con=null;
                     conn.closeConnection();
                %>
            </table>
        </form>   

    </body>
</html>




