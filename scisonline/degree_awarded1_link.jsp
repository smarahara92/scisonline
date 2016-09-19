<%-- 
    Document   : degree_awarded1_link
    Created on : Jan 30, 2014, 6:30:44 PM
    Author     : veeru
--%>
<%@include file="checkValidity.jsp"%>
<%@page import="java.sql.*"%>
<%@include file="programmeRetrieveBeans.jsp"%>
<%@include file="connectionBean.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <style>
            .style11 {color :red}
            .style12 {color :white}
            .style13 {color :yellow}
        </style>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="table_css.css">
        <style type="text/css">
            @media print {
                .noPrint
                {
                    display:none;
                }
            }
        </style>
    </head>
    <body bgcolor="#CCFFFF">
        <form name="frmd" id="fmr" action="act_area" method="POST">
            <%  try {
                    //int flag = 0;
                    String programmeName = request.getParameter("pgname");
                    String pyear = request.getParameter("year");
                   // System.out.println("slected year is" +pyear);
                    programmeName = programmeName.replace('-', '_');
                    //System.out.println("program name is"+programmeName);
                    Connection con = conn.getConnectionObj();
                    
                    Statement st3 = con.createStatement();
                    Statement st4 = con.createStatement();
                    Statement st7 = con.createStatement();
                    Statement st8 = con.createStatement();
                   
                    String tablename = programmeName + "_Project_Student_" + pyear;
                    try {
                        ResultSet rs22 = (ResultSet) st8.executeQuery("select * from " + tablename);
                        rs22.close();
                        ResultSet rss7 = scis.programmeStream(programmeName.replace('_', '-'));
                        rss7.next();
 %>                     <center><h2 style=" color: #c2000d"><%=rss7.getString(1)%> Degree Awarded</h2></center>
                        <table border="1" align="center" width="85%">
                        <tr style=" word-wrap: break-word">
                        <td style=" color: black; font-weight: bold; font-size: 15">Sl.No</td> 
                        <td style=" color: black; font-weight: bold; font-size: 15">Student ID</td>
                        <td style=" color: black; font-weight: bold; font-size: 15">Name of the Student</td> 
                        <td style=" color: black; font-weight: bold; font-size: 15">Name of the Supervisor(s)</td>
 <%                     if (rss7.getString(1).equalsIgnoreCase("mca")) {
 %>
                        <td style=" color: black; font-weight: bold; font-size: 15;" width="50%">Title of the Project</td></tr>

                        <%} else if (rss7.getString(1).equalsIgnoreCase("mtech")) {
                        %>
                        <td style=" color: black; font-weight: bold; font-size: 15;" width="50%">Title of the Dissertation</td></tr>

<%
                        } else if (rss7.getString(1).equalsIgnoreCase("PhD")) {
%>
                        <td style=" color: black; font-weight: bold; font-size: 15;" width="50%">Title of the Thesis</td></tr>
 <%
                    }%>
                <tr>
                    <td colspan="3"><font style=" color: #c2000d; font-weight: bold"><%=programmeName.replace('_', '-')%></font>
                    </td>
                </tr>
<%                
                    } catch (Exception e) {
                        out.println("Project registration has not done for  " + programmeName.replace('_', '-') + "-" + pyear);
                        return;
                    }
                    //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% retrieving programme duration%%%%%%%%%%%%%%%%%%%%
%>
                <%  String name;
                    int i = 1;
                    System.out.println(programmeName + "_" + pyear);
                    ResultSet rs2 = (ResultSet) st3.executeQuery("select * from " + tablename + " where  Status = 'DegreeAwarded'");
                    while (rs2.next()) {
                        System.out.println(rs2.getString(2));
                        name = scis.studentName(rs2.getString(1));
                        if (rs2.getString(2) != null) {
                            ResultSet rs7 = (ResultSet) st7.executeQuery("select * from  programme_table where Programme_name='" + programmeName.replace('_', '-') + "'");
                            rs7.next();
                            ResultSet rs3 = (ResultSet) st4.executeQuery("select * from " + rs7.getString(4) + "_Project_" + pyear + " where ProjectId='" + rs2.getString(2) + "' and Allocated='yes'");
                            while (rs3.next()) {

                %>

                <tr>
                    <td><%=i%>.</td>
                    <td><%=rs2.getString(1)%> </td>
                    <td><%=name%> </td>
                    <td>
                        <%
                            if (rs3.getString(3) == null || rs3.getString(3).equalsIgnoreCase("none")) {%>
                            <%} else {
                                String facultyName = scis.facultyName(rs3.getString(3));
                                if (facultyName != null) {%>
                                    <%=facultyName%>
                                <% }
                            }
                            if (rs3.getString(4) == null || rs3.getString(4).equalsIgnoreCase("none")) {
                        %>
                        <%} else {
                            String facultyName = scis.facultyName(rs3.getString(4));
                            if (facultyName != null) {%>
                                <%=facultyName%>
                        <% }
                        }
                        if (rs3.getString(6).equals("uoh")){ // To ensure if project is a university one as internship projects don't have Supervisor Id3.
                            if (rs3.getString(5) == null || rs3.getString(5).equalsIgnoreCase("none")) {
                        %>
                        <%} else {
                                String facultyName = scis.facultyName(rs3.getString(5));
                                if (facultyName != null) {%>
                                    <%=facultyName%>
                        <%      }
                           }
                        } else {
                        %>
                        <%                    }
                        %>

                    </td>
                    
                    <td><%=rs3.getString(2)%></td>
                </tr>  

                <%
                    scis.close();
                }
                %>
                <%  rs7.close();
                     rs3.close();
                    }  i++;
                       
                      }
                        rs2.close(); 
                        st3.close();
                        st4.close();
                        st7.close();
                        st8.close();
                       // rss7.close();
                        conn.closeConnection();
                        con = null;
                    }
                    catch (Exception e) {
                        out.println("<h3>Project registration has not done for this batch.</h3>");
                        return;
                    }

                %>
            </table>
            <br><br>
            <div align="center"> <td>
                <input type="button" value="Print" id="p1"  class="noPrint" onclick="window.print();" /></div>          
        </td>
    </form>

</body>
</html>




