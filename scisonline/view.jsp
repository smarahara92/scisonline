<%-- 
    Document   : subjectwise
    Created on : Aug 30, 2011, 5:42:43 AM
    Author     : admin
--%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.*"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.SimpleDateFormat.*"%>
<%@page import="java.io.*"%>
<%@page import="java.text.ParseException.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.sql.*"%>
<%@ page import="org.apache.poi.hssf.usermodel.HSSFWorkbook"%>
<%@ page import="org.apache.poi.ss.usermodel.Workbook"%>
<%@ page import="org.apache.poi.ss.usermodel.CellStyle"%>
<%@ page import="org.apache.poi.ss.usermodel.IndexedColors"%>
<%@ page import="org.apache.poi.ss.usermodel.Sheet"%>
<%@ page import="org.apache.poi.ss.usermodel.Cell"%>
<%@ page import="org.apache.poi.ss.usermodel.Row"%>
<%--<%@include file="dbconnection.jsp"%>--%>
<%@include file="connectionBean.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <script language="javascript" src="print.js"></script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
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
    </head>
    <body>
        <%
            Connection con = conn.getConnectionObj();
             try {

                //*************************************************************

                Workbook workbook = new HSSFWorkbook();
                Sheet s = workbook.createSheet();

                //***********************************************************************
                Calendar now = Calendar.getInstance();

                System.out.println("Current date : " + (now.get(Calendar.MONTH) + 1)
                        + "-"
                        + now.get(Calendar.DATE)
                        + "-"
                        + now.get(Calendar.YEAR));
                int month = now.get(Calendar.MONTH) + 1;
                int year = now.get(Calendar.YEAR);
                int date = now.get(Calendar.DATE);
                String semester = "";
                if (month == 7 || month == 8 || month == 9 || month == 10 || month == 11 || month == 12) {
                    semester = "Monsoon";
                } else if (month == 1 || month == 2 || month == 3 || month == 4 || month == 5 || month == 6) {
                    semester = "Winter";
                }
                System.out.println("**************************************************************************");
                System.out.println("***************************************");
                // Class.forName("com.mysql.jdbc.Driver").newInstance();
                String sname = request.getParameter("subjectname");
                String sid = request.getParameter("subjectid");
                //System.out.println("database connected");
                System.out.println(sname + sid);

                Statement st1 = con.createStatement();
                Statement st2 = con.createStatement();
                Statement st3 = con.createStatement();
                Statement st4 = con.createStatement();
                Statement st9 = con.createStatement();
                System.out.println(sname + sid);
                ResultSet rs9 = st9.executeQuery("show columns from subject_attendance_"+semester+"_"+year+"");
                int columns = 0;
                System.out.println(sname + sid);
                while (rs9.next()) {
                    columns++;
                }
                columns = columns - 2;
                System.out.println(sname + sid);
                String qry1 = "select * from " + sid + "_Attendance_" + semester + "_" + year+"";

                ResultSet rs1 = st1.executeQuery(qry1);
                String qry2 = "select * from subject_attendance_"+semester+"_"+year+" where subjectId='" + sid + "'";

                ResultSet rs2 = st3.executeQuery(qry2);
                rs2.next();
                String qry3 = "select count(*) from " + sid + "_Attendance_" + semester + "_" + year;

                ResultSet rs3 = st4.executeQuery(qry3);
                rs3.next();
                System.out.println("database connected");
                //******************************************************************
                Statement st30 = con.createStatement();
                ResultSet rs30 = st30.executeQuery("select * from session  where name='" + semester + "'");
                String startdate = "";
                String enddate = "";
                int sm = 0, em = 0, sd = 0, ed = 0, gap = 0;
                while (rs30.next()) {
                    startdate = rs30.getDate(2).toString();
                    enddate = rs30.getDate(3).toString();
                    String table_year = (startdate.substring(0, 4));
                    String table_session = rs30.getString(1);
                    String session_year = table_session + table_year;
                    // System.out.println("table "+session_year+" given "+given_session+given_year);
                    if (session_year.equalsIgnoreCase(semester + year)) {
                        System.out.println("matched");
                        rs30.afterLast();
                    }


                }
                //creates a array of string for months name

                sm = Integer.parseInt(startdate.substring(5, 7));
                em = Integer.parseInt(enddate.substring(5, 7));

                gap = em - sm;
                if (gap < 0) {
                    gap = -gap;
                }
                sd = Integer.parseInt(startdate.substring(8));
                ed = Integer.parseInt(enddate.substring(8));
                if (ed - sd > 0) {
                    gap = gap + 1;
                }
                System.out.println(gap + month);
                int month1 = month;
                if (month1 - sm >= gap) {
                    month1 = gap + 1;
                } else {
                    month1 = month1 - sm;
                    if (date - sd > 0) {
                        month1 = month1 + 1;
                    }
                }
                boolean isLeapYear;
                isLeapYear = (year % 4 == 0);

                // divisible by 4 and not 100  
                isLeapYear = isLeapYear && (year % 100 != 0);

                // divisible by 4 and not 100 unless divisible by 400  
                isLeapYear = isLeapYear || (year % 400 == 0);
                String u = "28";
                if (isLeapYear == true) {
                    u = "29";
                }
                String[] nameOfMonth = {"Jan", "Feb", "Mar", "Apr",
                    "May", "Jun", "Jul", "Aug", "Sep", "Oct",
                    "Nov", "Dec"};
                String[] nameOfMonth1 = {"Jan31", "Feb" + u, "Mar31", "Apr30",
                    "May31", "Jun30", "Jul31", "Aug31", "Sep30", "Oct31",
                    "Nov30", "Dec31"};
                String[] find = {"", "", "", "", "", "", "", "", ""};
                int y = 1, m = sm;
                while (y <= gap) {
                    if (y == gap) {
                        if (sd > 5) {
                            find[y] = nameOfMonth[m - 1] + sd + "-" + nameOfMonth[em - 1] + ed;
                        } else {
                            find[y] = nameOfMonth[m - 1] + "1" + "-" + nameOfMonth[em - 1] + ed;
                        }
                    } else {
                        if (sd <= 5) {
                            if (y == 1) {
                                find[y] = nameOfMonth[m - 1] + sd + "-" + nameOfMonth1[m - 1];
                            } else {
                                find[y] = nameOfMonth[m - 1] + "1" + "-" + nameOfMonth1[m - 1];
                            }
                        } else {
                            find[y] = nameOfMonth[m - 1] + sd + "-" + nameOfMonth[m] + (sd - 1);
                        }
                    }
                    y++;
                    m++;
                }
                int rowcount = 0, columncount = 0;
                //***************************************************************************
        %>


    <center><b>University of Hyderabad</b></center>
    <center><b>School of Computer and Information Sciences</b></center>
    <center><b style="color:blue"><%=sname%></b>:<b> Subject Attendance</b></center>
    </br></br>

    <table border="1" class="table" align="center">


        <th class="th">StudentID<br/><font color="white">(<%=rs3.getInt(1)%>)</font></th>
        <th class="th">Student Name</th>
            <%
                Row row1 = s.createRow(rowcount++);
                row1.createCell(columncount++).setCellValue("Student ID");

                row1.createCell(columncount++).setCellValue("Student Name");
                int h = 1;
                while (h <= columns) {
            %><th class="th"><%=find[h]%><br/><font color="white">(<%=rs2.getString(h + 1)%>)</font></th>
            <%
                    row1.createCell(columncount++).setCellValue(find[h]);
                    h++;
                }
                row1.createCell(columncount++).setCellValue("Overall Percentage");
            %>
        <th class="th">Overall Percentage</th>

        <%


            int i = columns + 4;
            while (rs1.next()) {
                columncount = 0;
                Row row = s.createRow(rowcount);
        %>

        <%
            if (Math.ceil(rs1.getFloat(i)) < 75) {
        %>
        <tr style="background-color:#F3F781" width="1">
            <td><%=rs1.getString(1)%></td>
            <td><%=rs1.getString(2)%></td>
            <%
                row.createCell(columncount++).setCellValue(rs1.getString(1));
                row.createCell(columncount++).setCellValue(rs1.getString(2));
                h = 1;
                while (h <= columns) {
                    if (rs2.getInt(h + 1) == 0) {
            %>
            <td></td>
            <%  row.createCell(columncount++).setCellValue(" ");
            } else {
            %>  
            <td><%=rs1.getInt(h + 2)%></td>
            <%row.createCell(columncount++).setCellValue(rs1.getInt(h + 2));
                    }
                    h++;
                }

            %>
            <td><font><%=Math.ceil(rs1.getFloat(i))%></font></td>
                <%
                    row.createCell(columncount++).setCellValue(Math.ceil(rs1.getFloat(i)));
                } else {
                %>
        </tr>
        <tr>
            <td class="td"><%=rs1.getString(1)%></td>
            <td class="td"><%=rs1.getString(2)%></td>
            <%
                row.createCell(columncount++).setCellValue(rs1.getString(1));
                row.createCell(columncount++).setCellValue(rs1.getString(2));
                h = 1;
                while (h <= columns) {
                    if (rs2.getInt(h + 1) == 0) {
            %> 
            <td class="td"> </td>
            <%
                row.createCell(columncount++).setCellValue(" ");
            } else {
            %>
            <td class="td"><%=rs1.getInt(h + 2)%></td>
            <%row.createCell(columncount++).setCellValue(rs1.getInt(h + 2));
                    }
                    h++;
                }
            %>
            <td class="td"><%=Math.ceil(rs1.getFloat(i))%></td>
            <%
                    row.createCell(columncount++).setCellValue(Math.ceil(rs1.getFloat(i)));
                }%>
        </tr>

        <%

                    rowcount++;
                }
                String realPath = getServletContext().getRealPath("/");
                try {


                    File file = new File(realPath, "download.xls");
                    if (file.createNewFile()) {
                        System.out.println("File is created!");
                    } else {
                        System.out.println("File already exists.");
                    }
                    System.out.println(file.getAbsolutePath());
                    OutputStream os = (OutputStream) new FileOutputStream(file);
                    workbook.write(os);


                } catch (IOException e) {
                    e.printStackTrace();
                }


            } catch (Exception e) {
            }finally{
                 conn.closeConnection();
                 con = null;
             }
        %>

    </table>
    <table align="center" cellspacing="20">
        <tr class="noPrint">
            <td>
                <input type="button" value="Print" id="p1"  class="noPrint" onclick="window.print();" />
            </td>
            <td>
                <input type="button" value="Export as xls" onclick="window.location.href = 'download.xls';"/>
            </td>
        </tr>
    </table>
</body>
</html>
