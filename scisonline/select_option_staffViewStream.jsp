<%-- 
    Document   : select_option_staffViewStream
    Created on : 25 Dec, 2013, 10:12:18 AM
    Author     : Veeru
--%>
<%@include file="checkValidity.jsp"%>
<%@page import="java.sql.*"%>
<%@include file="programmeRetrieveBeans.jsp"%>
<%@include file="connectionBean.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="table_css.css">

    </head>
    <body bgcolor="#CCFFFF">

        <%            
            int flag = 0;

            String fid = request.getParameter("fid");
            session.setAttribute("facid", fid);

            String streamName = request.getParameter("streamName");
            streamName = streamName.replace('-', '_');
            String studentName = "";
            String pyear = request.getParameter("year");
            
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
            Statement st10 = con.createStatement();
            Statement stp = con.createStatement();
            ResultSet rs2 = null;

            try {

                rs2 = (ResultSet) st1.executeQuery("select * from  " + streamName + "_Project" + "_" + pyear + " where Allocated='yes'  ");
                if (rs2.next()) {
                } else {%>
    <center><h2>The Projects are not yet allocated.</h2></center>

    <%
                return;
            }
            rs2.beforeFirst();

        } catch (Exception ex) {
            out.println(ex);
            return;

        }

        int i = 0;

        try {


    %>
    <form  id="form" method="POST" onsubmit="" action="">

        <table align="center" >
            <caption><h3><font style=" color: blue"><%=streamName%></font> : List of allocated Projects</h3></caption>
            <th>Student Id</th> 
            <th>Student Name</th> 
            <th>Project Title </th> 
            <th>Supervisor 1</th>
            <th>Supervisor 2</th>
            <th>Supervisor 3</th>


            <% while (rs2.next()) {

                    String programmeName = "";

                    ResultSet rs = scis.getProgramme(streamName, 1);
                    while (rs.next()) {
                        programmeName = rs.getString(1).replace('-', '_');
                        ResultSet rs3 = (ResultSet) st3.executeQuery("select * from  " + programmeName + "_Project_Student_" + pyear + " where ProjectId='" + rs2.getString(1) + "'");

                        while (rs3.next()) {
            %>
            <tr>
                <%
                    studentName = scis.studentName(rs3.getString(1));

                %>

                <td><%=rs3.getString(1)%></td>
                <td><%=studentName%></td>
                <td><%=rs2.getString(2)%></td>
                <%if (rs2.getString(3) == null || rs2.getString(3).equalsIgnoreCase("none")) {%>
                <td></td>

                <%} else {
                    String facName = scis.facultyName(rs2.getString(3));

                    if (facName != null) {
                %>
                <td><%=facName%></td>

                <% }
                    }

                    if (rs2.getString(4) == null || rs2.getString(4).equalsIgnoreCase("none")) {
                %>
                <td></td>

                <%} else {
                    String facName = scis.facultyName(rs2.getString(4));

                    if (facName != null) {
                %>
                <td><%=facName%></td>


                <% }
                    }
                    if (rs2.getString(6).equals("uoh")) // To ensure if project is a university one as internship projects don't have Supervisor Id3.
                    {
                        if (rs2.getString(5) == null || rs2.getString(5).equalsIgnoreCase("none")) {
                %>
                <td></td>
                <%} else {
                    String facName = scis.facultyName(rs2.getString(5));

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
            <%                            }
                            rs3.beforeFirst();
                            rs3.close();
                        }
                        rs.beforeFirst();
                        rs.close();
                    }
                    rs2.beforeFirst();

                } catch (Exception ex) {
                    ex.printStackTrace();
                }
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
                stp.close();
                rs2.close();
                conn.closeConnection();
                con = null;
            %>

    </form>

</body>
</html>



