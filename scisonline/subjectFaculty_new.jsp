<%-- 
    Document   : subjectFaculty_new
--%>
<%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@page import="java.io.OutputStream"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.util.GregorianCalendar"%>
<%@page import="java.io.File"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.ResultSetMetaData"%>
<%@include file="connectionBean.jsp" %>
<%@include file="checkValidity.jsp"%>
<%@include file="programmeRetrieveBeans.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%
    String username = (String) session.getAttribute("user");
    if(username == null) {
        response.sendRedirect("http://localhost:8084/scisonline");
    }
%>
<html>
    <head>
        <script type="text/javascript">
            function check() {
                var var2=document.getElementsByTagName('input');
                //alert(var2[0].value);
	
                for(var i=0; i<var2.length-1; i++) {
                    if(var2[i].type ==='text') {
                        var var1 = var2[i].value;
                        if(isNaN(var1) || var1==='') { 
                            alert("Error: Please enter the correct number!");
                            var2[i].select();
                            var2[i].focus();
                            return false; 
                        }
                    }
                }
                return true;
            }

            function select(temp) {
                document.getElementById(temp).select();
            } 
        </script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Assign Electives to Streams</title>
        <style type="text/css">
            .style30 {color: #c2000d}
            .style31 {color: white}
            .style32 {color: green}
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
                top:200px;
            }
            .border {
                background-color: #c2000d;
            }
            .fix {
                position:fixed;
                background-color: #c2000d;
            }
        </style>
    </head>
    <body bgcolor="#CCFFFF" ">
<%
        Connection con = conn.getConnectionObj();
        Connection con1 = conn1.getConnectionObj();
%>
        <form name="frm1"  >
