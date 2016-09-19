<%-- 
    Document   : SubjectwiseMarks
    Created on : 11 Apr, 2012, 3:04:02 PM
    Author     : khushali
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
        <%    Calendar now = Calendar.getInstance();

            int month = now.get(Calendar.MONTH) + 1;
            int year = now.get(Calendar.YEAR);
            String semester = "";
            if (month == 7 || month == 8 || month == 9 || month == 10 || month == 11 || month == 12) {
                semester = "Monsoon";
            } else if (month == 1 || month == 2 || month == 3 || month == 4 || month == 5 || month == 6) {
                semester = "Winter";
            }
            String sname = request.getParameter("subjectname");
            String subjectid = request.getParameter("subjectid");
            String fid = null;
            String checkk = null;
            String month1 = null;
            String month2 = null;
            try {
                
                fid = request.getParameter("fid");
                checkk = request.getParameter("checkk");
                System.out.println(checkk);
                month1 = request.getParameter("month");
                month1 = month1.replace('-', '_');
                month2 = month1.replace('_', ' ');
                if( month1.equals("Internal_Major Marks"))
                {
                    month1 = "InternalMarks,Major";
                }
               
            } catch (Exception ex) {
            }
            if(checkk==null)
            {
             checkk="";   
            }
            if (sname == null) {
                sname = "";
            }
