<%-- 
    Document   : consecutive_drc_fails
    Created on : 6 May, 2014, 3:46:30 PM
    Author     : srinu
--%>


<%@page import="java.text.SimpleDateFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.io.OutputStream"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.GregorianCalendar"%>
<%@page import="java.io.File"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Calendar"%>
<%@include file="dbconnection.jsp"%>   
<%@include file="university-school-info.jsp"%> 
<%@include file="id_parser.jsp"%>  
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <style>
            .style30{width:150px;color:#000000}
            .style31 {color: white}
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

        </style>
    </head>
    <body>
    <body>
        

        <%
            /**
             * *****************************************************************************
             * Latest DRC of all active students
             *
             ******************************************************************************
             */
            Calendar now = Calendar.getInstance();
            Statement st1 = (Statement) con2.createStatement();
            Statement st2 = (Statement) con2.createStatement();
            Statement st3 = (Statement) con2.createStatement();
            Statement st4 = (Statement) con2.createStatement();
        %>
        <br>
        <br>
        


            <%   int flag = 0;
                try {
                    // get all active students, go to their master table and retrive the
                    // latest DRC
                    ResultSet rs1 = st1.executeQuery("select * from active_students");
                    while (rs1.next()) {
                        String sid = rs1.getString(1);
                        int BATCH_YEAR = Integer.parseInt(CENTURY + sid.substring(SYEAR_PREFIX, EYEAR_PREFIX));



                        ResultSet rs2 = st2.executeQuery("select * from drcreports_" + BATCH_YEAR + " where StudentId='" + sid + "'");
                        ResultSet rs3 = st3.executeQuery("select StudentName from PhD_Student_info_" + BATCH_YEAR + " where StudentId='" + sid + "'");

                        if (rs2.next() && rs3.next()) {
                            String Sname = rs3.getString(1);
                            String date = " ";
                            String status = " ";
                            int drcs_fail = 0;
                            // look at all the dates from 1 to 12
                            // look for 3-consecutive unsatisfactory status
                            for (int d = 1; d <= 12; d++) {

                                if (rs2.getString("date" + d) != null) {
                                    if (!(rs2.getString("date" + d).equalsIgnoreCase("null"))) {
                                        if ((rs2.getString("status" + d).equalsIgnoreCase("UnSatisfactory"))) {
                                            drcs_fail = drcs_fail + 1;

                                        } else {
                                             if (drcs_fail >= 3)
                                                 break;
                                             else
                                            drcs_fail = 0;
                                        }

                                    }
                                }

                            }
                            if (drcs_fail >= 3) {
                                flag = 1;
            %>              <table align="center" border="1">
                                <tr  bgcolor="#c2000d">
                                    <td align="center" class="style31"><font size="4">List of Students having 3-consecutive Unsatisfied DRCs </font></td>
                                </tr>
                            </table>
                             <table border="1" cellspacing="2" cellpadding="1" align="center">
                             <tr>
                                <th>StudentID</th>
                                <th>Student Name</th>
                            </tr>
                            <tr>
                                <td> <%=sid%></td>
                                <td> <%=Sname%></td>
                            </tr>
                <%
                }
                            
                        }

                    }
                    st1.close();
                    st2.close();
                    st3.close();
                    st4.close();
                    con2.close();
                    con.close();

                } catch (Exception e) {
                    out.println(e);
                }


            %>
        </table>
        <br>
        <%if (flag == 0) {%>
            <tr><td colspan=2> <h3 style="color:#c2000d" align="center">No student available</h3></td></tr>
    <%  }%>
        <table width="100%" class="pos_fixed">
            <tr>
                <td align="center" class="border"> <input  type="button" class="border" value="Print" id="p1" style="width: 50px; color: white; background-color: #6d77d9; border-color: red;" class="noPrint" onclick="window.print();" />
                </td>
            </tr>
        </table>
    </body>
</html>
