<%-- 
    Document   : Q_ShortAtten_Subj3_15
    Created on : Mar 18, 2015, 12:05:23 PM
    Author     : richa
--%>

<%@include file ="connectionBean.jsp" %>
<%--<%@page import="com.hcu.con"%>--%>
<%@page import="javax.sound.midi.SysexMessage"%>
<%@page import="java.util.Calendar"%>
<%@page import ="javax.sql.*" %>
<%@page import="java.sql.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" type="text/css" href="print.css" media="print" />
        <style type="text/css">
            @media print {

                .noPrint
                {
                    display:none;
                }
            }

        </style>
        <link rel="stylesheet" type="text/css" href="table_css.css">

    </head>
    <body>

        <%
            Calendar now = Calendar.getInstance();

            int month = now.get(Calendar.MONTH) + 1;
            int year = now.get(Calendar.YEAR);
            String semester = "";
            String sem = "";
            int current_year = year;

            String StreamName = request.getParameter("pname");
            String BatchYear = request.getParameter("pyear");

            String year2 = request.getParameter("year");


            String stream = request.getParameter("streamname");


          
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
     <center><h3 style="color:red">List of students who have less than 75% attendance in a particular stream and batch</h3></center>
    <center><b>Stream :</b><%=stream1%> <b>  Semester :</b><%=sem%> <b>Batch :</b> <%=BatchYear%> <b>Attendance</b></center>
    </br></br>

    <%
        //out.println(year2+"   "+stream);
        Connection con = conn.getConnectionObj();
        try{
        Statement st1 = con.createStatement();
        Statement st2 = con.createStatement();
        Statement st3 = con.createStatement();
        Statement st4 = con.createStatement();
        Statement st5 = con.createStatement();
        Statement st6 = con.createStatement();
        Statement st7 = con.createStatement();
        ResultSet rs1 = st1.executeQuery("select * from " + StreamName + "_" + BatchYear + "");
        ResultSet rs2 =st2.executeQuery("select ");
        ResultSetMetaData rsmd = rs1.getMetaData();
        int noOfColumns = rsmd.getColumnCount();

    %>
    <table border="1" align="center">
        <tr>
            <th>Student Id</th>
            <th>Student Name</th>
             <th>Remarks</th>

        </tr>
        <%
        
         while(){
             
         }
          while (rs1.next()) {
                int i = 0;
                float percentage = 0;
                String subjectCode = "";
                int noofsubjects = 0;
               
            }%>
    </table>
    </br></br>
    <div align="center">
        <input type="button" value="Print" id="p1" class="noPrint" onclick="window.print();" />
    </div>

    <%
         
       }catch (Exception e) {
            out.println("<center><h2>Data not found</h2></center>");
            e.printStackTrace();
        }finally{
            conn.closeConnection();
            con = null;
        }
    %>
</body>
</html>
