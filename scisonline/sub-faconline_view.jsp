<%-- 
    Document   : sub-faconline
--%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@include file="connectionBean.jsp" %>
<%@include file="checkValidity.jsp"%>
<%--<%@page import="java.io.OutputStream"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.io.FileInputStream"%>
<%@ page import="java.io.*"%>
<%@page import="java.io.File"%>
<%@page import="java.sql.*"%>
<%@page import="com.mysql.jdbc.Statement"%>
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
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <script language="javaScript" type="text/javascript" src="calendar.js"></script>
        <link href="calendar.css" rel="stylesheet" type="text/css">
        <style>
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
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body bgcolor="#CCFFFF" >
        <%
            Connection con = conn.getConnectionObj();
            Calendar now = Calendar.getInstance();
            System.out.println("Current date : " + (now.get(Calendar.MONTH) + 1)
                    + "-"
                    + now.get(Calendar.DATE)
                    + "-"
                    + now.get(Calendar.YEAR));
            int month = now.get(Calendar.MONTH) + 1;
            int year = now.get(Calendar.YEAR);
//  data is coming from the session duration.jsp so where varible names are current session, year2

            String given_session = request.getParameter("current_session");
            String given_year = request.getParameter("year2");


            Statement st1 = (Statement) con.createStatement();
            Statement st2 = (Statement) con.createStatement();
            Statement st3 = (Statement) con.createStatement();
            Statement st5 = (Statement) con.createStatement();
//            Statement st15 = (Statement) con.createStatement();
            ResultSet rs = (ResultSet) st1.executeQuery("select * from faculty_data order by Faculty_Name");
            ResultSet rs1 = (ResultSet) st2.executeQuery("select * from subjecttable order by Subject_Name");
//            st15.executeUpdate("create table if not exists subject_faculty_" + given_session + "_" + given_year + "(subjectid varchar(20),facultyid1 varchar(20),facultyid2 varchar(20),primary key(subjectId))");
            ResultSet rs3 = null;
        
            ResultSet rs5 = null;

            // NOTE : we dont need rs3, rs4 for new allocaiton, so i make corresponding checks like force, force kept zero indeed means we are not considering.
        %>
        <table width="100%">
            <tr>
                <th colspan="5" class="style30" align="center"><font size="6">View Allocation : <%=given_session%>-<%=given_year%></font></th>
            </tr>
        </table>
        <form >
           <div id="div">    
                <table align="center" border="1">
                    <tr>
                        <td class="heading" align="center">S.no</td>
                        <td class="heading" align="center">Faculty Name</td>
                        <td class="heading" align="center">Subject 1</td>
                        <td class="heading" align="center">Subject 2</td>
                        <td class="heading" align="center">Subject 3</td>
                        <td class="heading" align="center">Subject 4</td>
                        <td class="heading" align="center">Subject 5</td>
                        <td class="heading" align="center">Subject 6</td>
                    </tr>
                    <%int i = 1;

