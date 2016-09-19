<%-- 
    Document   : streamwise11
    Created on : 17 Mar, 2014, 8:38:26 PM
    Author     : veeru
--%>

<%--<%@ include file="dbconnection.jsp" %>--%>
<%@ include file="connectionBean.jsp" %>
<%@page import="javax.sound.midi.SysexMessage"%>
<%@page import="java.util.Calendar"%>
<%@page import ="javax.sql.*" %>
<%@page import="java.sql.*" %>
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
            int j, CurriculumYear, LatestYear = 0, temp = 0;
            /*
             * get current date.
             */
            Calendar now = Calendar.getInstance();
            System.out.println("Current date : " + (now.get(Calendar.MONTH) + 1)
                    + "-"
                    + now.get(Calendar.DATE)
                    + "-"
                    + now.get(Calendar.YEAR));
            int month = now.get(Calendar.MONTH) + 1;
            int year = now.get(Calendar.YEAR);
            String semester = "";
            String sem = "";
            int current_year = year;


            String year2 = request.getParameter("year");

            System.out.println("Year2 value is:" + year2);

            /*
             * Retrieving parameter(programme name, year) from ****aslink1.jsp****.
             */
            String Stream = request.getParameter("pname");
            String BatchYear = request.getParameter("pyear");

            
            Connection con = conn.getConnectionObj();
            Connection con1 = conn.getConnectionObj();
            
            try {
                String Stream1 = Stream.replace('_', '-');
                Stream = Stream.replace('-', '_');


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


        <%--  page heading--%>

    <center><b>University of Hyderabad</b></center>
    <center><b>School of Computer and Information Sciences</b></center>
    <center><b>Stream :</b><%=Stream1%> <b>  Semester :</b><%=sem%> <b>Batch :</b> <%=BatchYear%> <b>Assessment</b></center>
    </br></br>

    <%


        Statement st1 = con.createStatement();
        Statement st2 = con.createStatement();
        Statement st3 = con1.createStatement();
        Statement st4 = con.createStatement();
        Statement st5 = con.createStatement();
        Statement st6 = con.createStatement();
        Statement st7 = con.createStatement();
        //##########################################################################################################
        /*
         * Taking correct version of curriculum for particular programme
         */
        ResultSet rs10 = st4.executeQuery("select * from " + Stream + "_curriculumversions order by Year desc");
        while (rs10.next()) {
            CurriculumYear = rs10.getInt(1);
            if (CurriculumYear <= Integer.parseInt(BatchYear)) {

                LatestYear = CurriculumYear;
                System.out.println(LatestYear);
                break;
            }
        }
        //##########################################################################################################
        try {
            ResultSet rs1 = st1.executeQuery("select * from " + Stream + "_" + BatchYear + "");
            ResultSetMetaData rsmd = rs1.getMetaData();

            int noOfColumns = rsmd.getColumnCount();

            Statement st30 = con.createStatement();
            ResultSet rs30 = st30.executeQuery("select * from " + Stream + "_" + LatestYear + "_currrefer"); //here LatestYear is  for latest curriculumrefer.


            /*
             * counting total number of subject in semester.
             * here columns is equal to number of subjects in semester.
             * So that many column can print on jsp page.
             */
            int columns = 0;

            while (rs30.next()) {

                if (rs30.getString(1).equals(sem)) {

                    System.out.println("sem value is" + sem);
                    columns = rs30.getInt(2) + rs30.getInt(3) + rs30.getInt(4);

                    System.out.println("columns" + columns);
                }

            }

    %>
    <table border="1"  align="center">


        <th>Student Id</th>
        <th>Student Name</th>
            <%
                System.out.println(columns + "column count");
                int w = 1;
                while (w <= columns) {
            %> <th colspan="2">Subject<%=w%></th>
            <%
                    w++;
                }
            %>
        <th>Remarks</th> 

        <%

            while (rs1.next()) {
        %><tr>
            <td class="td"><%=rs1.getString(1)%></td>

            <td width="10" class="td"><%=rs1.getString(2)%></td>

            <%
                if (Stream.equalsIgnoreCase("MCA")) {
                    temp = (noOfColumns - 2) / 2;
                    System.out.println("column value" + noOfColumns);
                } else {

                    temp = (noOfColumns - 2) / 2;
                    System.out.println("column value" + noOfColumns);
                }
                //need to mention number of columns in table
                System.out.println("temp value" + temp);
                int i = 0;
                String remarks = "";

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
                    System.out.println("veeru modified");
                    if (R.equals(rs1.getString(m + 1)) || R1.equals(rs1.getString(m + 1)) || R2.equals(rs1.getString(m + 1)) || R3.equals(rs1.getString(m + 1))
                            || R4.equals(rs1.getString(m + 1)) || R5.equals(rs1.getString(m + 1)) || R6.equals(rs1.getString(m + 1)) || R7.equals(rs1.getString(m + 1))) {

                        String modified = rs1.getString(m);

                        System.out.println(modified + "modified");



                        ResultSet rs11 = st2.executeQuery("select Alias from " + Stream + "_" + LatestYear + "_curriculum where SubCode='" + modified + "'");
                        while (rs11.next()) {
                            if (rs11.getString(1) != null) {
                                modified = rs11.getString(1);

                                System.out.println("modified variable value=" + modified);
                            }
                        }
            %>
            <%//=rs2.getString(m)%> <!--subjectid-->

            <%
                try {
                    String qry3 = "select Final  from " + modified + "_Assessment_" + semester + "_" + current_year + " where StudentId='" + rs1.getString(1) + "'";
                    ResultSet rs3 = st3.executeQuery(qry3);
                    while (rs3.next()) {
            %>
            <td class="td"><%=modified%></td>
            <%if (rs3.getString(1) == null) {
            %><td bgcolor="yellow">R</td><%               } else {

                if (rs3.getString(1).equals("F")) {
                    remarks = remarks + modified + ":" + rs3.getString(1) + " ";
                }
            %>
            <td bgcolor="yellow"><%=rs3.getString(1)%></td>
            <%}
                    }
                } catch (Exception e) {
                }
            %>

            <%}

                    i = i + 2;
                    temp--;
                }
            %>
            <td class="td"><%=remarks%></td>
        </tr>
        <%
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        %>
    </table>

    <%
        // 
        int flag = 0;
        String k = Stream + "-" + sem;
        k = k.replace('_', '-');
        System.out.println(k);
        ResultSet rs6 = st6.executeQuery("select * from subject_data_" + Stream + "_" + LatestYear + " where semester='" + k + "'");
        System.out.println(LatestYear + "latest years");
        k = k.replace('-', '_');
    %>
    <table border="1" align="center">
        <%
                        while (rs6.next()) {

                            if (flag == 0) {%>
        <th>Subject Id</th>
        <th>Subject Name</th>
            <% 
                           flag++; }
            %>
        <tr><td class="td"><%=rs6.getString(1)%></td>
            <td class="td"><%=rs6.getString(2)%></td>
        </tr>
        <%}
            k = k.replace('-', '_');
            ResultSet rs8 = st6.executeQuery("SHOW COLUMNS FROM " + current_year + "_" + semester + "_elective LIKE '" + k + "'");
            if (rs8.next()) {
                ResultSet rs7 = st7.executeQuery("select a.course_name,b.Subject_Name from " + current_year + "_" + semester + "_elective as a,subjecttable as b where a.course_name=b.Code");

                while (rs7.next()) {
        %>
        <tr><td class="td"><%=rs7.getString(1)%></td>
            <td class="td"><%=rs7.getString(2)%></td></tr>
            <%
                    }
                }
            %>                  
    </table>


    </br></br>

    <div align="center">
        <input type="button" class="noPrint" value="Print" id="p1" onclick="window.print();"/>
    </div>


    <%
        } catch (Exception e) {
            out.println("<center><h3>**Infirmation dose not exists for this batch.**</h3></center>");
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
