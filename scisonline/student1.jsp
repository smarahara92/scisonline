<%-- 
    Document   : student1
--%>

<%@include file="checkValidity.jsp"%>
<%@page import="java.sql.*"%>
<%@include file="programmeRetrieveBeans.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="table_css.css">
        <style type="text/css">
            @media print {
                .noPrint {
                    display:none;
                }
            }
        </style>
    </head>
    <body>
<%  
        String role = (String) session.getAttribute("role");

        String StudentId = "";

        if (role.equalsIgnoreCase("student") == true) {
            StudentId = (String) session.getAttribute("user"); // mc12mi28
            StudentId = scis.getStudentId(StudentId);
        } else {
            StudentId = request.getParameter("studentId");
        }

        int BatchYear = scis.studentBatchYear(StudentId);
     //   scis.close();
        String StreamName = scis.studentProgramme(StudentId);
      //  scis.close();
        int LatestYear = scis.latestCurriculumYear(StreamName, BatchYear);
      //  scis.close();

        String semester = "";

        String query = "select * from " + StreamName.replace('-', '_') + "_" + BatchYear + " where StudentId='"+StudentId+"'";
        ResultSet rs2 = scis.executeQuery(query);
        
        if(rs2 == null) {
            out.print("<center><h2>Data does not exists.</h2></center>");
            return;
        }

        if (!(rs2.next())) {
            out.print("<center><h2>Data does not exists.</h2></center>");
            return;
        }

            ResultSetMetaData rsmd = rs2.getMetaData();
            int noOfColumns = rsmd.getColumnCount();
        %>

        <center><b>University of Hyderabad</b></center>
        <center><b>School of Computer and Information Sciences</b></center>
        <center><b>Attendance of the Student: <%=StudentId%></b></center>
        <%
            String StreamName1 = StreamName.replace('_', '-');
        %>

        <center><b>Name of the Student : </b> <%=scis.studentName(StudentId)%> <b>&nbsp; Stream : </b><%=StreamName1%> <b> &nbsp;Batch :</b><%=BatchYear%></center>
        <%
       // scis.close();
        
        semester = scis.getLatestSemester();
      //  scis.close();
        int cyear = scis.getLatestYear();
      //  scis.close();

        String q = "select * from session  where name='"+semester+"' and start like '"+cyear+"%'";

        ResultSet rs30 = scis.executeQuery(q);
        String startdate = "";
        String enddate = "";
        if(rs30 == null) {
            out.print("<center><h2>Some internal problem occured.</h2></center>");
            return;
        }
        if (rs30.next()) {
            startdate = rs30.getDate(2).toString();
            enddate = rs30.getDate(3).toString();
        }
      //  scis.close();
        
        int sm = 0, em = 0, sd = 0, ed = 0;
        sm = Integer.parseInt(startdate.substring(5, 7));
        em = Integer.parseInt(enddate.substring(5, 7));

        sd = Integer.parseInt(startdate.substring(8));
        ed = Integer.parseInt(enddate.substring(8));

        boolean isLeapYear;
        isLeapYear = (cyear % 4 == 0);
        // divisible by 4 and not 100  
        isLeapYear = isLeapYear && (cyear % 100 != 0);
        // divisible by 4 and not 100 unless divisible by 400  
        isLeapYear = isLeapYear || (cyear % 400 == 0);
        String u = "28";
        if (isLeapYear == true) {
            u = "29";
        }
        String[] nameOfMonth = {"Jan", "Feb", "Mar", "Apr",
            "May", "Jun", "Jul", "Aug", "Sep", "Oct",
            "Nov", "Dec"};
        String[] nameOfMonth1 = {"Jan31", "Feb" + u, "Mar31", "Apr30",
            "May31", "Jun30", "Jul31", "Aug31", "Sep30", "Oct31",
            "Nov30", "Dec31"};
        String[] find = {"", "", "", "", "", "", "", "", "", "", "", ""};
        
        int m = sm - 1, z = 0;
        do {
            find[z++] = nameOfMonth[m] + sd + "-" + nameOfMonth1[m];
            ++m;
            m = m % 13;
            sd = 1;
        } while(em != m);
        find[z-1] = nameOfMonth[m-1] + sd + "-" + nameOfMonth[m-1]+ed;
       
        int columns = z;
        int p = 0;
    %>
    &nbsp;
    <table border="1" align="center" class="table">
        <tr class="th">
            <th class="th">Subject Name</th>  <%
                while (p < columns) {%>
                    <th class="th"><%=find[p]%></th>
                    <%p++;
                }%>
            <th class="th">Overall Percentage</th>
        </tr>
        <%
            int temp = (noOfColumns - 2) / 2; //need to mention number of columns in table
            int i = 0;
            while (temp > 0) {
                m = i + 3;
                String grade = rs2.getString(m + 1);
                if (grade != null && (grade.equals("R") || grade.equals("RR"))) {
                    String modified = rs2.getString(m); // subject code
                    String q1 = "select Alias from " + StreamName.replace('-', '_') + "_" + LatestYear + "_curriculum where SubCode='"+modified+"'";
                    ResultSet rs11 = scis.executeQuery(q1);
                    if(rs11 == null) {
                        out.print("<center><h2>Some internal problem occured.</h2></center>");
                        return;
                    }//*/
                    while (rs11.next()) {
                        if (rs11.getString(1) != null) {
                            modified = rs11.getString(1);
                        }
                    }
        %>
                    <tr>
            <%
                    String q2 = "select * from " + modified + "_Attendance_" + semester + "_" + cyear + " where StudentId='"+StudentId+"'";
                    ResultSet rs3 = scis.executeQuery(q2); %>
                    <td class="td"><%=scis.subjectName(modified)%></td><%
                //    scis.close();
                    if(rs3 != null) {
                        if (rs3.next()) {
                            p = 1;
                            while (p <= columns) { %>
                                <td class="td"><%=rs3.getInt(p + 2)%></td><%
                                p++;
                            }%>
                            <td class="td"><%=Math.round(rs3.getFloat(columns + 4))%></td><%
                        } else {
                            p = 1;
                            while (p <= columns) {%>
                                <td class="td"></td><%
                                p++;
                            }%>
                            <td class="td"></td><%
                        }
                    }
                }
                i = i + 2;
                temp--;
            }%>
            </tr><%        
            %>
    </table>
    &nbsp;
    <div align="center">
        <input type="button" value="Print" id="p1" class="noPrint" onclick="window.print();" />
    </div>
    <%
            scis.close();
    %>
</body>
</html>