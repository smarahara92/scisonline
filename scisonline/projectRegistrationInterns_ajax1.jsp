<%-- 
    Document   : projectRegistrationInterns_ajax1
    Created on : May 18, 2014, 4:52:36 PM
    Author     : veeru
--%>

<%@include file="checkValidity.jsp"%>
<%@page import="java.util.Calendar"%>
<%@include file="dbconnection.jsp"%>
<%@include file="programmeRetrieveBeans.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%            try {
                String streamName = request.getParameter("programmeName");
                String studentId = request.getParameter("studentId");
                String programmeName = scis.studentProgramme(studentId);
                programmeName = programmeName.replace('-', '_');
                Calendar now = Calendar.getInstance();
                int year = now.get(Calendar.YEAR);
                int month = now.get(Calendar.MONTH) + 1;
                int pyear = year;
                String semester = null;
                if (streamName.equalsIgnoreCase("MCA") == true) {
                    if (month <= 6) {
                        semester = "Winter";
                        pyear = year;
                    } else {
                        semester = "Monsoon";
                        pyear = year - 1;
                    }
                } else {
                    if (month > 3) {
                        pyear = year;
                    } else {
                        pyear = year - 1;
                    }
                }
                Statement st = con.createStatement();
                Statement st1 = con.createStatement();
                ResultSet rs5 = (ResultSet) st.executeQuery("select * from  " + streamName + "_project" + "_" + pyear + " as a where a.ProjectId in(Select b.ProjectId from " + programmeName + "_Project_Student_" + pyear + " as b where b.StudentId='" + studentId + "' ) and a.Organization<>'uoh'");
                ResultSet rs6 = (ResultSet) st1.executeQuery("select * from  " + streamName + "_project" + "_" + pyear + " as a where a.ProjectId in(Select b.ProjectId from " + programmeName + "_Project_Student_" + pyear + " as b where b.StudentId='" + studentId + "') and a.Organization='uoh'");

                if (rs5.next()) {%>
        1
        <%} else if (rs6.next() != true) {%>
        2
        <%}
            } catch (Exception ex) {
            }
        %>
    </body>
</html>
