<%-- 
    Document   : ajax_addSubject_validate
    Created on : 30 Apr, 2015, 5:14:46 AM
    Author     : root
--%>
<%@page import="java.sql.ResultSet"%>
<%@include file="programmeRetrieveBeans.jsp" %>
<%
    String sid = request.getParameter("sid").trim().toUpperCase();
    String query = "select * from subjecttable where code = '"+sid+"'";
    ResultSet rs = scis.executeQuery(query);
    if(rs != null && rs.next()) {
        out.println(0);
    } else {
        out.println(1);
    }
%>