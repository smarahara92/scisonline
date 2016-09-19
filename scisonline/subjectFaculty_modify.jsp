<%-- 
    Document   : subjectFaculty_modify
    Note : This page is not being used. Its replacement page is
            "course_allocation_modify_submit.jsp". After test it can be deleted.
--%>
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

        <script type="text/javascript">

            function check()
            {
                var var2=document.getElementsByTagName('input');
                //alert(var2[0].value);
	
                for(var i=0; i<var2.length-1; i++)
                {
                    if(var2[i].type =='text')
                    {
                        var var1 = var2[i].value;
                        if(isNaN(var1) || var1=='') 
                        { 
                            alert("Error: Please enter the correct number!");
                            var2[i].select();
                            var2[i].focus();
                            return false; 
                        }
                    }
                }
                return true;
            }

            function select(temp)
            {
                document.getElementById(temp).select();
            }
        </script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Assign Ellectives to Streams</title>
        <style>
            .style30 {color: #c2000d}
            .style31 {color: white}
            .style32 {color: green}
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
                position:fixed;
                background-color: #c2000d;
            }
        </style>
    </head>
    <body bgcolor="#CCFFFF">
        <form name="frm1" >
            <%
                String given_session = request.getParameter("given_session");
                String given_year = request.getParameter("given_year");
                String cores_status = "";
                Calendar now = Calendar.getInstance();

                System.out.println("Current date : " + (now.get(Calendar.MONTH) + 1)
                        + "-"
                        + now.get(Calendar.DATE)
                        + "-"
                        + now.get(Calendar.YEAR));
                // int month = now.get(Calendar.MONTH) + 1;
                int year = Integer.parseInt(given_year);
                // String semester = "";

                //String current_session =request.getParameter("current_session");
                //String startdate = request.getParameter("startdate");
                //String enddate = request.getParameter("enddate");
                Statement st1 = (Statement) con.createStatement();
                Statement st2 = (Statement) con.createStatement();
                Statement st3 = (Statement) con.createStatement();
                Statement st4 = (Statement) con.createStatement();
                Statement st5 = (Statement) con.createStatement();
                //System.out.println(startdate+"  laxman  "+enddate +"lll"+current_session);
                try {
                    // if(startdate.equals("")==false && enddate.equals("")==false)
                    // {
                    // st1.executeUpdate("insert into session values('"+current_session+"','"+startdate+"','"+enddate+"')");
                    st1.executeUpdate("drop table if exists  subject_faculty_" + given_session + "_" + given_year);
                    st1.executeUpdate("create table if not exists  subject_faculty_" + given_session + "_" + given_year + "(subjectid varchar(20),facultyid1 varchar(20),facultyid2 varchar(20),primary key(subjectId))");

                    // you should not drop the elective table.

                    //st1.executeUpdate("drop table if exists " + given_year + "_" + given_session + "_elective_temp");
                    //st1.executeUpdate("create table if not exists " + given_year + "_" + given_session + "_elective_temp(course_name	varchar(50),MCA_I int(11),MCA_II int(11),MCA_III int(11),MCA_IV int(11),MCA_V int(11),MCA_VI int(11),MTech_CS_I	int(11),MTech_CS_II int(11),MTech_CS_III int(11),MTech_CS_IV int(11),MTech_AI_I	int(11),MTech_AI_II int(11),MTech_AI_III int(11),MTech_AI_IV int(11),MTech_IT_I int(11),MTech_IT_II int(11),MTech_IT_III int(11),MTech_IT_IV int(11),pre_req_1 varchar(45),pre_req_grade1 varchar(2),pre_req_2 varchar(45),pre_req_grade2 varchar(2),primary key(course_name))");
                    // st1.executeUpdate("drop table if exists " + given_year + "_" + given_session + "_elective_temp2");
                    //st1.executeUpdate("create table if not exists " + given_year + "_" + given_session + "_elective_temp2(course_name	varchar(50),MCA_I int(11),MCA_II int(11),MCA_III int(11),MCA_IV int(11),MCA_V int(11),MCA_VI int(11),MTech_CS_I	int(11),MTech_CS_II int(11),MTech_CS_III int(11),MTech_CS_IV int(11),MTech_AI_I	int(11),MTech_AI_II int(11),MTech_AI_III int(11),MTech_AI_IV int(11),MTech_IT_I int(11),MTech_IT_II int(11),MTech_IT_III int(11),MTech_IT_IV int(11),pre_req_1 varchar(45),pre_req_grade1 varchar(2),pre_req_2 varchar(45),pre_req_grade2 varchar(2),primary key(course_name))");

                    //$$$$$$$$$$$$$$ elective table creation $$$$$$$$$$$$$$$$$$$$

                    DatabaseMetaData md = con.getMetaData();
                    //ResultSet rs_2 = (ResultSet)md.getTables(null, null,""+given_year+"_"+given_session+"_elective", null);
                    String ele_all_courses = ""; // contains all ele strems eg: MCA_I,MCA_II,MCA_III,MCA_IV,MCA_V,MCA_VI
                    String default_limits = "";//0,0,0,..

                    // ResultSet rs_ele_d2 = md.getTables(null, null, " + given_year + "_" + given_session + "_elective, null);

                    //   // table not found
                    st1.executeUpdate("drop table if exists " + given_year + "_" + given_session + "_elective_temp");
                    st1.executeUpdate("drop table if exists " + given_year + "_" + given_session + "_elective_temp2");
                    Statement st20_ele_dyn = (Statement) con.createStatement();
                    Statement st20_ele_dyn2 = (Statement) con.createStatement();
                    st20_ele_dyn.executeUpdate("create table if not exists " + given_year + "_" + given_session + "_elective_temp(course_name varchar(50),primary key(course_name))");
                    st20_ele_dyn.executeUpdate("create table if not exists " + given_year + "_" + given_session + "_elective_temp2(course_name varchar(50),primary key(course_name))");

                    Statement st_ele_dyn = (Statement) con.createStatement();
                    ResultSet rs_ele_dyn = (ResultSet) st20_ele_dyn2.executeQuery("select * from " + given_session + "_stream where electives='yes'");

                    while (rs_ele_dyn.next()) {

                        st20_ele_dyn.executeUpdate("ALTER TABLE " + given_year + "_" + given_session + "_elective_temp  ADD " + rs_ele_dyn.getString(1).replace('-', '_') + " INT(11)");
                        st20_ele_dyn.executeUpdate("ALTER TABLE " + given_year + "_" + given_session + "_elective_temp2  ADD " + rs_ele_dyn.getString(1).replace('-', '_') + " INT(11)");


                        ele_all_courses = ele_all_courses + " , " + rs_ele_dyn.getString(1).replace('-', '_');
                        default_limits = default_limits + ", 0";
                    }
                    //rs_ele_dyn.last();
                    st20_ele_dyn.executeUpdate("ALTER TABLE " + given_year + "_" + given_session + "_elective_temp  ADD pre_req_1 varchar(45)");
                    st20_ele_dyn.executeUpdate("ALTER TABLE " + given_year + "_" + given_session + "_elective_temp  ADD pre_req_grade1 varchar(2) ");
                    st20_ele_dyn.executeUpdate("ALTER TABLE " + given_year + "_" + given_session + "_elective_temp  ADD pre_req_2 varchar(45)");
                    st20_ele_dyn.executeUpdate("ALTER TABLE " + given_year + "_" + given_session + "_elective_temp  ADD pre_req_grade2 varchar(2)");

                    st20_ele_dyn.executeUpdate("ALTER TABLE " + given_year + "_" + given_session + "_elective_temp2  ADD pre_req_1 varchar(45)");
                    st20_ele_dyn.executeUpdate("ALTER TABLE " + given_year + "_" + given_session + "_elective_temp2  ADD pre_req_grade1 varchar(2) ");
                    st20_ele_dyn.executeUpdate("ALTER TABLE " + given_year + "_" + given_session + "_elective_temp2  ADD pre_req_2 varchar(45)");
                    st20_ele_dyn.executeUpdate("ALTER TABLE " + given_year + "_" + given_session + "_elective_temp2  ADD pre_req_grade2 varchar(2)");



                    ///  $$$ elective table over here



                    Statement st25 = (Statement) con.createStatement();


                    int k = 1;
                    ResultSet rs = (ResultSet) ConnectionDemo.getStatementObj().executeQuery("select * from faculty_data order by Faculty_Name");
                    while (rs.next()) {
                        for (int j = 1; j < 4; j++) {
                            String sub = (String) request.getParameter("select" + j + Integer.toString(k));
                            String s = (String) request.getParameter("s" + j + Integer.toString(k));
                            String check = (String) request.getParameter("check" + j + Integer.toString(k));
                            System.out.println(sub + "   " + s + "   " + check);
                            //String type     = (String)request.getParameter("s"+j+"stream"+Integer.toString(k));
                            //System.out.println(rs.getString(1)+" "+sub);
                            int checking = 0;
                            try {
                                ResultSet rs50 = (ResultSet) st25.executeQuery("select * from subject_faculty_" + given_session + "_" + given_year + "");
                                while (rs50.next()) {
                                    if (sub.equals(rs50.getString(1)) && !sub.equals("none") && rs50.getString(2) != null) {
                                        checking = 1;
                                    }

                                }
                                // System.out.println("checking is"+checking);                          
                                if (checking != 1) {
                                    if (!sub.equals("none")) {
                                        st2.executeUpdate("insert into subject_faculty_" + given_session + "_" + given_year + " values('" + sub + "', '" + rs.getString(1) + "',NULL)");
                                    }
                                } else {
                                    st2.executeUpdate("update subject_faculty_" + given_session + "_" + given_year + " set facultyid2='" + rs.getString(1) + "' where subjectid='" + sub + "'");
                                }
                                if (!sub.equals("none") && (s.equals("E") || s.equals("O") && checking != 1 || (s.equals("C") && check != null))) {
                                    // dont make it nulls in the modifcation, since we modify elective tables seperately. we need to maintain these table data.
                                   // st3.executeUpdate("insert into " + given_year + "_" + given_session + "_elective_temp(course_name,MCA_I,MCA_II,MCA_III,MCA_IV,MCA_V,MCA_VI,MTech_CS_I,MTech_CS_II,MTech_CS_III,MTech_CS_IV,MTech_AI_I,MTech_AI_II,MTech_AI_III,MTech_AI_IV,MTech_IT_I,MTech_IT_II,MTech_IT_III,MTech_IT_IV) values('" + sub + "',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0)");
                                    // System.out.println("laxman");   
                                     st3.executeUpdate("insert into " + given_year + "_" + given_session + "_elective_temp(course_name "+ ele_all_courses+") values('" + sub + "'"+default_limits+")");
                                                                   			
                                }
                  
                            } catch (Exception e) {
                                e.printStackTrace();
                            }
                        }
                        k++;
                    }







                    // logic to maintain previous stream limits.


                    Statement st_ele1 = (Statement) con.createStatement();
                    Statement st_ele2 = (Statement) con.createStatement();

                    ResultSet rs_ele1 = (ResultSet) st_ele1.executeQuery("select * from " + given_year + "_" + given_session + "_elective");
                    ResultSet rs_ele2 = (ResultSet) st_ele2.executeQuery("select * from " + given_year + "_" + given_session + "_elective_temp");

                    while (rs_ele2.next()) {
                        int find = 0;
                        while (rs_ele1.next()) {
                            if (rs_ele2.getString(1).equals(rs_ele1.getString(1))) {

                                st3.executeUpdate("insert into " + given_year + "_" + given_session + "_elective_temp2  select * from " + given_year + "_" + given_session + "_elective where course_name='" + rs_ele1.getString(1) + "'");
                                find = 1;
                                //break;
                            }
                        }
                        if (find == 0) {
                            st3.executeUpdate("insert into " + given_year + "_" + given_session + "_elective_temp2   select * from " + given_year + "_" + given_session + "_elective_temp where course_name='" + rs_ele2.getString(1) + "'");

                        }
                        rs_ele1.beforeFirst();

                    }

                    st1.executeUpdate("drop table if exists " + given_year + "_" + given_session + "_elective");
                    //st1.executeUpdate("create table if not exists " + given_year + "_" + given_session + "_elective(course_name varchar(50),MCA_I int(11),MCA_II int(11),MCA_III int(11),MCA_IV int(11),MCA_V int(11),MCA_VI int(11),MTech_CS_I	int(11),MTech_CS_II int(11),MTech_CS_III int(11),MTech_CS_IV int(11),MTech_AI_I	int(11),MTech_AI_II int(11),MTech_AI_III int(11),MTech_AI_IV int(11),MTech_IT_I int(11),MTech_IT_II int(11),MTech_IT_III int(11),MTech_IT_IV int(11),pre_req_1 varchar(45),pre_req_grade1 varchar(2),pre_req_2 varchar(45),pre_req_grade2 varchar(2),primary key(course_name))");
                    
                        Statement st20_ele_dyn_f = (Statement) con.createStatement();
                        Statement st20_ele_dyn2_f = (Statement) con.createStatement();
                        st20_ele_dyn_f.executeUpdate("create table if not exists " + given_year + "_" + given_session + "_elective(course_name varchar(50),primary key(course_name))");
                        Statement st_ele_dyn_f = (Statement) con.createStatement();
                        ResultSet rs_ele_dyn_f = (ResultSet) st20_ele_dyn2_f.executeQuery("select * from " + given_session + "_stream where electives='yes'");

                        while (rs_ele_dyn_f.next()) {

                            st20_ele_dyn_f.executeUpdate("ALTER TABLE " + given_year + "_" + given_session + "_elective  ADD " + rs_ele_dyn_f.getString(1).replace('-','_') + " INT(11)");

                        }
                        //rs_ele_dyn.last();
                        st20_ele_dyn_f.executeUpdate("ALTER TABLE " + given_year + "_" + given_session + "_elective  ADD pre_req_1 varchar(45)");
                        st20_ele_dyn_f.executeUpdate("ALTER TABLE " + given_year + "_" + given_session + "_elective  ADD pre_req_grade1 varchar(2) ");
                        st20_ele_dyn_f.executeUpdate("ALTER TABLE " + given_year + "_" + given_session + "_elective  ADD pre_req_2 varchar(45)");
                        st20_ele_dyn_f.executeUpdate("ALTER TABLE " + given_year + "_" + given_session + "_elective  ADD pre_req_grade2 varchar(2)");
                     
                    
                    
                    
                    
                    // copy temp2 to original table. so that previous stream limits wont effect and newly added electives will come to orinal ele-table

                    st3.executeUpdate("insert into " + given_year + "_" + given_session + "_elective   select * from " + given_year + "_" + given_session + "_elective_temp2");


                    // drop un necessary tables.
                    st1.executeUpdate("drop table if exists " + given_year + "_" + given_session + "_elective_temp");
                    st1.executeUpdate("drop table if exists " + given_year + "_" + given_session + "_elective_temp2");





                    // check all cores are allocated or not

                    //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$4//

                    String sub_code[] = new String[100];
                    String sub_name[] = new String[100];
                    String un_allocated_codes[] = new String[100];
                    String un_allocated_names[] = new String[100];
                    int i = 0, count = 0;

                    Statement st_dup1 = (Statement) con.createStatement();
                    Statement st_dup2 = (Statement) con.createStatement();
                    Statement st_dup3 = (Statement) con.createStatement();

                    ResultSet rs_dup1 = (ResultSet) st_dup1.executeQuery("select * from " + given_session + "_stream");  // sub code, sub name
                    while (rs_dup1.next()) {

                        System.out.println(rs_dup1.getString(1));
                        // get the subcode, name of all subjects for given stream like MTech-AI-I ( psm,krr,etc) , MTech-CS-I .. etc 
                        ResultSet rs_dup2 = (ResultSet) st_dup2.executeQuery("select subjId, subjName from subject_data where semester='" + rs_dup1.getString(1) + "'");

                        System.out.println("no upto here1");
                        while (rs_dup2.next()) {

                            sub_code[i] = rs_dup2.getString(1);
                            sub_name[i] = rs_dup2.getString(2);

                            // System.out.println("$$$$$$$$$$ cores here  $$$$$$$: ");
                            //System.out.println(sub_code[i]+sub_name[i]  );
                            i++;
                            count++;

                        }

                        rs_dup2.beforeFirst();
                        // System.out.println("no upto here2");
                    }

                    // now compare to list that we selected in the browser with list must be allocated(above list).

                    int found = 0, j = 0;
                    ResultSet rs_dup3 = (ResultSet) st_dup3.executeQuery("select subjectid from subject_faculty_" + given_session + "_" + given_year + "");
                    System.out.println("camparision here with count" + count);


                    for (i = 0; i < count; i++) {
                        while (rs_dup3.next()) {
                            found = 0;
                            System.out.println("cores array :" + sub_code[i]);
                            System.out.println("strem table :" + rs_dup3.getString(1));

                            if (sub_code[i].equalsIgnoreCase(rs_dup3.getString(1))) {

                                found = 1;
                                break;
                            }
                        }
                        rs_dup3.beforeFirst();
                        if (found == 0 && !( sub_name[i].contains("Project"))) {
                            un_allocated_codes[j] = sub_code[i];
                            un_allocated_names[j] = sub_name[i];
                            j = j + 1;
                            System.out.println("no upto here3");

                        }

                    }
                    // j=0 its for testing only, after testing remove j=0 stamt
                   j = 0;
                    if (j != 0) {

                        cores_status = "NO";
                        st1.executeUpdate("drop table if exists coretest_subject_faculty_" + given_session + "_" + given_year + "");
                        st1.executeUpdate("create table if not exists coretest_subject_faculty_" + given_session + "_" + given_year + "(subjectid varchar(20),facultyid1 varchar(20),facultyid2 varchar(20),primary key(subjectId))");
                        st1.executeUpdate("insert into coretest_subject_faculty_" + given_session + "_" + given_year + "   select * from subject_faculty_" + given_session + "_" + given_year);
                        st1.executeUpdate("drop table if exists subject_faculty_" + given_session + "_" + given_year + "");

            %>
            <center><h1> Allocation was not done </h1></center>
            <h3>Reason : The fallowing core subjects are not been allocated .</h3>                                             
            <%

                for (int p = 0; p < j; p++) {
                    String display = un_allocated_names[p];
            %>

            <br> <%=display%> <br>

            <%
                }%>

            <center><h4> press check button to allocate above list</h4></center><br>
            <center>   <input type="button" name="check" value="check" onclick="fun();"> </center>



            <%


            } else {

                cores_status = "YES";
















                //******************************************************************************

                Statement st6 = (Statement) con.createStatement();
                Statement st7 = (Statement) con.createStatement();
                Statement st8 = (Statement) con.createStatement();
                Statement st9 = (Statement) con.createStatement();
                Statement st12 = (Statement) con.createStatement();
                Statement st10 = (Statement) con.createStatement();
                Statement st13 = (Statement) con1.createStatement();
                Statement st11 = (Statement) con1.createStatement();
                Statement st1_prgm = (Statement) con.createStatement();
                Statement st2_prgm = (Statement) con.createStatement();


                // String session_date = startdate;
                //String saveFile=(String)request.getAttribute("filename");
      //          try {

                    Statement st30 = (Statement) con.createStatement();
                    ResultSet rs30 = (ResultSet) st30.executeQuery("select * from session where name ='" + given_session + "'");
                    String startdate = "";
                    String enddate = "";
                    String columns = "";
                    int stm = 0, em = 0, sd = 0, ed = 0, finding = 0, gap = 0;

                    while (rs30.next()) {
                        finding = 1;

                        startdate = rs30.getDate(2).toString();
                        enddate = rs30.getDate(3).toString();
                        String table_year = (startdate.substring(0, 4));
                        String table_session = rs30.getString(1);

                        String session_year = table_session + table_year;
                        System.out.println("table " + session_year + " given " + given_session + given_year);
                        if (session_year.equalsIgnoreCase(given_session + given_year)) {
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

                    String day = "2";

                    //******************************************************************************starts here************************************************************
                    st12.executeUpdate("drop table if exists subject_attendance_" + given_session + "_" + given_year + "");
                    st12.executeUpdate("create table if not exists subject_attendance_" + given_session + "_" + given_year + "(subjectId varchar(20)," + columns + "cumatten int(20),primary key(subjectId))");


                    //dropping current semester tables if it already exists;
                    //Attendance tables
                    ResultSet rs10 = (ResultSet) st10.executeQuery("show tables like '%_Attendance_" + given_session + "_" + given_year + "'");

                    while (rs10.next()) {
                        st12.executeUpdate("drop table " + rs10.getString(1) + "");

                    }
                    //Assessment tables
                    ResultSet rs11 = (ResultSet) st11.executeQuery("show tables like '%_Assessment_" + given_session + "_" + given_year + "'");

                    while (rs11.next()) {
                        st13.executeUpdate("drop table " + rs11.getString(1) + "");

                    }

                    ResultSet rs3 = (ResultSet) st7.executeQuery("select subjectid from subject_faculty_" + given_session + "_" + given_year + "");

                    while (rs3.next()) {
                        //insert data into the subject_attendance table

                        st12.executeUpdate("insert into subject_attendance_" + given_session + "_" + given_year + " (subjectId) values('" + rs3.getString(1) + "')");

                        System.out.println(rs3.getString(1)+"hello");
                        st12.executeUpdate("create table if not exists " + rs3.getString(1) + "_Attendance_" + given_session + "_" + given_year + "(StudentId varchar(20) not null,StudentName varchar(50)," + columns + "cumatten int(20),percentage float,primary key(StudentId))");
                        st13.executeUpdate("create table if not exists " + rs3.getString(1) + "_Assessment_" + given_session + "_" + given_year + "(StudentId varchar(20) not null,StudentName varchar(50),Minor_1 varchar(5),Minor_2 varchar(5),Minor_3 varchar(5),Major varchar(5),Final varchar(5),InternalMarks varchar(5),TotalMarks varchar(5),primary key(StudentId))");

                        //start loading data .  GET THE SEMESTER FOR WHICH REGISTER SUBJECTs(cores) HAS TO TEACH. MCA-I, MCA-II etc into rs4
                        ResultSet rs4 = (ResultSet) st8.executeQuery("select semester from subject_data where subjId='" + rs3.getString(1) + "'");
                        while (rs4.next()) {

                            String str_with1 = rs4.getString(1);
                            String str_free1 = str_with1;
                            System.out.println("program name from selection after replace - with _ : " + str_free1);


                            ResultSet rs1_prgm = (ResultSet) st1_prgm.executeQuery("select * from programme_table where Programme_status=1");
                            while (rs1_prgm.next()) {
                                System.out.println("program name from the prgm table : " + rs1_prgm.getString(1));
                                if (str_free1.contains(rs1_prgm.getString(1))) {
                                    int batch = 0;
                                    String program = rs4.getString(1);
                                    //System.out.println("program name " + program);

                                    int len = program.length();
                                   // System.out.println(len);

                                    String sub_2 = (rs4.getString(1)).substring(len - 2, len);  // MTech-CS-I OR -V, -AI-I OR -V, MCA-I OR -V,
                                    String sub_3 = (rs4.getString(1)).substring(len - 3, len);  // -II, -IV, -VI ..etc
                                    String sub_4 = (rs4.getString(1)).substring(len - 4, len);   // -III , -IIV , etc
                                    String sub_5 = (rs4.getString(1)).substring(len - 5, len);    // mostly no need.

                                    if (sub_2.equals("-I")) {
                                        batch = year;
                                    } else if (sub_3.equals("-IV") || sub_2.equals("-V")) {
                                        batch = year - 2;
                                    } else if (sub_3.equals("-II") || sub_4.equals("-III")) {
                                        batch = year - 1;

                                    } else if (sub_3.equals("-VI") || sub_4.equals("-VII")) {
                                        batch = year - 3;
                                    } else if (sub_5.equals("-VIII") || sub_3.equals("-IX")) {
                                        batch = year - 4;
                                    } else if (sub_2.equals("-X")) {
                                        batch = year - 5;
                                    }




                                    // replace the "-" with the " _"  in the name of the program, since mysql giving some excp with "-" in table name. 

                                    String str_with2 = rs1_prgm.getString(1);
                                    String str_free2 = str_with2.replace('-', '_');
                                    System.out.println("current progm batch:" + str_free2 + "_" + batch);
                                    ResultSet rs5 = (ResultSet) st9.executeQuery("select StudentId,StudentName from " + str_free2 + "_" + batch);
                                    //ResultSet rs5 = (ResultSet) st9.executeQuery("select StudentId , StudentName from" + str_free2 + "_" + batch);
                                    System.out.println("upto here no exception");
                                    int studentsem=0;
                                    String sem="";
                                    if(given_session.equals("Monsoon") )
                                    {
                                        studentsem = ((year-batch)*2)+1;
                                    }
                                    else
                                    {
                                         studentsem = ((year-batch)*2);
                                    }
                                    
                           if (studentsem == 1) {
                                sem = "I";
                            } else if (studentsem == 2) {
                                sem = "II";
                            } else if (studentsem == 3) {
                                sem = "III";
                            } else if (studentsem == 4) {
                                sem = "IV";
                            } else if (studentsem == 5) {
                                sem = "V";
                            } else if (studentsem == 6) {
                                sem = "VI";
                            } else if (studentsem == 7) {
                                sem = "VII";
                            } else if (studentsem == 8) {
                                sem = "VIII";
                            } else if (studentsem == 9) {
                                sem = "IX";
                            } else if (studentsem == 10) {
                                sem = "X";
                            } else if (studentsem == 11) {
                                sem = "XI";
                            } else if (studentsem == 12) {
                                sem = "XII";
                            } else if (studentsem == 13) {
                                sem = "XIII";
                            } else if (studentsem == 14) {
                                sem = "XIV";
                            } else if (studentsem == 15) {
                                sem = "XV";
                            } else if (studentsem == 16) {
                                sem = "XVI";
                            }
                           //To know latest curriculum for particular batch of programme.
                           Statement st24 = (Statement) con.createStatement();
                           Statement st21 = (Statement) con.createStatement();
                           ResultSet rs12 = (ResultSet) st24.executeQuery("select * from " + str_free2 + "_curriculumversions order by Year desc");
                            ResultSet rs13 = (ResultSet) st21.executeQuery("select * from " + str_free2 + "_curriculumversions order by Year desc");
                            int latestYear =0;
                            int  curriculumYear=0;
                            rs13.next();
                            while (rs12.next()) {
                                curriculumYear = rs13.getInt(1);
                                if (curriculumYear <= batch) {

                                    latestYear = curriculumYear;

                                    break;
                                }
                            }

                        //    semcount1 = studentsem;

                            int totalsubjectsinsem = 0;
                          //   System.out.println(totalsubjectsinsem+" iahg "+sem);
                           ResultSet rs15 = st4.executeQuery("select * from " + str_free2 + "_" + latestYear + "_currrefer where Semester='" + sem + "'");
                              
                            while (rs15.next()) {
                                totalsubjectsinsem = totalsubjectsinsem + (rs15.getInt(2) + rs15.getInt(3) + rs15.getInt(4));
                                totalsubjectsinsem = (totalsubjectsinsem / 2);
                                System.out.println(totalsubjectsinsem);
                                  }

                                    while (rs5.next()) {
                                        // System.out.println("students" + rs5.getString(1));
                                        //System.out.println("MCA subject:"+rs3.getString(1));
                                        ResultSetMetaData rsmd = rs5.getMetaData();
                                           int noOfColumns = rsmd.getColumnCount();
                                           int temp = (noOfColumns - 2) / 2;
                                            int i1 = 0;
                                        int count1 = 0;
                                
                                        while (temp > 0) {
                                        int m = i1 + 3;
                                        String F = "F";
                                        System.out.println(rs5.getString(m + 1)+" "+rs5.getString(1));
                                        if (F.equals(rs5.getString(m + 1))) {
                                            count1++;
                                        }
                                        i1 = i1 + 2;
                                        temp--;
                                   }
                                 System.out.println(" habh "+count1+" "+totalsubjectsinsem);
                                if (count1 <= totalsubjectsinsem )
                                 {                
                                        st12.executeUpdate("insert into " + rs3.getString(1) + "_Attendance_" + given_session + "_" + given_year + " (StudentId , StudentName) values('" + rs5.getString(1) + "','" + rs5.getString(2) + "')");

                                        st13.executeUpdate("insert into " + rs3.getString(1) + "_Assessment_" + given_session + "_" + given_year + " (StudentId , StudentName) values('" + rs5.getString(1) + "','" + rs5.getString(2) + "')");
                                        //con1.close();
                                    }
                                    }

                                    break;
                                }

                            }

                        }

                    }

                    //out.println("<center><h1>File uploaded sucessfully</h1></center>");
         //       } catch (Exception e) {
          //          System.out.println(e);
         //           out.println(e);
          //      }
                 %>

            <center><h1>Course Allocation Done</h1></center>

            <%
                    } // its else part of check allocated all cores
                    //********
                } catch (Exception e) {
                   // System.out.println("main"+e);
                    out.println(e);
                }



                // logic for maintaing previous elective stream limits.














                //************************************************************************ends here******
            %>
            <input type="hidden" name="year2" value="<%=given_year%>">
            <input type="hidden" name="current_session" value="<%=given_session%>">
            <input type="hidden" name="cores_status" value="<%=cores_status%>">
            
            
        </form>   


    </form>  
    <script>
        function fun(){  
            document.frm1.action="sub-faconline_modify.jsp";
            //document.frm2.target="right_f";
            document.frm1.submit();
        }
    </script>      

</body>
</html>
