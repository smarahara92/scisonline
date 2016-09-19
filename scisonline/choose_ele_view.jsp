<%-- 
    Document   : choose_ele_view
--%>
<%@page import="java.io.OutputStream"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.File"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.ResultSetMetaData"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@page import="org.apache.poi.hssf.usermodel.HSSFWorkbook"%>
<%@page import="org.apache.poi.hssf.util.HSSFColor"%>
<%@page import="org.apache.poi.ss.usermodel.Workbook"%>
<%@page import="org.apache.poi.ss.usermodel.Font"%>
<%@page import="org.apache.poi.ss.usermodel.CellStyle"%>
<%@page import="org.apache.poi.ss.usermodel.IndexedColors"%>
<%@page import="org.apache.poi.ss.usermodel.Sheet"%>
<%@page import="org.apache.poi.ss.usermodel.Cell"%>
<%@page import="org.apache.poi.ss.usermodel.Row"%>
<%@include file="connectionBean.jsp" %>
<%@include file="checkValidity.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style type="text/css">
            @media print {
                .noPrint {
                    display:none;
                }
            }
        </style>
        <script>
            function p1() {
                document.getElementById("p1").style.display="none";
                window.print();
            }
        </script>
        <style>
            .style30 {color: red}
            .style31 {
                background-color: #c2000d;
                color: white
            }
            .style32 {color: green}
            .style44{
                background-color: #9FFF9D;
            }
        </style> 
        <style type="text/css">
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
                background-color: #c2000d;
            }
            td,table {
                white-space: nowrap;
            }
        </style>
    </head>
    <body bgcolor="#CCFFFF">
<%
        Connection con = conn.getConnectionObj();
        
        String stream = request.getParameter("stream");
        String given_session = request.getParameter("given_session");
        String given_year = request.getParameter("given_year");
        int year = Integer.parseInt(given_year);

        Calendar cal = Calendar.getInstance();
        
        Statement st1 = (Statement) con.createStatement();
        Statement st2 = (Statement) con.createStatement();
        Statement st3 = (Statement) con.createStatement();
        Statement st4 = (Statement) con.createStatement();
        Statement st5 = (Statement) con.createStatement();
        Statement st10_cur = (Statement) con.createStatement();
        
        String stream_table = "",prgm="", currrefer_s = "", sem = "", stream1 = "", stream2 = "", curriculum = "";
        
        //if(stream==null){ stream ="";}
        stream = stream.replace('-', '_');
        
        int course_count = 0, current_cores = 0, max_stu = 0;
        int year2 = year;
            
        // Added this part 20-1-2013
        //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
        session.setAttribute("stream", stream);
        int str_len = stream.length();
        int sem2 = 0;
        String sub_2 = (stream).substring(str_len - 2, str_len);  // MTech-CS-I OR -V, -AI-I OR -V, MCA-I OR -V,
        String sub_3 = (stream).substring(str_len - 3, str_len);  // -II, -IV, -VI ..etc
        String sub_4 = (stream).substring(str_len - 4, str_len);   // -III , -IIV , etc
        String sub_5 = (stream).substring(str_len - 5, str_len);    // _VIII, 

        if (sub_2.equals("_I")) {
            sem2 = 1;
            sem="I";
            year2=year;
        } else if (sub_2.equals("_V")) {
            sem2 = 5;
            sem="V";
            year2=year-2;
        } else if (sub_2.equals("_X")) {
            sem2 = 10;
            sem="X";
            year2=year-5;
        } else if (sub_3.equals("_IV")) {
            sem2 = 4;
            sem="IV";
            year2=year-2;
        } else if (sub_3.equals("_II")) {
            sem2 = 2;
            sem="II";
            year2=year-1;
        } else if (sub_3.equals("_VI")) {
            sem2 = 6;
            sem="VI";
            year2=year-3;
        } else if (sub_3.equals("_IX")) {
            sem2 = 9;
            sem="IX";
            year2=year-4;
        } else if (sub_4.equals("_III")) {
            sem2 = 3;
            sem="III";
            year2=year-1;
        } else if (sub_4.equals("_VII")) {
            sem2 = 7;
            sem="VII";
            year2=year-3;
        } else if (sub_5.equals("_VIII")) {
            sem2 = 8;
            sem="VIII";
            year2=year-4;
        }

        Statement st10_prgm = (Statement) con.createStatement();
        String program_name="";
        ResultSet rs10_prgm = st10_prgm.executeQuery("select Programme_name from programme_table where Programme_status = '1'");
        while(rs10_prgm.next()) {
            program_name=rs10_prgm.getString(1);
            program_name=program_name.replace("-", "_");
            // program_name=program_name.toLowerCase()
            System.out.println(program_name+"");
            if(stream.contains(program_name)) {
                prgm=program_name; //this is the programme name.
                stream_table = prgm +"_"+ Integer.toString(year2);
                break;
            }
        }
        
        stream1 = stream.replace("_"," ");
        stream2 = stream;
        System.out.println(stream+"without "+stream2+" table :"+stream_table);
        
        // GETTING ACTIVE CURS, year2 contains year of the program, prm contains the programe name.
        /*
         *code for taking latest curriculum
         */
        
        int curriculumYear = 0, latestYear = 0;//here latestYear output of this code, that is the latest curriculum year
        ResultSet rs10_cur = (  ResultSet )st10_cur.executeQuery("select * from " + prgm + "_curriculumversions order by Year desc");
        while (rs10_cur.next()) {
            curriculumYear = rs10_cur.getInt(1);
            if (curriculumYear <=year2) {
                latestYear = curriculumYear;
                System.out.println(latestYear);
                break;
            }
        }
        st10_cur.close();
        //if( latestYear < 2014) {
