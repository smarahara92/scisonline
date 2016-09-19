<%-- 
    Document   : choose_ele_new_stored
    Created on : Nov 8, 2013, 2:02:42 PM
    Author     : sri
--%>
<%@include file="checkValidity.jsp"%>
<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@page import="java.io.OutputStream"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.GregorianCalendar"%>
<%@page import="java.io.File"%>
<%@page import="com.hcu.mysql.connection.ConnectionDemo3"%>
<%@page import="com.hcu.mysql.connection.ConnectionDemo1"%>
<%@page import="com.hcu.mysql.connection.ConnectionDemo"%>
<%@page import="java.sql.*"%>
<%@page import="com.mysql.jdbc.Statement"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@include file="dbconnection.jsp" %>
<%@include file="checkValidity.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>


        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title></title>
    </script> 

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

<body bgcolor="#CCFFFF">


    <%


        String given_session = request.getParameter("given_session");
        String given_year = request.getParameter("given_year");
        String stream = request.getParameter("stream");
        String stream_table = request.getParameter("stream_table");
        String curriculum = request.getParameter("curriculum");
        String currrefer = request.getParameter("currrefer_s");

        String total_cores = request.getParameter("total_cores");
        String total_ele = request.getParameter("total_ele");
        String course_count = request.getParameter("course_count");
        String current_cores = request.getParameter("current_cores");

        // course_count contains eletives count in the presnt semester for given stream.

        //System.out.println(stream);
        // System.out.println(stream_table);
        // System.out.println(currrefer);
        // System.out.println(total_cores);

        int total_cores_int = Integer.parseInt(total_cores);
        int total_ele_int = Integer.parseInt(total_ele);
        int course_count_int = Integer.parseInt(course_count);   //  #current electives
        int current_cores_int = Integer.parseInt(current_cores);  // # current cores


        // System.out.println("no of cores current:" + current_cores);
        Calendar now = Calendar.getInstance();

        System.out.println("Current date : " + (now.get(Calendar.MONTH) + 1)
                + "-"
                + now.get(Calendar.DATE)
                + "-"
                + now.get(Calendar.YEAR));

        int year = Integer.parseInt(given_year);
        Statement st1 = (Statement) con.createStatement();
        Statement st2 = (Statement) con.createStatement();
        Statement st3 = (Statement) con.createStatement();
        Statement st4 = (Statement) con.createStatement();
        Statement st5 = (Statement) con.createStatement();
        Statement st12 = (Statement) con.createStatement();

        Statement st13 = (Statement) con1.createStatement();
        Statement st14 = (Statement) con1.createStatement();


        // for removing old ele tables
        Statement st12_old_ele = (Statement) con.createStatement();
        Statement st4_old_ele = (Statement) con.createStatement();

        Statement st13_old_ele = (Statement) con1.createStatement();
       





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
        try {
            if (finding == 0) {
                throw new Exception();
            }
        } catch (Exception e) {
            out.println("<center><h2>please enter sem duration first</h2></center>");
            return;
        }

        /// insert electives in the master table of slected stream. so we need to know from which elective we have to start adding electives, eg : mtech-ai-ii we have to start from ele3 .
        // electives start location. we can get it from location=total_ele-(number of electives done till this semester)

        int len = stream.length();
        int sem = 0;
        String sub_2 = (stream).substring(len - 2, len);  // MTech-CS-I OR -V, -AI-I OR -V, MCA-I OR -V,
        String sub_3 = (stream).substring(len - 3, len);  // -II, -IV, -VI ..etc
        String sub_4 = (stream).substring(len - 4, len);   // -III , -IIV , etc
        String sub_5 = (stream).substring(len - 5, len);    // mostly no need.

        if (sub_2.equals("_I")) {
            sem = 1;
        } else if (sub_2.equals("_V")) {
            sem = 5;
        } else if (sub_2.equals("_X")) {
            sem = 10;
        } else if (sub_3.equals("_IV")) {
            sem = 4;
        } else if (sub_3.equals("_II")) {
            sem = 2;
        } else if (sub_3.equals("_VI")) {
            sem = 6;
        } else if (sub_3.equals("_IX")) {
            sem = 9;
        } else if (sub_4.equals("_III")) {
            sem = 3;
        } else if (sub_4.equals("_VII")) {
            sem = 7;
        } else if (sub_5.equals("_VIII")) {
            sem = 8;
        }

        ResultSet rs_ele_loc = (ResultSet) st2.executeQuery("select Electives, Cores, Labs from " + currrefer);
       
        int ele_stop = 1, ele_start = 1, core_start = 1,lab_start=1;  // ele_start has position from which we have to insert the electives, eg : ele3,ele4 for ai-ii
        while (rs_ele_loc.next()) {                      // core_start contains start position of cores in this semester for given stream.
            if (ele_stop < sem) {
                System.out.println("helooooooooooooooossssssssssssssssssssssss");
                ele_start = ele_start + rs_ele_loc.getInt(1);
                core_start = core_start + rs_ele_loc.getInt(2);
                lab_start=lab_start+rs_ele_loc.getInt(3);
            } else {
                rs_ele_loc.afterLast();
            }
            ele_stop = ele_stop + 1;
        }
         System.out.println("helooooooooooooooossssssssssssssssssssssss lab start :"+lab_start);
        


        System.out.println("no of cores current:" + current_cores_int);
        System.out.println("ele start here:" + ele_start);
        System.out.println("cores start here:" + core_start);
        //  System.out.println("ele total here:" + total_ele);        // total eles
        //System.out.println("cores total here:" + total_cores);  // total cores





        /// sending students to the respective attendance, assessment tables of electives.
        /// mark R for cores of this batch in stream_table, and R for electives.
