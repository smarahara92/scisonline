<%-- 
    Document   : subjects_students2
    Created on : Jan 8, 2013, 3:04:25 PM
    Author     : root
--%>

<%@page import="java.io.OutputStream"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.io.FileInputStream"%>
<%@ page import="java.io.*"%>
<%@page import="java.io.File"%>
<%@page import="com.hcu.mysql.connection.ConnectionDemo3"%>
<%@page import="com.hcu.mysql.connection.ConnectionDemo1"%>
<%@page import="com.hcu.mysql.connection.ConnectionDemo"%>
<%@page import="java.sql.*"%>
<%@page import="com.mysql.jdbc.Statement"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@ page import="org.apache.poi.hssf.usermodel.HSSFWorkbook"%>
<%@page import="org.apache.poi.hssf.util.HSSFColor"%>
<%@ page import="org.apache.poi.ss.usermodel.Workbook"%>
<%@ page import="org.apache.poi.ss.usermodel.Font"%>
<%@ page import="org.apache.poi.ss.usermodel.CellStyle"%>
<%@ page import="org.apache.poi.ss.usermodel.IndexedColors"%>
<%@ page import="org.apache.poi.ss.usermodel.Sheet"%>
<%@ page import="org.apache.poi.ss.usermodel.Cell"%>
<%@ page import="org.apache.poi.ss.usermodel.Row"%>
 <%-- <%@include file="dbconnection.jsp" %> --%>
 <%@include file="connectionBean.jsp" %>
