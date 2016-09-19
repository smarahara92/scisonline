        <%-- 
    Document   : Demo_streamsummary
    Created on : Mar 25, 2015, 10:50:57 AM
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
    <center><b>University of Hyderabad</b></center>
    <center><b>School of Computer and Information Sciences</b></center>
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
        Statement stmt01 = con.createStatement();
        ResultSet rs1 = st1.executeQuery("select * from " + StreamName + "_" + BatchYear + "");
        ResultSetMetaData rsmd = rs1.getMetaData();
        int noOfColumns = rsmd.getColumnCount();
        ResultSet rs3 = null ;
          String id ="";
            String name ="";
            ResultSet RS1 = null;
              while (rs1.next()) {
        
                int temp = (noOfColumns - 2) / 2; //need to mention number of columns in table
                int cummatten = 0;
                int total = 0;
                int i = 0;
                float percentage = 0;
                String subjects = "";
                int noofsubjects = 0;
                //##########################################################################################################

                /*
                 * Taking correct version of curriculum for particular programme
                 */
                ResultSet rs10 = st4.executeQuery("select * from " + StreamName + "_curriculumversions order by Year desc");
                while (rs10.next()) {
                    CurriculumYear = rs10.getInt(1);
                    if (CurriculumYear <= Integer.parseInt(BatchYear)) {

                        LatestYear = CurriculumYear;
                        System.out.println(LatestYear);
                        break;
                    }
                }
                //##########################################################################################################
                while (temp > 0) {

                    int m = i + 3;
                    String R = "R";
                    String R1 = "A+";
                    String R2 = "A";
                    String R3 = "B+";
                    String R4 = "B";
                    String R5 = "C";
                    String R6 = "D";
                    String R7 = "F";
                    if (R.equals(rs1.getString(m + 1)) || R1.equals(rs1.getString(m + 1)) || R2.equals(rs1.getString(m + 1)) || R3.equals(rs1.getString(m + 1))
                            || R4.equals(rs1.getString(m + 1)) || R5.equals(rs1.getString(m + 1)) || R6.equals(rs1.getString(m + 1)) || R7.equals(rs1.getString(m + 1))) {
                        String modified = rs1.getString(m);
                       
                        ResultSet rs11 = st2.executeQuery("select Alias from " + StreamName + "_" + LatestYear + "_curriculum where SubCode='" + modified + "'");
                        while (rs11.next()) {
                            if (rs11.getString(1) != null) {
                                modified = rs11.getString(1);
                            }
                        }
                      
            %>


            
              <%--  try {
                    String qry3 = "select *  from " + modified + "_Attendance_" + semester + "_" + year + " where StudentId='" + rs1.getString(1) + "'";
                     rs3 = st3.executeQuery(qry3);
                   
                    while (rs3.next()) {

                        percentage = percentage + rs3.getFloat("percentage");
                      //  out.println(rs3.getString(1)+":"+rs3.getFloat("percentage"));
                       
                        //out.println(modified);
                        if (rs3.getFloat("percentage") < 75) {
                         // out.println(modified);
                            ResultSet RS = stmt01.executeQuery("select subjName from subject_data where subjId ='"+modified+"'");
                            RS.next();
                            id = rs3.getString(1);
                            name = rs3.getString(2);
                            String Name = RS.getString(1);
                            //out.println(RS.getString(1));
                            subjects = subjects + " " + Name+" ::" + rs3.getFloat("percentage") + " ";
                        }
                    }
                } catch (Exception ex) {
                }%>
            <%}
                    i = i + 2;
                    temp--;
                }

               // if (percentage == 0.0) {%>
               <%--<td> </td>
            <%           } else {
            %><td><%=Math.ceil(percentage / noofsubjects)%></td><%
                }
            %> --%>
               
            --%>
            <%
                         ResultSet rs30 = stmt01.executeQuery("select * from " + StreamName + "_" + LatestYear + "_currrefer"); //here LatestYear is  for latest curriculumrefer.


            /*
             * counting total number of subject in semester.
             * here columns is equal to number of subjects in semester.
             * So that many column can print on jsp page.
             */
            int columns = 0;

            while (rs30.next()) {

                if (rs30.getString(1).equals(sem)) {

                    System.out.println("sem value is" + sem);
                    columns = rs30.getInt(2) + rs30.getInt(3) + rs30.getInt(4);

                    System.out.println("columns" + columns);
                }

            } %>
            <table border="1"  align="center">


        <th>Student Id</th>
        <th>Student Name</th>
            <%
                System.out.println(columns + "column count");
                int w = 1;
                while (w <= columns) {
            %> <th colspan="2">Subject<%=w%></th>
            <%
                    w++;
                }
            %>
        <th>Remarks</th> 
                       
            <tr>
            <td><%=id%></td>
            <td width="10"><%=name%></td>
            <td><%=subjects%></td>

          
        </tr>
        <%
            }
        %>
    </table>

   
    </br></br>
    <div align="center">
        <input type="button" value="Print" id="p1" class="noPrint" onclick="window.print();" />
    </div>

    <%
        } catch (Exception e) {
            out.println("<center><h2>Data not found</h2></center>");
            e.printStackTrace();
        }finally{
            conn.closeConnection();
            con = null;
        }
    %>
</body>
</html>
