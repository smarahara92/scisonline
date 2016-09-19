<%-- 
    Document   : choose_ele_modify
--%>

<%@page import="java.io.OutputStream"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.io.FileInputStream"%>
<%@ page import="java.io.*"%>
<%@page import="java.io.File"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSetMetaData" %>
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
<%@include file="connectionBean.jsp" %>
<%@include file="checkValidity.jsp"%>
<jsp:useBean id="semtotal" class="com.hcu.scis.automation.ReadminList" scope="session">
 </jsp:useBean>
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
        Connection con = conn.getConnectionObj();
        Connection con1 = conn1.getConnectionObj();


        String given_session = request.getParameter("given_session");
        String given_year = request.getParameter("given_year");
       // String selected_id=request.getParameter("selected_id");
        int year = Integer.parseInt(given_year);
        Calendar cal = Calendar.getInstance();
        //int year = cal.get(Calendar.YEAR);
        //  int month = cal.get(Calendar.MONTH) + 1;
        String stream = "", stream_table = "", prgm="",currrefer_s = "", sem = "", stream1 = "", stream2 = "", curriculum = "";
        stream = request.getParameter("stream");
        if(stream==null){ stream ="";}
        stream = stream.replace('-', '_');
            //  System.out.println("hiiii stream :"+stream);
            // System.out.println("hiiii year :"+year);
