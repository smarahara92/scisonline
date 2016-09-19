<%-- 
    Document   : projectRegistrationInterns_ajax
--%>

<%@page import="java.sql.ResultSet"%>
<%@include file="programmeRetrieveBeans.jsp"%>

<%
    try {
        //getting parameter from select_option_staffProjectStream2.jsp
        String streamName = request.getParameter("programmeName");
        String streamYear = request.getParameter("batch");
            
        if (streamName.equalsIgnoreCase("Select Programme")) {
%>
            <option value="none">Select Student ID</option>
<%
        } else {
            ResultSet rs = scis.studentListUnallocatedProject(streamName, streamYear);
        
%>
            <option value="none" >Select Student ID</option>
<%
            while (rs.next()) {
%>
                <option><%=rs.getString(1)%></option>
<%
            }
            rs.close();
        }
    } catch (Exception e) {
        System.out.println(e);
    }
    scis.close();
%>
