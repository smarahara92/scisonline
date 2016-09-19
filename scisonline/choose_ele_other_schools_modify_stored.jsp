<%-- 
    Document   : choose_ele_other_schools_modify_stored
--%>
<%@page import="java.util.HashMap"%>
<%@page import="java.io.OutputStream"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.io.FileInputStream"%>
<%@ page import="java.io.*"%>
<%@page import="java.io.File"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@page import="org.apache.poi.hssf.usermodel.HSSFWorkbook"%>
<%@page import="org.apache.poi.hssf.util.HSSFColor"%>
<%@page import="org.apache.poi.ss.usermodel.Workbook"%>
<%@page import="org.apache.poi.ss.usermodel.Font"%>
<%@ page import="org.apache.poi.ss.usermodel.CellStyle"%>
<%@ page import="org.apache.poi.ss.usermodel.IndexedColors"%>
<%@ page import="org.apache.poi.ss.usermodel.Sheet"%>
<%@ page import="org.apache.poi.ss.usermodel.Cell"%>
<%@ page import="org.apache.poi.ss.usermodel.Row"%>
<%@include file="connectionBean.jsp" %>
<%@include file="checkValidity.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <style type="text/css">

            @media print {

                .noPrint
                {
                    display:none;
                }
            }
        </style>


        <style>
            .style30 {color: red}
            .style31 {
                background-color: #c2000d;
                color: white}
            .style32 {color: green}
            .style44{

                background-color: #9FFF9D;
            }




        </style> 


        <style type="text/css">
            .pos_fixed
            {
                position:fixed;
                bottom:0px;
                background-color: #CCFFFF;
                border-color: red;
            }
            .head_pos
            {
                position:fixed;
                top:0px;
                background-color: #CCFFFF;
            }
            .menu_pos
            {
                position:fixed;
                top:105px;
                background-color: #CCFFFF;
            }
            .table_pos
            {
                top:200px;
            }
            .border
            {
                background-color: #c2000d;
            }
            .fix
            {   
                background-color: #c2000d;
            }

            td,table
            {
                white-space: nowrap;


            }
        </style>
    </head>
    <body>

        <%
            Connection con = conn.getConnectionObj();
            Connection con1 = conn1.getConnectionObj();
        
        
            //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
            //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
   // For selected student, retrive the previous choosen coursen, 
   //delete this student from the subject attendance, assessment tables.
   // get the newly choosen courses from the previous page, update the in assessment and attendance tables.

        %>

        <%
            Calendar cal = Calendar.getInstance();
            // int year = cal.get(Calendar.YEAR);
            int month = cal.get(Calendar.MONTH);
            // String given_session = "";
            String stream = "";
            // stream = (String) request.getParameter("stream");
            String student_id = "";
            String elective_code = "";
            String grade_formula = "";
            String student_index = "sid";
            String column_index = "select";
            student_id = request.getParameter("student_id");
            String given_session = request.getParameter("given_session");
            String given_year = request.getParameter("given_year");
            Statement st1 = (Statement) con.createStatement();
            Statement st2 = (Statement) con.createStatement();
            Statement st3 = (Statement) con.createStatement();
            Statement st2_con = (Statement) con.createStatement();
            Statement st3_con = (Statement) con.createStatement();
            Statement st4 = (Statement) con.createStatement();
            Statement st5 = (Statement) con.createStatement();
            Statement st12 = (Statement) con.createStatement();

            Statement st10 = (Statement) con1.createStatement();
            Statement st13 = (Statement) con1.createStatement();
            Statement st14 = (Statement) con1.createStatement();


            // DELETE THE OLD RECORDS OF STUDENT FROM THE ASSESSEMENT , ATTENDANCE TABLES. 

            ResultSet rs1 = (ResultSet) st2.executeQuery("select Elective1,Elective2,Elective3,Elective4 from Other_Schools_" + given_session + "_" + given_year + " where StudentID='" + student_id + "'");
            String old_sub1 = "", old_sub2 = "", old_sub3 = "", old_sub4 = "";
            rs1.next();
            old_sub1 = rs1.getString(1);
            old_sub2 = rs1.getString(2);
            old_sub3 = rs1.getString(3);
            old_sub4 = rs1.getString(4);
            if (old_sub1 != null && !old_sub1.isEmpty() && !old_sub1.equalsIgnoreCase("null")) {

                st12.executeUpdate("DELETE FROM  " + old_sub1 + "_Attendance_" + given_session + "_" + given_year + "  where StudentId='" + student_id + "'");
                st14.executeUpdate("DELETE FROM  " + old_sub1 + "_Assessment_" + given_session + "_" + given_year + "  where StudentId='" + student_id + "'");

            }
            if (old_sub2 != null && !old_sub2.isEmpty() && !old_sub2.equalsIgnoreCase("null")) {

                st12.executeUpdate("DELETE FROM  " + old_sub2 + "_Attendance_" + given_session + "_" + given_year + "  where StudentId='" + student_id + "'");
                st14.executeUpdate("DELETE FROM  " + old_sub2 + "_Assessment_" + given_session + "_" + given_year + "  where StudentId='" + student_id + "'");

            }
            if (old_sub3 != null && !old_sub3.isEmpty() && !old_sub3.equalsIgnoreCase("null")) {

                st12.executeUpdate("DELETE FROM  " + old_sub3 + "_Attendance_" + given_session + "_" + given_year + "  where StudentId='" + student_id + "'");
                st14.executeUpdate("DELETE FROM  " + old_sub3 + "_Assessment_" + given_session + "_" + given_year + "  where StudentId='" + student_id + "'");

            }
            if (old_sub4 != null && !old_sub4.isEmpty() && !old_sub4.equalsIgnoreCase("null")) {

                st12.executeUpdate("DELETE FROM  " + old_sub4 + "_Attendance_" + given_session + "_" + given_year + "  where StudentId='" + student_id + "'");
                st14.executeUpdate("DELETE FROM  " + old_sub4 + "_Assessment_" + given_session + "_" + given_year + "  where StudentId='" + student_id + "'");

            }



        %>

        <%
            // Now get the newly choosen courses name,add that student into corresponding subjects assessment , attendance tables.
