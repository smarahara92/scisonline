<%-- 
    Document   : subcheckdata_ajax
--%>

<%@ include file="connectionBean.jsp" %>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DatabaseMetaData"%>
<%@page import="java.util.Calendar"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<body>
<%
    Connection con = conn.getConnectionObj();
    DatabaseMetaData metadata = con.getMetaData();
    ResultSet resultSet;
    resultSet = metadata.getTables(null, null, "subject_data", null);
    if (resultSet.next()) {
        System.out.println("table exist");
%>
        true
<%
    } else {
%>
        false
<%
    }
    conn.closeConnection();
    con = null;
%>
</body>

