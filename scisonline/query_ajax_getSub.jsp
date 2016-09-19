<%-- 
    Document   : query_ajax_getSub
    Created on : 27 Feb, 2015, 12:12:27 PM
    Author     : nwlab
--%>

<%@page import = "java.sql.ResultSet"%>
<%@include file = "programmeRetrieveBeans.jsp" %>
<%
    String sess = request.getParameter("sess");
    int year = Integer.parseInt(request.getParameter("year").trim());
%>                    
    <option value="none" > Select Subject </option>
<%
    try {
        ResultSet rs = scis.subjectList(sess, year);
        while(rs.next()) {
%>
            <option value="<%=rs.getString(1)%>" ><%=rs.getString(2)%></option>
<%
        }
    } catch(Exception e) {
        System.out.println(e);
    }
    scis.close();
%>