%>

        <table align="center" border="1">

            <tr class="fix">

                <td class="style31" align="center"><b>Student ID</b></td>
                <td class="style31" align="center"><b>Student Name</b></td>

                <td class="style31" align="center"><b>Course 1</b></td>
                <td class="style31" align="center"><b>Course 2</b></td>
                <td class="style31" align="center"><b>Course 3</b></td>
                <td class="style31" align="center"><b>Course 4</b></td>
                <td class="style31" align="center"><b>Grade Formula</b></td>

            </tr>
            <%
                ResultSet rs_sname = st1.executeQuery("select Name from Other_Schools_" + given_session + "_" + given_year + " where StudentId='" + student_id + "'");
                if (rs_sname.next()) {
                    String student_name = rs_sname.getString(1);
            %>
            <td>
                <%=student_id%>

            </td>
            <td>
                <%=student_name%>

            </td>

            <%
            // logic for finding number of cols in attendance tables

        Statement st30 = (Statement) con.createStatement();
        ResultSet rs30 = (ResultSet) st30.executeQuery("select *  from session where name ='"+given_session+"'");
        String startdate = "";
        String enddate = "";
        String columns = "";
        int stm = 0, em = 0, sd = 0, ed = 0, finding = 0, gap = 0;

        while(rs30.next()) {
                                finding = 1;
                                
                                startdate = rs30.getDate(2).toString();
                                enddate = rs30.getDate(3).toString();
                                String table_year=(startdate.substring(0, 4));
                                String table_session=rs30.getString(1);
                                
                                String session_year=table_session+table_year;
                                System.out.println("table "+session_year+" given "+given_session+given_year);
                                if(session_year.equalsIgnoreCase(given_session+given_year))
                                {
                                    System.out.println("matched");
                                    rs30.afterLast();
                                stm = Integer.parseInt(startdate.substring(5, 7));
                                em = Integer.parseInt(enddate.substring(5, 7));
                                sd = Integer.parseInt(startdate.substring(8));
                                ed = Integer.parseInt(enddate.substring(8));
                                //System.out.println("lllllllllllllllllllllllllllllllllll"+stm+"  "+em);
                                gap = em - stm;
                                if (gap < 0) {
                                    gap = -gap;
                                }
                                int e = 1;
                                while (e <= gap) {
                                    columns = columns + "Month" + e + " int(20),";
                                    e++;
                                }
                                if (ed - sd > 0) {
                                    columns = columns + "Month" + e + " int(20),";
                                }
                                System.out.println(columns);
                                                }
                            }
            
            
            
            
            // get the selected values from the previous page.
                for (int i = 1; i <= 4; i++) {
                    String elective = "Elective" + i;
                    String En_Grade = "E" + i + "_Grade";
                    //System.out.println("sss column " +i+ " electiven "+elective+ "  grade "+En_Grade);
                    elective_code = request.getParameter(column_index + Integer.toString(1) + Integer.toString(i));
                    if (elective_code.equalsIgnoreCase("none") == false) {
                        st2.executeUpdate("update  Other_Schools_" + given_session + "_" + given_year + " set " + elective + "='" + elective_code + "' ," + En_Grade + "='R' where StudentID='" + student_id + "' ");
                        // st4.executeUpdate("update " + stream_table + " set  p1grade = 'R'   where StudentId='" + rs.getString(1) + "'");

            /// attendance , assessment tables creation , sending student list to respective tables.
                        st3.executeUpdate("create table if not exists " + elective_code + "_Attendance_" + given_session + "_" + given_year + "(StudentId varchar(20) not null,StudentName varchar(50)," + columns + "cumatten int(20),percentage float,primary key(StudentId))");
                        st13.executeUpdate("create table if not exists " + elective_code + "_Assessment_" + given_session + "_" + given_year + "(StudentId varchar(20) not null,StudentName varchar(50),Minor_1 varchar(5),Minor_2 varchar(5),Minor_3 varchar(5),Major varchar(5),Final varchar(5),InternalMarks varchar(5),TotalMarks varchar(5),primary key(StudentId))");

                        /// sending students to the respective attendance, assessment tables of electives.
                        st4.executeUpdate("insert ignore into " + elective_code + "_Attendance_" + given_session + "_" + given_year + " (StudentId , StudentName) values('" + student_id + "','" + student_name + "')");
                        st14.executeUpdate("insert ignore into " + elective_code + "_Assessment_" + given_session + "_" + given_year + " (StudentId , StudentName) values('" + student_id + "','" + student_name + "')");



                        //System.out.println("column " + i + ": " + elective_code);
                        ResultSet rs_cname = st5.executeQuery(" select Subject_Name from subjecttable where Code='" + elective_code + "'");
                        rs_cname.next();
            %>
            <td>
                <%=rs_cname.getString(1)%>  
            </td> 

            <%
                } else {
                         st2.executeUpdate("update  Other_Schools_" + given_session + "_" + given_year + " set " + elective + "='Null' ," + En_Grade + "='NR' where StudentID='" + student_id + "' ");
                       
    %>

            <td>
                None  
            </td> 
            <%}
                }
            %>

            <%    
                  grade_formula = request.getParameter("select1");
                    st2.executeUpdate("update  Other_Schools_" + given_session + "_" + given_year + " set Grade_Formula='" + grade_formula + "' where StudentID='" + student_id + "' ");

                   // System.out.println("grade : " + grade_formula);
                %>
                <td>
                    <%=grade_formula%>  
                </td> 

                <%}%>
        </table>
<table width="100%" class="pos_fixed">
                <tr>
                    <td align="center" class="border"> <input  type="button" class="border" value="Print" id="p1" style="width: 50px; color: white; background-color: #6d77d9; border-color: red;" class="noPrint" onclick="window.print();" />
                    </td>
                </tr>
            </table>
        <%
            conn.closeConnection();
            con = null;
            conn1.closeConnection();
            con1 = null;
        %>
    </body>
</html>
