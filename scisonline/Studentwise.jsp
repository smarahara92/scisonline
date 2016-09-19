<%-- 
    Document   : Studentwise
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.ResultSetMetaData"%>
<%@include file="checkValidity.jsp"%>
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
        String role = (String) session.getAttribute("role");
        String studentId = "";
        if (role.equalsIgnoreCase("student") == true) {
            studentId = (String) session.getAttribute("user"); // mc12mi28
            studentId = scis.getStudentId(studentId);
        } else {
            studentId = request.getParameter("studentId");
        }
        
        String programmeName = scis.studentProgramme(studentId).replace('_', '-');
        String programmeGroup = scis.getStreamOfProgramme(programmeName);
        int batchYear = scis.studentBatchYear(studentId);
        String studentName = scis.studentName(studentId);
        int curriculumYear = scis.latestCurriculumYear(programmeName, batchYear);

        String masterTable = programmeName.replace('-', '_') + "_" + batchYear;
        String query = "select * from " + masterTable + " where StudentId = '" + studentId +"'";
        ResultSet rs = scis.executeQuery(query);
        if(rs == null) {
            out.print("<center><h2>Data does not exists.</h2></center>");
            return;
        }
        if( !(rs.next()) ) {
            out.print("<center><h2>Data does not exists.</h2></center>");
            return;
        }
%>
        <center><b>University of Hyderabad</b></center>
        <center><b>School of Computer and Information Sciences</b></center>
        <center><b>Assessment of the Student:<%=studentId%></b></center>
        <center><b>Name of the Student : </b> <%=studentName%> <b>&nbsp; Stream : </b><%=programmeName%> <b> &nbsp;Batch :</b><%=batchYear%></center>
        
        <br/><br/>  

        <table border="1" align="center" class="table" width="70%"> 
            <th class="th">Subject Name</th> 
            <th class="th">Subject ID</th>
            <th class="th">Grade</th>
<%
            ResultSetMetaData rsmd = rs.getMetaData();
            int noOfColumns = rsmd.getColumnCount();
            int m = 0;
            float cgpa = 0;
            int totalcredits = 0;

            int temp = (noOfColumns - 2) / 2; //need to mention number of columns in table
            int i = 0;
            while (temp > 0) {
                m = i + 3;
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
                    }//*/
                    while (rs1.next()) {
                        if (rs1.getString(1) != null) {
                            subCodeAlias = rs1.getString(1);
                        }
                    }
%>
                    <tr>
                        <td class="td"><%=scis.subjectName(subCodeAlias)%></td>
                        <td class="td"><%=subCode%></td>
<%
                    if (grade == null || grade.equals("R")) {%>
                    <td class="td"></td>
<%
                    } else {
                        if(grade.equals("RR")) {
                            grade = "F";
                        }
%>
                        <td class="td"><%=grade%></td></tr>
<%
                        ResultSet rs2 = scis.subjectDetail(subCodeAlias);
                        int credits = 0;
                        if(rs2.next()) {
                            credits = rs2.getInt("credits");
                        }
                        
                        int w = 0;
                        if (grade.equals("A+")) {
                            w = 10;
                        } else if (grade.equals("A")) {
                            w = 9;
                        } else if (grade.equals("B+")) {
                            w = 8;
                        } else if (grade.equals("B")) {
                            w = 7;
                        } else if (grade.equals("C")) {
                            w = 6;
                        } else if (grade.equals("D")) {
                            w = 5;
                        } else {
                            w = 0;
                        }
                        w = w * credits;
                        cgpa = cgpa + w;
                        totalcredits = totalcredits + credits;
                    }
                }
                i = i + 2;
                --temp;
            }
%>
            <tr>
                <td class="td"><center>CGPA</center></td>
<%
                if (cgpa == 0) {
%>
                    <td colspan="2" class="td"><center>0.0</center></td>
<%
                } else {
%>
        <!--td colspan="2" class="td"><center><!%=Math.round((cgpa * 100 / totalcredits))/100.0%><center></td-->
        <td colspan="2" class="td"><center><%=String.format("%.2f", cgpa / totalcredits)%><center></td>
<%
                }
%>
            </tr>
        </table>
        <br/><br/>
        <div align="center">
            <input type="button" value="Print" id="p1" class="noPrint" onclick="window.print();" />
        </div>
    </body>
</html>
