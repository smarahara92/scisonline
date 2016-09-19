<%-- 
    Document   : choose_ele_new_stored
    Created on : Nov 8, 2013, 2:02:42 PM
    Author     : sri
--%>

<%@include file="checkValidity.jsp"%>
<%@page import="java.util.HashMap"%>
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
<%@include file="dbconnection.jsp" %>
<%@include file="checkValidity.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script language="javaScript" type="text/javascript" src="calendar.js"></script>
        <script src="jquery-1.10.2.min.js"></script> 
        <title>JSP Page</title>

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

    <body bgcolor="#CCFFFF">

        <%


            String given_session = request.getParameter("given_session");
            String given_year = request.getParameter("given_year");
            String selected_id = request.getParameter("selected_id");

            int year = Integer.parseInt(given_year);
            Calendar cal = Calendar.getInstance();
            //int year = cal.get(Calendar.YEAR);
            //  int month = cal.get(Calendar.MONTH) + 1;
            String stream = "", stream_table = "", prgm = "", currrefer_s = "", sem = "", stream1 = "", stream2 = "", curriculum = "";
            stream = request.getParameter("stream");
            //if(stream==null){ stream ="";}


            stream = stream.replace('-', '_');
            //  System.out.println("hiiii stream :"+stream);
            // System.out.println("hiiii year :"+year);
            int course_count = 0, current_cores = 0, max_stu = 0, total_stu = 0;

            int year2 = year;

            // Added this part 20-1-2013
            //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
            session.setAttribute("stream", stream);
            int str_len = stream.length();
            int sem2 = 0;
            String sub_2 = (stream).substring(str_len - 2, str_len);  // MTech-CS-I OR -V, -AI-I OR -V, MCA-I OR -V,
            String sub_3 = (stream).substring(str_len - 3, str_len);  // -II, -IV, -VI ..etc
            String sub_4 = (stream).substring(str_len - 4, str_len);   // -III , -IIV , etc
            String sub_5 = (stream).substring(str_len - 5, str_len);    // mostly no need.

            if (sub_2.equals("_I")) {
                sem2 = 1;
                sem = "I";
                year2 = year;
            } else if (sub_2.equals("_V")) {
                sem2 = 5;
                sem = "V";
                year2 = year - 2;
            } else if (sub_2.equals("_X")) {
                sem2 = 10;
                sem = "X";
                year2 = year - 5;
            } else if (sub_3.equals("_IV")) {
                sem2 = 4;
                sem = "IV";
                year2 = year - 2;
            } else if (sub_3.equals("_II")) {
                sem2 = 2;
                sem = "II";
                year2 = year - 1;
            } else if (sub_3.equals("_VI")) {
                sem2 = 6;
                sem = "VI";
                year2 = year - 3;
            } else if (sub_3.equals("_IX")) {
                sem2 = 9;
                sem = "IX";
                year2 = year - 4;
            } else if (sub_4.equals("_III")) {
                sem2 = 3;
                sem = "III";
                year2 = year - 1;
            } else if (sub_4.equals("_VII")) {
                sem2 = 7;
                sem = "VII";
                year2 = year - 3;
            } else if (sub_5.equals("_VIII")) {
                sem2 = 8;
                sem = "VIII";
                year2 = year - 4;

            }

            Statement st10_prgm = (Statement) con.createStatement();
            String program_name = "";
            ResultSet rs10_prgm = (ResultSet) st10_prgm.executeQuery("select Programme_name from programme_table where Programme_status='1'");
            while (rs10_prgm.next()) {

                program_name = rs10_prgm.getString(1);
                program_name = program_name.replace("-", "_");
                // program_name=program_name.toLowerCase()
                System.out.println(program_name + "");

                if (stream.contains(program_name)) {
                    prgm = program_name; //this is the programme name.
                    stream_table = prgm + "_" + Integer.toString(year2);
                    break;
                }

            }
            stream1 = stream.replace("_", " ");
            stream2 = stream;

            System.out.println(stream + "without " + stream2 + " table :" + stream_table);
            /*stream = stream.replace('-', '_');
             System.out.println("srinivas testing 1" + selected_id);



             int course_count = 0, current_cores = 0, max_stu = 0, total_stu = 0, ele_count = 0;
             int year2 = year;
             if (given_session.equals("Winter")) {
             if (stream.equals("MCA_IV")) {
             year2 = year - 2;
             prgm = "MCA";
             stream_table = "MCA_" + Integer.toString(year2);
             // currrefer_s = "MCA_currrefer";
             //curriculum = "MCA_curriculum";
             sem = "IV";
             stream1 = "MCA IV";
             stream2 = "MCA_IV";
             } else if (stream.equals("MTECH_CS_II")) {
             year2 = year - 1;
             prgm = "MTech_CS";
             stream_table = "MTech_CS_" + Integer.toString(year2);
             //currrefer_s = "MTech_CS_currrefer";
             //curriculum = "MTech_CS_curriculum";
             sem = "II";
             stream1 = "MTECH CS II";
             stream2 = "MTech_CS_II";
             } else if (stream.equals("MTECH_AI_II")) {
             year2 = year - 1;
             prgm = "MTech_AI";
             stream_table = "MTech_AI_" + Integer.toString(year2);
             // currrefer_s = "MTech_AI_currrefer";
             // curriculum = "MTech_AI_curriculum";
             sem = "II";
             stream1 = "MTECH AI II";
             stream2 = "MTech_AI_II";
             } else if (stream.equals("MTECH_IT_II")) {
             year2 = year - 1;
             prgm = "MTech_IT";
             stream_table = "MTech_IT_" + Integer.toString(year2);
             // currrefer_s = "MTech_IT_currrefer";
             // curriculum = "MTech_IT_curriculum";
             sem = "II";
             stream1 = "MTECH IT II";
             stream2 = "MTech_IT_II";
             }
             } else if (given_session.equals("Monsoon")) {
             if (stream.equals("MCA_III")) {
             year2 = year - 1;
             prgm = "MCA";
             stream_table = "MCA_" + Integer.toString(year2);
             // currrefer_s = "MCA_currrefer";
             // curriculum = "MCA_curriculum";
             sem = "III";
             stream1 = "MCA III";
             stream2 = "MCA_III";
             } else if (stream.equals("MCA_V")) {
             year2 = year - 2;
             prgm = "MCA";
             stream_table = "MCA_" + Integer.toString(year2);
             // currrefer_s = "MCA_currrefer";
             // curriculum = "MCA_curriculum";
             sem = "V";
             stream1 = "MCA V";
             stream2 = "MCA_V";
             } else if (stream.equals("MTECH_CS_I")) {
             stream_table = "MTech_CS_" + Integer.toString(year2);
             prgm = "MTech_CS";
             //currrefer_s = "MTech_CS_currrefer";
             /// curriculum = "MTech_CS_curriculum";
             sem = "I";
             stream1 = "MTECH CS I";
             stream2 = "MTech_CS_I";
             } else if (stream.equals("MTECH_AI_I")) {
             stream_table = "MTech_AI_" + Integer.toString(year2);
             prgm = "MTech_AI";
             // currrefer_s = "MTech_AI_currrefer";
             //  curriculum = "MTech_AI_curriculum";
             sem = "I";
             stream1 = "MTECH AI I";
             stream2 = "MTech_AI_I";
             } else if (stream.equals("MTECH_IT_I")) {
             stream_table = "MTech_IT_" + Integer.toString(year2);
             // currrefer_s = "MTech_IT_currrefer";
             prgm = "MTech_IT";
             // curriculum = "MTech_IT_curriculum";
             sem = "I";
             stream1 = "MTECH IT I";
             stream2 = "MTech_IT_I";
             }
             }

             */
            // GETTING ACTIVE CURS, year2 contains year of the program, prm contains the programe name.

            /*
             *code for taking latest curriculum
             */

            int curriculumYear = 0, latestYear = 0;//here latestYear output of this code, that is the latest curriculum year
            Statement st10_cur = (Statement) con.createStatement();

            ResultSet rs10_cur = (ResultSet) st10_cur.executeQuery("select * from " + prgm + "_curriculumversions order by Year desc");
            while (rs10_cur.next()) {
                curriculumYear = rs10_cur.getInt(1);
                if (curriculumYear <= year2) {

                    latestYear = curriculumYear;
                    System.out.println(latestYear);
                    break;
                }
            }
            currrefer_s = prgm + "_" + latestYear + "_currrefer";
            curriculum = prgm + "_" + latestYear + "_curriculum";

            /*
             *code for taking latest curriculum over here
             */


            //Calendar now = Calendar.getInstance();
            Statement st1 = (Statement) con.createStatement();
            Statement st2 = (Statement) con.createStatement();
            Statement st3 = (Statement) con.createStatement();
            Statement st4 = (Statement) con.createStatement();
            Statement st5 = (Statement) con.createStatement();
            Statement st7 = (Statement) con.createStatement();
            Statement st8 = (Statement) con.createStatement();
            Statement st9 = (Statement) con.createStatement();
            Statement st10 = (Statement) con.createStatement();
            Statement st12 = (Statement) con.createStatement();



            Statement st13 = (Statement) con1.createStatement();
            Statement st14 = (Statement) con1.createStatement();


            Statement st_study = (Statement) con.createStatement();
            Statement st_check = (Statement) con.createStatement();
            Statement st_pre_req = (Statement) con.createStatement();


            //$$$$$ total number ofcore,  electives for given branch. eg: ai has 6 cores, 4 elective throughout course
            //ResultSet rs_core_ele = (ResultSet) st1.executeQuery("select * from " + curriculum + "");
            ResultSet rs_core_ele = (ResultSet) st1.executeQuery("select sum(Cores),sum(Electives),sum(Labs) from " + currrefer_s + "");

            String total_cores = "";
            String total_ele = "";

            if (rs_core_ele.next()) {
                total_cores = rs_core_ele.getString(1);
                total_ele = rs_core_ele.getString(2);

            }
            int total_cores_i = Integer.parseInt(total_cores);
            int total_ele_i = Integer.parseInt(total_ele);





            ResultSet rs_student = (ResultSet) st1.executeQuery("select * from " + stream_table + "");
            ResultSet rs_student1 = (ResultSet) st2.executeQuery("select count(*) from " + stream_table + "");
            if (rs_student1.next()) {
                total_stu = rs_student1.getInt(1);
            }
            //System.out.println("laxman"+total_stu);
            ResultSet rs_t = (ResultSet) st3.executeQuery("select Electives, Cores from " + currrefer_s + " where Semester = '" + sem + "'");
            if (rs_t.next()) {
                current_cores = rs_t.getInt(2); // current cores
                course_count = rs_t.getInt(1);   /// # electives for given stream
            }          //  System.out.println(course_count);



            //System.out.println(ec);
            //System.out.println("nareh"+ec);
            int temp_i = 0;
            session.setAttribute("stream_table", stream_table);
            session.setAttribute("course_count", course_count);

            /*SELECT COUNT(*)
             FROM INFORMATION_SCHEMA.COLUMNS
             WHERE table_catalog = 'database_name' -- the database
             AND table_schema = 'dbo' -- or whatever your schema is
             AND table_name = 'table_name'

             */

            Statement st_pre_req_test = (Statement) con.createStatement();
            int col_count = 0;
            ResultSet rs_check_pre_req_test = (ResultSet) st_pre_req_test.executeQuery("SELECT count(*) FROM information_schema.COLUMNS WHERE table_name = '" + given_year + "_" + given_session + "_elective'");

            if (rs_check_pre_req_test.next()) {

                //System.out.println("helo colums");
                col_count = rs_check_pre_req_test.getInt(1);  // number of clumns in the stream table
                // System.out.println("and " + col_count);
            }
            //String arr = new Array();

            HashMap hm = new HashMap();
            HashMap hm_old_ele = new HashMap();
            session.setAttribute("hm_old_ele", hm_old_ele);
            //add key-value pair to hashmap
            hm.put("A+", 10);
            hm.put("A", 9);
            hm.put("B+", 8);
            hm.put("B", 7);
            hm.put("C", 6);
            hm.put("R", 1);
            hm.put("NR", 1);
            hm.put("F", 1);

            //int course_count_int=Integer.parseInt(course_count)

            /*
             int len = stream.length();
             int sem_2 = 0;
             String sub_2 = (stream).substring(len - 2, len);  // MTech-CS-I OR -V, -AI-I OR -V, MCA-I OR -V,
             String sub_3 = (stream).substring(len - 3, len);  // -II, -IV, -VI ..etc
             String sub_4 = (stream).substring(len - 4, len);   // -III , -IIV , etc
             String sub_5 = (stream).substring(len - 5, len);    // mostly no need.

             if (sub_2.equals("_I")) {
             sem_2 = 1;
             } else if (sub_2.equals("_V")) {
             sem_2 = 5;
             } else if (sub_2.equals("_X")) {
             sem_2 = 10;
             } else if (sub_3.equals("_IV")) {
             sem_2 = 4;
             } else if (sub_3.equals("_II")) {
             sem_2 = 2;
             } else if (sub_3.equals("_VI")) {
             sem_2 = 6;
             } else if (sub_3.equals("_IX")) {
             sem_2 = 9;
             } else if (sub_4.equals("_III")) {
             sem_2 = 3;
             } else if (sub_4.equals("_VII")) {
             sem_2 = 7;
             } else if (sub_5.equals("_VIII")) {
             sem_2 = 8;
             }
             */
            ResultSet rs_ele_loc = (ResultSet) st2.executeQuery("select Electives, Cores from " + currrefer_s);

            int ele_stop = 1, ele_start = 1, core_start = 1;   // ele_start has position from which we have to insert the electives, eg : ele3,ele4 for ai-ii
            while (rs_ele_loc.next()) {                      // core_start contains start position of cores in this semester for given stream.
                if (ele_stop < sem2) {
                    ele_start = ele_start + rs_ele_loc.getInt(1);
                    core_start = core_start + rs_ele_loc.getInt(2);
                } else {
                    rs_ele_loc.afterLast();
                }
                ele_stop = ele_stop + 1;
            }




        %>

        <form action="choose_ele_modify_stored_before2014.jsp" name="frm1" id="frm1">

            <h2 align="center" class="style30" > Modify Electives ( <%=stream2.replace('_', ' ')%> )</h2>

            <table align="center" border="1"><!-- class="table_pos"-->

                <tr>

                    <th class="style31" align="center"><b>Student ID</b></th>


                    <% int i;



                        for (i = 1; i <= course_count; i++) {
                          int  len = 150;
                    %> 
                    <th class="style31" align="center" ><b>Elective<%=i%></b></th>

                    <% }

                    %>
                </tr>
                <tr>
                    <td>
                        <select name="student_selected" id="student" >
                            <option value="<%=selected_id%>" selected="selected"><%=selected_id%></option>         

                        </select>
                    </td>

                    <%



                        int len = 150;
                        int core_start_live = core_start;
                        int ele_start_live = ele_start;
                        for (i = 1; i <= course_count; i++) {

                            //$$$$$$$$$  check if alredy has taken electives from the master table.$$$$$$$$$$$$$$$$$$
                            //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$                       

                            //  take the coresponding electives like ele3, ele4 for m.tech-ai-ii  


                    %>

                    <td>
                        <select name="select<%=Integer.toString(i)%>" id="select<%=Integer.toString(i)%>" onchange="dothis(<%=Integer.toString(i)%>);" style="width:<%=len%>px;">


                            <%

                                int old_ele_flag = 0;
                                ResultSet rs_old_ele = (ResultSet) st1.executeQuery("select ele" + ele_start_live + " from " + stream_table + "  where StudentId='" + selected_id + "'");
                                ele_start_live = ele_start_live + 1;
                                String old_ele = "none";
                                if (rs_old_ele.next()) {

                                    //System.out.println("srinivas tet here me "+rs_old_ele.getString(1));
                                    String col_value = (String) rs_old_ele.getString(1);
                                    hm_old_ele.put(i, col_value); //sending old ele to next page, to remove studnt from old attendance, assessment

                                    if (col_value != null && !col_value.isEmpty() && !col_value.equalsIgnoreCase("null")) {
                                        // System.out.println("srinivas tet here me " + rs_old_ele.getString(1));
                                        old_ele = rs_old_ele.getString(1);
                                        old_ele_flag = 1;


                                    }
                                }
                                // if ele alread choosen then make it selected in the drop down box.
                                if (old_ele_flag == 1) {

                                    String subname = "";
                                    ResultSet rs_old_ele2 = (ResultSet) ConnectionDemo.getStatementObj().executeQuery("select Subject_Name  from subjecttable where Code='" + old_ele + "'");
                                    if (rs_old_ele2.next()) {

                                        subname = rs_old_ele2.getString(1);
                            %> 


                            <option value="<%=old_ele%>" selected="selected"><%=subname%></option>
                            <option value="none">none</option>

                            <%


                                }

                            } else {

                            %> 

                            <option value="none">none</option>


                            <% }

                                ResultSet rs3 = null;
                                // System.out.println("testing here");
                                rs3 = (ResultSet) st3.executeQuery("select Code,Subject_Name from subjecttable as a," + given_year + "_" + given_session + "_elective as b where a.Code=b.course_name AND  b." + stream + "!=0");
                                while (rs3.next()) {
                                    //   System.out.println(rs3.getString(2));

                                    // check for the cores and ele in master table of batch, to confirm that student already studied or not this subject.
                                    // check for the pre-requisite validation.
                                    String check_ele = ""; // for study
                                    String check_core = ""; // for study
                                    String pre_req1_check_ele = ""; // to check pre_requisite
                                    String pre_req1_check_core = "";
                                    String pre_req2_check_ele = ""; // to check pre_requisite
                                    String pre_req2_check_core = "";

                                    String pre_req1_check_ele_no_grade = ""; // to check pre_requisite
                                    String pre_req1_check_core_no_grade = "";
                                    String pre_req2_check_ele_no_grade = ""; // to check pre_requisite
                                    String pre_req2_check_core_no_grade = "";

                                    String pre_req1 = "none";
                                    String pre_req2 = "none";
                                    String pre_req1_grade = "";
                                    String pre_req2_grade = "";


                                    ResultSet rs_check = (ResultSet) st_check.executeQuery("select pre_req_1, pre_req_grade1, pre_req_2, pre_req_grade2 from " + given_year + "_" + given_session + "_elective where course_name='" + rs3.getString(1) + "'");
                                    if (rs_check.next()) {
                                        pre_req1 = rs_check.getString(1);
                                        pre_req1_grade = rs_check.getString(2);

                                        pre_req2 = rs_check.getString(3);
                                        pre_req2_grade = rs_check.getString(4);


                                    }


                                    for (int ch = 1; ch <= total_ele_i; ch++) {
                                        if (ch == 1) {
                                            check_ele = "ele" + ch + "='" + rs3.getString(1) + "'";
                                            pre_req1_check_ele = "ele" + ch + "='" + pre_req1 + "' AND e" + ch + "grade='" + pre_req1_grade + "' ";
                                            pre_req2_check_ele = "ele" + ch + "='" + pre_req2 + "' AND e" + ch + "grade='" + pre_req2_grade + "' ";

                                            pre_req1_check_ele_no_grade = "ele" + ch + "='" + pre_req1 + "' ";
                                            pre_req2_check_ele_no_grade = "ele" + ch + "='" + pre_req2 + "' ";

                                        } else {

                                            check_ele = check_ele + " or " + "ele" + ch + "='" + rs3.getString(1) + "'";
                                            pre_req1_check_ele = pre_req1_check_ele + " OR ( " + "ele" + ch + "='" + pre_req1 + "' AND e" + ch + "grade='" + pre_req1_grade + "' ) ";
                                            pre_req2_check_ele = pre_req2_check_ele + " OR ( " + "ele" + ch + "='" + pre_req2 + "' AND e" + ch + "grade='" + pre_req2_grade + "' ) ";

                                            pre_req1_check_ele_no_grade = pre_req1_check_ele_no_grade + " OR ( " + "ele" + ch + "='" + pre_req1 + "' ) ";
                                            pre_req2_check_ele_no_grade = pre_req2_check_ele_no_grade + " OR ( " + "ele" + ch + "='" + pre_req2 + "' ) ";

                                        }
                                    }


                                    for (int ch = 1; ch <= total_cores_i; ch++) {
                                        if (ch == 1) {
                                            check_core = "core" + ch + "='" + rs3.getString(1) + "'";
                                            pre_req1_check_core = "core" + ch + "='" + pre_req1 + "' AND c" + ch + "grade='" + pre_req1_grade + "'  ";
                                            pre_req2_check_core = "core" + ch + "='" + pre_req2 + "' AND c" + ch + "grade='" + pre_req2_grade + "'  ";

                                            pre_req1_check_core_no_grade = "core" + ch + "='" + pre_req1 + "'  ";
                                            pre_req2_check_core_no_grade = "core" + ch + "='" + pre_req2 + "' ";

                                        } else {
                                            check_core = check_core + " or " + "core" + ch + "='" + rs3.getString(1) + "'";
                                            pre_req1_check_core = pre_req1_check_core + " OR  ( " + "core" + ch + "='" + pre_req1 + "' AND c" + ch + "grade='" + pre_req1_grade + "' )";
                                            pre_req2_check_core = pre_req2_check_core + " OR  ( " + "core" + ch + "='" + pre_req2 + "' AND c" + ch + "grade='" + pre_req2_grade + "' )";

                                            pre_req1_check_core_no_grade = pre_req1_check_core_no_grade + " OR  ( " + "core" + ch + "='" + pre_req1 + "'  )";
                                            pre_req2_check_core_no_grade = pre_req2_check_core_no_grade + " OR  ( " + "core" + ch + "='" + pre_req2 + "'  )";




                                        }
                                    }

                                    ResultSet rs_check_study = (ResultSet) st_study.executeQuery("select * from " + stream_table + " where StudentId='" + selected_id + "' and (" + check_ele + " or " + check_core + ")");

                                    int study_flag = 0;
                                    if (rs_check_study.next()) {
                                        study_flag = 1;
                                    }



                                    // verify whether this subject has to be there for this student.                                                                          


                                    if (study_flag == 0 && pre_req1.equals("none") && pre_req2.equals("none")) {  //  both pre-req are none (00) , and not studied.    
                            %>


                            <option  value="<%=rs3.getString(1)%>"><%=rs3.getString(2)%></option>


                            <%} else if (study_flag == 0 && (pre_req1.equals("none") && !(pre_req2.equals("none")))) { //01

                                if (pre_req2_grade.equals("")) {
                                    // check in the ele, cores whether this student has that pre-req2 or not, without looking at grade.

                                    ResultSet rs_check_pre_req = (ResultSet) st_pre_req.executeQuery("select * from " + stream_table + " where StudentId='" + selected_id + "' and " + pre_req2_check_ele_no_grade + " or " + pre_req2_check_core_no_grade + "");
                                    if (rs_check_pre_req.next()) {
                            %>


                            <option  value="<%=rs3.getString(1)%>"><%=rs3.getString(2)%></option>


                            <%

                                }


                            } else {

                                //System.out.println("s code and preq "+ "and"+pre_req2);                                     
                                ResultSet rs_check_pre_req = (ResultSet) st_pre_req.executeQuery("select * from " + stream_table + " where StudentId='" + selected_id + "' and " + pre_req2_check_ele_no_grade + " or " + pre_req2_check_core_no_grade + "");
                                if (rs_check_pre_req.next()) {
                                    // System.out.println("s code and preq "+ "and"+pre_req2);
                                    // System.out.println("and  "+col_count);      //  tested getting zero here.                                  
                                    for (int col = 1; col <= col_count; col++) {

                                        String code = rs_check_pre_req.getString(col);

                                        //System.out.println("code and preq "+code+ "and"+pre_req2);     // test                             
                                        if (code != null) {
                                            if (code.equals(pre_req2)) {

                                                col = col + 1;
                                                String s_grade = rs_check_pre_req.getString(col);
                                                if (s_grade == null) {
                                                    s_grade = "NR";
                                                }
                                                String left = hm.get(s_grade).toString();
                                                String right = hm.get(pre_req2_grade).toString();

                                                int left_i = Integer.parseInt(left); // student secured
                                                int right_i = Integer.parseInt(right); // constraint to get elective.

                                                // System.out.println("lef right "+left_i+ "and"+right_i); // it will print the result a total of #elctives for given batch
                                                if (left_i >= right_i) {

                            %>


                            <option  value="<%=rs3.getString(1)%>"><%=rs3.getString(2)%></option>


                            <%

                                                    }
                                                    col = col_count + 1;
                                                }
                                            }

                                        }

                                    }
                                }


                            } ////  here 1st elseif
                            else if (study_flag == 0 && (!(pre_req1.equals("none")) && pre_req2.equals("none"))) { //10

                                if (pre_req1_grade.equals("")) {
                                    // check in the ele, cores whether this student has that pre-req2 or not, without looking at grade.

                                    ResultSet rs_check_pre_req = (ResultSet) st_pre_req.executeQuery("select * from " + stream_table + " where StudentId='" + selected_id + "' and " + pre_req1_check_ele_no_grade + " or " + pre_req1_check_core_no_grade + "");
                                    if (rs_check_pre_req.next()) {
                            %>


                            <option  value="<%=rs3.getString(1)%>"><%=rs3.getString(2)%></option>


                            <%

                                }


                            } else {

                                ResultSet rs_check_pre_req = (ResultSet) st_pre_req.executeQuery("select * from " + stream_table + " where StudentId='" + selected_id + "' and " + pre_req1_check_ele_no_grade + " or " + pre_req1_check_core_no_grade + "");
                                if (rs_check_pre_req.next()) {

                                    for (int col = 1; col <= col_count; col++) {
                                        String code = rs_check_pre_req.getString(col);
                                        if (code != null) {
                                            if (code.equals(pre_req1)) {

                                                col = col + 1;
                                                String s_grade = rs_check_pre_req.getString(col);
                                                if (s_grade == null) {
                                                    s_grade = "NR";
                                                }
                                                String left = hm.get(s_grade).toString();
                                                String right = hm.get(pre_req1_grade).toString();

                                                int left_i = Integer.parseInt(left); // student secured
                                                int right_i = Integer.parseInt(right); // constraint to get elective.

                                                if (left_i >= right_i) {

                            %>


                            <option  value="<%=rs3.getString(1)%>"><%=rs3.getString(2)%></option>


                            <%

                                                    }
                                                    col = col_count + 1;
                                                }
                                            }

                                        }

                                    }
                                }

                            } // 2nd else if    
                            else if (study_flag == 0 && (!(pre_req1.equals("none")) && !(pre_req2.equals("none")))) { //11

                                if (pre_req1_grade.equals("") && pre_req2_grade.equals("")) {
                                    // check in the ele, cores whether this student has that pre-req2 or not, without looking at grade.

                                    ResultSet rs_check_pre_req = (ResultSet) st_pre_req.executeQuery("select * from " + stream_table + " where StudentId='" + selected_id + "' and (" + pre_req1_check_ele_no_grade + " or " + pre_req1_check_core_no_grade + ") and (" + pre_req2_check_ele_no_grade + " or " + pre_req2_check_core_no_grade + " )");
                                    if (rs_check_pre_req.next()) {
                            %>


                            <option  value="<%=rs3.getString(1)%>"><%=rs3.getString(2)%></option>


                            <%

                                }


                            } else if (!(pre_req1_grade.equals("")) && !(pre_req2_grade.equals(""))) {
                                ResultSet rs_check_pre_req = (ResultSet) st_pre_req.executeQuery("select * from " + stream_table + " where StudentId='" + selected_id + "' and (" + pre_req1_check_ele_no_grade + " or " + pre_req1_check_core_no_grade + ") and (" + pre_req2_check_ele_no_grade + " or " + pre_req2_check_core_no_grade + " )");

                                // ResultSet rs_check_pre_req = (ResultSet) st_pre_req.executeQuery("select * from " + stream_table + " where StudentId='"+student_id+"' and ("+pre_req1_check_ele+" or "+ pre_req1_check_core+") and ("+pre_req2_check_ele+" or "+ pre_req2_check_core+" )" );       
                                if (rs_check_pre_req.next()) {
                                    int flag1 = 0, flag2 = 0;
                                    for (int col = 1; col <= col_count; col++) {
                                        String code = rs_check_pre_req.getString(col);
                                        if (code != null) {
                                            if (code.equals(pre_req1)) {

                                                col = col + 1;
                                                String s_grade = rs_check_pre_req.getString(col);
                                                if (s_grade == null) {
                                                    s_grade = "NR";
                                                }
                                                String left = hm.get(s_grade).toString();
                                                String right = hm.get(pre_req1_grade).toString();

                                                int left_i = Integer.parseInt(left); // student secured
                                                int right_i = Integer.parseInt(right); // constraint to get elective.

                                                if (left_i >= right_i) {

                                                    flag1 = 1; // grade1 is okey

                                                }
                                                col = col_count + 1;
                                            }

                                        }

                                    }

                                    // second grade checking
                                    for (int col = 1; col <= col_count; col++) {

                                        String code = rs_check_pre_req.getString(col);

                                        //System.out.println("code and preq "+code+ "and"+pre_req2);     // test                             
                                        if (code != null) {
                                            if (code.equals(pre_req2)) {

                                                col = col + 1;
                                                String s_grade = rs_check_pre_req.getString(col);
                                                if (s_grade == null) {
                                                    s_grade = "NR";
                                                }
                                                String left = hm.get(s_grade).toString();
                                                String right = hm.get(pre_req2_grade).toString();

                                                int left_i = Integer.parseInt(left); // student secured
                                                int right_i = Integer.parseInt(right); // constraint to get elective.

                                                // System.out.println("lef right "+left_i+ "and"+right_i); // it will print the result a total of #elctives for given batch
                                                if (left_i >= right_i) {

                                                    flag2 = 1; // grade2 is okey

                                                }
                                                col = col_count + 1;
                                            }
                                        }

                                    }

                                    if (flag1 == 1 && flag2 == 1) {

                            %>


                            <option  value="<%=rs3.getString(1)%>"><%=rs3.getString(2)%></option>


                            <%

                                    }


                                } // database checking okey brace

                            } // else brace
                            else if (!(pre_req1_grade.equals("")) && (pre_req2_grade.equals(""))) {  // grade 1 given, grade 2 is not .

                                ResultSet rs_check_pre_req = (ResultSet) st_pre_req.executeQuery("select * from " + stream_table + " where StudentId='" + selected_id + "' and (" + pre_req1_check_ele_no_grade + " or " + pre_req1_check_core_no_grade + ") and (" + pre_req2_check_ele_no_grade + " or " + pre_req2_check_core_no_grade + " )");
                                //ResultSet rs_check_pre_req = (ResultSet) st_pre_req.executeQuery("select * from " + stream_table + " where StudentId='"+student_id+"' and "+pre_req1_check_ele_no_grade+" or "+ pre_req1_check_core_no_grade+"" );         
                                if (rs_check_pre_req.next()) {

                                    for (int col = 1; col <= col_count; col++) {
                                        String code = rs_check_pre_req.getString(col);
                                        if (code != null) {
                                            if (code.equals(pre_req1)) {

                                                col = col + 1;
                                                String s_grade = rs_check_pre_req.getString(col);
                                                if (s_grade == null) {
                                                    s_grade = "NR";
                                                }
                                                String left = hm.get(s_grade).toString();
                                                String right = hm.get(pre_req1_grade).toString();

                                                int left_i = Integer.parseInt(left); // student secured
                                                int right_i = Integer.parseInt(right); // constraint to get elective.

                                                if (left_i >= right_i) {

                            %>


                            <option  value="<%=rs3.getString(1)%>"><%=rs3.getString(2)%></option>


                            <%

                                                }
                                                col = col_count + 1;
                                            }
                                        }

                                    }

                                } /// upto here

                            } else if ((pre_req1_grade.equals("")) && !(pre_req2_grade.equals(""))) {  // grade 2 given, grade 1 is not .
                                ResultSet rs_check_pre_req = (ResultSet) st_pre_req.executeQuery("select * from " + stream_table + " where StudentId='" + selected_id + "' and (" + pre_req1_check_ele_no_grade + " or " + pre_req1_check_core_no_grade + ") and (" + pre_req2_check_ele_no_grade + " or " + pre_req2_check_core_no_grade + " )");
                                //ResultSet rs_check_pre_req = (ResultSet) st_pre_req.executeQuery("select * from " + stream_table + " where StudentId='"+student_id+"' and ("+pre_req1_check_ele_no_grade+" or "+ pre_req1_check_core_no_grade+") and ("+pre_req2_check_ele+" or "+ pre_req2_check_core+" )" );       
                                if (rs_check_pre_req.next()) {
                                    // System.out.println("s code and preq "+ "and"+pre_req2);
                                    // System.out.println("and  "+col_count);      //  tested getting zero here.                                  
                                    for (int col = 1; col <= col_count; col++) {

                                        String code = rs_check_pre_req.getString(col);

                                        //System.out.println("code and preq "+code+ "and"+pre_req2);     // test                             
                                        if (code != null) {
                                            if (code.equals(pre_req2)) {

                                                col = col + 1;
                                                String s_grade = rs_check_pre_req.getString(col);
                                                if (s_grade == null) {
                                                    s_grade = "NR";
                                                }
                                                String left = hm.get(s_grade).toString();
                                                String right = hm.get(pre_req2_grade).toString();

                                                int left_i = Integer.parseInt(left); // student secured
                                                int right_i = Integer.parseInt(right); // constraint to get elective.

                                                // System.out.println("lef right "+left_i+ "and"+right_i); // it will print the result a total of #elctives for given batch
                                                if (left_i >= right_i) {

                            %>


                            <option  value="<%=rs3.getString(1)%>"><%=rs3.getString(2)%></option>


                            <%

                                                            }
                                                            col = col_count + 1;
                                                        }
                                                    }

                                                }

                                            }

                                        }


                                    }


                                }


                            %>
                        </select>

                        <%}

                        %>



                </tr>

                <table>
                    <tr><td>&nbsp;</td></tr>
                    <tr><td>&nbsp;</td></tr>
                    <tr><td>&nbsp;</td></tr>


                </table>
                <table width="100%" class="pos_fixed">
                    <tr>

                        <td align="center" class="border"><input type="submit" name="submit" value="SUBMIT" ></td>

                    </tr>
                </table>




                <input type="hidden" name="selected_id" value="<%=selected_id%>">
                <input type="hidden" name="given_session" value="<%=given_session%>">
                <input type="hidden" name="given_year" value="<%=given_year%>"> 
                <input type="hidden" name="stream" value="<%=stream%>">
                <input type="hidden" name="stream_table" value="<%=stream_table%>">
                <input type="hidden" name="curriculum" value="<%=curriculum%>">
                <input type="hidden" name="currrefer_s" value="<%=currrefer_s%>">
                <input type="hidden" name="current_cores" value="<%=current_cores%>">

                <input type="hidden" name="total_cores" value="<%=total_cores%>">
                <input type="hidden" name="total_ele" value="<%=total_ele%>">
                <input type="hidden" name="course_count" value="<%=course_count%>">

                </form>


                <script>  
                    // alert("srinivas");
            
             
                    function dothis(col)
                    { 
            
                        //  hash map creating
            
                        var arr = new Array();
                        var arr2= new Array();
           
                    <%
                        ResultSet rs_course1 = (ResultSet) st7.executeQuery("select course_name, " + stream + " from " + given_year + "_" + given_session + "_elective where " + stream + "!=0");
                        while (rs_course1.next()) {

                            String code = rs_course1.getString(1);
                            String limit = rs_course1.getString(2);
                            //System.out.println(code + " limit :     " + limit);
                    %>  

                            //add key-value      pair to hashmap
                            arr["<%=code%>"]=<%=limit%>;       // given limits
                            arr2["<%=code%>"]=0;            // to hold take seats history
             
                            //alert(arr["AI720"] +" and"+arr["CS785"]);

                    <% }

                        // get the electives of all students in the stream, and look at the stream limits overflow or not.
                        ResultSet rs_course2 = (ResultSet) st7.executeQuery("select StudentId from " + stream_table);
                        while (rs_course2.next()) {
                            String student_id = rs_course2.getString(1);
                            core_start_live = core_start;
                            ele_start_live = ele_start;
                            for (i = 1; i <= course_count; i++) {


                                int old_ele_flag = 0;
                                ResultSet rs_old_ele2 = (ResultSet) st1.executeQuery("select ele" + ele_start_live + " from " + stream_table + "  where StudentId='" + student_id + "'");
                                ele_start_live = ele_start_live + 1;
                                String old_ele = "none";
                                if (rs_old_ele2.next()) {
                                    //System.out.println("srinivas tet here me "+rs_old_ele.getString(1));
                                    String col_value = (String) rs_old_ele2.getString(1);

                                    //  date = 13/11/13 here we have problem with comparision
                                    if (col_value != null && !col_value.isEmpty() && !col_value.equalsIgnoreCase("null")) {
                                        // System.out.println("srinivas tet here me " + rs_old_ele.getString(1));
                                        old_ele = rs_old_ele2.getString(1);
                    %>
                            arr2["<%=old_ele%>"]= arr2["<%=old_ele%>"]+1;
                    <%

                                    }
                                }

                            }// for



                        }//while


                    %>
            
            
            
                  
                
                            //  alert("srinivas3");
                            //  alert("<%=course_count%>");
            
                            //// $$$$$$$$$$$$$$$$$$$$$   logic for disabling the duplicate eletive selections. $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$4     4
            
                            var course_count=<%=course_count%>;
                  
                            var sel_code=$("#select"+col).val(); 
                            // alert(sel_code);
                            var i=1,flag=0;
                            for(i=1;i<=course_count;i++){
                                if(col==i){continue;}
                     
                                var comp_code=$("#select"+i).val(); 
                     
                                if(sel_code==comp_code){
                                    //var subj_code =document.getElementsByTagName("option")[sel_col].value;
                                    if(sel_code!="none"){
                                        //document.getElementById("select"+col+row).options.selectedIndex=(0);
                                        $("#select"+col).val("none");
                                        flag=1;
                                    }
                                }
       
                            }
                    
                    
                    
                            // stream limit logic
                               
                            // jquery to get the selected value without going for index.
                            var subj_code=$("#select"+col).val(); 
                                 
                            if(arr2[subj_code]>=arr[subj_code]){
                                alert("limit over");
                                //document.getElementById("select"+col).options.selectedIndex=(0);
                                $("#select"+col).val("none");
                            }
                            else{
                                arr2[subj_code]=arr2[subj_code]+1;
                               
                            } 
                          
                
                        }
           
                

                </script>
<%   // add this code at the last of you code. :) it will close all unwanted connections in the database with single shot.
            Statement stmt_close =(Statement) con.createStatement();
            Statement stmt3_close = (Statement)con.createStatement();
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