<%-- 
    Document   : Demo_shortAtten
    Created on : Mar 24, 2015, 10:05:36 AM
    Author     : richa
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="com.sun.org.apache.xalan.internal.xsltc.runtime.Hashtable"%>
<%@page import="javax.sound.midi.SysexMessage"%>
<%@page import="java.util.Calendar"%>
<%@page import ="javax.sql.*" %>
<%@page import ="java.sql.*" %>
<jsp:useBean id="prog" class="com.hcu.scis.automation.GetProgramme" scope="session">
</jsp:useBean>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" type="text/css" href="print.css" media="print" />
        <style type="text/css">
            
            .style30 {color: #c2000d}
            .style31 {color: white}
            .style32 {color: green}
            .heading
            {
                color: white;
                background-color: #c2000d;
            }
            .border
            {
                background-color: #c2000d;
            }
            .pos_fixed
            {
                position:fixed;
                bottom:0px;
                background-color: #CCFFFF;
                border-color: red;
            }
            #bold{
                font-weight: bold;
            }
            @media print {

                .noPrint
                {
                    display:none;
                }
            } 


        </style>
        <link rel="stylesheet" type="text/css" href="table_css.css">
        <%
             Calendar now = Calendar.getInstance();
            ArrayList<String> result=new ArrayList<String>();
            int month = now.get(Calendar.MONTH) + 1;
            int year = now.get(Calendar.YEAR);
            String semester = "";
            String sem = "";
            int current_year = year;

             String StreamName = request.getParameter("pname");
            String BatchYear = request.getParameter("pyear");
             String year2 = request.getParameter("year");
              String stream = request.getParameter("streamname");
              System.out.println(StreamName);
            
            int CurriculumYear = 0, LatestYear = 0;
                String stream1 = StreamName;
                StreamName = StreamName.replace('-', '_');


                String Batch = sem;
                if (month == 1 || month == 2 || month == 3 || month == 4 || month == 5 || month == 6) {
                    semester = "Winter";
                    if (year - Integer.parseInt(BatchYear) == 1) {
                        sem = "II";

                    } else if (year - Integer.parseInt(BatchYear) == 2) {
                        sem = "IV";

                    } else if (year - Integer.parseInt(BatchYear) == 3) {
                        sem = "VI";

                    } else if (year - Integer.parseInt(BatchYear) == 4) {
                        sem = "VIII";

                    } else if (year - Integer.parseInt(BatchYear) == 5) {
                        sem = "X";

                    } else if (year - Integer.parseInt(BatchYear) == 6) {
                        sem = "XII";

                    } else if (year - Integer.parseInt(BatchYear) == 7) {
                        sem = "XIV";

                    }
                } else {
                    semester = "Monsoon";
                    if (year - Integer.parseInt(BatchYear) == 0) {
                        sem = "I";

                    } else if (year - Integer.parseInt(BatchYear) == 1) {
                        sem = "III";

                    } else if (year - Integer.parseInt(BatchYear) == 2) {
                        sem = "V";

                    } else if (year - Integer.parseInt(BatchYear) == 3) {
                        sem = "VII";

                    } else if (year - Integer.parseInt(BatchYear) == 4) {
                        sem = "IX";

                    } else if (year - Integer.parseInt(BatchYear) == 5) {
                        sem = "XI";

                    } else if (year - Integer.parseInt(BatchYear) == 6) {
                        sem = "XIII";

                    }
                }

            %>
        
     
     <center><h2 style="color:red"> List of all students who have less than 75% attendance in a particular stream and batch <h2></center>
    </br></br>
   
    </head>
    <body>
        
        <%
            
           
           // System.out.println("name"+subjectname);
             Connection con=null;
             int i, flag  ;
             String s = null;
             String r = "";
             int j = 0;
             String SubjName="";
             String id = null;
             String name = null;
             int n = 1;
             float per;
           try{  
            Class.forName("com.mysql.jdbc.Driver");
           
                    con = DriverManager.getConnection
                ("jdbc:mysql://localhost/dcis_attendance_system","root","");
                    ResultSet rs=null;
                     ResultSet rs2=null;
                    ResultSet rs3=null;
                     ResultSet rs4 =null;
                    Statement stmt =con.createStatement();
                    Statement stmt1 =con.createStatement();
                    Statement stmt2 =con.createStatement();
                    Statement stmt3 =con.createStatement();
                    Statement stmt4 =con.createStatement();
            //Hashtable ht= new Hashtable();
                    String SCode="";
          
                int year1 = prog.latestCurriculumYear(StreamName, Integer.parseInt(BatchYear));
                ResultSet rs1 = stmt1.executeQuery("select Cores,Labs, Electives,OptionalCore from "+StreamName+"_"+year1+"_currrefer");
                int count = 0;
                System.out.println("Hello in final q");
                while( rs1.next())
                {
                    int count1 = rs1.getInt(1)+rs1.getInt(2)+rs1.getInt(3)+rs1.getInt(4);
                    count += count1;
                }
                System.out.println("here : "+ count);
                 String sql1 ="select * from  "+StreamName+"_"+BatchYear;
                 %>
                 <table align ='center'>
                                <tr><th><font color='WHITE'>Student ID</font></th>
                                    <th><font color='WHITE'>Student NAME</font></th>
                                    <th><font color='WHITE'>REMARKS</font></th>
                                </tr>
                 <%
                 rs = stmt.executeQuery(sql1);
                  while(rs.next()){
                       id = rs.getString(1);
                       name = rs.getString(2);
                       flag = 0;
                       j=3;
                       i =4;
                         %><tr>
                             <td><b><font color='#663300'><%=id%></font></b></td>
                             <td><b><font color='#663300'><%=name%></font></b></td> <%
                        while(i<= (count*2+2) ){
                            
                           String s1 = rs.getString(j);
                            s =rs.getString(i);
                           // out.println(s);
                            //out.println(s1);
                            if( (s1 !=null) && !("NR".equals(s)) ){
                              //   out.println("hello");
                                // out.println(semester+","+year+",pp"+s1);
                                
                                rs3 = stmt4.executeQuery("select subjectid from subject_faculty_"+semester+"_"+year+" where subjectid='"+s1+"'");
                                if(rs3.next())
                                {
                             SCode = rs3.getString(1);
                                //out.println(SCode);
                                
                                rs2 = stmt2.executeQuery("select Subject_Name from subjecttable where Code ='"+ SCode+"'");
                                rs2.next();
                                SubjName= rs2.getString(1);
                                //out.println(SubjName);
                                 //       out.println("***************");
                        
                                rs4 =stmt3.executeQuery("select * from "+s1+"_Attendance_"+semester+"_"+year);
                                if(rs4.next()){
                                per =rs4.getFloat("percentage");
                               // out.println("*********percentage ="+per+"******");
                                if(per < 75){%>
                                 
                                                 
                             <td><b><font color='#663300'><%= SubjName%>:<%=per%></font></b></td>
                  
                   <% }
                                }
                  }
                            }
                  i=i+2;
                  j =j+2;
                        }
                  }
           }catch(Exception e){
               System.out.println(e);
           }
                
                %>
                 </tr>
            </table>
              
          <div align="center">
        <input type="button" value="Print" id="p1" class="noPrint" onclick="window.print();" />
            </div> 
                     </body>
                </html>
            