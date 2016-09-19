<%-- 
    Document   : deletesubject_ajax
    Created on : Mar 24, 2014, 10:43:15 PM
    Author     : veeru
--%>

<%@page import="java.util.Calendar"%>
<%@ include file="dbconnection.jsp" %>
<%@ include file="id_parser.jsp" %>

<%    //System.out.println("//////in ajax code for deletesubject test");
    Calendar now = Calendar.getInstance();
    int month = now.get(Calendar.MONTH) + 1;
    int year = now.get(Calendar.YEAR);
    String semester = null;
    if (month <= 6) {
        semester = "Winter";
    } else {
        semester = "Monsoon";
    }

    String subid = request.getParameter("subcode");
    Statement st = con.createStatement();
    String table = "subject_faculty_" + semester + "_" + year;
    try {
        ResultSet rs = st.executeQuery("select * from " + table + "  where subjectid='" + subid + "'");
        if (rs.next()) {
%>
1
<%
} else {
%>
2
<%
    }
} catch (Exception e) {
%>
2
<%
    }
%>