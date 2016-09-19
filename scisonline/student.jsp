<%-- 
    Document   : student
--%>

<%@include file="checkValidity.jsp"%>
<%@page import="java.sql.ResultSet"%>
<%@include file="programmeRetrieveBeans.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href="table_css.css" type="text/css">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    </head>
    <body>
<%
        String role = (String) session.getAttribute("role");
        String studentId = "";
        if (role.equalsIgnoreCase("student") == true) {
            studentId = (String) session.getAttribute("user"); // mc12mi28
            studentId = scis.getStudentId(studentId);
        } else {
            studentId = request.getParameter("studentId");
        }
        
        String programmeName = scis.studentProgramme(studentId);
        String programmeGroup = scis.getStreamOfProgramme(programmeName);
        int batchYear = scis.studentBatchYear(studentId);
        String studentName = scis.studentName(studentId);
      //  String projectTable = programmeGroup.replace('-', '_') + "_Project_" + batchYear;
        String projectStudentTable = programmeName.replace('-', '_') + "_Project_Student_" + batchYear;
    //    int curriculumYear = scis.latestCurriculumYear(programmeName, batchYear);
        
        ResultSet rs = scis.executeQuery("select ProjectId, AdvisorMarks1, PanelMarks1, AverageMarks1, AdvisorMarks2, PanelMarks2, AverageMarks2, TotalMarks, Grade, Status+0 status from " + projectStudentTable + " where StudentId='" + studentId + "'");
        if(rs == null) {
%>
            <center><h2>The Projects are not yet floated.</h2></center>
<%
            return;
        } else if (!(rs.next())) {
%>
            <center><h2>Some internal error occurred.</h2></center>
<%            
            return;
        }
        int projectID = rs.getInt("ProjectId");
        String projectTitle = scis.getProjecttitle(programmeGroup, batchYear, projectID);
        if(projectTitle == null) {
            projectTitle = "";
        }
%>
        <center><b>University of Hyderabad</b></center>
        <center><b>School of Computer and Information Sciences</b></center>
        <center><b>Project assessment of the Student: <%=studentId%></b></center>
        <center><b>Name of the Student:</b> <%=studentName%> <b>&nbsp; Stream:</b> <%=programmeName.replace('_', '-')%><b>&nbsp;Batch:</b> <%=batchYear%></center>
        <br/>
        <table align="center" border="1" width="85%">
            <col width="34%">
            <col width="7%">
            <col width="7%">
            <col width="7%">
            <col width="7%">
            <col width="7%">
            <col width="7%">
            <col width="7%">
            <col width="7%">
            <col width="10%">
            <tr bgcolor="red"> 
                <td rowspan="2" align="center" style=" background-color: #c2000d;color: white;font-weight: bold">Project Title</td>
                <td colspan="2" align="center" style=" background-color: #c2000d;color: white;font-weight: bold">Mid Term</td>
                <td rowspan="2" align="center" style=" background-color: #c2000d;color: white;font-weight: bold">Internal</td>
                <td colspan="2" align="center" style=" background-color: #c2000d;color: white;font-weight: bold">Major</td>
                <td rowspan="2" align="center" style=" background-color: #c2000d;color: white;font-weight: bold">Final</td>
                <td rowspan="2" align="center" style=" background-color: #c2000d;color: white;font-weight: bold">Total</td>
                <td rowspan="2" align="center" style=" background-color: #c2000d;color: white;font-weight: bold">Grade</td>
                <td rowspan="2" align="center" style=" background-color: #c2000d;color: white;font-weight: bold">Status</td>
            </tr>
            <tr> 
                <td align="center" style=" background-color: #c2000d;color: white;font-weight: bold">Supervisor</td>
                <td align="center" style=" background-color: #c2000d;color: white;font-weight: bold">Panel</td>
                <td align="center" style=" background-color: #c2000d;color: white;font-weight: bold">Supervisor</td>
                <td align="center" style=" background-color: #c2000d;color: white;font-weight: bold">External / Panel</td>
            </tr>
            <tr>
                <td><%=projectTitle%></td> 
<%
                /**
                 * column names 
                 * ProjectId, AdvisorMarks1, PanelMarks1, AverageMarks1, AdvisorMarks2, PanelMarks2, AverageMarks2, TotalMarks, Grade, Status+0 status
                 **/
                String marks = null;
                for(int i = 2; i < 10; i++) {
                    marks = rs.getString(i);
                    if ( marks != null) {
%>
                        <td><%=marks%></td>
<%
                    } else {
%>  
                        <td></td> 
<%
                    }
                }
               
                String projID=rs.getString("ProjectId");
                marks = rs.getString("status");
                if(marks == null && projID != null) {
                    marks = "Allocated";
                } else {
                    marks = scis.getStatus(programmeGroup, rs.getString("status"));
                }
                if ( marks != null) {
%>
                    <td><%=marks%></td>
<%
                } else {
%>  
                    <td></td> 
<%
                }
%>
            </tr>
        </table>
<%
        scis.close();
%>
    </body>
</html>