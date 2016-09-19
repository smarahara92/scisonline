<%-- 
    Document   : student_projects2
    Created on : Feb 17, 2014, 10:38:52 AM
    Author     : veeru
--%>
<%@page import="java.sql.*"%>
<%@include file="connectionBean.jsp"%>
<%@include file="programmeRetrieveBeans.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link type="text/css" href="table_css.css" rel="stylesheet">
    </head>
    <body>


        <%  Connection con = conn.getConnectionObj();
            String pgname = null;
            int pyear = 0;
            String role = (String) session.getAttribute("role");
            String user = (String) session.getAttribute("user");
            

            if (role.equalsIgnoreCase("student") == false) {
                pgname = request.getParameter("programmeName");
                pgname = pgname.replace('_', '-');
                pyear = Integer.parseInt(request.getParameter("year"));

            } else if (role.equalsIgnoreCase("student") == true) {
                user = scis.getStudentId(user);
                //for student view....
                String pgname1 = scis.studentProgramme(user);

                pgname = scis.getStreamOfProgramme(pgname1);
                pyear = scis.studentBatchYear(user);

            }
        %>

        <table border="1" align="center">
            <col width="40%">
            <col width="20%">
            <col width="20%">
            <col width="20%">
            
                <%
                    Statement st = con.createStatement();
                    Statement st1 = con.createStatement();
                    Statement st2 = con.createStatement();
                    Statement st3 = con.createStatement();
                    pgname = pgname.replace('-', '_');
                    try {
                        ResultSet rs = st.executeQuery(" select * from " + pgname + "_Project_" + pyear + " where allocated='no'");
                %>        
                        <caption> <h2 style="color:  #B40404"><%=pgname%> Unallocated Projects</h2></caption>
                        <th>Project Title</th>
                        <th>Supervisor1</th>
                        <th>Supervisor2</th>
                        <th>Supervisor3</th>
                <%        if (rs.next()) {
                        rs.beforeFirst();
                        while (rs.next()) {%>
            <tr>
                <td><%=rs.getString(2)%></td>
                <%

                    String facName = scis.facultyName(rs.getString(3));
                    if (facName != null) {
                %>
                <td><%=facName%></td>

                <% } else {
                %>
                <td></td>
                <%
                    }

                    facName = scis.facultyName(rs.getString(4));
                    if (facName != null) {
                %>
                <td><%=facName%></td>

                <% } else {
                %>
                <td></td>
                <%
                    }

                    if (rs.getString(6).equals("uoh")) // To ensure if project is a university one as internship projects don't have Supervisor Id3.
                    {
                        facName = scis.facultyName(rs.getString(5));
                        if (facName != null) {
                %>
                <td><%=facName%></td>

                <% } else {
                %>
                <td></td>
                <%
                    }
                } else {
                %>
                <td></td>

                <%                    }
                %>

                <%    }

                } else {
                    if (role.equalsIgnoreCase("student") == true) {
                %>
            <script>
                window.open("Project_exceptions.jsp?check=2", "first");
            </script>
            <%return;
            } else {
            %>
            <script>
                window.open("Project_exceptions.jsp?check=2", "act_area2");
            </script>
            <%return;
                    }
                }rs.close();
               }catch(Exception e){
                   out.println("No currently unallocated projects");
               }
                st.close();
                st1.close();
                st2.close();
                st3.close();
                conn.closeConnection();
                con = null;
                scis.close();
            %>
        </tr>
    </table>
</body>
</html>
