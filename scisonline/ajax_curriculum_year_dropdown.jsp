<%-- 
    Document   : ajax_curriculum_year_dropdown
    Created on : 30 Apr, 2015, 4:23:33 AM
    Author     : root
--%>
<%@page import="java.sql.ResultSet"%>
<%@include file="programmeRetrieveBeans.jsp" %>
<%
    String programmeName = request.getParameter("programme").replace('-', '_');
    System.out.println(programmeName);
    String query = "select Year from "+programmeName+"_curriculumversions order by year";
    ResultSet rs = scis.executeQuery(query);
    out.println("<option value=\"\">Select Curriculum Year</option>");
    while(rs != null && rs.next()) {
        int year = rs.getInt(1);
        out.println("<option value=\""+year+"\">"+year+" Curriculum</option>");
    }
%>