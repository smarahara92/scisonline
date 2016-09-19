<%-- 
    Document   : readmin
    Created on : Mar 14, 2012, 9:58:10 AM
    Author     : admin
--%>
<%@include file="checkValidity.jsp"%>
<%@page import="com.hcu.mysql.connection.ConnectionDemo"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="dbconnection.jsp" %>
<%@page import="java.util.Calendar"%>
<!DOCTYPE html>
<html>
    <head>

        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style>
            .style30{width:150px;color:#000000}
            .style31 {color: white}
        </style>
        <script>
            function check1(temp, x)
            {

                if (x == true)
                {
                    temp = temp.trim();
                    var s = temp.substring(0, 8);
                    var year = temp.substring(8);
                    var year1 = "20" + temp.substring(0, 2);
                    year = year.trim();
                    year1 = year1.trim();
                    if (year1 == year)
                    {
                        return true;
                    }
                    else
                    {
                        alert("Student with ID " + s + " is already a recourse student in " + year + " Batch");
                        return false;
                    }
                }

            }


        </script>
    </head>
    <body bgcolor="#CCFFFF">
        <form name="frm" action="readminlink.jsp"  onsubmit="">
            <center>
                <table align="center" border="1">
                    <tr  bgcolor="#c2000d">
                        <td align="center" class="style31"><font size="6">Re-admin Registration</font></td>
                    </tr>
                </table>
                </br>
                </br>
                <%
                    Calendar now = Calendar.getInstance();
                    System.out.println("Current date : " + (now.get(Calendar.MONTH) + 1)
                            + "-"
                            + now.get(Calendar.DATE)
                            + "-"
                            + now.get(Calendar.YEAR));
                    int month = now.get(Calendar.MONTH) + 1;
                    int cyear = now.get(Calendar.YEAR);
                    String semester = "";
                    String year1 = "", year2 = "", year3 = "", syear = "";
                    Statement st1 = con.createStatement();
                    Statement st2 = con.createStatement();
                    Statement st3 = con.createStatement();
                    Statement st4 = con.createStatement();
                    int totalsubjectsinsem = 0;
                    if (month <= 6) {
                        semester = "Winter";
                    } else {
                        semester = "Monsoon";
                    }

                    if (semester.equals("Moonson")) {
                        year1 = Integer.toString(cyear);
                        year2 = Integer.toString(cyear - 1);
                        year3 = Integer.toString(cyear - 2);
                    } else {
                        year1 = Integer.toString(cyear - 1);
                        year2 = Integer.toString(cyear - 2);
                        year3 = Integer.toString(cyear - 3);
                    }
                %><table border="2" cellspaceing="" style="color:blue;background-color:#CCFFFF;" align="center">
                    <tr>
                        <th>Select</th>
                        <th>Student ID</th>
                        <th colspan="10">Failed Subjects<th>
                    </tr><%
                        int j = 0;
                        int studentsem = 0;
                        while (j < 3) {

                            ResultSet rs1 = null;
                            if (j == 0) {
                                rs1 = st1.executeQuery("select * from MCA_" + year1 + "");
                                if (semester.equals("Moonson")) {
                                    studentsem = 2;
                                } else {
                                    studentsem = 2;
                                }
                                syear = year1;
                            } else if (j == 1) {
                                rs1 = st1.executeQuery("select * from MCA_" + year2 + "");
                                if (semester.equals("Moonson")) {
                                    studentsem = 3;
                                } else {
                                    studentsem = 4;
                                }
                                syear = year2;
                            } else if (j == 2) {
                                rs1 = st1.executeQuery("select * from MCA_" + year3 + "");
                                if (semester.equals("Moonson")) {
                                    studentsem = 5;
                                } else {
                                    studentsem = 6;
                                }
                                syear = year3;
                            }
                            ResultSet rs15 = st4.executeQuery("select * from MCA_currrefer where Semester='sem" + (studentsem - 1) + "'");
                            while (rs15.next()) {
                                totalsubjectsinsem = rs15.getInt(2) + rs15.getInt(3) + rs15.getInt(4) + rs15.getInt(5);
                                System.out.println(totalsubjectsinsem);
                                totalsubjectsinsem = (totalsubjectsinsem / 2);
                                System.out.println(totalsubjectsinsem);
                            }
                            while (rs1.next()) {
                                ResultSetMetaData rsmd = rs1.getMetaData();
                                int noOfColumns = rsmd.getColumnCount();
                                int temp = (noOfColumns - 2) / 2;
                                int i = 0;
                                int count = 0;
                                String failedsubjects[] = new String[30];
                                int fail = 0;
                                while (temp > 0) {
                                    int m = i + 3;
                                    String F = "F";
                                    if (F.equals(rs1.getString(m + 1))) {
                                        failedsubjects[fail] = rs1.getString(m);
                                        fail++;
                                        count++;
                                    }
                                    i = i + 2;
                                    temp--;
                                }
                                if (count > totalsubjectsinsem && count != 0) {
                    %><input type="hidden" name="studentid" value="<%=rs1.getString(1) + syear%>">
                    <tr>
                        <td><center><input type="checkbox" name="status1" value="<%=rs1.getString(1) + syear%>" onClick="return check1('<%=rs1.getString(1) + syear%>', this.checked)"></center></td>
                    <td><input type="text" class="style30"  readonly value="<%=rs1.getString(1)%>"></td>
                        <%

                            for (fail = 0; fail < failedsubjects.length; fail++) {
                                if (failedsubjects[fail] != null) {
                                    ResultSet rs11 = st3.executeQuery("select Alias from MCA_curriculum where subjId='" + failedsubjects[fail] + "'");
                                    String subjectname = "";
                                    while (rs11.next()) {
                                        if (rs11.getString(1) != null) {
                                            failedsubjects[fail] = rs11.getString(1);
                                        }
                                    }
                                    ResultSet rs12 = st2.executeQuery("select * from subjecttable where Code='" + failedsubjects[fail] + "'");
                                    rs12.next();
                                    subjectname = rs12.getString(2);
                        %><td><center><%=subjectname%></center></td><%
                                }
                            }

                        %>
                    </tr>
                    <%}
                            }
                            j++;
                        }




                        //*************************************************************************************************************
                        int k = 0;
                        String stream = "";
                        while (k < 3) {
                            if (k == 0) {
                                stream = "MTech_CS";
                            } else if (k == 1) {
                                stream = "MTech_AI";
                            } else if (k == 2) {
                                stream = "MTech_IT";
                            }
                            j = 0;
                            while (j < 2) {

                                ResultSet rs1 = null;
                                if (j == 0) {
                                    rs1 = st1.executeQuery("select * from " + stream + "_" + year1 + "");
                                    if (semester.equals("Moonson")) {
                                        studentsem = 2;
                                    } else {
                                        studentsem = 2;
                                    }
                                    syear = year1;
                                } else if (j == 1) {
                                    rs1 = st1.executeQuery("select * from " + stream + "_" + year2 + "");
                                    if (semester.equals("Moonson")) {
                                        studentsem = 3;
                                    } else {
                                        studentsem = 3;
                                    }
                                    syear = year2;
                                }
                                ResultSet rs15 = st4.executeQuery("select * from " + stream + "_currrefer where Semester='sem" + (studentsem - 1) + "'");
                                while (rs15.next()) {
                                    totalsubjectsinsem = rs15.getInt(2) + rs15.getInt(3) + rs15.getInt(4) + rs15.getInt(5);
                                    System.out.println(totalsubjectsinsem);
                                    totalsubjectsinsem = (totalsubjectsinsem / 2);
                                    System.out.println(stream + "   " + totalsubjectsinsem);
                                }
                                while (rs1.next()) {
                                    ResultSetMetaData rsmd = rs1.getMetaData();
                                    int noOfColumns = rsmd.getColumnCount();
                                    int temp = (noOfColumns - 2) / 2;
                                    int i = 0;
                                    int count = 0;
                                    String failedsubjects[] = new String[30];
                                    int fail = 0;
                                    while (temp > 0) {
                                        int m = i + 3;
                                        String F = "F";
                                        if (F.equals(rs1.getString(m + 1))) {
                                            failedsubjects[fail] = rs1.getString(m);
                                            fail++;
                                            count++;
                                        }
                                        i = i + 2;
                                        temp--;
                                    }
                                    if (count > totalsubjectsinsem && count != 0) {
                    %><input type="hidden" name="studentid" value="<%=rs1.getString(1) + syear%>">
                    <tr>
                        <td><center><input type="checkbox" name="status1" value="<%=rs1.getString(1) + syear%>" onClick="return check1('<%=rs1.getString(1) + syear%>', this.checked)"></center></td>
                    <td><input type="text" class="style30"  readonly value="<%=rs1.getString(1)%>"></td>
                        <%

                            for (fail = 0; fail < failedsubjects.length; fail++) {
                                if (failedsubjects[fail] != null) {
                                    ResultSet rs11 = st3.executeQuery("select Alias from " + stream + "_curriculum where subjId='" + failedsubjects[fail] + "'");
                                    String subjectname = "";
                                    while (rs11.next()) {
                                        if (rs11.getString(1) != null) {
                                            failedsubjects[fail] = rs11.getString(1);
                                        }
                                    }
                                    ResultSet rs12 = st2.executeQuery("select * from subjecttable where Code='" + failedsubjects[fail] + "'");
                                    rs12.next();
                                    subjectname = rs12.getString(2);
                        %><td><center><%=subjectname%></center></td><%
                                }
                            }

                        %>
                    </tr>
                    <%}
                                }
                                j++;
                            }


                            k++;
                        }


                        //*************************************************************************************************************
                    %>
                </table>
                </br>
                </br>
                <input type="submit" name="submit" value="submit">
            </center>
        </form>
    </body>
</html>