int course_count = 0, current_cores = 0, max_stu = 0, total_stu = 0,optioalCore_count=0;

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
            ResultSet rs10_prgm = (  ResultSet )st10_prgm.executeQuery("select Programme_name from programme_table where Programme_status='1'");
            while(rs10_prgm.next()){
        
                 program_name=rs10_prgm.getString(1);
                 program_name=program_name.replace("-", "_");
                // program_name=program_name.toLowerCase()
                         System.out.println(program_name+"");
                         
                 if(stream.contains(program_name)){
                 prgm=program_name; //this is the programme name.
                  stream_table = prgm +"_"+ Integer.toString(year2);
                 break;
                 }
            
            }
             stream1 = stream.replace("_"," ");
             stream2=stream;
             
             System.out.println(stream+"without "+stream2+" table :"+stream_table);
       // stream = stream.toUpperCase();
       /* stream = stream.replace('-', '_');
        System.out.println("srinivas testing 1");



       
        
         // GETTING ACTIVE CURS, year2 contains year of the program, prm contains the programe name.

            /*
             *code for taking latest curriculum
             */

            int curriculumYear = 0, latestYear = 0;//here latestYear output of this code, that is the latest curriculum year
            Statement st10_cur = (Statement) con.createStatement();

            ResultSet rs10_cur = (  ResultSet )st10_cur.executeQuery("select * from " + prgm + "_curriculumversions order by Year desc");
            while (rs10_cur.next()) {
                curriculumYear = rs10_cur.getInt(1);
                if (curriculumYear <=year2) {

                    latestYear = curriculumYear;
                    System.out.println(latestYear);
                    break;
                }
            }
               
            
            currrefer_s = prgm+"_"+latestYear+"_currrefer";
            curriculum = prgm+"_"+latestYear+"_curriculum";
         //   if(latestYear  < 2014)
          //  { %> 
         <%--   <jsp:forward page="choose_ele_modify_before2014.jsp"/>
            --%>
            <% 
         //   }

            st10_cur.close();
            
            /*
             *code for taking latest curriculum over here
             */

        
        
        
        //int course_count_int=Integer.parseInt(course_count)

        
        //Calendar now = Calendar.getInstance();
        Statement st1 = (Statement) con.createStatement();
        Statement st2 = (Statement) con.createStatement();
        Statement st3 = (Statement) con.createStatement();
        Statement st4 = (Statement) con.createStatement();
        Statement st5 = (Statement) con.createStatement();
        Statement st12 = (Statement) con.createStatement();

        Statement st13 = (Statement) con1.createStatement();
        Statement st14 = (Statement) con1.createStatement();

        ResultSet rs_student = (ResultSet) st1.executeQuery("select * from " + stream_table + "");
        ResultSet rs_student1 = (ResultSet) st2.executeQuery("select count(*) from " + stream_table + "");
        if (rs_student1.next()) {
            total_stu = rs_student1.getInt(1);
        }
        //System.out.println("laxman"+total_stu);
        ResultSet rs2 = (ResultSet) st3.executeQuery("select Electives, Cores,OptionalCore from " + currrefer_s + " where Semester = '" + sem + "'");
        if (rs2.next()) {
            current_cores = rs2.getInt(2); // current cores
            course_count = rs2.getInt(1);   /// # electives for given stream
            optioalCore_count = rs2.getInt(3); 
        }          //  System.out.println(course_count);
        
      
       
      
        ResultSet rs_ele_loc = (ResultSet) st2.executeQuery("select Electives, Cores,OptionalCore from " + currrefer_s);

        int ele_stop = 1, ele_start = 1, core_start = 1,opt_start=1;   // ele_start has position from which we have to insert the electives, eg : ele3,ele4 for ai-ii
        while (rs_ele_loc.next()) {                      // core_start contains start position of cores in this semester for given stream.
            if (ele_stop < sem2) {
                ele_start = ele_start + rs_ele_loc.getInt(1);
                core_start = core_start + rs_ele_loc.getInt(2);
                opt_start = opt_start + rs_ele_loc.getInt(3);
            } else {
                rs_ele_loc.afterLast();
            }
            ele_stop = ele_stop + 1;
        }




    %>

    <form action="choose_ele_new_stored.jsp" name="frm1" id="frm1">

        <h2 align="center" class="style30" > Modify Electives ( <%=stream2.replace('_', ' ')%> )</h2>

        <table align="center" border="1"><!-- class="table_pos"-->

            <tr>

            <th class="style31" align="center"><b>Student ID</b></th>
            

            <% int i;

                for (i = 1; i <=  optioalCore_count; i++) {
            %> 
            <th class="style31" align="center" ><b>Optional Core<%=i%></b></th>

            <% }

                for (i = 1; i <= course_count; i++) {
            %> 
            <th class="style31" align="center" ><b>Elective<%=i%></b></th>

            <% }
              
            %>
            </tr>
            <tr>
                <td>
                  <select name="student_selected" id="student" >
                  <option value="none">Select</option>         
               
             <% 
            
            
                int totalsubjectsinsem = 0;
                totalsubjectsinsem = semtotal.readminList(program_name, year2, sem2);
                
                Statement st = con.createStatement();
                
                ResultSet rs = st.executeQuery("select * from " + stream_table + "");
                while (rs.next() ) {
                    String student_id = rs.getString(1);
                    String student_name = rs.getString(2);
                    ResultSetMetaData rsmd = rs.getMetaData();
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

            %>
                

                
                 <option value="<%=student_id%>"><%=student_id%></option>
               
                <%  
                }
                }
                
                %>
                  </td>
                  
                  <%
                    
                  for(i=1;i<=course_count+optioalCore_count;i++){
                      
                   %>
                   <td>
                   <select>
                  <option value="none">None</option>    
                  </select>
                   </td>
                  <%    
                      
                      
                  }
                     
                  %>
                  
                  
                  
                  </tr>
                  </select>
                        
            <table>
                <tr><td>&nbsp;</td></tr>
                 <tr><td>&nbsp;</td></tr>
                  <tr><td>&nbsp;</td></tr>
                 
                 
            </table>
     
                <script>
                    
            $( "#student option" ).click(function() {   // to call when we select the value in the drop down box. note if use "#year1 instead of "#year1 option we will get weired response.
                var student_id=$("#student").val(); 
                if(student_id=="none"){
                    alert("enter the student id")
                }
                else{
                     document.getElementById('send_id').value =student_id;
                document.frm1.action="choose_ele_modify_1.jsp";
                // document.frm2.target="right_f";
                document.frm1.submit();
                    
                }
     
             });    
                    
                </script>
            <input type="hidden" name="given_session" value="<%=given_session%>">
            <input type="hidden" name="given_year" value="<%=given_year%>"> 
            <input type="hidden" name="stream" value="<%=stream%>">
            <input type="hidden" name="stream_table" value="<%=stream_table%>">
            <input type="hidden" id="send_id" name="selected_id">
    </form>
    </body>           
               
    <%  
        conn.closeConnection();
        con = null;
        conn1.closeConnection();
        con1 = null;
        %>
                </html>