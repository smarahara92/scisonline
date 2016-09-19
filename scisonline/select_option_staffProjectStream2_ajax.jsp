<%-- 
    Document   : select_option_staffProjectStream2_ajax
--%>

<%@include file="programmeRetrieveBeans.jsp"%>
<%@page import="java.sql.ResultSet"%>

<%
    try {
        //getting parameter from select_option_staffProjectStream2.jsp
        String streamName = request.getParameter("programmeName");
        String streamYear = request.getParameter("streamYear");
        
        ResultSet rs2 = scis.studentListUnallocatedProject(streamName, streamYear);
%>
<option value="none">Select Student ID</option>
<%
        while (rs2.next()) {
%>
<option value="<%=rs2.getString(1)%>"><%=rs2.getString(1)%></option>
<%
        }
    } catch(Exception e) {
        System.out.println(e);
    }
    scis.close();
%>