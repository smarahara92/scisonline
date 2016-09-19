<%-- 
    Document   : faculty_uploadcheck_ajax
--%>

<%@include file="checkValidity.jsp"%>

<%@ include file="connectionBean.jsp" %>
<%@page import="java.sql.*"%>
<%@page import="java.util.Calendar"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

    <body>
<%
        Connection con = conn.getConnectionObj();
        
        DatabaseMetaData metadata = con.getMetaData();
        ResultSet resultSet;
        resultSet = metadata.getTables(null, null, "faculty_data", null);
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