%>

    <form action="choose_ele_new_stored.jsp" name="ele_form" id="ele_form">
        <center><h2 class="style30">Registration done</h2></center>

        <table align="center" border="1"><!-- class="table_pos"-->



            <th class="style31" align="center"><b>Student ID</b></th>
            <th class="style31" align="center"><b>Student Name</b></th>

            <% int i;
                // int len = 150;


                // remove all the elective then freshly create, so that any modifycations in ele reg will be droped old one, and write new ones.
    /*              ResultSet rs_old_ele = (ResultSet) st2.executeQuery("select course_name from " + given_year+"_"+given_session+"_elective");
                 while(rs_old_ele.next()){
                  
                 String old_sub=rs_old_ele.getString(1);
                  
                 st12_old_ele.executeUpdate("drop table if  exists " + old_sub + "_Attendance_" + given_session + "_" + given_year );
                 st13_old_ele.executeUpdate("drop table if  exists " + old_sub + "_Assessment_" + given_session + "_" + given_year );
          
                 }  // old ele deletion is over 
                 */


                for (i = 1; i <= course_count_int; i++) {
            %> 
            <th class="style31" align="center" ><b>Elective<%=i%></b></th>




            <% }
            %>



            <%

                int k = 1;
                ResultSet rs = (ResultSet) ConnectionDemo.getStatementObj().executeQuery("select * from " + stream_table + "");
                while (rs.next()) {
                    String student_id = rs.getString(1);
                    String student_name = rs.getString(2);
                    int core_start_live = core_start;
                    int ele_start_live = ele_start;
// remove all the elective then freshly create, so that any modifycations in ele reg will be droped old one, and write new ones.                  
//$$$$$$$$$  check if alredy has taken electives from the master table.$$$$$$$$$$$$$$$$$$

                 //  take the coresponding electives like ele3, ele4 for m.tech-ai-ii  
                    for (int j = 1; j <= course_count_int; j++) {
                        ResultSet rs_old_ele = (ResultSet) st4_old_ele.executeQuery("select ele" + ele_start_live + " from " + stream_table + "  where StudentId='" + student_id + "'");
                        ele_start_live = ele_start_live + 1;

                        if (rs_old_ele.next()) {

                            String col_value = (String) rs_old_ele.getString(1);
                            if (col_value != null && !col_value.isEmpty() && !col_value.equalsIgnoreCase("null")) {
                                try
                                {
                                st12.executeUpdate("DELETE FROM  " + col_value + "_Attendance_" + given_session + "_" + given_year + "  where StudentId='" + student_id + "'");
                                st14.executeUpdate("DELETE FROM  " + col_value + "_Assessment_" + given_session + "_" + given_year + "  where StudentId='" + student_id + "'");
                                }
                                catch(Exception e)
                                {
                                    
                                }
                            }
                        }
                    }







            %>
            <tr>

                <td align="center"><b><%=student_id%></b></td> 
                <td ><b><%=student_name%></b></td> 
                <%
                    core_start_live = core_start;
                    ele_start_live = ele_start;

                    for (int j = 1; j <= course_count_int; j++) {
                        String sub = (String) request.getParameter("select" + j + Integer.toString(k));
                        int checking = 0;
                        /// get the names for corresponding subjcode.



                        if (!sub.equals("none")) {

                            String subname = "";
                            ResultSet rs1 = (ResultSet) ConnectionDemo.getStatementObj().executeQuery("select Subject_Name  from subjecttable where Code='" + sub + "'");
                            if (rs1.next()) {

                                subname = rs1.getString(1);


                            }


                            System.out.println("here :" + sub);



                            st2.executeUpdate("create table if not exists " + sub + "_Attendance_" + given_session + "_" + given_year + "(StudentId varchar(20) not null,StudentName varchar(50)," + columns + "cumatten int(20),percentage float,primary key(StudentId))");
                            st13.executeUpdate("create table if not exists " + sub + "_Assessment_" + given_session + "_" + given_year + "(StudentId varchar(20) not null,StudentName varchar(50),Minor_1 varchar(5),Minor_2 varchar(5),Minor_3 varchar(5),Major varchar(5),Final varchar(5),InternalMarks varchar(5),TotalMarks varchar(5),primary key(StudentId))");

                            /// sending students to the respective attendance, assessment tables of electives.
                            st12.executeUpdate("insert into " + sub + "_Attendance_" + given_session + "_" + given_year + " (StudentId , StudentName) values('" + rs.getString(1) + "','" + rs.getString(2) + "')");
                            st14.executeUpdate("insert into " + sub + "_Assessment_" + given_session + "_" + given_year + " (StudentId , StudentName) values('" + rs.getString(1) + "','" + rs.getString(2) + "')");


                            // update electives in the master table of slected stream. so we need to know from which elective we have to start adding electives, eg : mtech-ai-ii we have to start from ele3 .
                            // update tablename set username='JACK', password='123' WHERE id='1';

                            st4.executeUpdate("update " + stream_table + " set ele" + ele_start_live + " ='" + sub + "', e" + ele_start_live + "grade = 'R'   where StudentId='" + rs.getString(1) + "'");
                            ele_start_live = ele_start_live + 1;

                %>


                <td ><%=subname%></td> 


                <%



                } else {
                    st4.executeUpdate("update " + stream_table + " set ele" + ele_start_live + " = 'null' , e" + ele_start_live + "grade = 'NR'   where StudentId='" + rs.getString(1) + "'");
                    ele_start_live = ele_start_live + 1;

                %> 

                <td align="center" > <p class="style30"> None</p></td> 

                <%                               }

                        }

/// for core as R
                        for (int ii = 0; ii < current_cores_int; ii++) {
                            st4.executeUpdate("update " + stream_table + " set  c" + core_start_live + "grade = 'R'   where StudentId='" + rs.getString(1) + "'");
                            core_start_live = core_start_live + 1;

                        }
                    
                    
                    // for labs as R
           
                    Statement st_lab = (Statement) con.createStatement();
                    
                    ResultSet rs_ele_loc2 = (ResultSet) st_lab.executeQuery("select Labs from " + currrefer+ " where Semester='sem"+sem+"'" );
                    int current_labs_int=0;
                    if(rs_ele_loc2.next()){
                    current_labs_int=rs_ele_loc2.getInt(1);
                    }
                    int lab_start_live=lab_start;
                    System.out.println("sem "+sem+"labs "+current_labs_int+" start at "+lab_start_live);
                     for (int jj = 0; jj < current_labs_int; jj++) {
                            st4.executeUpdate("update " + stream_table + " set  l" +lab_start_live + "grade = 'R'   where StudentId='" + rs.getString(1) + "'");
                            lab_start_live = lab_start_live+1;

                        }
                    
                   //  st4.executeUpdate("update " + stream_table + " set  p1grade = 'R'   where StudentId='" + rs.getString(1) + "'");
                         
                    

                        k++;
                    }

