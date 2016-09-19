<%-- 
    Document   : choose_ele
--%>
<%@page import="sun.security.util.Length"%>
<%@page import="java.util.Date"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.HashMap" %>
<jsp:useBean id="cgpa" class="com.hcu.scis.automation.GetCgpa" scope="session"></jsp:useBean>
<%@include file="connectionBean.jsp"%>
<%@include file="checkValidity.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script language="javaScript" type="text/javascript" src="calendar.js"></script>
        <script type="text/javascript" src="jquery-1.10.2.min.js"></script>
        <script type="text/javascript" src="./lib/jquery.marquee.js"></script>
        <link type="text/css" href="./css/jquery.marquee.css" rel="stylesheet" media="all" />
        
        <style type="text/css">
            .style30 {color: red}
            .style31 {color: white}
            .style32 {color: green}
            .style44{
                background-color: #9FFF9D;
            }
            .pos_fixed {
                position:fixed;
                bottom:0px;
                background-color: #CCFFFF;
                border-color: red;
            }
            .head_pos {
                position:fixed;
                top:0px;
                background-color: #CCFFFF;
            }
            .menu_pos {
                position:fixed;
                top:105px;
                background-color: #CCFFFF;
            }
            .table_pos {
                top:300px;
            }
            .border {
                background-color: #c2000d;
            }
            .fix {   
                background-color: #c2000d;
            }
        </style>
