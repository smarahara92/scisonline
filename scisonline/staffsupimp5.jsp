<%-- 
    Document   : staffsupimp5
    Created on : Apr 22, 2014, 3:06:21 PM
    Author     : veeru
--%>

<%@page import ="java.sql.*" %>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%--<%@include file="dbconnection.jsp" %>--%>
<%@include file="connectionBean.jsp" %>
<%@include file="id_parser.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="table_css1.css">
        <script>
            function fun() {
                var subjectCount = document.getElementById("subc").value;

                document.getElementById("stun2").value = subjectCount;
            }

        </script>
    </head>
    <body onload="fun();">
                  
        <%   
               Connection con = conn.getConnectionObj();
             try {
                Calendar now = Calendar.getInstance();
                int currentMonth = now.get(Calendar.MONTH) + 1;
                int currentYear = now.get(Calendar.YEAR);
                String semester = null;
                if (currentMonth <= 6) {
                    semester = "Winter";
                } else {
                    semester = "Monsoon";
                }
                String studentId = request.getParameter("studentId");
                String PROGRAMME_NAME = studentId.substring(SPRGM_PREFIX, EPRGM_PREFIX);
                String BATCH_YEAR = studentId.substring(SYEAR_PREFIX, EYEAR_PREFIX);

                Statement st = con.createStatement();
                Statement st1 = con.createStatement();
                Statement st4 = con.createStatement();
                Statement st5 = con.createStatement();

                int flag = 0, flag1 = 0;

                String year = "20" + BATCH_YEAR;
                String programmeName = null;
                String batchYear = null;

                ResultSet rs = null;
                ResultSet rs1 = null;
                ResultSet rs5 = null;
                ResultSet rs6 = null;

                try {

                    rs = st.executeQuery("select Programme_name from programme_table where Programme_code='" + PROGRAMME_NAME + "'");
                    rs.next();
                    programmeName = rs.getString(1).replace('-', '_');

                } catch (Exception e) {
                    out.println("Invalid studentId");
                    return;
                }

                try {
                    String studentName = null;
                    for (int i = 0; i < 2; i++) {
                        String table = programmeName + "_" + year;
                        System.out.println(table);

                        rs1 = st1.executeQuery("select StudentName from " + table + " where StudentId='" + studentId + "'");
                        if (rs1.next()) {
                            batchYear = year;
                            studentName = rs1.getString(1);
                            System.out.println(studentName);
                            break;
                        }
                        year = Integer.toString(Integer.parseInt(year) + 1);
                    }


        %>
        <table align="center">
            <th>Student ID</th>
            <th>Student Name</th>
            <th>Total Subjects</th>
            <tr>
                <td><input type="text" value="<%=studentId%>">&nbsp;&nbsp;</td>
                <td><input type="text" value="<%=studentName%>" name="studentName1" id="stun1">&nbsp;&nbsp;</td>
                <td><input type="text" value="" name="studentName1" id="stun2">&nbsp;&nbsp;</td></tr>
        </table>     <br>
        <table align="center" border="1" class="table">

            <th class="th">Subject Id</th>
            <th class="th">Subject Name</th>
            <th class="th">Supplementary/Improvement</th>


            <%

                } catch (Exception e) {
                    out.println("Student Id does not exists.");
                    return;

                }
                if (batchYear == null) {
                    out.println("Student Id does not exists.");
                    return;
                }
                //suplementary students....

                rs5 = st4.executeQuery("select * from supp_" + semester + "_" + currentYear + " where studentId='" + studentId + "'");
                if (rs5.next()) {

                    int colNum = 2;
                    int colNum1 = 3;
                    int colNum2 = 4;
                    for (int k = 0; k < 7; k++) {
                        if (rs5.getString(colNum) != null) {
            %>
            <tr>
                <td class="td"><%=rs5.getString(colNum)%></td>
                <%
                    rs6 = st5.executeQuery("select Subject_Name from subjecttable where Code='" + rs5.getString(colNum) + "'");
                    if (rs6.next()) {
                        flag++;
                        flag1++;
                %>
                <td class="td"><%=rs6.getString(1)%></td>
                <%
                } else {
                %>
                <td class="td"></td>
                <%
                    }

                %>
                <td>S</td>
            </tr>
            <%                        }
                        colNum = colNum + 3;
                        colNum1 = colNum1 + 3;
                        colNum2 = colNum2 + 3;
                    }
                }

                rs5 = st4.executeQuery("select * from imp_" + semester + "_" + currentYear + " where studentId='" + studentId + "'");
                if (rs5.next()) {

                    int colNum = 2;
                    int colNum1 = 3;
                    int colNum2 = 4;
                    for (int k = 0; k < 6; k++) {
                        if (rs5.getString(colNum) != null) {
            %>
            <tr>
                <td class="td"><%=rs5.getString(colNum)%></td>
                <%
                    rs6 = st5.executeQuery("select Subject_Name from subjecttable where Code='" + rs5.getString(colNum) + "'");
                    if (rs6.next()) {
                        flag++;
                        flag1++;
                %>
                <td class="td"><%=rs6.getString(1)%></td>
                <%
                } else {
                %>
                <td class="td"></td>
                <%
                    }

                %>
                <td>I</td>
            </tr>
            <%                        }
                        colNum = colNum + 3;
                        colNum1 = colNum1 + 3;
                        colNum2 = colNum2 + 3;
                    }
                }
                if (flag1 == 0) {
            %>
            <script>


                window.open("Project_exceptions.jsp?check=4", "act_area");
            </script>    
            <%
                    return;
                }

            %>
        </table>
        <input type="hidden" id="subc" value="<%=flag%>">
        <%
                if (flag == 0) {
                    out.println("<h3>No supplemenatry subjects found for this student.</h3>");
                }
            } catch (Exception e) {
                 e.printStackTrace();
            }finally{
                 conn.closeConnection();
                 con = null;
             }
        %>
    </body>
</html>
