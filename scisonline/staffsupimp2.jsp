<%-- 
    Document   : staffsupimp2
    Created on : Apr 22, 2014, 3:28:40 PM
    Author     : veeru
--%>

<%@include file="checkValidity.jsp"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@page  import="java.sql.* " %>
<%--<%@include file="dbconnection.jsp" %>--%>
<%@include file="connectionBean.jsp" %>
<%@include file="id_parser.jsp" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="table_css1.css">
        <style type="text/css">
            @media print {

                .noPrint
                {
                    display:none;
                }
            }
            .style30 {color: black}
            .style31 {color: white}
            .style32 {color: green}

            #div1
            {

                width:100%;
            }
            .th
            {
                color: white;
                background-color: #c2000d;
                border-collapse: collapse;
                border: 1px solid green;

            }
            .table
            {
                border-collapse:collapse;
                border: 1px solid green;
                white-space:nowrap;
                background-color: #F5F5F5;
                padding: 3px;
            }
            .td
            {
                border-collapse:collapse;
                border: 1px solid green;
                white-space:nowrap;
                background-color: #F5F5F5;
                padding: 2px;
            }

        </style>
        <script>
            function print1()
            {

                window.print();
            }
            function fun() {
                var subjectCount = document.getElementById("tstu").value;

                document.getElementById("stun2").value = subjectCount;
            }

        </script>
    </head>
    <body onload="fun();">

        <%  
            Connection con = conn.getConnectionObj();
            Connection con1 = conn1.getConnectionObj();
            try {
                Calendar now = Calendar.getInstance();
                int currentMonth = now.get(Calendar.MONTH) + 1;
                int currentYear = now.get(Calendar.YEAR);
                String semester = null;
                if (currentMonth <= 6) {
                     semester = "Monsoon";
                    currentYear = currentYear-1;
                } else {
                   semester = "Winter";
                }
                String subjectId = request.getParameter("subjectname");

                Statement st1 = con.createStatement();
                Statement st2 = con.createStatement();
                Statement st3 = con.createStatement();
                Statement st4 = con1.createStatement();
                Statement st5 = con.createStatement();

                String programmeName = null;

                ResultSet rs1 = null;
                ResultSet rs2 = null;
                ResultSet rs4 = null;
                ResultSet rs5 = null;
                ResultSet rs6 = null;
                ResultSet rs7 = null;

                try {

                    rs6 = st1.executeQuery("select Subject_Name from subjecttable where Code='" + subjectId + "'");
                    rs6.next();

        %>

        <table align="center">
            <th>Subject ID</th>
            <th>Subject Name</th>
            <th>Total Students</th>
            <tr>
                <td><input type="text" value="<%=subjectId%>">&nbsp;&nbsp;</td>
                <td><input type="text" value="<%=rs6.getString(1)%>" name="studentName1" id="stun1">&nbsp;&nbsp;</td>
                <td><input type="text" value="" name="studentName1" id="stun2">&nbsp;&nbsp;</td></tr>
        </table>     <br>
        <table align="center" border="1" class="table">

            <th class="th">Student Id</th>
            <th class="th">Student Name</th>

            <th class="th">Supplementary/Improvement</th>



            <%

                } catch (Exception e) {

                }

                int j = 0, flag = 0, flag1 = 0;
                //supplementary students...
                rs4 = st5.executeQuery("select studentId from supp_" + semester + "_" + currentYear + " ");
                while (rs4.next()) {

                    for (j = 1; j <= 7; j++) {
                        rs5 = st2.executeQuery("select studentId,coursename" + j + ",Marks" + j + ",Grade" + j + " from supp_" + semester + "_" + currentYear + " where  (coursename" + j + "='" + subjectId + "' and studentId='" + rs4.getString(1) + "')");
                        if (rs5.next()) {

                            flag++;
                            flag1++;

                            String studentName = null;
                            System.out.println(rs5.getString(1) + "-----");
                            String BATCH_YEAR = rs5.getString(1).substring(SYEAR_PREFIX, EYEAR_PREFIX);
                            String PROGRAMME_NAME = rs5.getString(1).substring(SPRGM_PREFIX, EPRGM_PREFIX);

                            rs1 = st3.executeQuery("select Programme_name from programme_table where Programme_code='" + PROGRAMME_NAME + "'");
                            rs1.next();
                            String year = "20" + BATCH_YEAR;
                            for (int i = 0; i < 2; i++) {
                                String table = rs1.getString(1).replace('-', '_') + "_" + year;
                                System.out.println(table);

                                rs1 = st3.executeQuery("select StudentName from " + table + " where StudentId='" + rs5.getString(1) + "'");
                                if (rs1.next()) {

                                    studentName = rs1.getString(1);
                                    System.out.println(studentName);
                                    break;
                                }
                                year = Integer.toString(Integer.parseInt(year) + 1);
                            }
            %>
            <tr>
                <td class="td"><%=rs5.getString(1)%></td>
                <%
                    if (studentName != null) {

                %>
                <td class="td"><%=studentName%></td>
                <%
                } else {
                %>
                <td class="td"></td>
                <%
                    }

                %>
                <td>S</td>
            </tr>
            <%                        }
                    }
                }

                //improvement students......
                rs4 = st5.executeQuery("select studentId from imp_" + semester + "_" + currentYear + " ");
                while (rs4.next()) {

                    for (j = 1; j <= 6; j++) {
                        rs5 = st2.executeQuery("select studentId,coursename" + j + ",Marks" + j + ",Grade" + j + " from imp_" + semester + "_" + currentYear + " where  (coursename" + j + "='" + subjectId + "' and studentId='" + rs4.getString(1) + "')");
                        if (rs5.next()) {

                            flag++;
                            flag1++;

                            String studentName = null;
                            System.out.println(rs5.getString(1) + "-----");
                            String BATCH_YEAR = rs5.getString(1).substring(SYEAR_PREFIX, EYEAR_PREFIX);
                            String PROGRAMME_NAME = rs5.getString(1).substring(SPRGM_PREFIX, EPRGM_PREFIX);

                            rs1 = st3.executeQuery("select Programme_name from programme_table where Programme_code='" + PROGRAMME_NAME + "'");
                            rs1.next();
                            String year = "20" + BATCH_YEAR;
                            for (int i = 0; i < 2; i++) {
                                String table = rs1.getString(1).replace('-', '_') + "_" + year;
                                System.out.println(table);

                                rs1 = st3.executeQuery("select StudentName from " + table + " where StudentId='" + rs5.getString(1) + "'");
                                if (rs1.next()) {

                                    studentName = rs1.getString(1);
                                    System.out.println(studentName);
                                    break;
                                }
                                year = Integer.toString(Integer.parseInt(year) + 1);
                            }
            %>
            <tr>
                <td class="td"><%=rs5.getString(1)%></td>
                <%
                    if (studentName != null) {

                %>
                <td class="td"><%=studentName%></td>
                <%
                } else {
                %>
                <td class="td"></td>
                <%
                    }

                %>
                <td>I</td>
            </tr>
            <%                        }
                    }
                }
                if (flag1 == 0) {
            %>
            <script>


                window.open("Project_exceptions.jsp?check=3", "act_area");
            </script>    
            <%
                    return;
                }

            %>

            <input type="hidden" id="tstu" value="<%=flag%>">
        </table><br>
        <div align="center"><input type="button" class="noPrint" value="Print" onclick="print1();"></div>
            <%
                } catch (Exception e) {
                     e.printStackTrace();
                }finally{
                conn.closeConnection();
                conn1.closeConnection();
                con = null;
                con1 = null;
            }
            %>
    </body>
</html>