// get the each faculty, provide all subjects in drop list for each faculty. given some checkbox to indicate it as elective or core.
                        while (rs.next()) {

                            int find2 = 0, find1 = 0, find3 = 0;
                            rs3 = (ResultSet) st3.executeQuery("select Code,Subject_Name,type from subjecttable as a,subject_faculty_" + given_session + "_" + given_year + " as b where a.Code=b.subjectidselect Code,Subject_Name,type from subjecttable as a,subject_faculty_" + given_session + "_" + given_year + " as b where a.Code=b.subjectid and(b.facultyid1='" + rs.getString(1) + "' or b.facultyid2='" + rs.getString(1) + "')");
                            //st1.executeUpdate("drop table if exists elective_table");
                            rs5 = (ResultSet) st5.executeQuery("select * from " + given_year+"_"+given_session+ "_elective");
                            int force = 0;
                            if (rs3.next()) {
                                force = 1;
                            }
                        while (rs1.next()) {
                            if (force == 1 && rs1.getString(1).equals(rs3.getString(1)) == true) {
                                find1 = 1;
                    %>

                    <tr>
                        <td class="style30"><b><%=i%></b></td>
                        <td><b><input type="text" name="faculty" value="<%=rs.getString(2)%>" readonly="readonly"></b></td>
                        <td> <input type="text"  value="<%=rs1.getString(2)%>" readonly="readonly" ></td>

                        <%  i++;
                                }
                            }
                        %>

                        <% rs1.beforeFirst();
                            force = 0;
                            if (rs3.next()) {
                                force = 1;
                            }

                        %>

                        <%
                            while (rs1.next()) {
                                if (force == 1 && rs1.getString(1).equals(rs3.getString(1)) == true) {
                                    find2 = 1;
                        %>


                        <td> <input type="text"  value="<%=rs1.getString(2)%>" readonly="readonly" ></td>

                        <%}

                            }
                        %>

                        <% rs1.beforeFirst();
                            force = 0;
                            if (rs3.next()) {
                                force = 1;
                            }

                        %>

                        <%
                            while (rs1.next()) {
                                if (force == 1 && rs1.getString(1).equals(rs3.getString(1)) == true) {
                                    find3 = 1;
                        %>


                        <td> <input type="text"  value="<%=rs1.getString(2)%>" readonly="readonly" ></td>

                        <%}
                            }
                        %>

                        <%
                            // PADDING EXTRA COLUMS AS NULL , if any.
                            if ((find1 == 1 && find2 == 0 && find3 == 0)) {
                        %> 

                        <td> <input type="text"  value="  " readonly="readonly" ></td>
                        <td> <input type="text"  value="  " readonly="readonly" ></td>       

                        <%                        } else if ((find1 == 1 && find2 == 0)) {
                        %> 

                        <td> <input type="text"  value="  " readonly="readonly" ></td>
                            <%                               } else if ((find1 == 1 && find3 == 0)) {
                            %> 

                        <td> <input type="text"  value="   " readonly="readonly" ></td>
                            <%                                }
                            %>

                    </tr>
                    <% rs1.beforeFirst();%>
                    <%
                        }
                    %>
                </table>
            </div>

            <input type="hidden" name="given_session" value="<%=given_session%>">
            <input type="hidden" name="given_year" value="<%=given_year%>">

            &nbsp;
            &nbsp;
            &nbsp;
            <br>
            <br>
               </form>
            <table width="100%" class="pos_fixed">
                <tr>
                    <td align="center" class="border"> <input  type="button" class="border" value="Print" id="p1" style="width: 50px; color: white; background-color: #6d77d9; border-color: red;" class="noPrint" onclick="window.print();" />
                    </td>
                </tr>
            </table>
<% 
        rs.close();
        rs1.close();
        rs3.close();
        rs5.close();
        st1.close();
        st2.close();
        st3.close();
        st5.close();
        conn.closeConnection(); con = null; %>
    </body>
</html>-->
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
        <script language="javaScript" type="text/javascript" src="calendar.js"></script>
        <link href="calendar.css" rel="stylesheet" type="text/css">
        <style>
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
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body  bgcolor="#CCFFFF">

<%
    Connection con = conn.getConnectionObj();
    String given_session = request.getParameter("current_session");
    String given_year = request.getParameter("year2");
    System.out.println(given_session);
    System.out.println(given_year);
    Statement query = (Statement) con.createStatement();
    String Query = "select Subject_Name,Faculty_Name from subjecttable as s,faculty_data as f ,subject_faculty_" + given_session + "_" + given_year + " as sf where s.code=sf.SUbjectid and (f.ID=sf.facultyid1 or f.ID=sf.facultyid2) order by Faculty_Name";
    System.out.println(Query);
    ResultSet rs = query.executeQuery(Query);
%>
<table width="100%" >
            <tr>
                <th colspan="5" class="style30" align="center"><font size="6">View Allocation : <%=given_session%>-<%=given_year%></font></th>
            </tr>
        </table>
    <form >
           <div id="div">    
                <table align="center" border="1">
                    <tr>
                        <td class="heading" align="center">S.no</td>
                        <td class="heading" align="center">Faculty Name</td>
                        <td class="heading" align="center">Subject 1</td>
                        <td class="heading" align="center">Subject 2</td>
                        <td class="heading" align="center">Subject 3</td>
                        <td class="heading" align="center">Subject 4</td>
                        <td class="heading" align="center">Subject 5</td>
                        <td class="heading" align="center">Subject 6</td>
                    </tr>
    <%
    int sno = 1;
    while(rs.next()) {
        int y = 0;
        out.println("<tr>");
        String fac_name = rs.getString(2);
        out.println("<td class=\"style30\" align=\"center\">" + sno + "</td>");
        out.println("<td class=\"style30\" align=\"center\">" + fac_name + "</td>");
        do{
            String new_fac_name = rs.getString(2);
            y += 1;
            if(fac_name.equals(new_fac_name)) {
                out.println("<td class=\"style30\" align=\"center\">" + rs.getString(1) + "</td>");
            } else {
                rs.previous();
                break;
            }
        } while(rs.next());
        for(; y <= 6; y++) {
            out.println("<td class=\"style30\" align=\"center\">" + "--" + "</td>");
        }
        out.println("</tr>");
        sno++;
    }
    con.close();
    %>
     </div>

</table>
    </body>
</html>