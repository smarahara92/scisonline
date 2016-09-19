<%-- 
    Document   : improvementview4
    Created on : Apr 5, 2014, 6:48:27 PM
    Author     : veeru
--%>
<%@include file="checkValidity.jsp"%>

<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@include file="connectionBean.jsp" %>
<%@page import = "java.sql.* " %>
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
            Connection con1 = conn1.getConnectionObj();
        try{
        
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
            Statement st2 = con.createStatement();
            Statement st3 = con.createStatement();
            Statement st4 = con.createStatement();
            Statement st5 = con.createStatement();
            Statement st6 = con1.createStatement();
            int curriculumYear = 0;
            int latestYear = 0;
            int semCount = 0;
            int sem = 0;
            int programmeDuration = 0;
            String year = "20" + BATCH_YEAR;
            String programmeName = null;
            String batchYear = null;
            ResultSet rs = null;
            ResultSet rs1 = null;
            ResultSet rs2 = null;
            ResultSet rs3 = null;
            ResultSet rs4 = null;
            ResultSet rs5 = null;
            ResultSet rs6 = null;
            ResultSet rs7 = null;
            String[] semm = {"I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX", "X", "XI", "XII", "XIII", "XIV", "XV", "XVI", "XVII", "XVIII", "XIX", "XX"};

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
            <th>Total Improvement Subjects</th>
            <tr>
                <td><input type="text" value="<%=studentId%>">&nbsp;&nbsp;</td>
                <td><input type="text" value="<%=studentName%>" name="studentName1" id="stun1">&nbsp;&nbsp;</td>
                <td><input type="text" value="" name="studentName1" id="stun2">&nbsp;&nbsp;</td></tr>
        </table>     <br>
        <table align="center" border="1" class="table">
            <caption><h2>Improvement Subjects</h2></caption>
            <th class="th">Subject Id</th>
            <th class="th">Subject Name</th>
            <th class="th">Previous Marks</th>
            <th class="th">Current Marks</th>
            <th class="th">Current Grade</th>
            <th class="th">Semester</th>


            <%

                } catch (Exception e) {
                    out.println("Student Id does not exists.");
                    return;

                }
                if (batchYear == null) {
                    out.println("Student Id does not exists.");
                    return;
                }
                rs3 = st2.executeQuery("select * from " + programmeName + "_curriculumversions order by Year desc");

                while (rs3.next()) {
                    curriculumYear = rs3.getInt(1);
                    if (curriculumYear <= Integer.parseInt(year)) {

                        latestYear = curriculumYear;//latest curriculum year*********
                        System.out.println(latestYear);
                        break;
                    }
                }

                //******************************************************************************
                //programme duration
                rs4 = st3.executeQuery("select count(*) from " + programmeName + "_" + latestYear + "_currrefer");
                if (rs4.next()) {
                    semCount = rs4.getInt(1);
                    programmeDuration = semCount / 2;

                }
                //find out current semester for student Id

                int subValue = currentYear - Integer.parseInt(batchYear);
                System.out.println(programmeDuration);
                if (subValue < programmeDuration) {
                    if (semester.equalsIgnoreCase("Winter")) {
                        if (subValue == 1) {
                            sem = 2;
                        } else if (subValue == 2) {
                            sem = 4;
                        } else if (subValue == 3) {
                            sem = 6;
                        } else if (subValue == 4) {
                            sem = 8;
                        } else if (subValue == 5) {
                            sem = 10;
                        } else if (subValue == 6) {
                            sem = 12;
                        } else if (subValue == 7) {
                            sem = 14;
                        } else if (subValue == 8) {
                            sem = 16;
                        }
                    } else if (semester.equalsIgnoreCase("Monsoon")) {
                        if (subValue == 0) {
                            sem = 1;
                        } else if (subValue == 1) {
                            sem = 3;
                        } else if (subValue == 2) {
                            sem = 5;
                        } else if (subValue == 3) {
                            sem = 7;
                        } else if (subValue == 4) {
                            sem = 9;
                        } else if (subValue == 5) {
                            sem = 11;
                        } else if (subValue == 6) {
                            sem = 13;
                        } else if (subValue == 7) {
                            sem = 15;
                        }
                    }
                } else {
                    sem = semCount;
                }
                System.out.println(sem);
                int j = 0;
                int sem1 = sem;
                int batchYear1 = Integer.parseInt(batchYear);
                System.out.println(batchYear);

                String semester1 = null;

                int flag = 0;
                for (j = 0; j < sem1; j++) {

                    if (j == 0) {
                        try {
                            rs5 = st4.executeQuery("select * from imp_Monsoon_" + batchYear1 + " where studentId='" + studentId + "'");
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
                %>
                <td class="td"><%=rs6.getString(1)%></td>
                <%
                } else {
                %>
                <td class="td"></td>
                <%
                    }
                    rs7 = st6.executeQuery("select TotalMarks from " + rs5.getString(colNum) + "_Assessment_Monsoon_" + batchYear1 + " where StudentId='" + studentId + "'");

                    if (rs7.next()) {
                %>
                <td class="td"><%=rs7.getString(1)%></td>
                <%
                } else {
                %>
                <td class="td"></td>
                <%
                    }%>

                <td class="td"><%=rs5.getString(colNum1)%></td>
                <td class="td"><%=rs5.getString(colNum2)%></td>
                <td class="td"><%=semm[j]%></td>
            </tr>
            <%
                                colNum = colNum + 3;
                                colNum1 = colNum1 + 3;
                                colNum2 = colNum2 + 3;
                            }
                        }
                    }
                } catch (Exception e) {
                }
                batchYear1 = batchYear1 + 1;
                semester1 = "Winter";
            } else if (semester1.equalsIgnoreCase("Winter")) {
                try {
                    System.out.println(".........." + batchYear1);
                    rs5 = st4.executeQuery("select * from imp_Winter_" + batchYear1 + " where studentId='" + studentId + "'");
                    if (rs5.next()) {

                        int colNum = 2;
                        int colNum1 = 3;
                        int colNum2 = 4;
                        for (int k = 0; k < 6; k++) {
                            if (rs5.getString(colNum) != null) {
                                System.out.println("======");
            %>
            <tr>
                <td class="td"><%=rs5.getString(colNum)%></td>
                <%
                    rs6 = st5.executeQuery("select Subject_Name from subjecttable where Code='" + rs5.getString(colNum) + "'");
                    if (rs6.next()) {
                        flag++;
                %>
                <td class="td"><%=rs6.getString(1)%></td>
                <%
                } else {
                %>
                <td class="td"></td>
                <%
                    }
                    try {
                        int flag1 = 0, batchYear2 = batchYear1;
                        String semester2 = "Winter";
                        for (int l = 0; l < j; l++) {
                            if (semester2.equalsIgnoreCase("Winter")) {
                                try {
                                    rs7 = st6.executeQuery("select TotalMarks from " + rs5.getString(colNum) + "_Assessment_Winter_" + batchYear2 + " where StudentId='" + studentId + "'");
                                } catch (Exception e) {
                                }
                                if (rs7.next()) {
                                    flag1++;
                                    break;
                                }
                                batchYear2 = batchYear2 - 1;
                                semester2 = "Monsoon";
                            } else {
                                try {
                                    rs7 = st6.executeQuery("select TotalMarks from " + rs5.getString(colNum) + "_Assessment_Monsoon_" + batchYear2 + " where StudentId='" + studentId + "'");
                                } catch (Exception e) {
                                }
                                if (rs7.next()) {
                                    flag1++;
                                    break;
                                }
                                semester2 = "Winter";
                            }
                        }
                        rs7.beforeFirst();
                        if (rs7.next()) {
                            flag1++;
                %>
                <td class="td"><%=rs7.getString(1)%></td>
                <%
                } else {
                %>
                <td class="td"></td>
                <%
                        }
                    } catch (Exception e) {
                    }
                %>

                <td class="td"><%=rs5.getString(colNum1)%></td>
                <td class="td"><%=rs5.getString(colNum2)%></td>
                <td class="td"><%=semm[j]%></td>
            </tr>
            <%
                                colNum = colNum + 3;
                                colNum1 = colNum1 + 3;
                                colNum2 = colNum2 + 3;
                            }
                        }
                    }
                } catch (Exception e) {
                }
            } else if (semester1.equalsIgnoreCase("Monsoon")) {
                try {

                    rs5 = st4.executeQuery("select * from imp_Winter_" + batchYear1 + " where studentId='" + studentId + "'");
                    if (rs5.next()) {
                        System.out.println("\\\\\\");
                        flag++;
                        int colNum = 2;
                        int colNum1 = 3;
                        int colNum2 = 4;
                        for (int k = 0; k < 6; k++) {
                            if (rs5.getString(colNum) != null) {
                                System.out.println("======");
            %>
            <tr>
                <td class="td"><%=rs5.getString(colNum)%></td>
                <%
                    rs6 = st5.executeQuery("select Subject_Name from subjecttable where Code='" + rs5.getString(colNum) + "'");
                    if (rs6.next()) {
                        flag++;
                %>
                <td class="td"><%=rs6.getString(1)%></td>
                <%
                } else {
                %>
                <td class="td"></td>
                <%
                    }

                    try {
                        int flag1 = 0, batchYear2 = batchYear1;
                        String semester2 = "Winter";
                        for (int l = 0; l < j; l++) {
                            if (semester2.equalsIgnoreCase("Winter")) {
                                try {
                                    rs7 = st6.executeQuery("select TotalMarks from " + rs5.getString(colNum) + "_Assessment_Winter_" + batchYear2 + " where StudentId='" + studentId + "'");
                                } catch (Exception e) {
                                }
                                if (rs7.next()) {
                                    flag1++;
                                    break;
                                }
                                batchYear2 = batchYear2 - 1;
                                semester2 = "Monsoon";
                            } else {
                                try {
                                    rs7 = st6.executeQuery("select TotalMarks from " + rs5.getString(colNum) + "_Assessment_Monsoon_" + batchYear2 + " where StudentId='" + studentId + "'");
                                } catch (Exception e) {
                                }
                                if (rs7.next()) {
                                    flag1++;
                                    break;
                                }
                                semester2 = "Winter";
                            }
                        }
                        rs7.beforeFirst();
                        if (rs7.next()) {
                            flag1++;
                %>
                <td class="td"><%=rs7.getString(1)%></td>
                <%
                } else {
                %>
                <td class="td"></td>
                <%
                        }
                    } catch (Exception e) {
                    }
                    if (rs7.next()) {
                %>
                <td class="td"><%=rs7.getString(1)%></td>
                <%
                } else {
                %>
                <td class="td"></td>
                <%
                    }%>

                <td class="td"><%=rs5.getString(colNum1)%></td>
                <td class="td"><%=rs5.getString(colNum2)%></td>
                <td class="td"><%=semm[j]%></td>
            </tr>
            <%
                            colNum = colNum + 3;
                            colNum1 = colNum1 + 3;
                            colNum2 = colNum2 + 3;
                        }
                    }
                }
                rs5 = st4.executeQuery("select * from imp_Monsoon_" + batchYear1 + " where studentId='" + studentId + "'");
                if (rs5.next()) {
                    flag++;
                    int colNum = 2;
                    int colNum1 = 3;
                    int colNum2 = 4;
                    for (int k = 0; k < 6; k++) {
                        if (rs5.getString(colNum) != null) {
            %>
            <tr>
                <td class="td"><%=rs.getString(colNum)%></td>
                <%
                    rs6 = st5.executeQuery("select Subject_Name from subjecttable where Code='" + rs.getString(colNum) + "'");
                    if (rs6.next()) {
                        flag++;
                %>
                <td class="td"><%=rs6.getString(1)%></td>
                <%
                } else {
                %>
                <td class="td"></td>
                <%
                    }
                    int Year2 = batchYear1 - 1;
                    System.out.println(Year2 + rs5.getString(colNum));
                    try {
                        int flag1 = 0, batchYear2 = batchYear1;
                        String semester2 = "Winter";
                        for (int l = 0; l < j; l++) {
                            if (semester2.equalsIgnoreCase("Winter")) {
                                try {
                                    rs7 = st6.executeQuery("select TotalMarks from " + rs5.getString(colNum) + "_Assessment_Winter_" + batchYear2 + " where StudentId='" + studentId + "'");
                                } catch (Exception e) {
                                }
                                if (rs7.next()) {
                                    flag1++;
                                    break;
                                }
                                batchYear2 = batchYear2 - 1;
                                semester2 = "Monsoon";
                            } else {
                                try {
                                    rs7 = st6.executeQuery("select TotalMarks from " + rs5.getString(colNum) + "_Assessment_Monsoon_" + batchYear2 + " where StudentId='" + studentId + "'");
                                } catch (Exception e) {
                                }
                                if (rs7.next()) {
                                    flag1++;
                                    break;
                                }
                                semester2 = "Winter";
                            }
                        }
                        rs7.beforeFirst();
                        if (rs7.next()) {
                            flag1++;
                %>
                <td class="td"><%=rs7.getString(1)%></td>
                <%
                } else {
                %>
                <td class="td"></td>
                <%
                        }
                    } catch (Exception e) {
                    }
                    if (rs7.next()) {
                %>
                <td class="td"><%=rs7.getString(1)%></td>
                <%
                } else {
                %>
                <td class="td"></td>
                <%
                    }%>

                <td class="td"><%=rs5.getString(colNum1)%></td>
                <td class="td"><%=rs5.getString(colNum2)%></td>
                <td class="td"><%=semm[j]%></td>
            </tr>
            <%
                                        colNum = colNum + 3;
                                        colNum1 = colNum1 + 3;
                                        colNum2 = colNum2 + 3;
                                    }
                                }
                            }
                        } catch (Exception e) {
                        }
                        batchYear1 = batchYear1 + 1;
                        semester1 = "Winter";
                    }

                }
            %>
        </table>
        <input type="hidden" id="subc" value="<%=flag%>">
        <%
            if (flag == 0) {
                out.println("<h3>No supplemenatry subjects found for this student.</h3>");
            }
            
        }catch (Exception e) {
                out.println(e);
            } finally{
              conn.closeConnection();
              con = null;
        }
        %>
    </body>
</html>
