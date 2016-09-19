<%-- 
    Document   : deleteSubjectLink
--%>

<%@include file="checkValidity.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@include file="connectionBean.jsp"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" type="text/css" href="table_css1.css">
        <script>
            function fun() {

                var subname = document.getElementById("sn").value;
                var subid = document.getElementById("si").value;
                var r = confirm("Do you really want to delete  " + subname + "?.");
                if (r == true)
                {
                    window.document.forms["form"].action = "deletesubjectlink2.jsp?subid=" + subid + "&subname=" + subname;
                    document.form.submit();
                }
                else
                {
                    window.document.forms["form"].action = "deleteSubject.jsp";
                    document.form.submit();
                }
            }
        </script>
    </head>
    <body>

        <%
        Connection con = conn.getConnectionObj();
        
        String subject = request.getParameter("subid");
            String subname = request.getParameter("subname");
            Statement st1 = con.createStatement();
            Statement st2 = con.createStatement();
            Statement st3 = con.createStatement();
            Statement st4 = con.createStatement();

            String subCode = "";
            String semester = "";

            Calendar now = Calendar.getInstance();
            int month = now.get(Calendar.MONTH) + 1;
            int year = now.get(Calendar.YEAR);

            if (month <= 6) {
                semester = "Winter";
            } else {
                semester = "Monsoon";
            }
            if (subject.equals("none") == true) {%>
        <h1> Please enter a valid Subject name. </h1>
        <%} else {%>
        <form  name="form">
            <!--**********************************************************************-->
            <%

                ResultSet rs2 = st1.executeQuery("Select * from " + subject + "_Attendance_" + semester + "_" + year + "");
                String table = "subject_faculty_" + semester + "_" + year;
                ResultSet rs = st2.executeQuery("select facultyid1,facultyid2 from " + table + "  where subjectid='" + subject + "'");

                try {
            %>   

            <table align="center">

                <th>Subject Id</th>
                <th>Subject Name</th>
                <th>Faculty Name</th>
                <tr>
                    <td><input type="text" id="si" name="subid" value="<%=subject%>" readonly="yes"></td>
                    <td><input type="text" id="sn" name="subname" value="<%=subname%>" readonly="yes"></td>
                        <%
                            if (rs.next()) {
                                if (rs.getString(1) != null && rs.getString(2) != null) {
                                    ResultSet rs1 = st3.executeQuery("select Faculty_Name from faculty_data  where ID='" + rs.getString(1) + "'");
                                    ResultSet rs3 = st4.executeQuery("select Faculty_Name from faculty_data  where ID='" + rs.getString(2) + "'");
                                    if (rs1.next() && rs3.next()) {
                        %>

                    <td><input type="text" value="<%=rs1.getString(1)%>" readonly="yes"></td>
                    <td><input type="text" value="<%=rs3.getString(1)%>" readonly="yes"></td>

                    <%}
                    } else if (rs.getString(1) != null && rs.getString(2) == null) {
                        ResultSet rs1 = st3.executeQuery("select Faculty_Name from faculty_data  where ID='" + rs.getString(1) + "'");
                        if (rs1.next()) {
                    %>

                    <td><input type="text" value="<%=rs1.getString(1)%>" readonly="yes"></td>

                    <%               }
                    } else if (rs.getString(2) != null && rs.getString(1) == null) {
                        ResultSet rs3 = st4.executeQuery("select Faculty_Name from faculty_data  where ID='" + rs.getString(2) + "'");
                        if (rs3.next()) {
                    %>

                    <td><input type="text" value="<%=rs3.getString(1)%>" readonly="yes"></td>

                    <%  }
                            }
                        }
                    %>
                </tr>
            </table>
            <h3 align="center">List of registered students</h3>
            <table border="1" width="400" align="center" class="table">


                <th class="th">Student ID </th>
                <th class="th">Student Name </th>

                <%
                    while (rs2.next()) {
                %>
                <tr>                   
                    <td width=auto align="center" class="td"> <%=rs2.getString(1)%></td>
                    <td align="center" class="td"> <%=rs2.getString(2)%></td>
                </tr> 

                <%}%> 

            </table>    

            <%
                    } catch (Exception ex) {
                        System.out.println(ex);
                    }

                }%>
            <br><br>

            <div align="center"><input type="button" value="Continue" onclick="fun();"></div>
        </form>
            <%
            conn.closeConnection();
            con = null;
            %>
    </body>
</html>
