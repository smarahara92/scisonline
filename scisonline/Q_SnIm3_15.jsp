<%-- 
    Document   : Q_FINAL_READMIN1
    Created on : Mar 3, 2015, 12:32:14 PM
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
        <script >
            function action1()
            {
                if (document.getElementById('select1').value === "Select Semester") {
                    parent.staffaction.location = "./BalankPage2.jsp";
                    document.getElementById('errfn').innerHTML = "*Please select Sem";
                    document.getElementById("select1").focus();
                } else {
                //  alert("helllooo");
                   // document.getElementById('errfn').innerHTML = "";
                   // document.form1.submit();
      //             var x= document.getElementById('mySelect2').value;
                     
                    var name = document.getElementById('select1').value;
                  //  alert(name);
                   
                    
                    parent.act_area.location = "./Q_SnIm4_15.jsp?pname="+name;
                                        //document.form1.submit();

                }

            }
        </script>
        <link rel="stylesheet" type="text/css" href="table_css.css">
        <%
           
             Calendar now = Calendar.getInstance();
             ArrayList<String> result=new ArrayList<String>();
            int month = now.get(Calendar.MONTH) + 1;
            int year = now.get(Calendar.YEAR);
            String semester = "";
            String sem = "";
            int current_year = year;
            int check = 0;
             String StreamName = request.getParameter("pname");
            String BatchYear = request.getParameter("pyear");
             String year2 = request.getParameter("year");
              String stream = request.getParameter("streamname");

             session.setAttribute("suppyear", BatchYear );
             session.setAttribute("suppsem", StreamName );
            System.out.println("Hello :"+StreamName);
            System.out.println("Hello dhf:"+BatchYear);
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
       
    </head>
    <body>
        <form name="form1" id="form1" action="Q_SnIm4_15.jsp" target="staffaction" method="POST">
        <%
            
           
           // System.out.println("name"+subjectname);
             Connection con=null;
             int i, flag  ;
             String id = null;
             String name = null;
             int n = 1;
           try{  
            Class.forName("com.mysql.jdbc.Driver");
           
                    con = DriverManager.getConnection
                ("jdbc:mysql://localhost/dcis_attendance_system","root","");
                 ResultSet rs=null;
                  ResultSet rs3=null;
                 Statement stmt =con.createStatement();
                 Statement stmt1 =con.createStatement();
                  Statement stmt4 =con.createStatement();
                  String sql1 = "select * from subject_faculty_"+StreamName+"_"+BatchYear+"";
                  rs = stmt.executeQuery(sql1);
                  %>
                  <select  name="psubject" id="select1" onchange="action1();">
                      <option>Select Subject</option>
                  <%
          while(rs.next()){
              rs3 = stmt4.executeQuery("select * from subjecttable where Code='"+rs.getString(1)+"'");
              
              rs3.next();
          %>
          <option value="<%=rs.getString(1)%>"><%=rs3.getString(2)%></option>
                        
                  <%}
          %>
           </select>
                  <%
                }catch(Exception e){
                   con.close();
                }%>
                
               
        </form>
    </body>
    </html>