//session.setAttribute("facultyname",fname);
                Connection con = conn.getConnectionObj();
                Connection con1 = conn1.getConnectionObj();
            try {

                Statement st1 = con.createStatement();
                Statement st2 = con.createStatement();
                Statement st9 = con1.createStatement();
                Statement st10 = con.createStatement();
                Statement st11 = con1.createStatement();
                String fname = null;

                Workbook workbook = new HSSFWorkbook();
                Sheet s = workbook.createSheet();
                if (checkk.equalsIgnoreCase("yes")==false) {
                    System.out.println("1...");
                    ResultSet rs10 = st10.executeQuery("select * from subjecttable where Code='" + subjectid + "'");
                    rs10.next();
                    String credits = rs10.getString(3);
                    String qry1 = "select * from " + subjectid + "_Assessment_" + semester + "_" + year;
                    //String qry2 = "select * from " + subjectid + "_Assessment_" + semester + "_" + year where();
                    System.out.println("11...");
                    ResultSet rs1 = st9.executeQuery(qry1);


        %>

        <%            int rowcount = 0, columncount = 0;

        %>
    <center><b>University of Hyderabad</b></center>
    <center><b>School of Computer and Information Sciences</b></center>
    <center><b style=" color: blue"><%=sname%> :</b><b> Subject Assessment</b></center>
    <div align="left"><b>Course Code : <%=subjectid%></b></div>
    <div align="right"><b>Course Code : <%=credits%></b></div>
    </br></br>
    <table border="1" align="center">
        <th>Student ID</th>
        <th>Student Name</th>
        <th>Internal</th>
        <th>Major</th>
        <th>Total</th>
        <th>Grade</th>

        <%
            Row row1 = s.createRow(rowcount++);

            row1.setHeightInPoints(20);
            row1.createCell(columncount++).setCellValue("Student ID");
            row1.createCell(columncount++).setCellValue("Student Name");
            row1.createCell(columncount++).setCellValue("Internal");
            row1.createCell(columncount++).setCellValue("Major");
            row1.createCell(columncount++).setCellValue("Total");
            row1.createCell(columncount++).setCellValue("Grade");
            ResultSet rss10 = null;

            while (rs1.next()) {
                columncount = 0;
                Row row = s.createRow(rowcount++);
                row.setHeightInPoints(20);
        %>
        <tr>
            <%if (rs1.getString(1) == null) {%>
            <td></td>
            <%
                row.createCell(columncount++).setCellValue(" ");

            } else {%>                  
            <td><%=rs1.getString(1)%></td>
            <%
                    rss10 = st11.executeQuery("select * from " + subjectid + "_Assessment_" + semester + "_" + year + " where (Major IS NOT NULL and StudentId='" + rs1.getString(1) + "')");

                    row.createCell(columncount++).setCellValue(rs1.getString(1));
                }%>

            <%if (rs1.getString(2) == null) {%>
            <td></td>
            <%
                row.createCell(columncount++).setCellValue(" ");
            } else {%>                  
            <td><%=rs1.getString(2)%></td>
            <%
                    row.createCell(columncount++).setCellValue(rs1.getString(2));
                }%>


            <%if (rs1.getString(8) == null) {%>
            <td></td>
            <%
                row.createCell(columncount++).setCellValue(" ");
            } else {%>                  
            <td><%=rs1.getString(8)%></td>
            <%
                    row.createCell(columncount++).setCellValue(rs1.getString(8));
                }%>

            <%if (rs1.getString(6) == null) {%>
            <td></td>
            <%
                row.createCell(columncount++).setCellValue(" ");
            } else {%>                  
            <td><%=rs1.getString(6)%></td>
            <%
                    row.createCell(columncount++).setCellValue(rs1.getString(6));
                }%>


            <%if (rs1.getString(9) == null) {%>
            <td></td>
            <%
                row.createCell(columncount++).setCellValue(" ");
            } else {%>                  
            <td><%=rs1.getString(9)%></td>
            <%
                    row.createCell(columncount++).setCellValue(rs1.getString(9));
                }%>


            <%
                if (rss10.next()) {
                    if (rss10.getString(7) == null) {%>
            <td></td>
            <%
                row.createCell(columncount++).setCellValue(" ");
            } else {%>                  
            <td><%=rss10.getString(7)%></td>
            <%
                    row.createCell(columncount++).setCellValue(rss10.getString(7));
                }
            } else {
            %>
            <td></td>
            <%
                }
            %>
        </tr>
        <%
            }
System.out.println("1.22..");
        } else {

            ResultSet rs10 = st10.executeQuery("select * from subjecttable where Code='" + subjectid + "'");
            rs10.next();
            String credits = rs10.getString(3);
            String qry1 = "select StudentId,StudentName,"+month1+" from " + subjectid + "_Assessment_" + semester + "_" + year;
            //String qry2 = "select * from " + subjectid + "_Assessment_" + semester + "_" + year where();
            System.out.println(qry1);
            ResultSet rs1 = st9.executeQuery(qry1);


        %>

        <%            int rowcount = 0, columncount = 0;

        %>
        <center><b>University of Hyderabad</b></center>
        <center><b>School of Computer and Information Sciences</b></center>
        <center><b style=" color: blue"><%=sname%> :</b><b> Subject Assessment</b></center>
        <div align="left"><b>Course Code : <%=subjectid%></b></div>
        <div align="right"><b>Course Code : <%=credits%></b></div>
        </br></br>
        <table border="1" align="center">
            <th>Student ID</th>
            <th>Student Name</th>
            
            <%
                 System.out.println(month1);
                if( month2.equals("Internal Major Marks"))
                {
                 
                
                %>
                 <th>Internal Marks</th>
                  <th>Major</th>
                 <%
                }
                else
                {
            %>
            <th><%=month2%></th>
            <%}%>                                                                                                                                                         

            <%
                Row row1 = s.createRow(rowcount++);

                row1.setHeightInPoints(20);
                row1.createCell(columncount++).setCellValue("Student ID");
                row1.createCell(columncount++).setCellValue("Student Name");
                 if( month2.equals("Internal Major Marks"))
                {
                    row1.createCell(columncount++).setCellValue("Internal Marks");
                    row1.createCell(columncount++).setCellValue("Major");
                }
                 else
                 {
                row1.createCell(columncount++).setCellValue(month2);
                 }
//                row1.createCell(columncount++).setCellValue("Major");
//                row1.createCell(columncount++).setCellValue("Total");
//                row1.createCell(columncount++).setCellValue("Grade");
                ResultSet rss10 = null;

                while (rs1.next()) {
                    columncount = 0;
                    Row row = s.createRow(rowcount++);
                    row.setHeightInPoints(20);
            %>
            <tr>
                <%if (rs1.getString(1) == null) {%>
                <td></td>
                <%
                    row.createCell(columncount++).setCellValue(" ");

                } else {%>                  
                <td><%=rs1.getString(1)%></td>
                <%

                        row.createCell(columncount++).setCellValue(rs1.getString(1));
                    }%>

                <%if (rs1.getString(2) == null) {%>
                <td></td>
                <%
                    row.createCell(columncount++).setCellValue(" ");
                } else {%>                  
                <td><%=rs1.getString(2)%></td>
                <%
                        row.createCell(columncount++).setCellValue(rs1.getString(2));
                    }%>


                <%if (rs1.getString(3) == null) {%>
                <td></td>
                <%
                    row.createCell(columncount++).setCellValue(" ");
                } else {%>                  
                <td><%=rs1.getString(3)%></td>
                <%
                        row.createCell(columncount++).setCellValue(rs1.getString(3));
                    }%>
                     
                  
                                 <% if(month2.equals("Internal Major Marks"))
                                 {
                                     if (rs1.getString(4) == null) {%>
                                 <td></td>
                                <%
                                    row.createCell(columncount++).setCellValue(" ");
                                    } else {%>                  
                                    <td><%=rs1.getString(4)%></td>
                                    <%
                                 row.createCell(columncount++).setCellValue(rs1.getString(4));
                                    }%>
                    <%}%>

            </tr>
            <%
                    }

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

                String qry6 = "select Faculty_Name from faculty_data where ID='" + fid + "'";
                Statement st6 = con.createStatement();
                ResultSet rs6 = st6.executeQuery(qry6);
                rs6.next();
                fname = rs6.getString(1);

            %>

        </table>
        </br>
        </br>
        </br>
        <div align="left" style="color:blue;background-color:#CCFFFF;"><b>Name of the Faculty  :  </b><%=fname%></div>
        <div align="right" style="color:blue;background-color:#CCFFFF;"><b>Signature of the Faculty</b></div>
        <div align="left" style="color:blue;background-color:#CCFFFF;"><b>Date  : <%=now.get(Calendar.DATE)
                + "-"
                + (now.get(Calendar.MONTH) + 1)
                + "-"
                + now.get(Calendar.YEAR)%> </b>
        </div>
        </br>
        </br>
        <div align="center" style="color:blue;background-color:#CCFFFF;"><b>Dean of the School</b></div><br/>

        <%
            } catch (Exception e) {
                
            System.out.println(e);
                out.println("<h1><center>Data is not Available </center></h1>");
                e.printStackTrace();
            }finally{
                conn.closeConnection();
                conn1.closeConnection();
                con = null;
                con1 = null;
            }
        %>

        </br></br>
        <div align="center">
            <input type="button" value="Print" id="p1" class="noPrint" onclick="window.print();" />
            <input type="button" value="Export as xls" id="p2" class="noPrint"onclick="window.location.href = 'download.xls';"/>
        </div>
    </body>
</html>

