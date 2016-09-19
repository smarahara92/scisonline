<%-- 
    Document   : s_drc
    Created on : 19 May, 2014, 10:23:50 AM
    Author     : srinu
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.io.OutputStream"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.GregorianCalendar"%>
<%@page import="java.io.File"%>
<%@page import="java.util.Calendar"%>
<%@include file="dbconnection.jsp"%>   
<%@include file="university-school-info.jsp"%> 
<%@include file="id_parser2.jsp"%> 
<%@include file="status_array.jsp"%> 
<!DOCTYPE html>
<html>
    <head>

        <script language="javaScript" type="text/javascript" src="calendar.js">
            
            
        </script>
        <link href="calendar.css" rel="stylesheet" type="text/css">
        <style>
            .var_value
            {
                width: 50px;
                overflow: hidden;
            }

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
        </style>

    </head>
    <body>
        <form action="BlankPage.jsp">
            <%

                /**
                 * **************************************************************************************************
                 * we will get the student id here, so by using studentid we
                 * find out the year. then we will retrive details of the
                 * particular student from master table, drc table.
                 * *****************************************************************************************************
                 */
                Calendar now = Calendar.getInstance();
                System.out.println("Current date : " + (now.get(Calendar.MONTH) + 1)
                        + "-"
                        + now.get(Calendar.DATE)
                        + "-"
                        + now.get(Calendar.YEAR));
                int month = now.get(Calendar.MONTH) + 1;
                int cyear = now.get(Calendar.YEAR);
                Statement st1 = con2.createStatement();
                Statement st2 = con2.createStatement();
                Statement st3 = con2.createStatement();
                Statement st4 = con2.createStatement();
                Statement st5 = con2.createStatement();
                 Statement st_snam=con2.createStatement(); 

                String sid_parser = (String) session.getAttribute("user");
                //sid_parser = "MC13PC01";


                if (sid_parser.equals("none")) {
                    out.println("<center><h3>please select student id</h3></center>");
                } else {
                    try {
                        int BATCH_YEAR = Integer.parseInt(CENTURY + sid_parser.substring(SYEAR_PREFIX, EYEAR_PREFIX));

                        String GYEAR = sid_parser.substring(SYEAR_PREFIX, EYEAR_PREFIX);
                        String SCHOOLID = sid_parser.substring(SSCHOOL_PREFIX, ESCHOOL_PREFIX);
                        String GROUPID = sid_parser.substring(SPRGM_PREFIX, EPRGM_PREFIX);
                        String ROLLID = sid_parser.substring(SROLL_PREFIX, EROLL_PREFIX);
                        /// String GYEAR= sid_parser.substring(SYEAR_PREFIX, EYEAR_PREFIX);

                        String sid = GYEAR + SCHOOLID + GROUPID + ROLLID;
                        //out.println(sid);
                        ResultSet rs1 = st1.executeQuery("select * from PhD_" + BATCH_YEAR + " where StudentId='" + sid + "'");
                        ResultSet rs_sname=st_snam.executeQuery("select * from  PhD_Student_info_"+BATCH_YEAR+" where StudentId='"+sid+"'");
                        rs_sname.next(); 
                        //out.println("srinu");
                        /*
                         *code for taking latest curriculum
                         */

                        int curriculumYear = 0, latestYear = 0;//here latestYear output of this code, that is the latest curriculum year
                        Statement st10_cur = (Statement) con2.createStatement();

                        ResultSet rs10_cur = st10_cur.executeQuery("select * from  PhD_curriculumversions order by Year desc");
                        while (rs10_cur.next()) {
                            curriculumYear = rs10_cur.getInt(1);

                            if (curriculumYear <= BATCH_YEAR) {

                                latestYear = curriculumYear;
                                System.out.println("cur year" + latestYear);
                                break;
                            }
                        }
                        // done   code for taking latest curriculum

                        // find noof electives and cores from curriculms.

                        ResultSet rs5 = st3.executeQuery("select * from PhD_" + latestYear + "_currrefer ");
                        rs5.next();
                        int noofelectives = Integer.parseInt(rs5.getString(2));
                        int noofcores = Integer.parseInt(rs5.getString(1));


                        String phd_cores_table = "PhD_" + latestYear + "_curriculum";
                        //out.println(map.get(rs1.getString("status")));

                        if (rs1.next()) {
                           
            %>
            <center>

                <table border="10" cellspacing="5" cellpadding="5" style="color:blue;background-color:#CCFFFF;" align="center">
                    <tr>
                        <th align="center">Student Id</th>
                        <th align="center">Student Name</th>
                        <th align="center">Area of Research</th>
                        <th align="center">Thesis Title</th>
                        <th align="center">Status</td>
                    </tr>
                    <tr> 

                    <input type="hidden" name="studentid" value="<%=rs1.getString("StudentId")%>">
                    <td align="center"><%=rs1.getString("StudentId")%></td>

                    <input type="hidden" name="studentname" value="<%=rs_sname.getString("StudentName")%>">
                    <td align="center"><%=rs_sname.getString("StudentName")%></td>

                    <input type="hidden" name="area" value="<%=rs1.getString("areaofresearch")%>">
                    <td align="center"><%=rs1.getString("areaofresearch")%></td>

                    <input type="hidden" name="title" value="<%=rs1.getString("thesistitle")%>">
                    <td align="center"><%=rs1.getString("thesistitle")%></td>
                    <input type="hidden" name="title" value="<%=rs1.getString("status")%>">
                    <td align="center"><%=map.get(rs1.getString("status"))%></td>
                    </tr>
                </table>
                <br>








                <table border="10" cellspacing="5" cellpadding="5" style="color:blue;background-color:#CCFFFF;" align="center">
                    <col width="10">
                    <col width="10">
                    <col width="10">
                    <col width="10">
                    <tr>
                        <td  colspan="4"><b>DRC Reports  </b></td>
                    </tr>

                    <tr>
                        <td><b>Date</b></td>
                        <td><b>Status</b></td>
                        <td><b>Progress</b></td>
                        <td><b>Suggestions</b></td>
                    </tr>

                    <%

                        ResultSet rs3 = st3.executeQuery("select * from drcreports_" + BATCH_YEAR + " where StudentId='" + sid + "'");
                        if (rs3.next()) {
                            // for cronological order use d=12,d>=1 d--;
                            for (int d = 1; d <= 12; d++) {
                                if ((rs3.getString("date" + d) != null)) {
                                    if (!(rs3.getString("date" + d).equalsIgnoreCase("null"))) {
                    %>
                    <tr>

                        <td> <a href="drcview3.jsp?studentid=<%=sid%>&date=<%=rs3.getString("date" + d)%>"><%=rs3.getString("date" + d)%></a></td>
                        <td><%=rs3.getString("status" + d)%></td>
                        <% if (rs3.getString("progress" + d).length() > 50) {
                        %>
                        <td width="50%"><a title="<%=rs3.getString("progress" + d)%>" ><%=rs3.getString("progress" + d).substring(0, 50)%></a> </td>
                        <% } else {%>
                        <td  width="50%"><a title="<%=rs3.getString("progress" + d)%>" ><%=rs3.getString("progress" + d)%></a> </td>   
                        <%}%>

                        <% if (rs3.getString("suggestions" + d).length() > 50) {
                        %>
                        <td width="50%"><a title="<%=rs3.getString("suggestions" + d)%>" ><%=rs3.getString("suggestions" + d).substring(0, 50)%></a> </td>
                        <% } else {%>
                        <td width="50%"><a title="<%=rs3.getString("suggestions" + d)%>" ><%=rs3.getString("suggestions" + d)%></a> </td>   
                        <%}%>

                    </tr>

                    <%   }
                                }
                            }
                        }
                    %>
                </table>
                <br>
                <br>
            </center>
            <%
                        } else {
                            out.println("<center><h3>No records with your id in PhD </h3></center>");
                        }
                    }// try end here
                    catch (Exception ex) {
                        out.println("<center><h3>please enter a valid student id</h3></center>");
                        // out.println("<center><h3>Fallowing could be reason"</h3></center>");
                        out.println("<center><h3>" + ex + "</h3></center>");

                    }

                }


                st1.close();
                st2.close();
                st3.close();
                st4.close();
                st5.close();
                con2.close();
            %>
        </form>
        <table width="100%" class="pos_fixed">
            <tr>
                <td align="center" class="border"> <input  type="button" class="border" value="Print" id="p1" style="width: 50px; color: white; background-color: #6d77d9; border-color: red;" class="noPrint" onclick="window.print();" />
                </td>
            </tr>
        </table>
    </body>
</html>