// mark for this session,year ele registration is done
                
    ConnectionDemo.getStatementObj().executeUpdate("update  session_course_registration set registration='yes' where session='"+given_session+"' and year='"+given_year+"'" );
                        


                %>


            <table>
                <tr><td>&nbsp;</td></tr>
                <tr><td>&nbsp;</td></tr>
                <tr><td>&nbsp;</td></tr>


            </table>


            <table width="100%" class="pos_fixed">
                <tr>
                    <td align="center" class="border"> <input  type="button" class="border" value="Print" id="p1" style="width: 50px; color: white; background-color: #6d77d9; border-color: red;" class="noPrint" onclick="window.print();" />
                    </td>
                </tr>
            </table>

<%   // add this code at the last of you code. :) it will close all unwanted connections in the database with single shot.
            Statement stmt_close =(Statement) con.createStatement();
            Statement stmt3_close =(Statement) con.createStatement();
            ResultSet rs_close = (ResultSet) stmt_close.executeQuery("SHOW PROCESSLIST");
            while (rs_close.next()) {
                // System.out.println(rs_2.getString("Host"));
                //System.out.println(rs_close.getString("Id") + " and state is :" + rs_close.getString("Command"));
                //System.out.println(rs_2.getString("State"));
                if (rs_close.getString("Command").equalsIgnoreCase("sleep")) {
                    ResultSet rs_3 = (ResultSet) stmt3_close.executeQuery("KILL " + rs_close.getString("Id"));
                }
            }

        %>
            </body>
            </html>