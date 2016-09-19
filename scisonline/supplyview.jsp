<%-- 
    Document   : supplyview
    Created on : Mar 10, 2014, 10:43:31 AM
    Author     : veeru
--%>

<%@page import="java.util.Calendar"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="connectionBean.jsp"%>
<%@page import ="java.sql.*" %>
<%@include file="id_parser.jsp"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" type="text/css" href="table_css.css">
    </head>
    <body>


        <%             
        
            Connection con = conn.getConnectionObj();
        try{
            Calendar now = Calendar.getInstance();
            int year = now.get(Calendar.YEAR);
            int month = now.get(Calendar.MONTH);
            String byear = null;
            String semester = null;
            String studentName = null;
            ResultSet rs = null;
            if (month <= 6) {
                semester = "Winter";
            } else {
                semester = "Winter";
            }
            Statement st = con.createStatement();
            Statement st1 = con.createStatement();
            Statement st2 = con.createStatement();
            Statement st3 = con.createStatement();
            try {
                rs = st3.executeQuery("select * from supp_" + semester + "_" + year + "");
            } catch (Exception e) {
                out.println("Supplementary registration has not done.");
                return;
            }
            ResultSetMetaData metaData = rs.getMetaData();
            int count = metaData.getColumnCount(); //number of column
            if (rs.next()) {
        %>
    <center>University of Hyderabad</center>
    <center>School of Computer and Information Sciences</center>
    <center>supplementary registration</center>
    <table align="center" width="95%" border="1">
        <caption><h3> </h3></caption>
        <th>Student Id</th>
        <th>Student Name</th>
        <th>Subject Name</th>
            <%
                } else {

                    out.println("No students are registered for supplementary.");
                    return;
                }
                rs.beforeFirst();

                while (rs.next()) {

            %>
        <tr>
            <td><%=rs.getString(1)%></td>
            <%
                String PROGRAMME_NAME = rs.getString(1).substring(SPRGM_PREFIX, EPRGM_PREFIX);
                String BATCH_YEAR = rs.getString(1).substring(SYEAR_PREFIX, EYEAR_PREFIX);
                ResultSet rs1 = st.executeQuery("select Programme_name  from programme_table where Programme_code='" + PROGRAMME_NAME + "'");
                rs1.next();
                byear = "20" + BATCH_YEAR;
                int byear1 = Integer.parseInt(byear);

                int year1 = byear1;
                for (int i = 2; i > 0; i--) {
                    String table = rs1.getString(1).replace('-', '_') + "_" + year1;
                    System.out.println(table + rs.getString(1) + "==------");
                    ResultSet rs2 = st1.executeQuery("select StudentName from " + table + " where StudentId='" + rs.getString(1) + "'");
                    if (rs2.next()) {
                        studentName = rs2.getString(1);
                        System.out.println(studentName);
                        break;
                    }
                    year1++;

                }
            %>
            <td><%=studentName%></td>
            <td>
                <%
                    int m = 2;
                    int count1 = 0;
                    int count2 = 0;
                    for (int j = 0; j < 7; j++) {
                        if (rs.getString(m) != null) {
                            ResultSet rs3 = st2.executeQuery("select Subject_Name from subjecttable  where Code='" + rs.getString(m) + "'");
                            if (rs3.next()) {
                                count1++;
                            }
                            m = m + 3;
                        }
                    }

                    m = 2;
                    for (int j = 0; j < 7; j++) {
                        if (rs.getString(m) != null) {
                            count2++;
                            ResultSet rs3 = st2.executeQuery("select Subject_Name from subjecttable  where Code='" + rs.getString(m) + "'");
                            if (rs3.next()) {
                                if (count2 != count1) {
                %>
                <%=rs3.getString(1)%> ,&nbsp;
                <%} else {
                %>
                <%=rs3.getString(1)%> 
                <%
                                }
                            }
                            m = m + 3;
                        }
                    }
                %>
            </td>
        </tr>
        <%                }

        %>
    </table>&nbsp;<br>
    <div align="center">
        <input type="button" value="Print" id="p1"  class="noPrint" onclick="window.print();" />
    </div>
</body>
</html>
<%}catch (Exception e) {
                out.println(e);
            } finally{
              conn.closeConnection();
              con = null;
        }
                
                %>
