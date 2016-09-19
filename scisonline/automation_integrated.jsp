<%@page import="sun.security.util.Length"%>
<%@page import="com.hcu.mysql.connection.ConnectionDemo"%>
<%@page import="com.mysql.jdbc.ResultSet"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@page import="java.util.HashMap" %>
<%@include file="dbconnection.jsp"%>
<%@include file="checkValidity.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
         <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script language="javaScript" type="text/javascript" src="calendar.js"></script>
        <script type="text/javascript" src="jquery-1.10.2.min.js">
            
        </script> 
        
        <style>
            .style30 {color: red}
            .style31 {color: white}
            .style32 {color: green}
            .style44{

                background-color: #9FFF9D;
            }
        </style>




        <%
            String given_session = request.getParameter("given_session");
            String given_year = request.getParameter("given_year");
            int year = Integer.parseInt(given_year);
            Calendar cal = Calendar.getInstance();
            //int year = cal.get(Calendar.YEAR);
            //  int month = cal.get(Calendar.MONTH) + 1;
            String stream = "", stream_table = "", currrefer_s = "", sem = "", stream1 = "", stream2 = "", curriculum = "";
            stream = request.getParameter("stream");
            //if(stream==null){ stream ="";}
            stream = stream.toUpperCase();
            stream = stream.replace('-', '_');
            //  System.out.println("hiiii stream :"+stream);
            // System.out.println("hiiii year :"+year);

            session.setAttribute("stream", stream);


            int course_count = 0,current_cores=0, max_stu = 0, total_stu = 0;

            int year2 = year;

            if (given_session.equals("Winter")) {
                if (stream.equals("MCA_IV")) {
                    year2 = year - 2;
                    stream_table = "MCA_" + Integer.toString(year2);
                    currrefer_s = "MCA_currrefer";
                    curriculum = "MCA_curriculum";
                    sem = "Sem4";
                    stream1 = "MCA IV";
                    stream2 = "MCA_IV";
                } else if (stream.equals("MTECH_CS_II")) {
                    year2 = year - 1;
                    stream_table = "MTech_CS_" + Integer.toString(year2);
                    currrefer_s = "MTech_CS_currrefer";
                    curriculum = "MTech_CS_curriculum";
                    sem = "Sem2";
                    stream1 = "MTECH CS II";
                    stream2 = "MTech_CS_II";
                } else if (stream.equals("MTECH_AI_II")) {
                    year2 = year - 1;
                    stream_table = "MTech_AI_" + Integer.toString(year2);
                    currrefer_s = "MTech_AI_currrefer";
                    curriculum = "MTech_AI_curriculum";
                    sem = "Sem2";
                    stream1 = "MTECH AI II";
                    stream2 = "MTech_AI_II";
                } else if (stream.equals("MTECH_IT_II")) {
                    year2 = year - 1;
                    stream_table = "MTech_IT_" + Integer.toString(year2);
                    currrefer_s = "MTech_IT_currrefer";
                    curriculum = "MTech_IT_curriculum";
                    sem = "Sem2";
                    stream1 = "MTECH IT II";
                    stream2 = "MTech_IT_II";
                }
            } else if (given_session.equals("Monsoon")) {
                if (stream.equals("MCA_III")) {
                    year2 = year - 1;
                    stream_table = "MCA_" + Integer.toString(year2);
                    currrefer_s = "MCA_currrefer";
                    curriculum = "MCA_curriculum";
                    sem = "Sem3";
                    stream1 = "MCA III";
                    stream2 = "MCA_III";
                } else if (stream.equals("MCA_V")) {
                    year2 = year - 2;
                    stream_table = "MCA_" + Integer.toString(year2);
                    currrefer_s = "MCA_currrefer";
                    curriculum = "MCA_curriculum";
                    sem = "Sem5";
                    stream1 = "MCA V";
                    stream2 = "MCA_V";
                } else if (stream.equals("MTECH_CS_I")) {
                    stream_table = "MTech_CS_" + Integer.toString(year2);
                    currrefer_s = "MTech_CS_currrefer";
                    curriculum = "MTech_CS_curriculum";
                    sem = "Sem1";
                    stream1 = "MTECH CS I";
                    stream2 = "MTech_CS_I";
                } else if (stream.equals("MTECH_AI_I")) {
                    stream_table = "MTech_AI_" + Integer.toString(year2);
                    currrefer_s = "MTech_AI_currrefer";
                    curriculum = "MTech_AI_curriculum";
                    sem = "Sem1";
                    stream1 = "MTECH AI I";
                    stream2 = "MTech_AI_I";
                } else if (stream.equals("MTECH_IT_I")) {
                    stream_table = "MTech_IT_" + Integer.toString(year2);
                    currrefer_s = "MTech_IT_currrefer";
                    curriculum = "MTech_IT_curriculum";
                    sem = "Sem1";
                    stream1 = "MTECH IT I";
                    stream2 = "MTech_IT_I";
                }
            }




            int ele_count = 0;

            Statement st1 = con.createStatement();
            Statement st2 = con.createStatement();
            Statement st3 = con.createStatement();
            Statement st4 = con.createStatement();
            Statement st5 = con.createStatement();
            Statement st6 = con.createStatement();
            Statement st_pre_req_test = con.createStatement();


            //$$$$$ total number ofcore,  electives for given branch. eg: ai has 6 cores, 4 elective throughout course
            ResultSet rs_core_ele = (ResultSet) st1.executeQuery("select * from " + curriculum + "");
            String total_cores = "";
            String total_ele = "";

            if (rs_core_ele.next()) {
                total_cores = rs_core_ele.getString(1);
                total_ele = rs_core_ele.getString(4);

            }
            int total_cores_i = Integer.parseInt(total_cores);
            int total_ele_i = Integer.parseInt(total_ele);





            ResultSet rs_student = (ResultSet) st1.executeQuery("select * from " + stream_table + "");
            ResultSet rs_student1 = (ResultSet) st2.executeQuery("select count(*) from " + stream_table + "");
            if (rs_student1.next()) {
                total_stu = rs_student1.getInt(1);
            }
            //System.out.println("laxman"+total_stu);
            ResultSet rs = (ResultSet) st3.executeQuery("select elective, core from " + currrefer_s + " where Semester = '" + sem + "'");
            if (rs.next()) {
                current_cores=rs.getInt(2); // current cores
                course_count = rs.getInt(1);   /// # electives for given stream
            }          //  System.out.println(course_count);
            ResultSet rs_max_stu1 = (ResultSet) st4.executeQuery("select count(*) from elective_table");
            if (rs_max_stu1.next()) {
                ele_count = rs_max_stu1.getInt(1);
            }
            //System.out.println(ele_count);
            String[] a = new String[ele_count];   // to hold all the electives names
            int[] b = new int[ele_count];  // int array of size = # electives.
            ResultSet rs_max_stu = (ResultSet) st5.executeQuery("select course_name, " + stream2 + " from elective_table where " + stream2 + "!=0");

            int ec = 0;
            //System.out.println(ec);
            ResultSet rs_course11 = (ResultSet) st6.executeQuery("select count(*) from elective_table where " + stream + "!=0");
            if (rs_course11.next()) {
                ec = rs_course11.getInt(1);               // tolal elective subjects for that given course (ec)
            }	   //System.out.println("nareh"+ec);
            int temp_i = 0;
            session.setAttribute("stream_table", stream_table);
            session.setAttribute("course_count", course_count);

            /*SELECT COUNT(*)
             FROM INFORMATION_SCHEMA.COLUMNS
             WHERE table_catalog = 'database_name' -- the database
             AND table_schema = 'dbo' -- or whatever your schema is
             AND table_name = 'table_name'

             */


            int col_count = 0;
            ResultSet rs_check_pre_req_test = (ResultSet) st_pre_req_test.executeQuery("SELECT count(*) FROM information_schema.COLUMNS WHERE table_name = '" + given_year + "_" + given_session + "_elective'");

            if (rs_check_pre_req_test.next()) {

                //System.out.println("helo colums");
                col_count = rs_check_pre_req_test.getInt(1);  // number of clumns in the stream table
               // System.out.println("and " + col_count);
            }
            //String arr = new Array();

            HashMap hm = new HashMap();
            //add key-value pair to hashmap
            hm.put("A+", 10);
            hm.put("A", 9);
            hm.put("B+", 8);
            hm.put("B", 7);
            hm.put("C", 6);
            hm.put("R", 1);
            hm.put("NR", 1);
            hm.put("F", 1);

            // System.out.println(hm);



            //  System.out.println(values + "\n" + values1);
            // System.out.println("laxman");
        %>

        
        
       
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
        </style>
    </head>
    <body bgcolor="#CCFFFF">






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
        int str_len = stream.length();
        int sem2 = 0;
        String sub_2 = (stream).substring(str_len - 2, str_len);  // MTech-CS-I OR -V, -AI-I OR -V, MCA-I OR -V,
        String sub_3 = (stream).substring(str_len - 3, str_len);  // -II, -IV, -VI ..etc
        String sub_4 = (stream).substring(str_len - 4, str_len);   // -III , -IIV , etc
        String sub_5 = (stream).substring(str_len - 5, str_len);    // mostly no need.

        if (sub_2.equals("_I")) {
            sem2 = 1;
        } else if (sub_2.equals("_V")) {
            sem2 = 5;
        } else if (sub_2.equals("_X")) {
            sem2 = 10;
        } else if (sub_3.equals("_IV")) {
            sem2 = 4;
        } else if (sub_3.equals("_II")) {
            sem2 = 2;
        } else if (sub_3.equals("_VI")) {
            sem2 = 6;
        } else if (sub_3.equals("_IX")) {
            sem2 = 9;
        } else if (sub_4.equals("_III")) {
            sem2 = 3;
        } else if (sub_4.equals("_VII")) {
            sem2 = 7;
        } else if (sub_5.equals("_VIII")) {
            sem2 = 8;
        }

        ResultSet rs_ele_loc = (ResultSet) st2.executeQuery("select elective, core from " + currrefer_s);

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


        
        System.out.println("ele start here:" + ele_start);
        System.out.println("cores start here:" + core_start);
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
                        for (i = 1; i <= course_count; i++) {
                    %> 
                    <td style="width:<%=len%>px;" class="style31" align="center" ><b>Elective<%=i%></b></td>




                    <% }
                    %>

                </tr>
                <%               int j = 1;
                    while (rs_student.next() && rs_studetails.next()) {

                        //System.out.println(rs_student.getString(1));
                        String student_id = rs_student.getString(1);
                        String student_name = rs_student.getString(2);
                         int core_start_live = core_start;
                         int ele_start_live = ele_start;
                        
                %>
                <tr>

                    <td align="center" ><b><%=student_id%></b></td> 
                    <td align="center" ><b><%=student_name%></b></td> 


                    <% len = 150;

                        for (i = 1; i <= course_count; i++) { 
                            
  //$$$$$$$$$  check if alredy has taken electives from the master table.$$$$$$$$$$$$$$$$$$
  //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$                       
                         
                        //  take the coresponding electives like ele3, ele4 for m.tech-ai-ii  
                        int old_ele_flag=0;
                        ResultSet rs_old_ele = (ResultSet) st4_old_ele.executeQuery("select ele" + ele_start_live +" from "+stream_table+"  where StudentId='" + student_id + "'");
                        ele_start_live = ele_start_live + 1;                            
                        String old_ele="none";
                        if(rs_old_ele.next()){
                        //System.out.println("srinivas tet here me "+rs_old_ele.getString(1));
                        String col_value=(String)rs_old_ele.getString(1);
                        
                        //  date = 13/11/13 here we have problem with comparision
                        if (col_value!= null && !col_value.isEmpty() && !col_value.equalsIgnoreCase("null") ){ 
                        System.out.println("srinivas tet here me "+rs_old_ele.getString(1));
                        old_ele=rs_old_ele.getString(1);
                        old_ele_flag=1;
                        
                        }
                       }
                       // if ele alread choosen then make it selected in the drop down box.
                       if(old_ele_flag==1){
                       
                           String subname = "";
                            ResultSet rs_old_ele2 = (ResultSet) ConnectionDemo.getStatementObj().executeQuery("select Subject_Name  from subjecttable where Code='" + old_ele + "'");
                            if (rs_old_ele2.next()) {

                                subname = rs_old_ele2.getString(1);
                        %> 

                         <td>
 <select name="select<%=Integer.toString(i)%><%=Integer.toString(j)%>" id="select<%=Integer.toString(i)%><%=Integer.toString(j)%>" onchange="dothis(<%=Integer.toString(i)%>,<%=Integer.toString(j)%>);" style="width:<%=len%>px;">
     <option value="<%=old_ele%>" selected="selected"><%=subname%></option>
     <option value="none">none</option>

                        <%
                       
                       
                       }                           
                                                   
                       }else{
                                                    
                            

                    %> 

                    <td>



                        <select name="select<%=Integer.toString(i)%><%=Integer.toString(j)%>" id="select<%=Integer.toString(i)%><%=Integer.toString(j)%>" onchange="dothis(<%=Integer.toString(i)%>,<%=Integer.toString(j)%>);" style="width:<%=len%>px;">
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
                                    /*  System.out.println("srinivas chekc  "+pre_req1_check_core);
                                     System.out.println("helo core wo g :"+pre_req2_check_core_no_grade);
                                     System.out.println("helo ele wo g :"+pre_req2_check_ele_no_grade);
                                     System.out.println("helo core w g :"+pre_req2_check_core);
                                     System.out.println("helo ele w g :"+pre_req2_check_ele);
                                     System.out.println("helo pq2 and grade2 :"+pre_req2_grade +"  "+pre_req2);
                                     System.out.println("helo pq1  grade 1 :"+pre_req1_grade+"  "+pre_req1);
                                     */
                                    ResultSet rs_check_study = (ResultSet) st_study.executeQuery("select * from " + stream_table + " where StudentId='" + student_id + "' and (" + check_ele + " or " + check_core + ")");

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

                                    ResultSet rs_check_pre_req = (ResultSet) st_pre_req.executeQuery("select * from " + stream_table + " where StudentId='" + student_id + "' and " + pre_req2_check_ele_no_grade + " or " + pre_req2_check_core_no_grade + "");
                                    if (rs_check_pre_req.next()) {
                            %>


                            <option  value="<%=rs3.getString(1)%>"><%=rs3.getString(2)%></option>


                            <%

                                }


                            } else {

                                //System.out.println("s code and preq "+ "and"+pre_req2);                                     
                                ResultSet rs_check_pre_req = (ResultSet) st_pre_req.executeQuery("select * from " + stream_table + " where StudentId='" + student_id + "' and " + pre_req2_check_ele_no_grade + " or " + pre_req2_check_core_no_grade + "");
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

                                    ResultSet rs_check_pre_req = (ResultSet) st_pre_req.executeQuery("select * from " + stream_table + " where StudentId='" + student_id + "' and " + pre_req1_check_ele_no_grade + " or " + pre_req1_check_core_no_grade + "");
                                    if (rs_check_pre_req.next()) {
                            %>


                            <option  value="<%=rs3.getString(1)%>"><%=rs3.getString(2)%></option>


                            <%

                                }


                            } else {

                                ResultSet rs_check_pre_req = (ResultSet) st_pre_req.executeQuery("select * from " + stream_table + " where StudentId='" + student_id + "' and " + pre_req1_check_ele_no_grade + " or " + pre_req1_check_core_no_grade + "");
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

                                    ResultSet rs_check_pre_req = (ResultSet) st_pre_req.executeQuery("select * from " + stream_table + " where StudentId='" + student_id + "' and (" + pre_req1_check_ele_no_grade + " or " + pre_req1_check_core_no_grade + ") and (" + pre_req2_check_ele_no_grade + " or " + pre_req2_check_core_no_grade + " )");
                                    if (rs_check_pre_req.next()) {
                            %>


                            <option  value="<%=rs3.getString(1)%>"><%=rs3.getString(2)%></option>


                            <%

                                }


                            } else if (!(pre_req1_grade.equals("")) && !(pre_req2_grade.equals(""))) {
                                ResultSet rs_check_pre_req = (ResultSet) st_pre_req.executeQuery("select * from " + stream_table + " where StudentId='" + student_id + "' and (" + pre_req1_check_ele_no_grade + " or " + pre_req1_check_core_no_grade + ") and (" + pre_req2_check_ele_no_grade + " or " + pre_req2_check_core_no_grade + " )");

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

                                ResultSet rs_check_pre_req = (ResultSet) st_pre_req.executeQuery("select * from " + stream_table + " where StudentId='" + student_id + "' and (" + pre_req1_check_ele_no_grade + " or " + pre_req1_check_core_no_grade + ") and (" + pre_req2_check_ele_no_grade + " or " + pre_req2_check_core_no_grade + " )");
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
                                ResultSet rs_check_pre_req = (ResultSet) st_pre_req.executeQuery("select * from " + stream_table + " where StudentId='" + student_id + "' and (" + pre_req1_check_ele_no_grade + " or " + pre_req1_check_core_no_grade + ") and (" + pre_req2_check_ele_no_grade + " or " + pre_req2_check_core_no_grade + " )");
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


                            <%}
                                    j = j + 1;
                                } // while end here 

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
            
            <input type="hidden" name="total_cores" value="<%=total_cores%>">
            <input type="hidden" name="total_ele" value="<%=total_ele%>">
            <input type="hidden" name="course_count" value="<%=course_count%>">


        </form>
        <script>  
            
            
            //  hash map creating
            
            var arr = new Array();
            var arr2= new Array();
            <%
                while (rs_course1.next()) {

                    String code = rs_course1.getString(1);
                    String limit = rs_course1.getString(2);
                    //System.out.println(code + " limit :" + limit);
            %>  

                //add key-value pair to hashmap
                arr["<%=code%>"]=<%=limit%>;
                arr2["<%=code%>"]=0;
             
                //alert(arr["AI720"] +" and"+arr["CS785"]);

            <% }%>   
                    
              //  alert(arr["AI720"] +" and"+arr["CS799"]);        
            
            
                function dothis(col, row)
                {  
                  
                
                    //        alert("<%=currrefer_s%>");
            
                    //// $$$$$$$$$$$$$$$$$$$$$   logic for disabling the duplicate eletive selections. $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$44
            
                    var course_count=<%=course_count%>;
                    //alert("see this row, cols "+ row+", "+col);
                    var sel_code=$("#select"+col+row).val(); 
                    //var sel_col=parseInt(document.getElementById("select"+col+row).options.selectedIndex);
                    // alert("see this row, cols "+sel_col);
                    var i=1,flag=0;
                    for(i=1;i<=course_count;i++){
                        if(col==i){continue;}
                        // var str_i=i+'';
                        var comp_code=$("#select"+i+row).val(); 
                       // var comp_col=parseInt(document.getElementById("select"+i+row).options.selectedIndex);
                        //alert("select"+''+i+row);
                    
                        if(sel_code==comp_code){
                            //var subj_code =document.getElementsByTagName("option")[sel_col].value;
                            if(sel_code!="none"){
                            //document.getElementById("select"+col+row).options.selectedIndex=(0);
                            $("#select"+col+row).val("none");
                            flag=1;
                        }
                        }
       
                    }
            
            
             
                    if(flag==0){

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
    </body>
</html>