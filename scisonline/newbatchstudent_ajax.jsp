<%-- 
    Document   : newbatchstudent_ajax
--%>

<%@page import="java.sql.*"%>
<%@include file="checkValidity.jsp"%>
<%@include file="connectionBean.jsp" %>

<%
    Connection con = conn.getConnectionObj();
    
    String pgname = request.getParameter("pgname");
    Statement st = con.createStatement();

    ResultSet rs = st.executeQuery("select Programme_group from programme_table where Programme_name='" + pgname + "' and Programme_status='1'");
    if (rs.next()) {
%>
1
<%
} else {
%>
0
<%
    }


%>
<%
        conn.closeConnection();
        con = null;
%>