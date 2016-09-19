<%-- 
    Document   : addingstudent_ajax
--%>

<%@page import="java.sql.*"%>
<%@ include file="connectionBean.jsp" %>
<%@ include file="id_parser.jsp" %>

<%
    Connection con = conn.getConnectionObj();
    
    String programmeName = null;
    String PROGRAMME_NAME = null;
    String year = null;
    String studentId = request.getParameter("studentId");
    programmeName = request.getParameter("stream");

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
    System.out.println(programmeName);



    ResultSet rs = st.executeQuery("select Programme_name from programme_table where Programme_code='" + PROGRAMME_NAME + "'");
    if (rs.next()) {

        if (rs.getString(1).equalsIgnoreCase(programmeName)) {
        } else {//Invalid student id for Programme.
%>
2
<%                }

} else {//Invalid Student id.
%>
3            
<%    }

        conn.closeConnection();
        con = null;
%>