<%-- 
    Document   : studentMarks
--%>

<%@page import="java.sql.*"%>
<%@include  file = "connectionBean.jsp" %>
<%@include file="programmeRetrieveBeans.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="table_css.css"> </head>
    </head>
    <body>
<%
        /*String role = (String) session.getAttribute("role");
        String studentId = "";
        if (role.equalsIgnoreCase("student") == true) {
            studentId = (String) session.getAttribute("user"); // mc12mi28
            studentId = scis.getStudentId(studentId);
        } else {
            studentId = request.getParameter("studentId");
        }
        
        String programmeName = scis.studentProgramme(studentId).replace('_', '-');
        int batchYear = scis.studentBatchYear(studentId);
        String studentName = scis.studentName(studentId);
        int curriculumYear = scis.latestCurriculumYear(programmeName, batchYear);*/

        /*String masterTable = programmeName.replace('-', '_') + "_" + batchYear;
        String query = "select * from " + masterTable + " where StudentId = '" + studentId +"'";
        ResultSet rs = scis.executeQuery(query);*/
        if(rs == null) {
            out.print("<center><h2>Data does not exists.</h2></center>");
            return;
        }
        if( !(rs.next()) ) {
            out.print("<center><h2>Data does not exists.</h2></center>");
            return;
        }
        
        //Connection con1 = conn1.getConnectionObj();
        //Statement st = con1.createStatement();
            
        int noOfColumns = 0;
        int i = 0;

        String sem = scis.getLatestSemester();
        int cyear = scis.getLatestYear();
%>
        <center>University of Hyderabad</center>
        <center>Department of Computer and Information Sciences</center>
        <center>Assessment of the Student: <%=studentId%></center>
        <center><%=studentName%> &nbsp;&nbsp;<b>Stream: </b><%=programmeName.replace('_', '-')%>&nbsp; &nbsp;<b>Batch: </b><%=batchYear%></center>
        <center> Current Semester Subject Marks </center>
        <br/>
        <table border="1" align="center">
            <col width="8%">
            <col width="22%">
            <col width="10%">
            <col width="10%">
            <col width="10%">
            <col width="10%">
            <col width="10%">
            <col width="10%">
            <col width="10%">
    
            <tr>
                <th>Subject ID</th>
                <th>Subject Name</th>
                <th>Minor1</th>
                <th>Minor2</th>
                <th>Minor3</th>
                <th>Internal Marks</th>
                <th>Major</th>
                <th>Total</th>
                <th>Grade</th>
            </tr> 

<%
        int m = 0;
                
        //ResultSetMetaData rsmd = rs.getMetaData();
        
        noOfColumns = rsmd.getColumnCount();
        int temp = (noOfColumns - 2) / 2; //need to mention number of columns in table
        i = 0;

        while (temp > 0) {
            m = i + 3;
            rs.next();
            String grade = rs.getString(m + 1);

            if (grade != null && (grade.equals("R") || grade.equals("RR") || grade.equals("A+") || grade.equals("A")
                    || grade.equals("B+") || grade.equals("B") || grade.equals("C") || grade.equals("D") || grade.equals("F"))) {

                String subCode = rs.getString(m); // subject code
                String subCodeAlias = subCode; // subject code
                String q1 = "select Alias from " + programmeName.replace('-', '_') + "_" + curriculumYear + "_curriculum where SubCode='"+subCode+"'";
                ResultSet rs1 = scis.executeQuery(q1);
                if(rs1 == null) {
                    out.print("<center><h2>Some internal problem occured.</h2></center>");
                    return;
                }
                while (rs1.next()) {
                    if (rs1.getString(1) != null) {
                        subCodeAlias = rs1.getString(1);
                    }
                }
                
                //Minor_1, Minor_2, Minor_3, InternalMarks, Major, TotalMarks, Final..................(7)
                String qry3 = "select Minor_1, Minor_2, Minor_3, InternalMarks, Major, TotalMarks, Final from " + subCodeAlias + "_Assessment_" + sem + "_" + cyear + " where StudentId='" + studentId + "'";
               try {
                    ResultSet rs3 = st.executeQuery(qry3);

                    if (rs3.next()) {
%>
                        <tr>
                            <td class="td"><%=subCode%></td>
                            <td class="td"><%=scis.subjectName(subCodeAlias) %></td>

<%
                            for(int j = 1; j < 7; j++) {
                                String marks = rs3.getString(j);
                                if (marks == null) {
%>            
                                    <td></td>
<%
                                } else {
%>
                                    <td><%=marks%></td>
<%
                                }
                            }
                            if(grade.equals("R") || grade.equals("RR")) {
%>            
                                <td></td>
<%
                            } else {
%>
                                <td><%=grade%></td>
<%
                            }
                    }
                    } catch(Exception e) {
                        cyear = cyear - 1;
                        rs.previous();
                            }
                }
                i = i + 2;
                temp--;
            }