<%
        Connection con = conn.getConnectionObj();
        Statement st0 = con.createStatement();
        
        String given_session = request.getParameter("given_session");
        String given_year = request.getParameter("given_year");
        int year = Integer.parseInt(given_year);
            
        String stream = "", stream_table = "", prgm = "", currrefer_s = "", sem = "", stream1 = "", stream2 = "", curriculum = "";
        stream = request.getParameter("stream");
        //if(stream==null){ stream ="";}
        //stream = stream.toUpperCase();
        stream = stream.replace('-', '_');
        //  System.out.println("hiiii stream :"+stream);
        // System.out.println("hiiii year :"+year);
        int course_count = 0, current_cores = 0, max_stu = 0, total_stu = 0;
        int year2 = year;
        
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

        Statement st_ele_count = (Statement) con.createStatement();
        ResultSet res_ele_count = (ResultSet) st_ele_count.executeQuery("select Code,Subject_Name from subjecttable as a," + given_year + "_" + given_session + "_elective as b where a.Code=b.course_name AND  b." + stream + "!=0");

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
        // System.out.println(stream + "without " + stream2 + " table :" + stream_table);

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
                //    System.out.println(latestYear);
                break;
            }
        }
        
        currrefer_s = prgm + "_" + latestYear + "_currrefer";
        curriculum = prgm + "_" + latestYear + "_curriculum";
        /****** code for taking latest curriculum over here ***********/

        int ele_count = 0;
        
        Statement st1 = con.createStatement();
        Statement st2 = con.createStatement();
        Statement st3 = con.createStatement();
        Statement st4 = con.createStatement();
        Statement st5 = con.createStatement();
        Statement st6 = con.createStatement();
        Statement st_pre_req_test = con.createStatement();


        //$$$$$ total number ofcore,  electives for given branch. eg: ai has 6 cores, 4 elective throughout course
        //ResultSet rs_core_ele = (ResultSet) st1.executeQuery("select * from " + curriculum + "");
        ResultSet rs_core_ele = (ResultSet) st1.executeQuery("select sum(Cores),sum(Electives),sum(Labs),sum(OptionalCore) from " + currrefer_s + "");

        String total_cores = "";
        String total_ele = "";
        String total_optionalcores = "";
        
        if (rs_core_ele.next()) {
            total_cores = rs_core_ele.getString(1);
            System.out.print(total_cores);
            total_ele = rs_core_ele.getString(2);
            System.out.print(total_cores);
            total_optionalcores = rs_core_ele.getString(4);
        }
        
        int total_cores_i = Integer.parseInt(total_cores);
        int total_ele_i = Integer.parseInt(total_ele);
        int total_optional_i = Integer.parseInt(total_optionalcores);
        
        ResultSet rs_student = null;
        
        if( sem2 > 1) {
            int k = cgpa.getCgpa(stream_table,curriculum);
            rs_student  = (ResultSet) st1.executeQuery("select * from " + stream_table +"_temp ORDER by cgpa DESC");
        } else {
            rs_student  = (ResultSet) st1.executeQuery("select * from " + stream_table + "");
        }
        
        ResultSet rs_student1 = (ResultSet) st2.executeQuery("select count(*) from " + stream_table + "");
        if (rs_student1.next()) {
            total_stu = rs_student1.getInt(1);
        }
        
        int electives = 0,optionalCore = 0;
            ResultSet rs = (ResultSet) st3.executeQuery("select Electives, Cores,OptionalCore from " + currrefer_s + " where Semester = '" + sem + "'");
            if (rs.next()) {
                current_cores = rs.getInt(2); // current cores
                optionalCore = rs.getInt(3);   /// # electives for given stream
                electives = rs.getInt(1);
                course_count = optionalCore + electives;
                System.out.print(course_count);
            }          //  System.out.println(course_count);

            //System.out.println(ele_count);
            String[] a = new String[ele_count];   // to hold all the electives names
            int[] b = new int[ele_count];  // int array of size = # electives.

            int ec = 0;
            //System.out.println(ec);
            int temp_i = 0;
            session.setAttribute("stream_table", stream_table);
            session.setAttribute("course_count", course_count);

            /*SELECT COUNT(*)
             FROM INFORMATION_SCHEMA.COLUMNS
             WHERE table_catalog = 'database_name' -- the database
             AND table_schema = 'dbo' -- or whatever your schema is
             AND table_name = 'table_name'

             */

             System.out.println(stream_table);

            int col_count = 0;
            ResultSet rs_check_pre_req_test = (ResultSet) st_pre_req_test.executeQuery("SELECT count(*) FROM information_schema.COLUMNS WHERE table_name = '" + stream_table + "'");

            if (rs_check_pre_req_test.next()) {

                //System.outprintln("helo colums"); 
                col_count =  rs_check_pre_req_test.getInt(1)/2; // number of clumns in the stream table
                 System.out.println("and col_count " + col_count);
            }
            //String arr = new Array();

            HashMap hm = new HashMap();
            //add key-value pair to hashmap
            hm.put("A+", 10);
            hm.put("A", 9);
            hm.put("B+", 8);
            hm.put("B", 7);
            hm.put("C", 6);
            hm.put("D", 5);
            hm.put("R", 1);
            hm.put("NR", 1);
            hm.put("F", 1);

            // System.out.println(hm);
            //  System.out.println(values + "\n" + values1);
        %>




        
    </head>
    <body bgcolor="#CCFFFF"  onload="dothis(1,1)">






        <%


            Statement st7 = con.createStatement();
            Statement st8 = con.createStatement();
            Statement st9 = con.createStatement();
            Statement st10 = con.createStatement();
            Statement st_study = con.createStatement();
            Statement st_check = con.createStatement();
            Statement st_pre_req = con.createStatement();

            // ResultSet rs_course1 = (ResultSet) st7.executeQuery("select course_name, pre_req_1, pre_req_2, pre_req_grade1, pre_req_grade2 , " + stream + " from elective_table where " + stream + "!=0");
            ResultSet rs_course1 = (ResultSet) st7.executeQuery("select course_name, " + stream + " from " + given_year + "_" + given_session + "_elective where " + stream + "!=0");
            ResultSet rs_studetails = (ResultSet) st8.executeQuery("select * from " + stream_table + "");
            String elective, elective1;


            // newly added code here for alowing to change ele to other ele , so we need to take display the previous taken ele from master table
            Statement st4_old_ele = con.createStatement();
             Statement st4_old_ele1 = con.createStatement();


            ResultSet rs_ele_loc = (ResultSet) st2.executeQuery("select Electives, Cores,OptionalCore from " + currrefer_s);

            int ele_stop = 1, ele_start = 1, core_start = 1,opt_start = 1;   // ele_start has position from which we have to insert the electives, eg : ele3,ele4 for ai-ii
            while (rs_ele_loc.next()) {                      // core_start contains start position of cores in this semester for given stream.
                if (ele_stop < sem2) {
                    ele_start = ele_start + rs_ele_loc.getInt(1);
                    core_start = core_start + rs_ele_loc.getInt(2);
                    opt_start = opt_start+rs_ele_loc.getInt(3);
                } else {
                    rs_ele_loc.afterLast();
                }
                ele_stop = ele_stop + 1;
            }



        //    System.out.println("ele start here:" + ele_start);
        //    System.out.println("cores start here:" + core_start);
            // newly added end here

        %>
        <table width="100%" align="center" class="head_pos">
            <tr>
                <td align="center"><h2><u><font color="#c2000d">Elective Registration For <%=stream1%></font></u></h2></td>
            </tr>
        </table>

        <form action="choose_ele_new_stored.jsp" name="ele_form" id="ele_form">
            <table width="100%" align="center">
                <tr>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td>&nbsp;</td>
                </tr>
            </table>
            <table align="center" border="1">

                <tr class="fix">

                    <td class="style31" align="center"><b>Student ID</b></td>
                    <td class="style31" align="center"><b>Student Name</b></td>

                    <% int i;
                        int len = 150;
                        for (i = 1; i <=optionalCore ; i++) {
                    %> 
                    <td style="width:<%=len%>px;" class="style31" align="center" ><b>Optional Core<%=i%></b></td>




                    <% }
                         for (i = 1; i <= electives;i++) {
                    %> 
                    <td style="width:<%=len%>px;" class="style31" align="center" ><b>Elective<%=i%></b></td>




                    <% }
                    %>

                </tr>
                <%               int j = 1;
               
                  
                    try{
                    while (rs_student.next() ) {

                        //System.out.println(rs_student.getString(1));
                        String student_id = rs_student.getString(1);
                        String student_name = rs_student.getString(2);
                        int core_start_live = core_start;
                        int ele_start_live = ele_start;
                        int optionalCore_start_live = opt_start;
                        
           
                %>
                <tr>

                    <td align="center" ><b><%=student_id%></b></td> 
                    <td align="center" ><b><%=student_name%></b></td> 


                    <% len = 150;
                        int temp1 = optionalCore;
                        for (i = 1; i <= course_count; i++) {

                            //$$$$$$$$$  check if alredy has taken electives from the master table.$$$$$$$$$$$$$$$$$$
                            //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$                       
                             ResultSet rs_old_ele;
                            //  take the coresponding electives like ele3, ele4 for m.tech-ai-ii  
                            //   System.out.println(temp1 + " "+i);
                            int old_ele_flag = 0;
                            if( temp1 <  i)
                            {
                                // System.out.println(temp1 + " "+i + "eledsc  " + ele_start_live);
                                rs_old_ele = (ResultSet) st4_old_ele1.executeQuery("select ele" + ele_start_live + " from " + stream_table + "  where StudentId='" + student_id + "'"); 
                                ele_start_live = ele_start_live + 1;
                             
                            }
                            else
                            {
                               rs_old_ele = (ResultSet) st4_old_ele.executeQuery("select optCore" + optionalCore_start_live + " from " + stream_table + "  where StudentId='" + student_id + "'");
                            // temp1 = temp1 +1;
                               optionalCore_start_live = optionalCore_start_live+1;
                            }
                            String old_ele = "none";
                            if (rs_old_ele.next()) {
                                //System.out.println("srinivas tet here me "+rs_old_ele.getString(1));
                                String col_value = (String) rs_old_ele.getString(1);
                                //    System.out.print(col_value);
                                //  date = 13/11/13 here we have problem with comparision
                                if (col_value != null && !col_value.isEmpty() && !col_value.equalsIgnoreCase("null")) {
                                    old_ele = rs_old_ele.getString(1);
                                    old_ele_flag = 1;

                                }
                            }
                            // if ele alread choosen then make it selected in the drop down box.
                            if (old_ele_flag == 1) {

                                String subname = "";
                                ResultSet rs_old_ele2 = st0.executeQuery("select Subject_Name  from subjecttable where Code='" + old_ele + "'");
                                if (rs_old_ele2.next()) {

                                    subname = rs_old_ele2.getString(1);
                    %> 

                    <td>
                        <select name="select<%=Integer.toString(i)%><%=Integer.toString(j)%>" id="select<%=Integer.toString(i)%><%=Integer.toString(j)%>" onchange="dothis(<%=Integer.toString(i)%>,<%=Integer.toString(j)%>);" style="width:<%=len%>px;">
                            <option value="<%=old_ele%>" selected="selected"><%=subname%></option>
                            <option value="none">none</option>

                            <%


                                }

                            } else {



                            %> 

                            <td>



                                <select name="select<%=Integer.toString(i)%><%=Integer.toString(j)%>" id="select<%=Integer.toString(i)%><%=Integer.toString(j)%>" onchange="dothis(<%=Integer.toString(i)%>,<%=Integer.toString(j)%>);" style="width:<%=len%>px;">
                                    <option value="none">none</option>


                                    <% }



                                        ResultSet rs3 = null;
                                        // System.out.println("testing here");
                                        int temp = optionalCore;
                                        if( temp < i )
                                        {
                                            rs3 = (ResultSet) st3.executeQuery("select Code,Subject_Name from subjecttable as a," + given_year + "_" + given_session + "_elective as b where a.Code=b.course_name AND  b." + stream + "!=0 ");
                                           // temp = temp+1;
                                        }
                                        else
                                            rs3 = (ResultSet) st3.executeQuery("select Code,Subject_Name from subjecttable as a," + given_year + "_" + given_session + "_elective as b where a.Code=b.course_name AND  b." + stream + "!=0 AND a.type = 'O'");
                                        while (rs3.next()) {
                                            //   System.out.println(rs3.getString(2));

                                            // check for the cores and ele in master table of batch, to confirm that student already studied or not this subject.
                                            // check for the pre-requisite validation.
                                            String check_ele = ""; // for study
                                            String check_core = ""; // for study
                                            String check_optCore = ""; // for study
                                            String pre_req1_check_ele = ""; // to check pre_requisite
                                            String pre_req1_check_core = "";
                                             String pre_req1_check_optCore = "";
                                            String pre_req2_check_ele = ""; // to check pre_requisite
                                            String pre_req2_check_core = "";
                                             String pre_req2_check_optCore = "";

                                            String pre_req1_check_ele_no_grade = ""; // to check pre_requisite
                                            String pre_req1_check_core_no_grade = "";
                                            String pre_req1_check_optCore_no_grade = "";
                                            String pre_req2_check_ele_no_grade = ""; // to check pre_requisite
                                            String pre_req2_check_core_no_grade = "";
                                            String pre_req2_check_optCore_no_grade = "";

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

                                           Statement alias_core = con.createStatement();
                                            String pre_req1_alias = null;
                                            
                                            String aliasQuery = "select SubCode from "+ curriculum +" where Alias='"+pre_req1+"'";
                                            System.out.println( aliasQuery);
                                            ResultSet rs_alias_core = (ResultSet)alias_core.executeQuery(aliasQuery);
                                            System.out.println(curriculum);
                                            if( rs_alias_core.next() == true )
                                            {
                                                System.out.println( rs_alias_core.getString(1) + " Heloooo ");
                                                if( rs_alias_core.getString(1) != null)
                                                {
                                                    pre_req1_alias = rs_alias_core.getString(1);
                                                }
                                                else
                                                {
                                                    pre_req1_alias = pre_req1;
                                                }
                                            }
                                            else
                                            {
                                                pre_req1_alias = pre_req1;
                                            }
                                            
                                             Statement alias_core1 = con.createStatement();
                                            String pre_req2_alias = null;
                                          //  String aliasQuery1 = 
                                            ResultSet rs_alias_core1 = (ResultSet)alias_core1.executeQuery("select SubCode from "+ curriculum +" where Alias='"+pre_req2+"'");
                                            if( rs_alias_core1.next() == true )
                                            {
                                                System.out.println( rs_alias_core1.getString(1) + " Heloooo111 ");
                                                if( rs_alias_core1.getString(1) != null)
                                                {
                                                    pre_req2_alias = rs_alias_core1.getString(1);
                                                }
                                                 else
                                                {
                                                    pre_req2_alias = pre_req2;
                                                }
                                            }
                                            else
                                            {
                                                pre_req2_alias = pre_req2;
                                            }
                                            
                                            System.out.println( pre_req2_alias + " alias " + pre_req1_alias);
                                            
                                            for (int ch = 1; ch <= total_cores_i; ch++) {
                                                if (ch == 1) {
                                                    check_core = "core" + ch + "='" + rs3.getString(1) + "'";
                                                    pre_req1_check_core = "core" + ch + "='" + pre_req1_alias + "' AND c" + ch + "grade='" + pre_req1_grade + "'  ";
                                                    pre_req2_check_core = "core" + ch + "='" + pre_req2_alias + "' AND c" + ch + "grade='" + pre_req2_grade + "'  ";

                                                    pre_req1_check_core_no_grade = "core" + ch + "='" + pre_req1_alias + "'  ";
                                                    pre_req2_check_core_no_grade = "core" + ch + "='" + pre_req2_alias + "' ";

                                                } else {
                                                    check_core = check_core + " or " + "core" + ch + "='" + rs3.getString(1) + "'";
                                                    pre_req1_check_core = pre_req1_check_core + " OR  ( " + "core" + ch + "='" + pre_req1_alias + "' AND c" + ch + "grade='" + pre_req1_grade + "' )";
                                                    pre_req2_check_core = pre_req2_check_core + " OR  ( " + "core" + ch + "='" + pre_req2_alias + "' AND c" + ch + "grade='" + pre_req2_grade + "' )";

                                                    pre_req1_check_core_no_grade = pre_req1_check_core_no_grade + " OR  ( " + "core" + ch + "='" + pre_req1_alias + "'  )";
                                                    pre_req2_check_core_no_grade = pre_req2_check_core_no_grade + " OR  ( " + "core" + ch + "='" + pre_req2_alias + "'  )";

                                                }
                                            }
                                            
                                             for (int ch = 1; ch <= total_optional_i; ch++) {
                                                if (ch == 1) {
                                                    check_optCore = "optCore" + ch + "='" + rs3.getString(1) + "'";
                                                    pre_req1_check_optCore = "optCore" + ch + "='" + pre_req1 + "' AND o" + ch + "grade='" + pre_req1_grade + "'  ";
                                                    pre_req2_check_optCore = "optCore" + ch + "='" + pre_req2 + "' AND o" + ch + "grade='" + pre_req2_grade + "'  ";

                                                    pre_req1_check_optCore_no_grade = "optCore" + ch + "='" + pre_req1 + "'  ";
                                                    pre_req2_check_optCore_no_grade = "optCore" + ch + "='" + pre_req2 + "' ";

                                                } else {
                                                    check_optCore = check_optCore + " or " + "optCore" + ch + "='" + rs3.getString(1) + "'";
                                                    pre_req1_check_optCore = pre_req1_check_optCore + " OR  ( " + "optCore" + ch + "='" + pre_req1 + "' AND o" + ch + "grade='" + pre_req1_grade + "' )";
                                                    pre_req2_check_optCore = pre_req2_check_optCore + " OR  ( " + "optCore" + ch + "='" + pre_req2 + "' AND o" + ch + "grade='" + pre_req2_grade + "' )";

                                                    pre_req1_check_optCore_no_grade = pre_req1_check_optCore_no_grade + " OR  ( " + "optCore" + ch + "='" + pre_req1 + "'  )";
                                                    pre_req2_check_optCore_no_grade = pre_req2_check_optCore_no_grade + " OR  ( " + "optCore" + ch + "='" + pre_req2 + "'  )";

                                                }
                                            }
                                             
                           //                  System.out.println( "opt core Test : " + pre_req1_check_optCore_no_grade +" "+pre_req2_check_optCore_no_grade);
                                            /*  System.out.println("srinivas chekc  "+pre_req1_check_core);
                                             System.out.println("helo core wo g :"+pre_req2_check_core_no_grade);
                                             System.out.println("helo ele wo g :"+pre_req2_check_ele_no_grade);
                                             System.out.println("helo core w g :"+pre_req2_check_core);
                                             System.out.println("helo ele w g :"+pre_req2_check_ele);
                                             System.out.println("helo pq2 and grade2 :"+pre_req2_grade +"  "+pre_req2);
                                             System.out.println("helo pq1  grade 1 :"+pre_req1_grade+"  "+pre_req1);
                                             */
                                             int study_flag = 0;
                                             if(total_optional_i>0)
                                             {
                                                String query = "select * from " + stream_table + " where StudentId='" + student_id + "' and (" + check_optCore +  ")";
                                            //    System.out.println(query);
                                                ResultSet rs_check_study1 = (ResultSet) st_study.executeQuery(query);
                                                 if(rs_check_study1.next() )
                                                {
                                                  study_flag = 1;
                                                }
                                             }
                                            String query = "select * from " + stream_table + " where StudentId='" + student_id + "' and (" + check_ele + " or " + check_core +  ")";
                                            ResultSet rs_check_study = (ResultSet) st_study.executeQuery("select * from " + stream_table + " where StudentId='" + student_id + "' and (" + check_ele + " or " + check_core +  ")");
                                            
                               //             System.out.println( query );
                                           
                                            if (rs_check_study.next()) {
                                                study_flag = 1;
                                            }

                               //             System.out.println(study_flag+" ");

                                            // verify whether this subject has to be there for this student.                                                                          
                                            Statement alias = con.createStatement();
                                            ResultSet rs_alias = null;

                                            if (study_flag == 0 && pre_req1.equals("none") && pre_req2.equals("none")) {  //  both pre-req are none (00) , and not studied.    
                                    %>


                                    <option  value="<%=rs3.getString(1)%>"><%=rs3.getString(2)%></option>


                                    <%} else if (study_flag == 0 && (pre_req1.equals("none") && !(pre_req2.equals("none")))) { //01

                                        if (pre_req2_grade.equals("")) {
                                            // check in the ele, cores whether this student has that pre-req2 or not, without looking at grade.
                                            ResultSet rs_check_pre_req = null;
                                             if(total_optional_i>0)
                                             {
                                                rs_check_pre_req = (ResultSet) st_pre_req.executeQuery("select * from " + stream_table + " where StudentId='" + student_id + "' and )" + pre_req2_check_ele_no_grade + " or " + pre_req2_check_core_no_grade + " or " + pre_req2_check_optCore_no_grade + ")");
                                             } 
                                             else
                                             {
                                               rs_check_pre_req = (ResultSet) st_pre_req.executeQuery("select * from " + stream_table + " where StudentId='" + student_id + "' and )" + pre_req2_check_ele_no_grade + " or " + pre_req2_check_core_no_grade +")");  
                                             }
                                                     
                                            if (rs_check_pre_req.next()) {
                                    %>


                                    <option  value="<%=rs3.getString(1)%>"><%=rs3.getString(2)%></option>


                                    <%

                                        }


                                    } else {

                                        //System.out.println("s code and preq "+ "and"+pre_req2);                                     
                                        ResultSet rs_check_pre_req = null;
                                        if(total_optional_i>0)
                                        {
                                          rs_check_pre_req = (ResultSet) st_pre_req.executeQuery("select * from " + stream_table + " where StudentId='" + student_id + "' and (" + pre_req2_check_ele_no_grade + " or " + pre_req2_check_core_no_grade +  " or " + pre_req2_check_optCore_no_grade + ")");
                                        }        
                                        else
                                        {
                                          rs_check_pre_req = (ResultSet) st_pre_req.executeQuery("select * from " + stream_table + " where StudentId='" + student_id + "' and (" + pre_req2_check_ele_no_grade + " or " + pre_req2_check_core_no_grade +  ")");                  
                                        }
                                        
                                        if (rs_check_pre_req.next()) {
                                            // System.out.println("s code and preq "+ "and"+pre_req2);
                                            // System.out.println("and  "+col_count);      //  tested getting zero here.                                  
                                            for (int col = 1; col <= col_count; col++) {

                                                String code = rs_check_pre_req.getString(col);

                                                //System.out.println("code and preq "+code+ "and"+pre_req2);     // test                             
                                                if (code != null) {
                                                    rs_alias = (ResultSet)alias.executeQuery("select Alias from "+ curriculum +" where SubCode='"+code+"'");
                                                    if( rs_alias.next() == true)
                                                    {
                                                       String code1 = rs_alias.getString(1);
                                                        if( code1 != null)
                                                            code = code1;
                                                    }
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
                                                rs_alias = null;

                                                }

                                            }
                                        }


                                    } ////  here 1st elseif
                                    else if (study_flag == 0 && (!(pre_req1.equals("none")) && pre_req2.equals("none"))) { //10

                                        if (pre_req1_grade.equals("")) {
                                            // check in the ele, cores whether this student has that pre-req2 or not, without looking at grade.

                                            ResultSet rs_check_pre_req = null;
                                            if(total_optional_i > 0)
                                            {
                                              rs_check_pre_req =  (ResultSet) st_pre_req.executeQuery("select * from " + stream_table + " where StudentId='" + student_id + "' and (" + pre_req1_check_ele_no_grade + " or " + pre_req1_check_core_no_grade + " or " + pre_req1_check_optCore_no_grade + ")");
                                            }
                                            else
                                            {
                                              rs_check_pre_req =  (ResultSet) st_pre_req.executeQuery("select * from " + stream_table + " where StudentId='" + student_id + "' and (" + pre_req1_check_ele_no_grade + " or " + pre_req1_check_core_no_grade + ")");  
                                            }
                                            if (rs_check_pre_req.next()) {
                                    %>


                                    <option  value="<%=rs3.getString(1)%>"><%=rs3.getString(2)%></option>


                                    <%

                                        }


                                    } else {
                                           
                                        String query1 = null;                                           
                                        if( total_optional_i > 0)
                                        {
                                            query1 = "select * from " + stream_table + " where StudentId='" + student_id + "' and (" + pre_req1_check_ele_no_grade + " or " + pre_req1_check_core_no_grade +  " or " + pre_req1_check_optCore_no_grade + ")";
                                            System.out.println( " query1 : " + query1 );
                                        }
                                        else
                                        {
                                            query1 = "select * from " + stream_table + " where StudentId='" + student_id + "' and (" + pre_req1_check_ele_no_grade + " or " + pre_req1_check_core_no_grade + ")";
                                        }
                                        ResultSet rs_check_pre_req = (ResultSet) st_pre_req.executeQuery(query1);
                                        if (rs_check_pre_req.next()) {
                                            String code1 = rs_check_pre_req.getString(1);
                                            //             System.out.println( "code befor : " +code1 + " "+ student_id);
                                            for (int col = 1; col <= col_count; col++) {
                                                String code = rs_check_pre_req.getString(col);
                                                System.out.println( " code "+ code);
                                                if (code != null) {
                                                    rs_alias = (ResultSet)alias.executeQuery("select Alias from "+ curriculum +" where SubCode='"+code+"'");
                                                    if( rs_alias.next() == true)
                                                    {
                                                        String code12 = rs_alias.getString(1);
                                                        if( code12 != null)
                                                            code = code12;
                                                    }
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
                                                        System.out.println( left_i + " " + right_i);
                                                        if (left_i >= right_i) {

                                    %>


                                    <option  value="<%=rs3.getString(1)%>"><%=rs3.getString(2)%></option>


                                    <%

                                                            }
                                                            col = col_count + 1;
                                                        }
                                                    }
                                                   rs_alias = null; 
                                                }

                                            }
                                        }

                                    } // 2nd else if    
                                    else if (study_flag == 0 && (!(pre_req1.equals("none")) && !(pre_req2.equals("none")))) { //11

                                        if (pre_req1_grade.equals("") && pre_req2_grade.equals("")) {
                                            // check in the ele, cores whether this student has that pre-req2 or not, without looking at grade.
                                            ResultSet rs_check_pre_req = null;
                                            if ( total_optional_i > 0)
                                            {
                                                rs_check_pre_req = (ResultSet) st_pre_req.executeQuery("select * from " + stream_table + " where StudentId='" + student_id + "' and (" + pre_req1_check_ele_no_grade + " or " + pre_req1_check_core_no_grade +" or " + pre_req1_check_optCore_no_grade +" or " + pre_req2_check_ele_no_grade + " or " + pre_req2_check_core_no_grade + " or "+ pre_req2_check_optCore_no_grade+" )");
                                            }
                                            else
                                            {
                                                rs_check_pre_req = (ResultSet) st_pre_req.executeQuery("select * from " + stream_table + " where StudentId='" + student_id + "' and (" + pre_req1_check_ele_no_grade + " or " + pre_req1_check_core_no_grade +" or " + pre_req1_check_optCore_no_grade +" or " + pre_req2_check_ele_no_grade + " or " + pre_req2_check_core_no_grade + ")");
                                            }
                                            if (rs_check_pre_req.next()) {
                                    %>


                                    <option  value="<%=rs3.getString(1)%>"><%=rs3.getString(2)%></option>


                                    <%

                                        }


                                    } else if (!(pre_req1_grade.equals("")) && !(pre_req2_grade.equals(""))) {
                                        
                                        ResultSet rs_check_pre_req = null;
                                            if ( total_optional_i > 0)
                                            {
                                                rs_check_pre_req = (ResultSet) st_pre_req.executeQuery("select * from " + stream_table + " where StudentId='" + student_id + "' and (" + pre_req1_check_ele_no_grade + " or " + pre_req1_check_core_no_grade +" or " + pre_req1_check_optCore_no_grade +" or " + pre_req2_check_ele_no_grade + " or " + pre_req2_check_core_no_grade + " or "+ pre_req2_check_optCore_no_grade+" )");
                                            }    
                                            else
                                            {
                                                rs_check_pre_req = (ResultSet) st_pre_req.executeQuery("select * from " + stream_table + " where StudentId='" + student_id + "' and (" + pre_req1_check_ele_no_grade + " or " + pre_req1_check_core_no_grade +" or " + pre_req2_check_ele_no_grade + " or " + pre_req2_check_core_no_grade + " )");
                                            }
                                            
                                        // ResultSet rs_check_pre_req = (ResultSet) st_pre_req.executeQuery("select * from " + stream_table + " where StudentId='"+student_id+"' and ("+pre_req1_check_ele+" or "+ pre_req1_check_core+") and ("+pre_req2_check_ele+" or "+ pre_req2_check_core+" )" );       
                                        
                                        if (rs_check_pre_req.next()) {
                                            System.out.println(" STudent id : "+ student_id + " ");
                                            int flag1 = 0, flag2 = 0;
                                            for (int col = 1; col <= col_count; col++) {
                                                String code = rs_check_pre_req.getString(col);
                                            //     System.out.println("code and preq "+code+ "and"+pre_req2); 
                                                if (code != null) {
                                                    rs_alias = (ResultSet)alias.executeQuery("select Alias from "+ curriculum +" where SubCode='"+code+"'");
                                                    if( rs_alias.next() == true)
                                                    {
                                                        String code1 = rs_alias.getString(1);
                                                        if( code1 != null)
                                                            code = code1;
                                                    }
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
                                                        System.out.println(left_i +" "+right_i);
                                                        if (left_i >= right_i) {

                                                            flag1 = 1; // grade1 is okey

                                                        }
                                                        col = col_count + 1;
                                                    }
                                                    rs_alias = null;
                                                }

                                            }

                                            // second grade checking
                                            for (int col = 1; col <= col_count; col++) {

                                                String code = rs_check_pre_req.getString(col);

                                                System.out.println("code and preq "+code+ "and"+pre_req2);     // test                             
                                                if (code != null) {
                                                    rs_alias = (ResultSet)alias.executeQuery("select Alias from "+ curriculum +" where SubCode='"+code+"'");
                                                    if( rs_alias.next() == true)
                                                    {
                                                       String code1 = rs_alias.getString(1);
                                                        if( code1 != null)
                                                            code = code1;
                                                    }
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
                                                rs_alias = null;
                                            }

                                            if (flag1 == 1 || flag2 == 1) {

                                    %>


                                    <option  value="<%=rs3.getString(1)%>"><%=rs3.getString(2)%></option>


                                    <%

                                            }


                                        } // database checking okey brace

                                    } // else brace
                                    else if (!(pre_req1_grade.equals("")) && (pre_req2_grade.equals(""))) {  // grade 1 given, grade 2 is not .

                                         ResultSet rs_check_pre_req = null;
                                            if ( total_optional_i > 0)
                                            {
                                                rs_check_pre_req = (ResultSet) st_pre_req.executeQuery("select * from " + stream_table + " where StudentId='" + student_id + "' and (" + pre_req1_check_ele_no_grade + " or " + pre_req1_check_core_no_grade +" or " + pre_req1_check_optCore_no_grade +" or " + pre_req2_check_ele_no_grade + " or " + pre_req2_check_core_no_grade + " or "+ pre_req2_check_optCore_no_grade+" )");
                                            }    
                                            else
                                            {
                                                rs_check_pre_req = (ResultSet) st_pre_req.executeQuery("select * from " + stream_table + " where StudentId='" + student_id + "' and (" + pre_req1_check_ele_no_grade + " or " + pre_req1_check_core_no_grade +" or " + pre_req2_check_ele_no_grade + " or " + pre_req2_check_core_no_grade + " )");
                                            }
                                        //ResultSet rs_check_pre_req = (ResultSet) st_pre_req.executeQuery("select * from " + stream_table + " where StudentId='"+student_id+"' and "+pre_req1_check_ele_no_grade+" or "+ pre_req1_check_core_no_grade+"" );         
                                        
                                        if (rs_check_pre_req.next()) {

                                            for (int col = 1; col <= col_count; col++) {
                                                String code = rs_check_pre_req.getString(col);
                                                if (code != null) {
                                                    rs_alias = (ResultSet)alias.executeQuery("select Alias from "+ curriculum +" where SubCode='"+code+"'");
                                                    if( rs_alias.next() == true)
                                                    {
                                                        String code1 = rs_alias.getString(1);
                                                        if( code1 != null)
                                                            code = code1;
                                                    }
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
                                                      else
                                                    {
                                                       if (code.equals(pre_req2)) {
                                                            %>
                                                           
                                                           <option  value="<%=rs3.getString(1)%>"><%=rs3.getString(2)%></option>
                                                           <%
                                                            break;
                                                       } 
                                                    }
                                                }
                                                rs_alias = null;
                                            }

                                        } /// upto here

                                    } else if ((pre_req1_grade.equals("")) && !(pre_req2_grade.equals(""))) {  // grade 2 given, grade 1 is not .
                                        
                                         ResultSet rs_check_pre_req = null;
                                            if ( total_optional_i > 0)
                                            {
                                                rs_check_pre_req = (ResultSet) st_pre_req.executeQuery("select * from " + stream_table + " where StudentId='" + student_id + "' and (" + pre_req1_check_ele_no_grade + " or " + pre_req1_check_core_no_grade +" or " + pre_req1_check_optCore_no_grade +" or " + pre_req2_check_ele_no_grade + " or " + pre_req2_check_core_no_grade + " or "+ pre_req2_check_optCore_no_grade+" )");
                                            }    
                                            else
                                            {
                                                String query3 = "select * from " + stream_table + " where StudentId='" + student_id + "' and (" + pre_req1_check_ele_no_grade + " or " + pre_req1_check_core_no_grade +" or " + pre_req2_check_ele_no_grade + " or " + pre_req2_check_core_no_grade + " )";
                                                System.out.println( query3);
                                                rs_check_pre_req = (ResultSet) st_pre_req.executeQuery(query3);
                                                System.out.println("Helloooooooooo");
                                            }
                                        //ResultSet rs_check_pre_req = (ResultSet) st_pre_req.executeQuery("select * from " + stream_table + " where StudentId='"+student_id+"' and ("+pre_req1_check_ele_no_grade+" or "+ pre_req1_check_core_no_grade+") and ("+pre_req2_check_ele+" or "+ pre_req2_check_core+" )" );       
                                     //   System.out.println( " query2" + query2 );
                                        if (rs_check_pre_req.next()) {
                                             System.out.println("s code and preq "+ "and"+pre_req2);
                                             System.out.println("and  "+col_count);      //  tested getting zero here.                                  
                                            
                                            for (int col = 1; col <= col_count; col++) {

                                                String code = rs_check_pre_req.getString(col);

                                                //System.out.println("code and preq "+code+ "and"+pre_req2);     // test                             
                                                if (code != null) {
                                                    rs_alias = (ResultSet)alias.executeQuery("select Alias from "+ curriculum +" where SubCode='"+code+"'");
                                                    if( rs_alias.next() == true)
                                                    {
                                                        String code1 = rs_alias.getString(1);
                                                        if( code1 != null)
                                                            code = code1;
                                                    }
                                                    System.out.println(" check :" + code);
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
                                                     else
                                                    {
                                                       if (code.equals(pre_req1)) {
                                                            %>
                                                           
                                                           <option  value="<%=rs3.getString(1)%>"><%=rs3.getString(2)%></option>
                                                           <%
                                                            break;
                                                       } 
                                                    }
                                                            }
                                                            rs_alias = null;
                                                        }

                                                    }

                                                }


                                            }


                                        }


                                    %>


                                    <%}
                                            j = j + 1;
                 //   }
                                        }
                    // while end here 
                    cgpa.dropTable(stream_table);
                                    }
                                    catch( Exception e)
                                    {
                                        System.out.println(e);
                                    }
                                    %>
                                </select>

                            </td>   
                </tr>


                <tr>
                    &nbsp;
                </tr>



                <tr>
                    &nbsp;
                </tr>

            </table>



            <br><br>
            <table width="100%" class="pos_fixed">
                <tr>

                    <td align="center" class="border"><input type="submit" name="submit" value="SUBMIT" ></td>

                </tr>
            </table>
            <input type="hidden" name="given_session" value="<%=given_session%>">
            <input type="hidden" name="given_year" value="<%=given_year%>"> 
            <input type="hidden" name="stream" value="<%=stream%>">
            <input type="hidden" name="stream_table" value="<%=stream_table%>">
            <input type="hidden" name="curriculum" value="<%=curriculum%>">
            <input type="hidden" name="currrefer_s" value="<%=currrefer_s%>">
            <input type="hidden" name="current_cores" value="<%=current_cores%>">
             <input type="hidden" name="program_name" value="<%=program_name%>">

            <input type="hidden" name="total_cores" value="<%=total_cores%>">
            <input type="hidden" name="total_ele" value="<%=total_ele%>">
            <input type="hidden" name="course_count" value="<%=course_count%>">
            <input type="hidden" name="optionalCore_count" value="<%=optionalCore%>">


        </form>
        <script>  
            
            
            //  hash map creating
            
            var arr = new Array();
            var arr2= new Array();
            var arr2names= new Array();
            <%
                while (rs_course1.next()) {

                    String code = rs_course1.getString(1);
                    String limit = rs_course1.getString(2);
                    //System.out.println(code + " limit :" + limit);
            %>  

                //add key-value pair to hashmap
                arr["<%=code%>"]=<%=limit%>;
                arr2["<%=code%>"]=0;
                //arr2_names[]         
                //alert(arr["AI720"] +" and"+arr["CS785"]);

            <% }%>
                   
    
    
    
    <%  while(res_ele_count.next()){
                              String ele_code = res_ele_count.getString(1);
                              String ele_name = res_ele_count.getString(2);
    %>   
            arr2names["<%=ele_code%>"]="<%=ele_name%>";
             
       <% }
                         %>
    
    
                    
                //  alert(arr["AI720"] +" and"+arr["CS799"]);        
            
            
                function dothis(col, row)
                {  
                    var name_plus_limit=" ";
                
                    //        alert("<%=currrefer_s%>");
            
                    //// $$$$$$$$$$$$$$$$$$$$$   logic for disabling the duplicate eletive selections. $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$44
            
                    var course_count=<%=course_count%>;
                    //alert("see this row, cols "+ row+", "+col);
                    var sel_code=$("#select"+col+row).val(); 
                    //var sel_col=parseInt(document.getElementById("select"+col+row).options.selectedIndex);
                    // alert("see this row, cols "+sel_col);
                    var i=1,flag=0;
                    for(i=1;i<=course_count;i++){
                        if(col===i){continue;}
                        // var str_i=i+'';
                        var comp_code=$("#select"+i+row).val(); 
                        // var comp_col=parseInt(document.getElementById("select"+i+row).options.selectedIndex);
                        //alert("select"+''+i+row);
                    
                        if(sel_code===comp_code){
                            //var subj_code =document.getElementsByTagName("option")[sel_col].value;
                            if(sel_code!=="none"){
                                //document.getElementById("select"+col+row).options.selectedIndex=(0);
                                $("#select"+col+row).val("none");
                                flag=1;
                            }
                        }
       
                    }
            
            
             
                    if(flag===0){

                        // $$$$$$$$$$$$$$$$$4 logic for stream limit handling. $$$$$$$$$$$$$$$$
                        //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
                  
            <%    rs_course1.beforeFirst();
                while (rs_course1.next()) {

                    String code = rs_course1.getString(1);
                    String limit = rs_course1.getString(2);

            %>  

                        //add key-value pair to hashmap
                        //arr["<%=code%>"]=<%=limit%>;
                        arr2["<%=code%>"]=0;
             
                        //  var  course_count_i=Interger.parseInt(course_count);

            <% }%>  
            
              
                        var j=<%=j%>;
                        j=j-1;
                        // alert(j+"  "+"<%=course_count%>");
                        var k,l;
                        for (k = 1; k <=j; k++) {
                            for (l = 1; l <=course_count; l++) {
                       
                                 
                                //alert("test"+l);
                                // jquery to get the selected value without going for index.
                                var subj_code=$("#select"+l+k).val(); 
                                // alert("test me"+l);
                                // var code_index= document.getElementById("select"+l+k).options.selectedIndex;
                                // var subj_code =document.getElementsByTagName("option")[code_index].value;
                                //  arr2[subj_code]=arr2[subj_code]+1;
                                //while()          
                     
                                //if(subj_code!="none")
                                // alert("code"+subj_code);
           
                               
                                if(arr2[subj_code]>=arr[subj_code]){
                                    alert("limit over");
                                    // document.getElementById("select"+col+row).options.selectedIndex=(0);
                                    $("#select"+col+row).val("none");
                                }
                                else{
                                    arr2[subj_code]=arr2[subj_code]+1;
                               
                                } 
                
                            }
                        }
            <%
                  Statement st_ele_count2 = (Statement) con.createStatement();
                  ResultSet res_ele_count2 = (ResultSet) st_ele_count2.executeQuery("select Code,Subject_Name from subjecttable as a," + given_year + "_" + given_session + "_elective as b where a.Code=b.course_name AND  b." + stream + "!=0");
                  int send_ele_count = 0;
                  while (res_ele_count2.next()) {
                      send_ele_count = send_ele_count + 1;
                      String code = res_ele_count2.getString(1);
            %>
                        var delimeter="&";
                        name_plus_limit=name_plus_limit.concat("<%=code%>"," : ", arr2["<%=code%>"], delimeter);                                  
        
            <%
        }
            %>
                        //self.location='course_reg_select_new.?'            
                      //document.getElementById("test1").innerHTML=name_plus_limit;
            
                        sessionStorage.setItem("code_limits",name_plus_limit);
                        sessionStorage.setItem("old_stream","<%=stream%>");
                        sessionStorage.setItem("send_ele_count","<%=send_ele_count%>");
                        parent.left.location.reload();
                        // alert("srinivas");
                        // writing hash map in js
                        /* 
                    var arr = new Array();
            <%--        <%
    while (rs_course1.next()) {

                    String code = rs_course1.getString(1);
                    String limit = rs_course1.getString(2);

%>  

                        //add key-value pair to hashmap
                        arr["<%=code%>"]=<%=limit%>;
             


            <% }%>   --%>
                    
                        for(var i in arr)
                        {
                            alert('Key='+i + ', Value = '+arr[i]);     
                        }

           
                         */
                    }  
                }
                

        </script>
        <%
            conn.closeConnection();
            con = null;
        %>
    </body>
</html>