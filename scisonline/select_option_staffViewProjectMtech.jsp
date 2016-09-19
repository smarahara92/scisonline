<%-- 
    Document   : select_option_staffViewProjectMtech
    Created on : 9 Mar, 2013, 2:12:17 AM
    Author     : varun
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
    <body>

        <%  
            String fid = request.getParameter("fid");
            String streamId = request.getParameter("streamName");
            streamId = streamId.replace('-', '_');
            String pyear = request.getParameter("year");

            session.setAttribute("facid", fid);
            Connection con = conn.getConnectionObj();
            
            Statement st1 = con.createStatement();
            Statement st4 = con.createStatement();
            ResultSet rs2 = null;
            String studentName = "";
            String studentId = "";

            //retrieving allocated projects from master table and checking if no projects are allocated.
            try {
                rs2 = (ResultSet) st1.executeQuery("select * from  " + streamId + "_Project" + "_" + pyear + " where Allocated='yes' order by ProjectId");
                if (rs2.next()) {
                    //rs2.beforeFirst();

                } else {%>
        `		   <center><h2>The Projects are not yet allocated.</h2></center>
    <%                     return;
                 }
            } catch (Exception e) {
                out.println(e);
                return;
            }

        try {
            String facName = scis.facultyName(fid);
            if (facName != null) {
    %>

        <center><h2>List of allocated Projects</h2></center>
        <center><b>Faculty Name:</b> <%=facName%>&nbsp;&nbsp;<b>Stream:</b> <%=streamId%></center>
            <%}%>
        &nbsp;&nbsp;&nbsp;
        <table align="center" >
            <caption></caption>
            <th>Student ID</th> 
            <th>Student Name</th> 
            <th>Project Title </th> 
            <th>Supervisor 1</th>
            <th>Supervisor 2</th>
            <th>Supervisor 3</th>

            <%
                int flag1 = 0;
                rs2.beforeFirst();
                while (rs2.next()) {
                    if (fid.equalsIgnoreCase(rs2.getString(3)) || fid.equalsIgnoreCase(rs2.getString(4)) || fid.equalsIgnoreCase(rs2.getString(5))) {//System.out.println("prakash");

                        //creating all project-student-master table for every programme of a stream, which avoid exception if table not exist.
                        String programmeName = "";
                        ResultSet rs = scis.getProgramme(streamId, 1);

                        while (rs.next()) {
                            programmeName = rs.getString(1).replace('-', '_');

                            ResultSet rs3 = (ResultSet) st4.executeQuery(" select * from  " + programmeName + "_Project_Student_" + pyear + " where ProjectId='" + rs2.getString(1) + "'");

                            while (rs3.next()) {
                                flag1++;
            %>
            <tr>
                <%
                    studentId = rs3.getString(1);
                    String Name = scis.studentName(studentId);
                %>

                <td><%=studentId%></td>

                <td><%=Name%></td>

                <td><%=rs2.getString(2)%></td>

                <%if (rs2.getString(3) == null || rs2.getString(3).equalsIgnoreCase("none") || rs2.getString(3).equalsIgnoreCase(" ")) {%>
                <td></td>

                <%} else {
                    facName = scis.facultyName(rs2.getString(3));
                    if (facName != null) {
                %>
                <td><%=facName%></td>

                <%}
                    }

                    if (rs2.getString(4) == null || rs2.getString(4).equalsIgnoreCase("none") || rs2.getString(4).equalsIgnoreCase(" ")) {

                %>
                <td></td>

                <%} else {

                    facName = scis.facultyName(rs2.getString(4));
                    if (facName != null) {
                %>
                <td><%=facName%></td>

                <%}
                    }

                    if (rs2.getString(6).equalsIgnoreCase("uoh")) // To ensure if project is a university one as internship projects don't have Supervisor Id3.
                    {

                        if (rs2.getString(5) == null || rs2.getString(5).equalsIgnoreCase("none") || rs2.getString(5).equalsIgnoreCase("")) {

                %>
                <td></td>

                <%} else {
                    facName = scis.facultyName(rs2.getString(5));
                    if (facName != null) {
                %>
                <td><%=facName%></td>

                <%}
                    }
                } else {
                %>
                <td></td>
                <td></td>
                <% }


                %>
            </tr>
            <%                                }
                        }
                    }
                }
                if (flag1 == 0) {
            %>
            <script>


                window.open("Project_exceptions.jsp?check=10", "act_area");//here check =6 means error number (if condition number.)
            </script> 
            <%
                    }
                } 
             catch (Exception ex) {
                    ex.printStackTrace();
                } 
                st1.close();
                rs2.close();
                conn.closeConnection();
                con = null;
                scis.close();
            %>
</body>
</html>