<%-- 
    Document   : course_allocation_modify_submit
    Created on : 4 Feb, 2015, 10:12:03 AM
    Author     : nwlab
--%>


<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.ResultSetMetaData"%>
<%@page import="java.util.HashSet"%>
<%@include file="connectionBean.jsp" %>
<%@include file="programmeRetrieveBeans.jsp" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    </head>
    <body>
        <form name="frm1"  >
<%
            Connection con = conn.getConnectionObj();
            Connection con1 = conn1.getConnectionObj();
            
            String given_session = request.getParameter("given_session");
            String given_year = request.getParameter("given_year");
            
            int year = Integer.parseInt(given_year);
            
            Statement st1 = (Statement) con.createStatement();
            Statement st2 = (Statement) con.createStatement();
            Statement st3 = (Statement) con.createStatement();
            Statement st5 = (Statement) con.createStatement();
            ResultSet rs = null;

            try {
                st1.executeUpdate("drop table if exists  subject_faculty_" + given_session + "_" + given_year + "_temp");
                st1.executeUpdate("create table if not exists  subject_faculty_" + given_session + "_" + given_year + "_temp" + "(subjectid varchar(20),facultyid1 varchar(20),facultyid2 varchar(20),primary key(subjectId))");

                /*--------------Elective Stream Limit Table------------------*/
                // eletive table values initial to zero.
                Statement st20_ele_dyn = (Statement) con.createStatement();
                Statement st20_ele_dyn2 = (Statement) con.createStatement();
                String tb_name = given_year + given_session + "_elective";
                String col_name = null;
                st20_ele_dyn.executeUpdate("create table if not exists " + tb_name + "(course_name varchar(50),primary key(course_name))");
                ResultSet rs_ele_dyn = (ResultSet) st20_ele_dyn2.executeQuery("select * from " + given_session + "_stream where electives='yes'");
                String ele_all_courses=""; // contains all ele strems eg: MCA_I,MCA_II,MCA_III,MCA_IV,MCA_V,MCA_VI
                String default_limits="";//0,0,0,..
                while(rs_ele_dyn.next()) {
                    col_name = rs_ele_dyn.getString(1).replace('-', '_');
                    
                    try {
                        st20_ele_dyn.executeUpdate("ALTER TABLE " + tb_name + " ADD " + col_name + " INT(11)");
                    } catch(Exception e) {
                        System.out.println(e);
                    }
                    ele_all_courses= ele_all_courses+" , "+rs_ele_dyn.getString(1).replace('-', '_');             
                    default_limits=default_limits+", 0"; 
                }

                try {
                    st20_ele_dyn.executeUpdate("ALTER TABLE " + tb_name +  " ADD pre_req_1 varchar(45)");
                    st20_ele_dyn.executeUpdate("ALTER TABLE " + tb_name + " ADD pre_req_grade1 varchar(2) ");
                    st20_ele_dyn.executeUpdate("ALTER TABLE " + tb_name + " ADD pre_req_2 varchar(45)");
                    st20_ele_dyn.executeUpdate("ALTER TABLE " + tb_name + " ADD pre_req_grade2 varchar(2)");
                } catch(Exception e) {
                    System.out.println(e);
                }
                
                // insertion to this table is done later
                /*-----Elective Stream Limit Table Creation End------------------*/
                
                Statement st25 = (Statement) con.createStatement();

                int k = 1;
                rs = st5.executeQuery("select * from faculty_data order by Faculty_Name");
                while (rs.next()) {
                    for (int j = 1; j < 7; j++) {
                        String sub = (String) request.getParameter("select" + j + Integer.toString(k));
                        String s = (String) request.getParameter("s" + j + Integer.toString(k));
                        String check = (String) request.getParameter("check" + j + Integer.toString(k));
                        
                        int checking = 0;
                        try {
                            ResultSet rs50 = (ResultSet) st25.executeQuery("select * from subject_faculty_" + given_session + "_" + given_year + "_temp");
                            while (rs50.next()) {
                                if (sub.equals(rs50.getString(1)) && !sub.equals("none") && rs50.getString(2) != null) {
                                    checking = 1;
                                }
                            }
                            if (checking != 1) {
                                if (!sub.equals("none")) {
                                    st2.executeUpdate("insert into subject_faculty_" + given_session + "_" + given_year  + "_temp" + " values('" + sub + "', '" + rs.getString(1) + "',null)");
                                }
                            } else {
                                st2.executeUpdate("update subject_faculty_" + given_session + "_" + given_year + "_temp" + " set facultyid2='" + rs.getString(1) + "' where subjectid='" + sub + "'");
                            }
                            if (!sub.equals("none") && (s.equals("E") || s.equals("O") && checking != 1 || (s.equals("C") && check != null))) {
                                // dont make it nulls in the modifcation, since we modify elective tables seperately. we need to maintain these table data.
                                st3.executeUpdate("insert ignore into " + given_year + "_" + given_session + "_elective(course_name "+ ele_all_courses+") values('" + sub + "'"+default_limits+")");
                            }
                        } catch (Exception e) {
                            System.out.println(e);
                        }
                    }
                    k++;
                }
                
                //Calculation for num of moths for creation of attendance table
                Statement st_atten = con.createStatement();
                ResultSet rs_atten = st_atten.executeQuery("select * from session  where name='" + given_session + "' and start like '" +given_year + "%'");
                
                String columns = "";
                int stm = 0, em = 0, sd = 0, ed = 0, gap = 0;
                if(rs_atten.next()) {
                    String startdate = rs_atten.getDate(2).toString();
                    String enddate = rs_atten.getDate(3).toString();
                    
                    stm = Integer.parseInt(startdate.substring(5, 7));
                    em = Integer.parseInt(enddate.substring(5, 7));
                    sd = Integer.parseInt(startdate.substring(8));
                    ed = Integer.parseInt(enddate.substring(8));
                    
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
                }
                st_atten.executeUpdate("create table if not exists subject_attendance_" + given_session + "_" + given_year + "(subjectId varchar(20)," + columns + "cumatten int(20),primary key(subjectId))");
                /*calculation ends here*/
                
                //Transfer from sub_fac_temp to sub_fac
                int found_flag = 0;
                String sub = null;
                Statement st_sub_temp = con.createStatement();
                Statement st_sub = con.createStatement();
                Statement st_sub_update = con.createStatement();
                ResultSet rs_sub_temp = null;
                ResultSet rs_sub = null;
                HashSet<String> hs = new HashSet<String>();
                rs_sub_temp = st_sub_temp.executeQuery("select * from subject_faculty_" + given_session + "_" + given_year + "_temp");
                while(rs_sub_temp.next()){
                    sub = rs_sub_temp.getString(1);
                    //do hash map here
                    hs.add(sub);
                    rs_sub = st_sub.executeQuery("select * from subject_faculty_" + given_session + "_" + given_year);
                    found_flag = 0;
                    while(rs_sub.next()) {
                        if(sub.equals(rs_sub.getString(1))) {
                            String fac1 = rs_sub_temp.getString(2);
                            String fac2 = rs_sub_temp.getString(3);
                            
                            String fac_prev1 = rs_sub.getString(2);
                            String fac_prev2 = rs_sub.getString(3);
                            if(fac1 != null) {
                                if(fac_prev1==null || !(fac1.equals(fac_prev1))) {
                                    try {
                                        con.setAutoCommit(false);
                                        st_sub_update.executeUpdate("update subject_faculty_" + given_session + "_" + given_year + " set facultyid1='" + fac1 + "' where subjectid='" + sub + "'");
                                        con.commit();
                                    } catch(Exception e) {
                                        con.rollback();
                                        System.out.println(e);
                                        System.out.println("rollback");
                                    }
                                } 
                            } else {
                                try {
                                    con.setAutoCommit(false);
                                    st_sub_update.executeUpdate("update subject_faculty_" + given_session + "_" + given_year + " set facultyid1= NULL where subjectid='" + sub + "'");
                                    con.commit();
                                } catch(Exception e) {
                                    con.rollback();
                                    System.out.println(e);
                                    System.out.println("rollback");
                                }
                            }
                            if(fac2 != null) {
                                if(fac_prev2==null || !(fac2.equals(fac_prev2))) {
                                    try {
                                        con.setAutoCommit(false);
                                        st_sub_update.executeUpdate("update subject_faculty_" + given_session + "_" + given_year + " set facultyid2='" + fac2 + "' where subjectid='" + sub + "'");
                                        con.commit();
                                    } catch(Exception e) {
                                        con.rollback();
                                        System.out.println(e);
                                        System.out.println("rollback");
                                    }
                                } 
                            } else {
                                try {
                                    con.setAutoCommit(false);
                                    st_sub_update.executeUpdate("update subject_faculty_" + given_session + "_" + given_year + " set facultyid2= NULL where subjectid='" + sub + "'");
                                    con.commit();
                                } catch(Exception e) {
                                    con.rollback();
                                    System.out.println(e);
                                    System.out.println("rollback");
                                }
                            }
                            found_flag = 1;
                            break;
                        }
                    }
                    if(found_flag == 0) {
                        st2.executeUpdate("insert into subject_faculty_" + given_session + "_" + given_year + " values('" + sub + "', '" + rs_sub_temp.getString(2) + "', '" + rs_sub_temp.getString(3)+ "')");
                        /***Create attendance and assessment table***/
                        Statement st_att = con.createStatement();
                        Statement st_ass = con1.createStatement();
                        
                        st_atten.executeUpdate("insert ignore into subject_attendance_" + given_session + "_" + given_year + " (subjectId) values('" + sub + "')");
                        st_att.executeUpdate("create table if not exists " + sub + "_Attendance_" + given_session + "_" + given_year + "(StudentId varchar(20) not null,StudentName varchar(50)," + columns + "cumatten int(20),percentage float,primary key(StudentId))");
                        st_ass.executeUpdate("create table if not exists " + sub + "_Assessment_" + given_session + "_" + given_year + "(StudentId varchar(20) not null,StudentName varchar(50),Minor_1 varchar(5),Minor_2 varchar(5),Minor_3 varchar(5),Major varchar(5),Final varchar(5),InternalMarks varchar(5),TotalMarks varchar(5),primary key(StudentId))");
                        /***attendance and assessment table creation ends here***/
                        
                        /**insertion of students for core subjects**/
                        Statement st_sem = con.createStatement();
                        ResultSet rs_sem = st_sem.executeQuery("select semester from subject_data where subjId='" + sub + "'");
                        while (rs_sem.next()) {
                            String prg_sem = rs_sem.getString(1);
                            
                            Statement st_prgm = (Statement) con.createStatement();
                            ResultSet rs_prgm = (ResultSet) st_prgm.executeQuery("select * from programme_table where Programme_status=1");
                            while (rs_prgm.next()) {
                                String program = rs_prgm.getString(1);
                                if (prg_sem.contains(program)) {
                                    int batch = 0;
                                    int len = prg_sem.length();
                                    
                                    String sub_2 = (prg_sem).substring(len - 2, len);  // MTech-CS-I OR -V, -AI-I OR -V, MCA-I OR -V,
                                    String sub_3 = (prg_sem).substring(len - 3, len);  // -II, -IV, -VI ..etc
                                    String sub_4 = (prg_sem).substring(len - 4, len);   // -III , -IIV , etc
                                    String sub_5 = (prg_sem).substring(len - 5, len);    // -VIII
                                    
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
                                    
                                    String prog_rep = program.replace('-', '_');
                                    
                                    Statement st_stdlist = (Statement) con.createStatement();
                                    Statement rs_R_U = con.createStatement(); 
                                    
                                    //ResultSet rs_stdlist = st_stdlist.executeQuery("select StudentId,StudentName from " + prog_rep + "_" + batch);
                                    try {
                                        ResultSet rs_stdlist = st_stdlist.executeQuery("select * from " + prog_rep + "_" + batch);
                                        ResultSetMetaData rsmd_R = rs_stdlist.getMetaData();
                                        int columnCount = rsmd_R.getColumnCount();

                                        
                                             String currTable="",subOriginalCode="";
                                             ResultSet rsCurr=st1.executeQuery("select * from " + prog_rep + "_curriculumversions order by Year desc");
                                             ResultSet rsLstStu=st2.executeQuery("select StudentId,StudentName from " + prog_rep + "_" + year);
                                             rsCurr.next();
                                             currTable=rsCurr.getString("Curriculum_name");
                                             String q="select SubCode from "+currTable+" where Alias="+sub+" or SubCode="+sub;
                                             System.out.println(q);
                                             rsCurr=st1.executeQuery("select SubCode from "+currTable+" where Alias='"+sub+"' or SubCode='"+sub+"'");
                                             if(rsCurr.next())
                                                 subOriginalCode=rsCurr.getString("SubCode");
                                        while(rs_stdlist.next()) {
                                            String studentID = rs_stdlist.getString(1);
                                            String studentName = rs_stdlist.getString(2);

                                            st_att.executeUpdate("insert ignore into " + sub + "_Attendance_" + given_session + "_" + given_year + " (StudentId , StudentName) values('" + studentID + "','" + studentName + "')");
                                            st_ass.executeUpdate("insert ignore into " + sub + "_Assessment_" + given_session + "_" + given_year + " (StudentId , StudentName) values('" + studentID + "','" + studentName + "')");

                                            // Mofication of master table from 'NR' to 'R'
                                             
                                            for(int i = 3; i < columnCount - 1; i += 2) {
                                                String currsub = rs_stdlist.getString(i);
                                                if(currsub != null && currsub.equals(subOriginalCode)) {
                                                    String gr_col = rsmd_R.getColumnName(i + 1);
                                                    System.out.println(studentID + " " + gr_col);
                                                    rs_R_U.executeUpdate("UPDATE " + prog_rep + "_" + batch + " SET " + gr_col + " = 'R' WHERE StudentId = '" + studentID + "'");
                                                    break;
                                                }
                                            }
                                        }
                                    } catch(SQLException sql) {}
                                    break;
                                }
                            }
                        }
                        /**insertion of students ends here*/
                    }
                }
                //delete sub_fac_temp
                st1.executeUpdate("drop table if exists  subject_faculty_" + given_session + "_" + given_year + "_temp");
                /***Transfer ends here***/
                
                /**check for unallocated subjects**/
                int sub_count = 0;
                int sub_count_hs = hs.size();
                Statement st_sub_count = con.createStatement();
                ResultSet rs_sub_count = st_sub_count.executeQuery("select count(*) from subject_faculty_" + given_session + "_" + given_year);
                if(rs_sub_count.next()) {
                    sub_count = rs_sub_count.getInt(1);
                }
                rs_sub_count.close();
                st_sub_count.close();
                System.out.println(hs);
                if(sub_count > sub_count_hs) {
                    // find unallocated subjects
                    int un_alc_sub_count = sub_count - sub_count_hs;
                    String un_alc_sub[] = new String[un_alc_sub_count];
                    int i = 0;
                    
                    Statement s_sub = con.createStatement();
                    ResultSet r_sub = s_sub.executeQuery("select subjectid from subject_faculty_" + given_session + "_" + given_year);
                    while(r_sub.next()) {
                        String subject = r_sub.getString(1);
                        if( !(hs.contains(subject)) ) {
                            un_alc_sub[i] = subject;
                            ++i;
                        }
                    }
                    int msgflg1 = 0, msgflg2 = 0;
                    for(String x : un_alc_sub) {
                        System.out.println("x = " + x);
                        //check whether x is core or not
                        Boolean core;
                        Statement st_core = con.createStatement();
                        ResultSet rs_core = st_core.executeQuery("select semester from subject_data where subjId='" + x + "'");
                        core = rs_core.next();
                        
                        if(core) {
                            hs.add(x);
                            //core can only be reallocated
                            if(msgflg1 == 0) {
                                msgflg1 = 1;
%>
                            <script>
                                alert("Core courses can not be deallocated.\nIt needs to be reallocated.");
                            </script>
<%
                            }
                        } else {
                            //get students in this subject
                            Statement st_std = con.createStatement();
                            ResultSet rs_std = st_std.executeQuery("select count(*) from " + x + "_Attendance_" + given_session + "_" + given_year);
                            rs_std.next();
                            int std_count = rs_std.getInt(1);
                            if(std_count == 0){
                                //delete stream_limit entry
                                Statement st_del_str_lm = con.createStatement();
                                st_del_str_lm.executeUpdate("delete from " + given_year + "_" + given_session + "_elective where course_name = '"+ x + "'");
                                st_del_str_lm.executeUpdate("delete from subject_faculty_" + given_session + "_" + given_year + " where subjectid = '"+ x + "'");
                                
                                //delete attendance and assessment table
                                Statement st_del_att = con.createStatement();
                                Statement st_del_ass = con1.createStatement();
                                st_del_att.executeUpdate("drop table if exists " + x + "_Attendance_" + given_session + "_" + given_year );
                                st_del_ass.executeUpdate("drop table if exists " + x + "_Assessment_" + given_session + "_" + given_year );

                            } else {
                                hs.add(x);
                                if(msgflg2 == 0) {
                                msgflg2 = 1;
%>
                                <script>
                                    alert("There are registered students in this subject.\nStudents' registration needs to be modified befofe course can be unallocated.");
                                </script>
<%
                                }
                            }
                        }
                    }
                }
                hs.clear();
                // check all cores are allocated or not
                ResultSet unAlcCoreRS = scis.getUnallocatedCoreCourses(given_session, year);
                // its the part if all cores are not allocated
                if (unAlcCoreRS != null && unAlcCoreRS.next()) { // means all cores are allocated.
                    String display = "";
                    int p = 1;
                    do {
                        display = display + "\\" + "n" + p + ". " + unAlcCoreRS.getString(1);
                        ++p;
                    }while(unAlcCoreRS.next());
%>
                <script>
                    alert("The following core courses are not yet allocated.\n" + "<%=display%>");
                </script>
<%
                }
                scis.close();
%>

<%
            } catch (Exception e) {
                System.out.println(e);
            }
            
            conn.closeConnection();
            con = null;
            conn1.closeConnection();
            con1 = null;
%>

<script>
    window.location = "sub-faconline_view.jsp?year2=<%=given_year%>&current_session=<%=given_session%>";
</script>
            <input type="hidden" name="year2" value="<%=given_year%>">
            <input type="hidden" name="current_session" value="<%=given_session%>">
        </form>  
    </body>
</html>