%>
            <%-- <jsp:forward page="choose_ele_view_before2014.jsp"/>  --%>
<%
        //}
        
        currrefer_s = prgm+"_"+latestYear+"_currrefer";
        curriculum = prgm+"_"+latestYear+"_curriculum";
        
        /*
         *code for taking latest curriculum over here
         */
        
        int electives = 0, optionalCore  = 0;
        ResultSet rs2 = null;
        try {
            rs2 = (ResultSet) st3.executeQuery("select Electives, Cores, OptionalCore from " + currrefer_s + " where Semester = '" + sem + "'");
        } catch(Exception e) {
            System.out.println(e);
%>
<h2><center>There is currently no batch in <%=stream.replace('_', '-')%> semester</center></h2>
<%
            return;
        }
        if (rs2.next()) {
            current_cores = rs2.getInt(2); // current cores
            electives = rs2.getInt(1);
            optionalCore = rs2.getInt(3);
            course_count = electives + optionalCore;
            // # electives for given stream
        }
        //System.out.println(course_count);
      
        ResultSet rs_ele_loc = (ResultSet) st2.executeQuery("select Electives, Cores, OptionalCore from " + currrefer_s);
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
%>
    <form action="choose_ele_new_stored.jsp" name="ele_form" id="ele_form">
        <h2 align="center" class="style30" > Electives List ( <%=stream2.replace('_', ' ')%> )</h2>
        <table align="center" border="1"><!-- class="table_pos"-->
            <th class="style31" align="center"><b>Student ID</b></th>
            <th class="style31" align="center"><b>Student Name</b></th>
<%
            int i;
            for (i = 1; i <= optionalCore; i++) {
%>
                <th class="style31" align="center" ><b>Optional Core<%=i%></b></th>
<%
            }
            for (i = 1; i <= electives; i++) {
%> 
                <th class="style31" align="center" ><b>Elective<%=i%></b></th>
<%
            }
            
            //$$$$$$$$$$$ get the electives of student from master table. and print $$$$$$$$$$$$$$$$$$$$$4
            //############################################################################################
            ResultSet rs = null;
            try {
                rs = (ResultSet) st4.executeQuery("select * from " + stream_table + "");
            } catch(Exception e) {
                System.out.println(e);
                return;
            }
            while (rs.next()) {
                String student_id = rs.getString(1);
                String student_name = rs.getString(2);
%>
                <tr>
                    <td align="center"><b><%=student_id%></b></td> 
                    <td ><b><%=student_name%></b></td>
<%
                    int ele_start_live = ele_start;
                    int opt_start_live = opt_start;
                    
                    ResultSet rs_old_ele = null;
                    
                    for (int j = 1; j <= course_count; j++) { 
                        if( j > optionalCore) {
                            rs_old_ele= (ResultSet) st3.executeQuery("select ele" + ele_start_live + " from " + stream_table + "  where StudentId='" + student_id + "'");
                            ele_start_live = ele_start_live + 1;
                        }
                        else {
                             rs_old_ele= (ResultSet) st3.executeQuery("select optCore" + opt_start_live + " from " + stream_table + "  where StudentId='" + student_id + "'");
                             opt_start_live = opt_start_live + 1;
                        }

                        if (rs_old_ele.next()) {
                            String col_value = (String) rs_old_ele.getString(1);
                            if (col_value != null && !col_value.isEmpty() && !col_value.equalsIgnoreCase("null")) {
                                String subname = "";
                                ResultSet rs1 = (ResultSet) st5.executeQuery("select Subject_Name  from subjecttable where Code='" + col_value + "'");
                                if (rs1.next()) {
                                    subname = rs1.getString(1);
                                    // System.out.println("ele from table:" +subname );
%>
                                    <td align="center" ><%=subname%></td>
<%
                                } else {
%>
                                    <td>&nbsp;</td>
<%
                                }
                            } else {
%>
                                <td>&nbsp;</td>
<%
                            }
                        }
                    } // for
%>
                </tr>
<%
            } //while
            st1.close();
            st2.close();
            st3.close();
            st4.close();
            st5.close();
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
<%
        con = null;
        conn.closeConnection();
        
%>
    </body>
</html>