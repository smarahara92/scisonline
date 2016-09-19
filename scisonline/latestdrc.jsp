<%-- 
    Document   : latestdrc
    Created on : 6 May, 2014, 1:59:19 PM
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
<%--<%@page import="java.sql.Date"%>--%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Calendar"%>
<%@include file="dbconnection.jsp"%>   
<%@include file="university-school-info.jsp"%> 
<%@include file="id_parser.jsp"%>  
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
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
        <table align="center" border="1">
            <tr  bgcolor="#c2000d">
                <td align="center" class="style31"><font size="4">Latest DRC of students</font></td>
            </tr>
        </table>

        <%
            /**
             * *****************************************************************************
             * Latest DRC of all active students
             *
             ******************************************************************************
             */
            Calendar now = Calendar.getInstance();
            String user = (String) session.getAttribute("user");

            Statement st1 = (Statement) con2.createStatement();
            Statement st2 = (Statement) con2.createStatement();
            Statement st3 = (Statement) con2.createStatement();
            Statement st4 = (Statement) con2.createStatement();
            Statement st_snam = con2.createStatement();
        %>
        <br>
        <br>
        <table border="1" cellspacing="2" cellpadding="1" align="center">
            <tr>
                <th>StudentID</th>
                <th>Student Name</th>
                <th>DRC-Date</th>
                <th>DRC-Status</th>

            </tr>


            <%
                try {
                    // get all active students, go to their master table and retrive the
                    // latest DRC
                    ResultSet rs1 = st1.executeQuery("select * from active_students");
                    while (rs1.next()) {
                        String sid = rs1.getString(1);
                        int BATCH_YEAR = Integer.parseInt(CENTURY + sid.substring(SYEAR_PREFIX, EYEAR_PREFIX));



                        ResultSet rs2 = st2.executeQuery("select * from drcreports_" + BATCH_YEAR + " where StudentId='" + sid + "'");
                        //ResultSet rs3 = st3.executeQuery("select StudentName from PhD_" + BATCH_YEAR + " where StudentId='" + sid + "'");
                        ResultSet rs_sname = st_snam.executeQuery("select * from  PhD_Student_info_" + BATCH_YEAR + " where StudentId='" + sid + "'");
                        rs_sname.next();
                        ResultSet rs3 = null;
                        if (user.equalsIgnoreCase("staff")) {
                            rs3 = st3.executeQuery("select * from PhD_" + BATCH_YEAR + " where StudentId='" + sid + "'");
                        } else {
                            rs3=st3.executeQuery("select * from PhD_"+BATCH_YEAR+" where StudentId='" + sid + "' AND ( supervisor1='"+user+"' or supervisor2='"+user+"' or supervisor3='"+user+"' )");
                       
                        }
                        if (rs3.next()) {
                            if (rs2.next()) {

                                //String Sname = rs3.getString(1);
                                String Sname = rs_sname.getString(2);
                                String date = " ";
                                String status = " ";
                                // look at all the dates from 1 to 12
                                for (int d = 1; d <= 12; d++) {

                                    if (rs2.getString("date" + d) != null) {
                                        if (!(rs2.getString("date" + d).equalsIgnoreCase("null"))) {
                                            date = rs2.getString("date" + d);
                                            status = rs2.getString("status" + d);

                                        }
                                    }

                                }
                                if (!(date.equalsIgnoreCase(" "))) {
            %>
            <tr>
                <td> <a href="drcview3.jsp?studentid=<%=sid%>&date=<%=date%>"><%=sid%> </a></td>
                <td><a href="drcview3.jsp?studentid=<%=sid%>&date=<%=date%>"> <%=Sname%></td>
                <td> <a href="drcview3.jsp?studentid=<%=sid%>&date=<%=date%>"><%=date%></td>
                <td> <a href="drcview3.jsp?studentid=<%=sid%>&date=<%=date%>"> <%=status%></td>
            <tr>
                <!--            <tr>
                                <td>fallowing not done</td>
                            </tr>-->
                <%
                } else {

                %>
            <tr>
                <td> <%=sid%></td>
                <td> <%=Sname%></td>
                <td> Not yet done</td>
                <td>Not yet done</td>
            </tr>
            <%



                                }
                            }
                        }
                        
                        rs2 = null;
                        rs3 = null;
                    }
                    rs1 = null;
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
        <table width="100%" class="pos_fixed">
            <tr>
                <td align="center" class="border"> <input  type="button" class="border" value="Print" id="p1" style="width: 50px; color: white; background-color: #6d77d9; border-color: red;" class="noPrint" onclick="window.print();" />
                </td>
            </tr>
        </table>
    </body>
</html>