%>
    </tr>

</table>
<br/><br/>

<div align="center">
    <input type="button" value="Print" id="p1" class="noPrint" onclick="window.print();" />
</div>

<%
    conn1.closeConnection();
    scis.close();
%>


</body>
</html>



<%
    String role = (String) session.getAttribute("role");
    String studentId = "";
    if (role.equalsIgnoreCase("student") == true) {
       studentId = (String) session.getAttribute("user"); // mc12mi28
        studentId = scis.getStudentId(studentId);
    } else {
       studentId = request.getParameter("studentId");
    }
        
        String programmeName = scis.studentProgramme(studentId).replace('_', '-');
        int batchYear = scis.studentBatchYear(studentId);
        String studentName = scis.studentName(studentId);
        int curriculumYear = scis.latestCurriculumYear(programmeName, batchYear);
        
        String masterTable = programmeName.replace('-', '_') + "_" + batchYear;
        String query = "select * from " + masterTable + " where StudentId = '" + studentId +"'";
        ResultSet rs = scis.executeQuery(query);
%>

        <center>University of Hyderabad</center>
        <center>Department of Computer and Information Sciences</center>
        <center>Assessment of the Student: <%=studentId%></center>
        <center><%=studentName%> &nbsp;&nbsp;<b>Stream: </b><%=programmeName.replace('_', '-')%>&nbsp; &nbsp;<b>Batch: </b><%=batchYear%></center>
        <center> Current Semester Subject Marks </center>
        <br/>
        
        <table border="1" align="center">
            <col width="8%">
            <col width="22%">
            <col width="10%">
            <col width="10%">
            <col width="10%">
            <col width="10%">
            <col width="10%">
            <col width="10%">
            <col width="10%">
            <tr>
                <th>Subject ID</th>
                <th>Subject Name</th>
                <th>Minor1</th>
                <th>Minor2</th>
                <th>Minor3</th>
                <th>Internal Marks</th>
                <th>Major</th>
                <th>Total</th>
                <th>Grade</th>
            </tr>
<% 
    Connection con1 = conn1.getConnectionObj();
    Statement st = con1.createStatement();
    
    ResultSetMetaData rsmd = rs.getMetaData();
    int tc = rsmd.getColumnCount() - 2;
    
    ResultSet sessions = scis.executeQuery("select name sem, substring(start, 1, 4) year from session where substring(start, 1, 4)>=" + batchYear  + " order by year");
    try {
        if(sessions != null) {
            sessions.next();
        }
        if(rs.next()) {
            for(int x = 2; x < tc; x += 2) {
                String subjectcode = rs.getString(x);
                ResultSet rs2 = scis.executeQuery("select Alias from " +programmeName+ "_" + curriculumYear +"_curriculum where SubCode=" + subjectcode + "and Alias is not NULL");
                if(rs2.next()) {
                    subjectcode = rs2.getString(0);
                }
                rs2 = scis.executeQuery("select Subject_Name from subjecttable where code=" + subjectcode);
                String subjectname = null;
                if(rs2.next()) {
                    subjectname = rs2.getString(0);
                }
                try {
                    ResultSet rs1 = st.executeQuery("select * from " + subjectcode + "_Assessment_" + sessions.getString(0) + "_" + sessions.getString(1) + "where StudentId=" + studentId);
                    out.println("<tr>");
                        out.println("<td>" + subjectcode + "</td>");
                        out.println("<td>" + subjectname + "</td>");
                        out.println("<td>" + rs1.getString("Minor_1") + "</td>");
                        out.println("<td>" + rs1.getString("Minor_2") + "</td>");
                        out.println("<td>" + rs1.getString("Minor_3") + "</td>");
                        out.println("<td>" + rs1.getString("InternalMarks") + "</td>");
                        out.println("<td>" + rs1.getString("Major") + "</td>");
                        out.println("<td>" + rs1.getString("TotalMarks") + "</td>");
                        out.println("<td>" + rs1.getString("Final") + "</td>");
                    out.println("<tr>");
                } catch(Exception e) {
                    sessions.next();
                    x -= 2;
                    continue;
                }
                
            }
        }
    } catch(Exception e) {
        e.printStackTrace();
    }
%>        