<%-- 
    Document   : SubjectwiseMarks
    Created on : 11 Apr, 2012, 3:04:02 PM
    Author     : khushali
--%>


<%@page import="java.util.Calendar"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.sql.*"%>
<%@ page import="java.io.*"%>
<%@ page import="org.apache.poi.hssf.usermodel.HSSFWorkbook"%>
<%--<%@include file="dbconnection.jsp" %>--%>
<%@include file="connectionBean.jsp" %>
<%@ page import="org.apache.poi.ss.usermodel.Workbook"%>
<%@ page import="org.apache.poi.ss.usermodel.Font"%>
<%@ page import="org.apache.poi.ss.usermodel.CellStyle"%>
<%@ page import="org.apache.poi.ss.usermodel.IndexedColors"%>
<%@ page import="org.apache.poi.ss.usermodel.Sheet"%>
<%@ page import="org.apache.poi.ss.usermodel.Cell"%>
<%@ page import="org.apache.poi.ss.usermodel.Row"%>
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
            Connection con1 = conn1.getConnectionObj();
            Calendar now = Calendar.getInstance();
            int month = now.get(Calendar.MONTH) + 1;
            int year = now.get(Calendar.YEAR);

            String semester = "";

            if (month == 7 || month == 8 || month == 9 || month == 10 || month == 11 || month == 12) {
                semester = "Monsoon";
            } else if (month == 1 || month == 2 || month == 3 || month == 4 || month == 5 || month == 6) {
                semester = "Winter";
            }

            System.out.println("**************************************************************************");
            String sname = request.getParameter("subjectname");
            String subjectid = request.getParameter("subjectid");
            System.out.println("subject id is " + subjectid);
            if (sname == null) {
                sname = "";
            }
            ResultSet rss10 = null;
            Statement st11 = con1.createStatement();
            try {

                Statement st1 = con1.createStatement();

                String qry1 = "select * from " + subjectid + "_Assessment_" + semester + "_" + year;
    System.out.println("Subid"+subjectid+"year:"+year+semester);
                ResultSet rs1 = st1.executeQuery(qry1);

                int rowcount = 0, columncount = 0;
        %>
    <center><b>University of Hyderabad</b></center>
    <center><b>School of Computer and Information Sciences</b></center>
    <center><b style="color:blue"><%=sname%></b>:<b> Assessment</b></center>
    </br></br>
    <table border="1"  align="center">

        <th>Student ID</th>
        <th>Student Name</th>
        <th>Minor1</th>
        <th>Minor2</th>
        <th>Minor3</th>
        <th>Internal</th>
        <th>Major</th>
        <th>Total Marks</th>
        <th>Grade</th>

        <%
            Workbook workbook = new HSSFWorkbook();
            Sheet s = workbook.createSheet();
            Row row1 = s.createRow(rowcount++);
            row1.setHeightInPoints(20);
            row1.createCell(columncount++).setCellValue("Student ID");
            row1.createCell(columncount++).setCellValue("Student Name");
            row1.createCell(columncount++).setCellValue("Minor 1");
            row1.createCell(columncount++).setCellValue("Minor 2");
            row1.createCell(columncount++).setCellValue("Minor 3");
            row1.createCell(columncount++).setCellValue("Internal");
            row1.createCell(columncount++).setCellValue("Major");
            row1.createCell(columncount++).setCellValue("Total Marks");
            row1.createCell(columncount++).setCellValue("Grade");

        %>

        <%while (rs1.next()) {
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


            <%if (rs1.getString(3) == null) {%>
            <td></td>
            <%
                row.createCell(columncount++).setCellValue(" ");
            } else {%>                  
            <td><%=rs1.getString(3)%></td>
            <%
                    row.createCell(columncount++).setCellValue(rs1.getString(3));
                }%>

            <%if (rs1.getString(4) == null) {%>
            <td></td>
            <%
                row.createCell(columncount++).setCellValue(" ");
            } else {%>                  
            <td><%=rs1.getString(4)%></td>
            <%
                    row.createCell(columncount++).setCellValue(rs1.getString(4));
                }%>


            <%if (rs1.getString(5) == null) {%>
            <td></td>
            <%
                row.createCell(columncount++).setCellValue(" ");
            } else {%>                  
            <td><%=rs1.getString(5)%></td>
            <%
                    row.createCell(columncount++).setCellValue(rs1.getString(5));
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
                }else{
                %>
                <td></td>
            <%
                }
            %>
        </tr>

        <%
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
                System.out.println("Caught the exception");
                out.println("<h1><center>Data is not Available</center></h1>");
                e.printStackTrace();
            }finally{
                conn1.closeConnection();
                con1 = null ;
            }
        %>

    </table>
    </br></br>
    <div align="center">
        <input type="button" value="Print" id="p1" class="noPrint" onclick="window.print();" />
        <input type="button" value="Export as xls" class="noPrint" onclick="window.location.href = 'download.xls';"/>
    </div>
</body>
</html>

