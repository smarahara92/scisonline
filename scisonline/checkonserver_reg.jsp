<%-- 
    Document   : checkonserver_reg
--%>

<%@ include file="connectionBean.jsp" %>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DatabaseMetaData"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.io.*,java.util.*, javax.servlet.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
    <head>
        <title>JSP Page</title>
    </head>
    <body>
<%
        Connection con = conn.getConnectionObj();
        
        String selected_year = request.getParameter("selectedYear");
        String selected_session = request.getParameter("stream");
        
        DatabaseMetaData md = con.getMetaData();
        ResultSet rs = md.getTables(null, null, "subject_faculty_" + selected_session + "_" + selected_year, null);
        
        Statement st1 = (Statement) con.createStatement();
        ResultSet rs1 = null;
        String session_year = selected_session + selected_year + "yes";
        int count1 = 0, count2 = 0;
        boolean val;
        if ((rs.next())) {
            count1 = 1;  // table found , allocation done
        }
        // check counters here if any doubt in logic
        if (count1 == 0) {
%>
            00
<%
        } else {
            rs1 = st1.executeQuery("select session,year, limits from session_course_registration");
            while (rs1.next()) {
                String table_session_year = rs1.getString(1) + rs1.getString(2) + rs1.getString(3);  // get session , year from table concatinate .
                if (session_year.equals(table_session_year)) {
                    count2 = 1;  // registration done
                    break;
                }
            }        
            if (count2 == 1) {
%> 
                11
<%
            } else if (count2 == 0) {
%>
                10
<%
            }
        }
        st1.close();
        rs1.close();
        rs.close();
        conn.closeConnection();
        con = null;
%>    
    </body>
</html>