<%@include file="checkValidity.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script language="javascript" src="print.js"></script>
        <style type="text/css">

            @media print {

                .noPrint
                {
                    display:none;
                }
            }
        </style>
        <style type="text/css">
            .style30 {color: black}
            .style31 {color: white}
            .style32 {color: green}
            .caption{
                font-weight: bold;
            }

            .th
            {
                color: white;
                background-color: #c2000d;
            }
            .heading1
            {
                color: white;
                background-color:#003399;
            }
            .td
            {
                border-collapse:collapse;
                border: 1px solid green;
                white-space:nowrap;
                background-color: #F5F5F5;
                padding: 4px;
                font-size-adjust: 0.5;
                font-family: initial;

            }
            .table{
                border-collapse:collapse;
                border: 1px solid green;
                white-space:nowrap;
                background-color: #F5F5F5;
                padding: 4px;
                font-size-adjust: 0.5;
                font-family: initial;
            }

        </style>

        <script>
            function p1()
            {
                document.getElementById("p1").style.display = "none";
                window.print();
            }
        </script>    </head>
    <body>
        <%
             Connection con = conn.getConnectionObj();
            try {
                String code = (String) request.getParameter("subjectname");
                System.out.println(code);
                if (code.equals("none")) {
                    throw new Exception();
                }
               
                Statement st2 = (Statement) con.createStatement();
                ResultSet rs2 = st2.executeQuery("select Subject_Name from subjecttable where Code='" + code + "'");
                rs2.next();
                String subjectname = rs2.getString(1);
                System.out.println(subjectname);
                Calendar cal = Calendar.getInstance();
                int year = cal.get(Calendar.YEAR);
                int year1 = year;
                int month = cal.get(Calendar.MONTH) + 1;
                String semester = "";
                if (month <= 6) {
                    semester = "Winter";
                }
                if (month > 6) {
                    semester = "Monsoon";

                }

                int mca = 0, cs = 0, ai = 0, it = 0;

                //String table=semester+"_"+year+"_"+code; attendance table has changed. eg :AI758_Attendance_Monsoon_2013
                String table = code + "_Attendance_" + semester + "_" + year;
                System.out.println(table);
                Statement st1 = (Statement) con.createStatement();
                ResultSet rs1 = st1.executeQuery("select * from " + table + "");
                Workbook workbook = new HSSFWorkbook();
                Sheet s = workbook.createSheet();
                int rowcount = 0, columncount = 0;
                //**********************************************************

                CellStyle style = workbook.createCellStyle();
                Font font = workbook.createFont();
                font.setBoldweight(Font.BOLDWEIGHT_BOLD);
                font.setFontName("Helvetia");
                font.setColor(HSSFColor.RED.index);
                style.setFont(font);

                Row row1 = s.createRow(rowcount++);

                row1.setHeightInPoints(20);
                Cell cell = row1.createCell(columncount++);
                cell.setCellStyle(style);

                cell.setCellValue("  StudentID");
                //  row1.createCell(columncount++).setCellValue("Student ID");
                // row1.createCell(columncount++).setCellValue("   Student Name   ");
                cell = row1.createCell(columncount++);
                cell.setCellStyle(style);

                cell.setCellValue("   Student Name");
                //row1.createCell(columncount++).setCellValue("  Attended Classes "+"\t"+"("+ca+")  ");

                s.autoSizeColumn(0);
                s.autoSizeColumn(1);



                //**********************************************************
        %>

        <table  align="center" border="0" cellspacing="0" cellpadding="0" style="color:blue;background-color:#CCFFFF;" width="100%">

            <th align="center">Year</th>
            <th align="center">Semester</th>
            <th align="center">Subject Name</th>
            <th align="center">Code</th>

            <tr>
                <td align="center"><input type="text" value="<%=year%>" readonly="yes"></td>
                <td align="center"><input type="text"  value="<%=semester%>" readonly="yes"></td>

                <td align="center"><input type="text"  value="<%=subjectname%>" readonly="yes"></td>  
                    <% //session.setAttribute("subjname",sname);%>
                <td align="center"><input type="text"  value="<%=code%>" readonly="yes"></td>    
                    <%  //session.setAttribute("subjid",subjectId);%>


            </tr>
        </table>

        </br>

        <table align="center" class="table">

            <th class="th">S.No</th>
            <th class="th">Student Id</th>
            <th class="th" >Student Name</th>

            <%
                 String ii = "#"+"ffffff";
                int i = 1;
                while (rs1.next()) {
                    columncount = 0;
                    Row row = s.createRow(rowcount++);
                   
            %>
            <tr>
                <td class="td" style="color:red; background-color:<%=ii%>;"><%=i%></td>
                <td class="td"><%=rs1.getString(1)%></td>
                <td class="td"><%=rs1.getString(2)%></td>
            </tr>

            <%i++;
                    
                    row.createCell(columncount++).setCellValue(rs1.getString(1));
                    row.createCell(columncount++).setCellValue(rs1.getString(2));
                }%>
        </table>
        </br>
        <table align="center">
            <tr>
                <%

                    Statement st = (Statement) con.createStatement();
                    Statement st3 = (Statement) con.createStatement();
                    Statement st4 = (Statement) con.createStatement();
                    Statement st10 = (Statement) con.createStatement();
                    int curriculumYear = 0, latestYear = 0;
                    String streamName = "";
                    // get elective max limits for all streams in the given semester.
                    //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$ //

                    Statement st_ele = (Statement) con.createStatement();
                    Statement st_ele_max = (Statement) con.createStatement();
                     Statement st_ele_max2 = (Statement) con.createStatement();
                    ResultSet rs2_ele = st_ele.executeQuery("select sname from " + semester + "_stream");
                    System.out.println(semester);
                    String stream1 = ""; // contains mtech-ai-ii
                    String stream2 = "";// contains mtech_ai_ii
                    while (rs2_ele.next()) {
                        try {
                            stream1 = rs2_ele.getString(1); //
                        stream2 = stream1.replace("-", "_");
                        ResultSet rss1 = null;
                        String prgm_name1 = "";
                        String prgm_name2 = "";

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
                        // get the corresponding programe name.
                        ResultSet rss = st.executeQuery("select Programme_name from programme_table where Programme_status='1'");
                        int k = 0;
                        while (rss.next()) {
                            prgm_name1 = rss.getString(1);
                            if (stream1.contains(prgm_name1)) {
                                prgm_name2 = prgm_name1;
                                break;
                            }

                        }
                        if (!(prgm_name2.equalsIgnoreCase(""))) {


//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$444$44
                            // get the year of the stream( for eg: mtech-ai-ii,mtech-ai-iv,...).
                            int year2 = year; // year is the system year.

                            int str_len = stream2.length();
                            int sem2 = 0;
                            String sub_2 = (stream2).substring(str_len - 2, str_len);  // MTech-CS-I OR -V, -AI-I OR -V, MCA-I OR -V,
                            String sub_3 = (stream2).substring(str_len - 3, str_len);  // -II, -IV, -VI ..etc
                            String sub_4 = (stream2).substring(str_len - 4, str_len);   // -III , -IIV , etc
                            String sub_5 = (stream2).substring(str_len - 5, str_len);    // mostly no need.

                            if (sub_2.equals("_I")) {

                                year2 = year;
                            } else if (sub_2.equals("_V")) {

                                year2 = year - 2;
                            } else if (sub_2.equals("_X")) {

                                year2 = year - 5;
                            } else if (sub_3.equals("_IV")) {

                                year2 = year - 2;
                            } else if (sub_3.equals("_II")) {

                                year2 = year - 1;
                            } else if (sub_3.equals("_VI")) {

                                year2 = year - 3;
                            } else if (sub_3.equals("_IX")) {

                                year2 = year - 4;
                            } else if (sub_4.equals("_III")) {

                                year2 = year - 1;
                            } else if (sub_4.equals("_VII")) {

                                year2 = year - 3;
                            } else if (sub_5.equals("_VIII")) {

                                year2 = year - 4;

                            }

                            //******************************************************************************

                            //===============================
                            
                        int start = 0;
                         int flag = 1;
                        //curriculum for programme.
                         Statement st5 = (Statement) con.createStatement();
                        ResultSet rs12 = (ResultSet) st5.executeQuery("select * from " + prgm_name2.replace('-', '_') + "_curriculumversions order by Year desc");
                        while (rs12.next()) {
                            curriculumYear = rs12.getInt(1);
                            if (curriculumYear <= year && flag!=0) {

                                latestYear = curriculumYear;

                            flag=0;
                             }  
                        start = curriculumYear;
                        }
                            
                            

                            if( start <= year2)
                            {
                                  rss1 = st3.executeQuery("select StudentId from " + prgm_name2.replace('-', '_') + "_" + year2 + "");
                            while (rss1.next()) {
                                System.out.println(rss1.getString(1));
                                ResultSet rss2 = st4.executeQuery("select * from " + code + "_Attendance_" + semester + "_" + year + " where StudentId='" + rss1.getString(1) + "'");
                                if (rss2.next()) {
                                    k++;
                                    // flag++;
                                    streamName = prgm_name2;
                                    System.out.println(streamName);
                                }
                                rss2.beforeFirst();


                            }
                            rss1.beforeFirst();

                            //  System.out.println("year11111111111qq=======================================");

                            if (k > 0) {
                                
                                int max_limit = 0;
                                System.out.println("strem is : " + stream2 +" "+year);
                             try{
                                    ResultSet rs2_ele_max = st_ele_max.executeQuery("select " + stream2 + "  from  " + year + "_" + semester + "_elective where course_name='" + code + "'");
                                if (rs2_ele_max.next()) {
                                    max_limit = rs2_ele_max.getInt(1);
                                    System.out.println("strem is : " + stream2 + ",subject and limit :" + code + " " + rs2_ele_max.getInt(1));

                                    String limit_over_by_max = Integer.toString(k) + " / " + Integer.toString(max_limit);

                                    if (max_limit == 0) {
                                        String core_stream = stream1 + "( Core ) ";

                %>
                <td style="color:blue; background-color:#CCFFFF;"> <b> <%=core_stream%></b><br><input type="text"  readonly="yes" value="<%=k%>"  style=" width: 50%; color: black"></td>

                <%                    } else {

                %>
                <td style="color:blue; background-color:#CCFFFF;"> <b><%=stream1%></b><br><input type="text"  readonly="yes" value="<%=limit_over_by_max%>"  style=" width: 50%; color: black"></td>

                <%

                                    }
                                }
                             }// here try ends
                             catch(Exception e){
                             
                             // it is a core , so no need to display anythin here.
                             
                             }
 
                            }

                        }
                    }
                        } catch(Exception e) {}
                    }
                %>
            </tr>
        </table>
        <%
            s.autoSizeColumn(0);
            s.autoSizeColumn(1);
            String realPath = getServletContext().getRealPath("/");
            String download = subjectname + " students.xls";
            try {


                File file = new File(realPath, download);
                if (file.createNewFile()) {
                    System.out.println("File is created!");
                } else {
                    System.out.println("File already exists.");
                }
                System.out.println(file.getAbsolutePath());
                OutputStream os = (OutputStream) new FileOutputStream(file);
                workbook.write(os);


            } catch (IOException e) {
                out.print(e);
            }

        %>

        </br>
        <div align="center">
            <input type="button" value="Print" id="p1"  class="noPrint" onclick="window.print();" />
            <input type="button" value="Export as xls" id="p2"  class="noPrint" onclick="window.location.href = '<%=download%>';"/>
        </div>
        <%
            } catch (Exception e) {
                out.println(e);
            }
            finally{
                conn.closeConnection();
                con=null;
            }
        %>
    </body>
</html>
