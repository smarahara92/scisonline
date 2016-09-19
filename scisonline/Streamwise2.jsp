<%-- 
    Document   : Streamwise2
    Created on : Mar 18, 2013, 9:01:02 PM
    Author     : root
--%>

<%--<%@page import="com.hcu.con"%>--%>
<%@page import="javax.sound.midi.SysexMessage"%>
<%@page import="java.util.Calendar"%>
<%@page import ="javax.sql.*" %>
<%@page import="java.sql.*" %>
<%--<%@include file="dbconnection.jsp"%>--%>
<%@include file ="connectionBean.jsp"%>
<%@include file="checkValidity.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
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
    <body>

        <%

            Calendar now = Calendar.getInstance();

            int month = now.get(Calendar.MONTH) + 1;
            int year = now.get(Calendar.YEAR);
            int current_year = year;

            String semester = "";
            String sem = "";

            String StreamName = request.getParameter("pname");
            String BatchYear = request.getParameter("pyear");
            Connection con = conn.getConnectionObj();
            try {
                int CurriculumYear = 0, LatestYear = 0;
                String StreamName2 = StreamName;
                StreamName = StreamName.replace('-', '_');
                String stream1 = "";
                int semfinding = 0;
                String Batch = sem;
                if (month == 1 || month == 2 || month == 3 || month == 4 || month == 5 || month == 6) {
                    semester = "Winter";
                    if (year - Integer.parseInt(BatchYear) == 1) {
                        sem = "II";
                        semfinding = 2;
                    } else if (year - Integer.parseInt(BatchYear) == 2) {
                        sem = "IV";
                        semfinding = 4;
                    } else if (year - Integer.parseInt(BatchYear) == 3) {
                        sem = "VI";
                        semfinding = 6;
                    } else if (year - Integer.parseInt(BatchYear) == 4) {
                        sem = "VIII";
                        semfinding = 8;
                    } else if (year - Integer.parseInt(BatchYear) == 5) {
                        sem = "X";
                        semfinding = 10;
                    } else if (year - Integer.parseInt(BatchYear) == 6) {
                        sem = "XII";
                        semfinding = 12;
                    } else if (year - Integer.parseInt(BatchYear) == 7) {
                        sem = "XIV";
                        semfinding = 14;
                    }
                } else {
                    semester = "Monsoon";
                    if (year - Integer.parseInt(BatchYear) == 0) {
                        sem = "I";
                        semfinding = 1;
                    } else if (year - Integer.parseInt(BatchYear) == 1) {
                        sem = "III";
                        semfinding = 3;
                    } else if (year - Integer.parseInt(BatchYear) == 2) {
                        sem = "V";
                        semfinding = 5;
                    } else if (year - Integer.parseInt(BatchYear) == 3) {
                        sem = "VII";
                        semfinding = 7;
                    } else if (year - Integer.parseInt(BatchYear) == 4) {
                        sem = "IX";
                        semfinding = 9;
                    } else if (year - Integer.parseInt(BatchYear) == 5) {
                        sem = "XI";
                        semfinding = 11;
                    } else if (year - Integer.parseInt(BatchYear) == 6) {
                        sem = "XIII";
                        semfinding = 13;
                    }
                }
        %>
    <center><b>University of Hyderabad</b></center>
    <center><b>School of Computer and Information Sciences</b></center>
    <center><b>Stream :</b><%=StreamName2%> <b>  Semester :</b><%=sem%> <b>Batch :</b> <%=BatchYear%> <b>Attendance</b></center>
    </br></br>

    <%
        //out.println(year2+"   "+stream);
        Statement st1 = con.createStatement();
        Statement st2 = con.createStatement();
        Statement st3 = con.createStatement();
        Statement st4 = con.createStatement();
        Statement st5 = con.createStatement();
        Statement st6 = con.createStatement();
        Statement st7 = con.createStatement();
        ResultSet rs1 = st1.executeQuery("select * from " + StreamName + "_" + BatchYear + "");
        ResultSetMetaData rsmd = rs1.getMetaData();
        int noOfColumns = rsmd.getColumnCount();
        Statement st30 = con.createStatement();
        //##########################################################################################################
        /*
         * Taking correct version of curriculum for particular programme
         */
        ResultSet rs10 = st4.executeQuery("select * from " + StreamName + "_curriculumversions order by Year desc");
        while (rs10.next()) {
            CurriculumYear = rs10.getInt(1);
            if (CurriculumYear <= Integer.parseInt(BatchYear)) {

                LatestYear = CurriculumYear;
                System.out.println(LatestYear);
                break;
            }
        }
        //##########################################################################################################
        System.out.println(StreamName);
        ResultSet rs30 = st30.executeQuery("select * from " + StreamName + "_" + LatestYear + "_currrefer");
        int columns = 0;
        while (rs30.next()) {
            if (rs30.getString(1).equals(sem)) {
                System.out.println(sem);
                columns = rs30.getInt(2) + rs30.getInt(3) + rs30.getInt(4);
                System.out.println("currefer cooooooooooooooooooooooooooooo" + columns);
            }
        }
    %>
    <table border="1" align="center">

        <th>Student Id</th>
        <th>Student Name</th>
            <%

                int w = 1;
                while (w <= columns) {
            %> <th colspan="2">Subject<%=w%></th>
            <%
                    w++;

                }
            %>


        <%

            while (rs1.next()) {
        %><tr>
            <td><%=rs1.getString(1)%></td>
            <td width="10"><%=rs1.getString(2)%></td><%
                int temp = (noOfColumns - 2) / 2; //need to mention number of columns in table
                int cummatten = 0;
                int total = 0;
                int i = 0;

                while (temp > 0) {
                    int m = i + 3;
                    String R = "R";
                    String R1 = "A+";
                    String R2 = "A";
                    String R3 = "B+";
                    String R4 = "B";
                    String R5 = "C";
                    String R6 = "D";
                    String R7 = "F";
                    if (R.equals(rs1.getString(m + 1)) || R1.equals(rs1.getString(m + 1)) || R2.equals(rs1.getString(m + 1)) || R3.equals(rs1.getString(m + 1))
                            || R4.equals(rs1.getString(m + 1)) || R5.equals(rs1.getString(m + 1)) || R6.equals(rs1.getString(m + 1)) || R7.equals(rs1.getString(m + 1))) {
                        String modified = rs1.getString(m);
                        ResultSet rs11 = st2.executeQuery("select Alias from " + StreamName + "_" + LatestYear + "_curriculum where SubCode='" + modified + "'");
                        while (rs11.next()) {
                            if (rs11.getString(1) != null) {
                                modified = rs11.getString(1);
                            }
                        }
            %>
            <%//=rs2.getString(m)%> <!--subjectid-->

            <%
                try {
                    String qry3 = "select percentage  from " + modified + "_Attendance_" + semester + "_" + year + " where StudentId='" + rs1.getString(1) + "'";
                    ResultSet rs3 = st3.executeQuery(qry3);
                    while (rs3.next()) {
            %>
            <td><%=modified%></td>
            <td><%=Math.ceil(rs3.getFloat(1))%></td>

            <%}
                } catch (Exception ex) {
                }%>
            <%}
                    i = i + 2;
                    temp--;
                }
            %>
        </tr>
        <%
            }
        %>
    </table>

    <%
        String StreamName1 = StreamName.replace('_', '-');
        String k = StreamName1 + "-" + sem;
        int flag = 0;
        System.out.println(k);
        System.out.println(StreamName);
        System.out.println(LatestYear);
        ResultSet rs6 = st6.executeQuery("select * from subject_data_" + StreamName + "_" + LatestYear + " where semester='" + k + "'");

    %>
    <table border="1" align="center">




        <%
            while (rs6.next()) {

                if (flag == 0) {
        %>
        <th>Subject Id</th>
        <th>Subject Name</th>
            <%flag++;
                }%>
        <tr>
            <td><%=rs6.getString(1)%></td>
            <td><%=rs6.getString(2)%></td>
        </tr><%
            }

            k = k.replace('-', '_');
            ResultSet rs8 = st6.executeQuery("SHOW COLUMNS FROM " + current_year + "_" + semester + "_elective LIKE '" + k + "'");
            if (rs8.next()) {
                flag++;


                ResultSet rs7 = st7.executeQuery("select a.course_name,b.Subject_Name from " + current_year + "_" + semester + "_elective as a,subjecttable as b where a.course_name=b.Code");

                while (rs7.next()) {
        %>
        <tr>
            <td><%=rs7.getString(1)%></td>
            <td><%=rs7.getString(2)%></td>
        </tr>
        <%}
            }

        %>                  
    </table>
    </br></br>
    <div align="center">
        <input type="button" value="Print" id="p1" class="noPrint" onclick="window.print();" />
    </div>

    <%
        } catch (Exception e) {

            
        }finally{
         conn.closeConnection();
         con = null;
     }
    %>
</body>
</html>