<%
            String given_session = request.getParameter("given_session");
            String given_year = request.getParameter("given_year");
            String cores_status = "null";

            int year = Integer.parseInt(given_year);

            Statement st1 = (Statement) con.createStatement();
            Statement st2 = (Statement) con.createStatement();
            Statement st3 = (Statement) con.createStatement();
            Statement st4 = (Statement) con.createStatement();
            Statement st5 = (Statement) con.createStatement();

            try {
                System.out.println("hgggggggggjvhkb");
                // if(startdate.equals("")==false && enddate.equals("")==false) {
                // st1.executeUpdate("insert into session values('"+current_session+"','"+startdate+"','"+enddate+"')");
                st1.executeUpdate("drop table if exists  subject_faculty_" + given_session + "_" + given_year);
                st1.executeUpdate("create table if not exists  subject_faculty_" + given_session + "_" + given_year + "(subjectid varchar(20),facultyid1 varchar(20),facultyid2 varchar(20),primary key(subjectId))");

                /*--------------Elective Stream Limit Table------------------*/
                // eletive table values initial to zero.
                Statement st20_ele_dyn = (Statement) con.createStatement();
                Statement st20_ele_dyn2 = (Statement) con.createStatement();
                st20_ele_dyn.executeUpdate("create table if not exists " + given_year + "_" + given_session + "_elective(course_name varchar(50),primary key(course_name))");
                Statement st_ele_dyn = (Statement) con.createStatement();
                ResultSet rs_ele_dyn = (ResultSet) st20_ele_dyn2.executeQuery("select * from " + given_session + "_stream where electives='yes'");
                String ele_all_courses=""; // contains all ele strems eg: MCA_I,MCA_II,MCA_III,MCA_IV,MCA_V,MCA_VI
                String default_limits="";//0,0,0,..
                while(rs_ele_dyn.next()) {
                    st20_ele_dyn.executeUpdate("ALTER TABLE " + given_year + "_" + given_session + "_elective  ADD " + rs_ele_dyn.getString(1).replace('-', '_') + " INT(11)");
                    ele_all_courses= ele_all_courses+" , "+rs_ele_dyn.getString(1).replace('-', '_');             
                    default_limits=default_limits+", 0"; 
                }
                st20_ele_dyn.executeUpdate("ALTER TABLE " + given_year + "_" + given_session + "_elective  ADD pre_req_1 varchar(45)");
                st20_ele_dyn.executeUpdate("ALTER TABLE " + given_year + "_" + given_session + "_elective  ADD pre_req_grade1 varchar(2) ");
                st20_ele_dyn.executeUpdate("ALTER TABLE " + given_year + "_" + given_session + "_elective  ADD pre_req_2 varchar(45)");
                st20_ele_dyn.executeUpdate("ALTER TABLE " + given_year + "_" + given_session + "_elective  ADD pre_req_grade2 varchar(2)");
                
                // insertion to this table is done later
                /*-----Elective Stream Limit Table Creation End------------------*/

                Statement st25 = (Statement) con.createStatement();

                // $$$$$$ sending data to subject faculty table, and make all limits as zero for elective subjects.$$$$$

                int k = 1;
                ResultSet rs = st5.executeQuery("select * from faculty_data order by Faculty_Name");
                while (rs.next()) {
                    for(int j = 1; j < 7; j++) {
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
                            }                            System.out.println("checking is"+checking);                          

                            // System.out.println("checking is"+checking);                          
                            if (checking != 1) {
                                if (!sub.equals("none")) {
                                    st2.executeUpdate("insert into subject_faculty_" + given_session + "_" + given_year + " values('" + sub + "', '" + rs.getString(1) + "',NULL)");
                                }
                            } else {
                                st2.executeUpdate("update subject_faculty_" + given_session + "_" + given_year + " set facultyid2='" + rs.getString(1) + "' where subjectid='" + sub + "'");
                            }
                            if (!sub.equals("none") && (s.equals("E") || s.equals("O") && checking != 1 || (s.equals("C") && check != null))) {
                                //st3.executeUpdate("insert into " + given_year + "_" + given_session + "_elective(course_name,MCA_I,MCA_II,MCA_III,MCA_IV,MCA_V,MCA_VI,MTech_CS_I,MTech_CS_II,MTech_CS_III,MTech_CS_IV,MTech_AI_I,MTech_AI_II,MTech_AI_III,MTech_AI_IV,MTech_IT_I,MTech_IT_II,MTech_IT_III,MTech_IT_IV) values('" + sub + "',0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0)");
                                st3.executeUpdate("insert into " + given_year + "_" + given_session + "_elective(course_name "+ ele_all_courses+") values('" + sub + "'"+default_limits+")");
                                //  INSERTION TO STREAM LIMIT TABLE
                            }
                            rs50.close();
                        } catch (Exception e) {
                                e.printStackTrace();
                        }
                    }
                    k++;
                }

                                
                
                    cores_status = "YES";
                       
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
                    try {
                        Statement st30 = (Statement) con.createStatement();
                        //ResultSet rs30 = (ResultSet) st30.executeQuery("select * from session  where name='" + given_session + "'");
                        ResultSet rs30 = (ResultSet) st30.executeQuery("select * from session  where name='" + given_session + "' and start like '" +given_year + "%'");
                        String startdate = "";
                        String enddate = "";
                        String columns = "";
                        int stm = 0, em = 0, sd = 0, ed = 0, gap = 0;
                        if (rs30.next()) {
                            startdate = rs30.getDate(2).toString();
                            enddate = rs30.getDate(3).toString();
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
                        //***********************************************starts here************************************************************
                        // st12.executeUpdate("drop table if exists subject_attendance_" + given_session + "_" + given_year + "");
                        st12.executeUpdate("create table if not exists subject_attendance_" + given_session + "_" + given_year + "(subjectId varchar(20)," + columns + "cumatten int(20),primary key(subjectId))");
                        ResultSet rs3 = (ResultSet) st7.executeQuery("select subjectid from subject_faculty_" + given_session + "_" + given_year + "");
                        while (rs3.next()) {
                            //insert data into the subject_attendance table
                            st12.executeUpdate("insert into subject_attendance_" + given_session + "_" + given_year + " (subjectId) values('" + rs3.getString(1) + "')");
                            st12.executeUpdate("create table if not exists " + rs3.getString(1) + "_Attendance_" + given_session + "_" + given_year + "(StudentId varchar(20) not null,StudentName varchar(50)," + columns + "cumatten int(20),percentage float,primary key(StudentId))");
                            st13.executeUpdate("create table if not exists " + rs3.getString(1) + "_Assessment_" + given_session + "_" + given_year + "(StudentId varchar(20) not null,StudentName varchar(50),Minor_1 varchar(5),Minor_2 varchar(5),Minor_3 varchar(5),Major varchar(5),Final varchar(5),InternalMarks varchar(5),TotalMarks varchar(5),primary key(StudentId))");
                            //start loading data .  GET THE SEMESTER FOR WHICH REGISTER SUBJECTs(cores) HAS TO TEACH. MCA-I, MCA-II etc into rs4
                            ResultSet rs4 = (ResultSet) st8.executeQuery("select semester from subject_data where subjId='" + rs3.getString(1) + "'");
                            while (rs4.next()) {
                                String str_with1 = rs4.getString(1);
                                String str_free1 = str_with1;
                                // System.out.println("program name from selection after replace - with _ : " + str_free1);
                                ResultSet rs1_prgm = (ResultSet) st1_prgm.executeQuery("select * from programme_table where Programme_status=1");
                                while (rs1_prgm.next()) {
                                    System.out.println("program name from the prgm table : " + rs1_prgm.getString(1));
                                    if (str_free1.contains(rs1_prgm.getString(1))) {
                                        int batch = 0;
                                        String program = rs4.getString(1);
                                        System.out.println("program name " + program);
                                        int len = program.length();
                                        System.out.println(len);
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
                                        try {
                                                ResultSet rs5 = (ResultSet) st9.executeQuery("select * from " + str_free2 + "_" + batch);
                                            ResultSetMetaData rsmd_R = rs5.getMetaData();
                                            int columnCount = rsmd_R.getColumnCount();
                                            Statement rs_R_U = con.createStatement(); 
                                            //ResultSet rs5 = (ResultSet) st9.executeQuery("select StudentId , StudentName from" + str_free2 + "_" + batch);

                                            String sub = rs3.getString(1);
                                             String currTable="",subOriginalCode="";
                                             ResultSet rsCurr=st1.executeQuery("select * from " + str_free2 + "_curriculumversions order by Year desc");
                                             ResultSet rsLstStu=st2.executeQuery("select StudentId,StudentName from " + str_free2 + "_" + batch);
                                             rsCurr.next();
                                             currTable=rsCurr.getString("Curriculum_name");
                                             String q="select SubCode from "+currTable+" where Alias="+sub+" or SubCode="+sub;
                                             System.out.println(q);
                                             rsCurr=st1.executeQuery("select SubCode from "+currTable+" where Alias='"+sub+"' or SubCode='"+sub+"'");
                                             if(rsCurr.next())
                                                 subOriginalCode=rsCurr.getString("SubCode");
                                       
                                            while (rs5.next()) {
                                                String studentID = rs5.getString(1);
                                                String studentName = rs5.getString(2);

                                                st12.executeUpdate("insert into " + sub + "_Attendance_" + given_session + "_" + given_year + " (StudentId , StudentName) values('" + studentID + "','" + studentName + "')");
                                                st13.executeUpdate("insert into " + sub + "_Assessment_" + given_session + "_" + given_year + " (StudentId , StudentName) values('" + studentID + "','" + studentName + "')");

                                                
                                                
                                                
                                                // Mofication of master table from 'NR' to 'R'
                                                for(int c = 3; c < columnCount - 1; c += 2) {
                                                    String currsub = rs5.getString(c);
                                                    if(currsub != null && currsub.equals(subOriginalCode)) {
                                                        String gr_col = rsmd_R.getColumnName(c + 1);
                                                        System.out.println(studentID + " " + gr_col);
                                                        rs_R_U.executeUpdate("UPDATE " + str_free2 + "_" + batch + " SET " + gr_col + " = 'R' WHERE StudentId = '" + studentID + "'");
                                                        break;
                                                    }
                                                }
                                            }
                                        } catch(SQLException sql) {}
                                        break;
                                    }
                                }
                            }
                        }
                        st30.close();
                    } catch (Exception e) {
                        System.out.println(e);
                    }
                    //********

                // check all cores are allocated or not
                ResultSet unAlcCoreRS = scis.getUnallocatedCoreCourses(given_session, year);
                                // its the part if all cores are not allocated
                if (unAlcCoreRS != null && unAlcCoreRS.next()) { // means all cores are allocated.
                    String display = "";
                    int p = 1;
                    do {
                        display = display + "\\" + "n" + p + ". " + unAlcCoreRS.getString(1);
                        ++p;
                    } while(unAlcCoreRS.next()); %>
                    <script>
                        alert("The following core courses are not yet allocated.\n" + "<%=display%>");
                    </script> <%
                }
                scis.close();


                
                    
                    st6.close();
                    st7.close();
                    st8.close();
                    st9.close();
                    st12.close();
                    st10.close();
                    st13.close();
                    st11.close();
                    st1_prgm.close();
                    st2_prgm.close();
                   
                rs_ele_dyn.close();
                rs.close();
                st20_ele_dyn.close();
                st20_ele_dyn2.close();
                st_ele_dyn.close();
                st25.close();
            } catch (Exception e) {
                out.println(e);
            }
            //************************************************************************ends here******
%> 
            <input type="hidden" name="year2" value="<%=given_year%>">
            <input type="hidden" name="current_session" value="<%=given_session%>">
            <input type="hidden" name="cores_status" value="<%=cores_status%>">
<%            
            st1.close();
            st2.close();
            st3.close();
            st4.close();
            st5.close();
%>
        </form>
        <script>
            window.location = "sub-faconline_view.jsp?year2=<%=given_year%>&current_session=<%=given_session%>";
        </script>
        
<%
        conn.closeConnection();
        con = null;
        conn1.closeConnection();
        con1 = null;
%>
    </body>
</html>