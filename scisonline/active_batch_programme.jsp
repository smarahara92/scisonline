<%-- 
    Document   : ajax_active_batch
    Created on : 17 Mar, 2015, 10:58:55 AM
    Author     : nwlab
--%>

<%@page import = "java.sql.ResultSet"%>
<%@include file = "programmeRetrieveBeans.jsp" %>
<%
    String prg = request.getParameter("programme");
    String programme = scis.getStreamOfProgramme(prg);
%>                    
    <option style=" alignment-adjust: central" value="none">Select Year</option>
<%
    try {
        ResultSet rs = scis.getActiveBatchs(programme);
        while(rs.next()) {
%>
            <option value="<%=rs.getString(1)%>" ><%=rs.getString(1)%></option>
<%
        }
    } catch(Exception e) {
        System.out.println(e);
    }
    scis.close();
%>