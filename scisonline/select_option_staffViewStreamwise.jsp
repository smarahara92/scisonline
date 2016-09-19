
<%-- 
Document   : newjsp1
Created on : Dec 26, 2013, 11:13:39 PM
Author     : veeru
--%>
<%@include file="checkValidity.jsp"%>
<%@page import="java.sql.*"%>
<%@include file="connectionBean.jsp"%>
<%@include file="programmeRetrieveBeans.jsp"%>
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
        <link rel="stylesheet" type="text/css" href="table_css.css">

    </head>
    <body bgcolor="#CCFFFF">


        <%  try {
                String fid = request.getParameter("fid");
                String programmeName = request.getParameter("streamName");
                programmeName = programmeName.replace('-', '_');
                String pyear = request.getParameter("year");
                session.setAttribute("facid", fid);
                Connection con = conn.getConnectionObj();
                
                Statement st2 = con.createStatement();
                Statement st3 = con.createStatement();
                Statement st4 = con.createStatement();
                
        %>
        <table align="center">
            <caption><h2>List of Students-Projects</h2></caption>
            <th>Student ID</th> 
            <th>Student Name</th> 
            <th>Project Title </th> 
            <th>&nbsp;Supervisor 1</th>
            <th>&nbsp;Supervisor 2</th>
            <th>&nbsp;Supervisor 3</th>


            <%  
                ResultSet rs1 = null;
                rs1 = (ResultSet) st2.executeQuery("select * from  " + programmeName + "_" + pyear + " order by StudentId");

                while (rs1.next()) {
                    ResultSet rs2 = (ResultSet) st3.executeQuery("select * from " + programmeName + "_Project_Student_" + pyear + " where StudentId='" + rs1.getString(1) + "'");
                    if (rs2.next()) {
                        if (rs2.getString(2) != null) {
                            String streamName = scis.getStreamOfProgramme(programmeName);
                            ResultSet rs3 = (ResultSet) st4.executeQuery("select * from " + streamName + "_Project_" + pyear + " where ProjectId='" + rs2.getString(2) + "' and Allocated='yes'");
                            while (rs3.next()) {
            %>

            <tr>
                <td><%=rs1.getString(1)%></td>
                <td><%=rs1.getString(2)%></td>
                <td><%=rs3.getString(2)%></td>
                <%if (rs3.getString(3) == null || rs3.getString(3).equalsIgnoreCase("none")) {%>
                <td></td>

                <%} else {
                    String facName = scis.facultyName(rs3.getString(3));
                    if (facName != null) {
                %>
                <td><%=facName%></td>

                <% }
                    }

                    if (rs3.getString(4) == null || rs3.getString(4).equalsIgnoreCase("none")) {
                %>
                <td></td>

                <%} else {
                    String facName = scis.facultyName(rs3.getString(4));
                    if (facName != null) {
                %>
                <td><%=facName%></td>

                <% }
                    }

                    if (rs3.getString(6).equals("uoh")) // To ensure if project is a university one as internship projects don't have Supervisor Id3.
                    {
                        if (rs3.getString(5) == null || rs3.getString(5).equalsIgnoreCase("none")) {
                %>
                <td></td>

                <%} else {
                    String facName = scis.facultyName(rs3.getString(5));
                    if (facName != null) {
                %>
                <td><%=facName%></td>

                <% }
                    }
                } else {
                %>
                <td></td>
                <td></td>
                <%                    }
                %>
            </tr>  

            <% }
                //while loop close(master table)
               rs3.close();
            } else {
            %>
            <tr>
                <td style="background-color:#F3F781"><%=rs1.getString(1)%></td>
                <td style="background-color:#F3F781"><%=rs1.getString(2)%></td>
                <td style="background-color:#F3F781"></td>          
                <td style="background-color:#F3F781"></td>
                <td style="background-color:#F3F781"></td>
                <td style="background-color:#F3F781"></td>
            </tr>  
            <%}
            } else {
            %>
            <tr>
                <td style="background-color:#F3F781"><%=rs1.getString(1)%></td>
                <td style="background-color:#F3F781"><%=rs1.getString(2)%></td>
                <td style="background-color:#F3F781"></td>          
                <td style="background-color:#F3F781"></td>
                <td style="background-color:#F3F781"></td>
                <td style="background-color:#F3F781"></td>
            </tr>  
            <%
                        }
                        rs2.close();
                    }
                    st2.close();
                    st3.close();
                    st4.close();
                    rs1.close();
                    conn.closeConnection();
                    con = null;
                    scis.close();
                } catch (Exception e) {
                    out.println(e);
                    return;
                }
            %>
        </table>
</body>
</html>