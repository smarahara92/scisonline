<%-- 
    Document   : choose_ele_new_stored
--%>

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
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<jsp:useBean id="semtotal" class="com.hcu.scis.automation.ReadminList" scope="session">
 </jsp:useBean>
<jsp:useBean id="cgpa" class="com.hcu.scis.automation.GetCgpa" scope="session">
 </jsp:useBean>
<%@include file="connectionBean.jsp" %>
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
        Connection con = conn.getConnectionObj();
        Connection con1 = conn1.getConnectionObj();


        String given_session = request.getParameter("given_session");
        String given_year = request.getParameter("given_year");
        String stream = request.getParameter("stream");
        String stream_table = request.getParameter("stream_table");
        String curriculum = request.getParameter("curriculum");
        String currrefer = request.getParameter("currrefer_s");
        String program_name = request.getParameter("program_name");

        String total_cores = request.getParameter("total_cores");
        String total_ele = request.getParameter("total_ele");
        String course_count = request.getParameter("course_count");
        String current_cores = request.getParameter("current_cores");
        String optionalCore_count = request.getParameter("optionalCore_count");

        // course_count contains eletives count in the presnt semester for given stream.

        //System.out.println(stream);
        // System.out.println(stream_table);
        // System.out.println(currrefer);
        // System.out.println(total_cores);

        int total_cores_int = Integer.parseInt(total_cores);
        int total_ele_int = Integer.parseInt(total_ele);
        int course_count_int = Integer.parseInt(course_count);   //  #current electives
        int current_cores_int = Integer.parseInt(current_cores);  // # current cores
        int optionalCore_count_int = Integer.parseInt(optionalCore_count);

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
        Statement st4_old_ele1 = (Statement) con.createStatement();
        
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
        String sem1 = "I";
          int year1 = Integer.parseInt(given_year); 
          int year2 = year1;
        if (sub_2.equals("_I")) {
            sem1 = "I";
            sem = 1;
             year2 = year1;
        } else if (sub_2.equals("_V")) {
            sem1 = "V";
            sem = 5;
            year2 = year - 2;
        } else if (sub_2.equals("_X")) {
            sem1 = "X";
            sem = 10;
            year2 = year - 5;
        } else if (sub_3.equals("_IV")) {
            sem1 = "IV";
            sem = 4;
            year2 = year - 2;
        } else if (sub_3.equals("_II")) {
            sem1 = "II";
            sem = 2;
            year2 = year - 1;
        } else if (sub_3.equals("_VI")) {
            sem1 = "VI";
            sem = 6;
            year2 = year - 3;
        } else if (sub_3.equals("_IX")) {
            sem1 = "IX";
            sem = 9;
            year2 = year - 4;
        } else if (sub_4.equals("_III")) {
            sem1 = "III";
            sem = 3;
            year2 = year - 1;
        } else if (sub_4.equals("_VII")) {
            sem1 = "VII";
            sem = 7;
             year2 = year - 3;
        } else if (sub_5.equals("_VIII")) {
            sem1 = "VIII";
            sem = 8;
            year2 = year - 4;
        }

        ResultSet rs_ele_loc = (ResultSet) st2.executeQuery("select Electives, Cores,OptionalCore, Labs from " + currrefer);
       
        int ele_stop = 1, ele_start = 1, core_start = 1,lab_start=1,opt_start=1;  // ele_start has position from which we have to insert the electives, eg : ele3,ele4 for ai-ii
        while (rs_ele_loc.next()) {                      // core_start contains start position of cores in this semester for given stream.
            if (ele_stop < sem) {
                System.out.println("helooooooooooooooossssssssssssssssssssssss");
                ele_start = ele_start + rs_ele_loc.getInt(1);
                core_start = core_start + rs_ele_loc.getInt(2);
                opt_start = opt_start+rs_ele_loc.getInt(3);
                lab_start=lab_start+rs_ele_loc.getInt(4);
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


                for (i = 1; i <= (optionalCore_count_int); i++) {
            %> 
            <th class="style31" align="center" ><b>Optional Core<%=i%></b></th>




            <% }
                
                for (i = 1; i <= (course_count_int - optionalCore_count_int); i++) {
            %> 
            <th class="style31" align="center" ><b>Elective<%=i%></b></th>




            <% }
            %>



            <%

                int k = 1;
                int k1 = 0;
                ResultSet rs = null;
                if( sem > 1 )
                {
                     k1  = cgpa.getCgpa(stream_table, curriculum);
                      rs =  (ResultSet) st1.executeQuery("select * from " + stream_table +"_temp ORDER by cgpa DESC");
                }
                else
                {   
                    Statement st = con.createStatement();
                    rs  = st.executeQuery("select * from " + stream_table + "");
                }
                int totalsubjectsinsem = 0;
          //       while (rs15.next()) {
          //                      totalsubjectsinsem = totalsubjectsinsem + (rs15.getInt(2) + rs15.getInt(3) + rs15.getInt(4));
           //                     totalsubjectsinsem = (totalsubjectsinsem / 2);
           //                     System.out.println(totalsubjectsinsem);
         //           }
                    totalsubjectsinsem = semtotal.readminList(program_name, year2, sem);
                while (rs.next()) {
                    String student_id = rs.getString(1);
                    String student_name = rs.getString(2);
                    int core_start_live = core_start;
                    int ele_start_live = ele_start;
                    int optionalCore_start_live = opt_start;
// remove all the elective then freshly create, so that any modifycations in ele reg will be droped old one, and write new ones.                  
//$$$$$$$$$  check if alredy has taken electives from the master table.$$$$$$$$$$$$$$$$$$
                    
                    
            /*          ResultSetMetaData rsmd = rs.getMetaData();
                            int noOfColumns = rsmd.getColumnCount();
                            int temp2 = (noOfColumns - 2) / 2;
                            int i1 = 0;
                            int count = 0, count1 = temp2;
                            String failedsubjects[] = new String[30];
                            int fail = 0;


                            while (count1 > 0) {


                                int m = i1 + 3;
                                String F = "F";
                                if (F.equals(rs.getString(m + 1))) {

                                    failedsubjects[fail] = rs.getString(m);
                                    fail++;
                                    count++;
                                }
                                i1 = i1 + 2;
                                count1--;
                            }
                           //System.out.println(rs_studetails.getString(1)+" "+count+" "+totalsubjectsinsem);
                            if (count < totalsubjectsinsem ) {   
*/ 
                 //  take the coresponding electives like ele3, ele4 for m.tech-ai-ii  
                    for (int j = 1; j <= optionalCore_count_int; j++) {
                       // System.out.println(j+ " hjgsdaasd");
                      
                         ResultSet rs_old_ele1 = (ResultSet) st4_old_ele1.executeQuery("select optCore" + optionalCore_start_live + " from " + stream_table + "  where StudentId='" + student_id + "'");
                        optionalCore_start_live= optionalCore_start_live + 1;

                        if (rs_old_ele1.next()) {

                            String col_value = (String) rs_old_ele1.getString(1);
                            if (col_value != null && !col_value.isEmpty() && !col_value.equalsIgnoreCase("null")) {
                                System.out.println(j+ " hjgsdaasd");
                                st12.executeUpdate("DELETE FROM  " + col_value + "_Attendance_" + given_session + "_" + given_year + "  where StudentId='" + student_id + "'");
                                st14.executeUpdate("DELETE FROM  " + col_value + "_Assessment_" + given_session + "_" + given_year + "  where StudentId='" + student_id + "'");
                            }
                        }
                    }
                    System.out.println(course_count_int-optionalCore_count_int);
                    for (int j = 1; j <=( course_count_int-optionalCore_count_int); j++) {
                        ResultSet rs_old_ele = (ResultSet) st4_old_ele.executeQuery("select ele" + ele_start_live + " from " + stream_table + "  where StudentId='" + student_id + "'");
                        ele_start_live = ele_start_live + 1;

                        if (rs_old_ele.next()) {

                            String col_value = (String) rs_old_ele.getString(1);
                            if (col_value != null && !col_value.isEmpty() && !col_value.equalsIgnoreCase("null")) {
                                System.out.println(j+ " hjgsdaasd");
                                st12.executeUpdate("DELETE FROM  " + col_value + "_Attendance_" + given_session + "_" + given_year + "  where StudentId='" + student_id + "'");
                                st14.executeUpdate("DELETE FROM  " + col_value + "_Assessment_" + given_session + "_" + given_year + "  where StudentId='" + student_id + "'");
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
                    optionalCore_start_live = opt_start;
                    for (int j = 1; j <= course_count_int; j++) {
                        String sub = (String) request.getParameter("select" + j + Integer.toString(k));
                        int checking = 0;
                        /// get the names for corresponding subjcode.

                        String type = "E";

                        if (!sub.equals("none")) {

                            String subname = "";
                            Statement st = con.createStatement();
                            ResultSet rs1 = st.executeQuery("select Subject_Name,Type  from subjecttable where Code='" + sub + "'");
                            if (rs1.next()) {

                                subname = rs1.getString(1);

                                type = rs1.getString(2);
                            }


                            System.out.println("here :" + sub);

                            

                            st2.executeUpdate("create table if not exists " + sub + "_Attendance_" + given_session + "_" + given_year + "(StudentId varchar(20) not null,StudentName varchar(50)," + columns + "cumatten int(20),percentage float,primary key(StudentId))");
                            st13.executeUpdate("create table if not exists " + sub + "_Assessment_" + given_session + "_" + given_year + "(StudentId varchar(20) not null,StudentName varchar(50),Minor_1 varchar(5),Minor_2 varchar(5),Minor_3 varchar(5),Major varchar(5),Final varchar(5),InternalMarks varchar(5),TotalMarks varchar(5),primary key(StudentId))");

                            /// sending students to the respective attendance, assessment tables of electives.
                            try
                            {
                            st12.executeUpdate("insert into " + sub + "_Attendance_" + given_session + "_" + given_year + " (StudentId , StudentName) values('" + rs.getString(1) + "','" + rs.getString(2) + "')");
                            st14.executeUpdate("insert into " + sub + "_Assessment_" + given_session + "_" + given_year + " (StudentId , StudentName) values('" + rs.getString(1) + "','" + rs.getString(2) + "')");
                            }
                            catch( Exception e)
                            {
                                
                            }


                            // update electives in the master table of slected stream. so we need to know from which elective we have to start adding electives, eg : mtech-ai-ii we have to start from ele3 .
                            // update tablename set username='JACK', password='123' WHERE id='1';
                           if( optionalCore_count_int < j)
                            {
                            st4.executeUpdate("update " + stream_table + " set ele" + ele_start_live + " ='" + sub + "', e" + ele_start_live + "grade = 'R'   where StudentId='" + rs.getString(1) + "'");
                             ele_start_live = ele_start_live + 1;
                            }
                            else
                            {
                            st4.executeUpdate("update " + stream_table + " set optCore" + optionalCore_start_live + " ='" + sub + "', o" +optionalCore_start_live + "grade = 'R'   where StudentId='" + rs.getString(1) + "'");   
                            optionalCore_start_live = optionalCore_start_live+1;
                            }
                            
                           

                %>


                <td ><%=subname%></td> 


                <%



                } else {
                    if( optionalCore_count_int < j)
                    {
                    st4.executeUpdate("update " + stream_table + " set ele" + ele_start_live + " = 'null' , e" + ele_start_live + "grade = 'NR'   where StudentId='" + rs.getString(1) + "'");
                    ele_start_live = ele_start_live + 1;
                    }
                    else
                    {
                         st4.executeUpdate("update " + stream_table + " set optCore" + optionalCore_start_live + " = 'null', o" +optionalCore_start_live + "grade = 'R'   where StudentId='" + rs.getString(1) + "'");   
                            optionalCore_start_live = optionalCore_start_live+1;
                    }
                    
                    %> 
                   

                

                <td align="center" > <p class="style30"> None</p></td> 

                <%      }
                    }

                        

/// for core as R
                        for (int ii = 0; ii < current_cores_int; ii++) {
                            st4.executeUpdate("update " + stream_table + " set  c" + core_start_live + "grade = 'R'   where StudentId='" + rs.getString(1) + "'");
                            System.out.println("hii"+core_start_live);
                           core_start_live = core_start_live + 1;

                        }
                    
                    
                    // for labs as R
           
                    Statement st_lab = (Statement) con.createStatement();
                    
                    ResultSet rs_ele_loc2 = (ResultSet) st_lab.executeQuery("select Labs from " + currrefer+ " where Semester='"+sem1+"'" );
                    int current_labs_int=0;
                    if(rs_ele_loc2.next()){
                    current_labs_int=rs_ele_loc2.getInt(1);
                    }
                    int lab_start_live=lab_start;
                    System.out.println("sem "+sem + stream +"labs "+current_labs_int+" start at "+lab_start_live);
                     for (int jj = 0; jj < current_labs_int; jj++) {
                          //System.out.println("jfdvyadgawkfvb");
                            st4.executeUpdate("update " + stream_table + " set  l" +lab_start_live + "grade = 'R'   where StudentId='" + rs.getString(1) + "'");
                            lab_start_live = lab_start_live+1;

                        }
                    
                   //  st4.executeUpdate("update " + stream_table + " set  p1grade = 'R'   where StudentId='" + rs.getString(1) + "'");
                         
                    

                        k++;
           //     }
                    }
                System.out.println("K1 value is: " +k1);
                if( k1 ==1)                {
                    cgpa.dropTable(stream_table);
                }
// mark for this session,year ele registration is done
    Statement st = con.createStatement();
    st.executeUpdate("update  session_course_registration set registration='yes' where session='"+given_session+"' and year='"+given_year+"'" );
                        


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
        <%
            conn.closeConnection();
            con = null;
            conn1.closeConnection();
            con1 = null;
        %>
            </body>
            </html>