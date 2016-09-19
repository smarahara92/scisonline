<%-- 
    Document   : deletestudent_ajax
--%>

<%@page import="java.sql.*"%>
<%@ include file="connectionBean.jsp" %>
<%@ include file="id_parser.jsp" %>

<%
    Connection con = conn.getConnectionObj();
    
    System.out.println("dddddddddddddddddddddddddddddddddddddddddddddddd");
    String programmeName = null;
    String PROGRAMME_NAME = null;
    String year = null;
    String studentId = request.getParameter("stuid");


    try { //validating student id for adding student.


        PROGRAMME_NAME = studentId.substring(SPRGM_PREFIX, EPRGM_PREFIX);
        String BATCH_YEAR = studentId.substring(SYEAR_PREFIX, EYEAR_PREFIX);
        year = "20" + BATCH_YEAR;
    } catch (Exception e) {
%>
5
<% return;
    }
    Statement st = con.createStatement();
    Statement st1 = con.createStatement();
    



    ResultSet rs = st.executeQuery("select Programme_name from programme_table where Programme_code='" + PROGRAMME_NAME + "'");
    if (rs.next()) {



        String table = rs.getString(1).replace('-', '_') + "_" + year;
        System.out.println(table);
        ResultSet rs1 = st1.executeQuery("select * from " + table + " where studentId='" + studentId + "'");
        if (rs1.next()) {//Duplicate entry
%>
1
<%    } else {//Invalid student id for Programme.
%>
2
<%                }

} else {
%>
5
<%    }
%>
<%
        conn.closeConnection();
        con = null;
%>