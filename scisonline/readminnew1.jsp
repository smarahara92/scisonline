<%-- 
    Document   : readmin
    Created on : Mar 14, 2012, 9:58:10 AM
    Author     : admin
--%>

<%@include file="checkValidity.jsp"%>
<%@page import="com.hcu.mysql.connection.ConnectionDemo"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%--<%@ include file="dbconnection.jsp" %>--%>
<%@ include file="connectionBean.jsp" %>
<%@page import="java.util.Calendar"%>
<%@page import="java.sql.*"%>
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
            function checked1(q)
            {
                var id = q.id;

                var stream = document.getElementById("id" + id).value;
                var pname = document.getElementById("id" + id);
                var pname2 = pname.name;
                var studentId = document.getElementById("idd" + id).value;
                var batchYear = q.value;
                var count = document.getElementById("idd" + id);
                var count1 = count.name;


                window.document.forms["frm"].action = "readminnew2.jsp?batchYear=" + batchYear + "&studentId=" + studentId + "&stream=" + stream + "&pgname=" + pname2 + "&count=" + count1;

                document.frm.submit();



            }


        </script>
    </head>
    <body bgcolor="#CCFFFF">
        <form name="frm" id="frm"  method="POST"  target="facultyaction" >
            <b> List of students: </b> </br><br>

            <%
             Connection con = conn.getConnectionObj();
                Connection con1 = conn1.getConnectionObj();
               try{
                Calendar now = Calendar.getInstance();

                int month = now.get(Calendar.MONTH) + 1;
                int cyear = now.get(Calendar.YEAR);

                int year = cyear;
                int year1 = cyear;

                String semester = "";
                String sem = "", year3 = "", syear = "";

                Statement st1 = con.createStatement();
                Statement st2 = con.createStatement();
                Statement st3 = con.createStatement();
                Statement st4 = con.createStatement();
                Statement st5 = con.createStatement();
                Statement st6 = con.createStatement();
                Statement st7 = con.createStatement();

                int studentsem = 0;
                int studentsem1 = 0;


                if (month <= 6) {
                    semester = "Winter";
                    year = year - 1;
                    year1 = cyear - 1;
                    studentsem1 = 2;

                } else {
                    semester = "Monsoon";

                    studentsem1 = 1;
                }

                int curriculumYear = 0;
                int latestYear = 0;
                int streamYear = 0;
                int semcount1 = 0;

                ResultSet rs11 = null;
                ResultSet rs = null;
                String selectstream = null;
                String stream = null;
                int k = 0;

                rs = st2.executeQuery("select Programme_name, Programme_group from programme_table where (Programme_status='1' and not Programme_name ='PhD')");

                while (rs.next()) {

                    selectstream = rs.getString(1).replace('-', '_');
                    stream = rs.getString(2).replace('-', '_');

                    //curriculum for programme.
                    int start = cyear;
                    int flag = 1;
                    ResultSet rs12 = (ResultSet) st5.executeQuery("select * from " + selectstream + "_curriculumversions order by Year desc");
                    while (rs12.next()) {
                        curriculumYear = rs12.getInt(1);
                        if (curriculumYear <= year&& flag!=0) {

                            latestYear = curriculumYear;

                            flag=0;
                        }
                        start = curriculumYear;
                    }

                    //getting batch year for project student
                    rs11 = (ResultSet) st6.executeQuery("select count(*) from " + selectstream + "_" + latestYear + "_currrefer");
                    rs11.next();
                    int rowsCount = rs11.getInt(1);
                    rowsCount = rowsCount / 2;// programme duration


                    int rowsCount1 = rowsCount - 1;
                    streamYear = year - rowsCount1;//batch year

                    //*************************************************************
                    int j = 0, semcount = 0, l = 0;
                    studentsem = studentsem1;
                    year1 = year;
                    // System.out.println(rowsCount+"------"+selectstream);
                    while (j < rowsCount && start <= year1) {
                        ResultSet rs1 = null;

                        rs1 = st1.executeQuery("select * from " + selectstream + "_" + year1 + "");

                        if (l > 0) {
                            if (semester.equals("Moonson")) {

                                studentsem = studentsem + 2;



                            } else {

                                studentsem = studentsem + 2;



                            }
                        }
                        studentsem = studentsem - 1;

                        if (studentsem == 1||studentsem == 0) {
                            sem = "I";
                        } else if (studentsem == 2) {
                            sem = "II";
                        } else if (studentsem == 3) {
                            sem = "III";
                        } else if (studentsem == 4) {
                            sem = "IV";
                        } else if (studentsem == 5) {
                            sem = "V";
                        } else if (studentsem == 6) {
                            sem = "VI";
                        } else if (studentsem == 7) {
                            sem = "VII";
                        } else if (studentsem == 8) {
                            sem = "VIII";
                        } else if (studentsem == 9) {
                            sem = "IX";
                        } else if (studentsem == 10) {
                            sem = "X";
                        } else if (studentsem == 11) {
                            sem = "XI";
                        } else if (studentsem == 12) {
                            sem = "XII";
                        } else if (studentsem == 13) {
                            sem = "XIII";
                        } else if (studentsem == 14) {
                            sem = "XIV";
                        } else if (studentsem == 15) {
                            sem = "XV";
                        } else if (studentsem == 16) {
                            sem = "XVI";
                        }

                        //To know latest curriculum for particular batch of programme.
                        ResultSet rs13 = (ResultSet) st7.executeQuery("select * from " + selectstream + "_curriculumversions order by Year desc");
                        while (rs13.next()) {
                            curriculumYear = rs13.getInt(1);
                            if (curriculumYear <= year1) {

                                latestYear = curriculumYear;

                                break;
                            }
                        }

                        semcount1 = studentsem;

                        int totalsubjectsinsem = 0;
                        ResultSet rs15 = st4.executeQuery("select * from " + selectstream + "_" + latestYear + "_currrefer where Semester='" + sem + "'");

                        while (rs15.next()) {
                            System.out.println("Hello");
                            totalsubjectsinsem = totalsubjectsinsem + (rs15.getInt(2) + rs15.getInt(3) + rs15.getInt(4));
                            totalsubjectsinsem = (totalsubjectsinsem / 2);

                        }

                        System.out.println(totalsubjectsinsem);

                        while (rs1.next()) {
                            ResultSetMetaData rsmd = rs1.getMetaData();
                            int noOfColumns = rsmd.getColumnCount();
                            int temp = (noOfColumns - 2) / 2;
                            int i = 0;
                            int count = 0, count1 = temp;
                            String failedsubjects[] = new String[30];
                            int fail = 0;


                            while (count1 > 0) {


                                int m = i + 3;
                                String F = "F";
                                if (F.equals(rs1.getString(m + 1))) {

                                    failedsubjects[fail] = rs1.getString(m);
                                    fail++;
                                    count++;


                                }
                                i = i + 2;
                                count1--;
                            }
                            System.out.println(rs1.getString(1)+" "+count+" "+totalsubjectsinsem);
                            if (count > totalsubjectsinsem && count != 0) {
            %>
            <input type="radio" name="h" id="<%=k%>"  value="<%=year1%>" onClick="checked1(this);"><b><%=rs1.getString(1)%></b></br>
            <input type="hidden" id="id<%=k%>" name="<%=selectstream%>" value="<%=stream%>">
            <input type="hidden" id="idd<%=k%>" name="<%=count%>"  value="<%=rs1.getString(1)%>">

            <% k++;
                            }
                        }
                        l++;
                        rowsCount--;
                        year1--;
                    }

                }
               }catch( Exception e)
                            {
                                
                            }finally{
                                conn.closeConnection();
                                conn1.closeConnection();
                                con = null ;
                                con1 = null;
                            }


                //*************************************************************************************************************
%>
            </table>
            </br>
            </br>
            <input type="Submit" style="display:none;" value="Go" onclick="">

        </form>
    </body>
</html>
