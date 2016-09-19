<%-- 
    Document   : recoursenew3
    Created on : Apr 6, 2013, 6:05:19 PM
    Author     : root
--%>
<%@include file="checkValidity.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.Calendar"%>
<%@ include file="dbconnection.jsp" %>
<%@page import="javax.sound.midi.SysexMessage"%>
<%@page import ="javax.sql.*" %>
<%@page import="java.sql.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style>
            .style30{width:150px;color:#000000}
            .style31 {color: white}
        </style>
        <script language="javascript">
            function display1(a)
            {
                var selectlist = document.getElementById("mySelect1");
                var selectedText = selectlist.options[selectlist.selectedIndex].text;

                var selectvalue = document.getElementById("mySelect1").value;
                var count = selectlist.options[selectlist.selectedIndex].id;
                if (selectedText !== "none") {
                    window.document.forms["form1"].action = "recoursenew4.jsp?batchYear=" + selectvalue + "&studentId=" + selectedText + "&failedcount=" + count;
                    document.form1.submit();
                }else{
                    window.document.forms["form1"].action = "BalankPage2.jsp";
                    document.form1.submit();
                }

            }
        </script>
    </head>

    <body>
        <form name="form1" target="facultyaction1" method="POST">
            <table align="center" border="1">
                <tr  bgcolor="#c2000d">
                    <td align="center" class="style31"><font size="6">Re-course Registration</font></td>
                </tr>
            </table>
            </br>
            </br>

            <%

                Calendar now = Calendar.getInstance();

                int month = now.get(Calendar.MONTH) + 1;
                int cyear = now.get(Calendar.YEAR);
                int year = cyear;
                int year1 = cyear;
                int semcount1 = 0;
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
                int totalsubjectsinsem = 0;
                if (month <= 6) {
                    semester = "Winter";
                    year = year - 1;
                    year1 = cyear - 1;
                    studentsem = 2;

                } else {
                    semester = "Monsoon";
                    year = cyear;
                    studentsem = 1;
                }
                int curriculumYear = 0;
                int latestYear = 0;
                int streamYear = 0;
                ResultSet rs11 = null;

                String selectstream = request.getParameter("selectstream");
                selectstream = selectstream.replace('-', '_');




            %>
            <input type="hidden" name="streamto" value="<%=selectstream%>">
            <center><b>Select Student ID</b>&nbsp&nbsp&nbsp<select align="center" valign="bottom" style="width:175px" name="studentid" id="mySelect1" onchange="display1(this)"> 

                    <option value="none1234591235">none</option><%

                        
                    
                         int start = cyear;
                         int flag = 1;
                        //curriculum for programme.
                        ResultSet rs12 = (ResultSet) st5.executeQuery("select * from " + selectstream + "_curriculumversions order by Year desc");
                        while (rs12.next()) {
                            curriculumYear = rs12.getInt(1);
                            if (curriculumYear <= year && flag!=0) {

                                latestYear = curriculumYear;

                            flag=0;
                             }  
                        start = curriculumYear;
                        }

                        //******************************************************************************

                        //getting batch year for project student
                        
                        rs11 = (ResultSet) st6.executeQuery("select count(*) from " + selectstream + "_" + latestYear + "_currrefer");
                        rs11.next();
                        int rowsCount = rs11.getInt(1);
                        rowsCount = rowsCount / 2;// programme duration


                        int rowsCount1 = rowsCount - 1;
                        streamYear = year - rowsCount1;//batch year

                        //*************************************************************
                        int j = 0, l = 0;
                       
                        
                        while (j < rowsCount && start <=year1) {
                        //      if (month <= 6) {
                        //          studentsem = 2;
                        //      }
                        //      else
                        //      {
                        //          studentsem = 1;
                        //      }
                        //     l = cyear-year1;
                            System.out.println(cyear+" "+year1+" "+l);
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
                            System.out.println(studentsem + " hg");
                            if (studentsem == 1 || studentsem == 0) {
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
                            System.out.println(sem+" jkdas ");
                            //To know latest curriculum for particular batch of programme.
                            ResultSet rs13 = (ResultSet) st7.executeQuery("select * from " + selectstream + "_curriculumversions order by Year desc");
                            while (rs12.next()) {
                                curriculumYear = rs13.getInt(1);
                                if (curriculumYear <= year1) {

                                    latestYear = curriculumYear;

                                    break;
                                }
                            }

                            semcount1 = studentsem;

                            totalsubjectsinsem = 0;
                          //   System.out.println(totalsubjectsinsem+" iahg "+sem);
                           ResultSet rs15 = st4.executeQuery("select * from " + selectstream + "_" + latestYear + "_currrefer where Semester='" + sem + "'");
                              
                            while (rs15.next()) {
                                totalsubjectsinsem = totalsubjectsinsem + (rs15.getInt(2) + rs15.getInt(3) + rs15.getInt(4));
                                totalsubjectsinsem = (totalsubjectsinsem / 2);
                                System.out.println(totalsubjectsinsem);
                            }


                            while (rs1.next()) {
                                
                                ResultSetMetaData rsmd = rs1.getMetaData();
                                int noOfColumns = rsmd.getColumnCount();
                                int temp = (noOfColumns - 2) / 2;
                                int i = 0;
                                int count = 0;

                                while (temp > 0) {
                                    int m = i + 3;
                                    String F = "F";
                                    if (F.equals(rs1.getString(m + 1))) {
                                        count++;
                                    }
                                    i = i + 2;
                                    temp--;
                                }
                               //  System.out.println(rs1.getString(1)+" habh "+count+" "+totalsubjectsinsem);
                                if (count != 0) {
                               // System.out.println(rs1.getString(1)+" habh "+count);
                    %>  <option value="<%=year1%>" id="<%=count%>"><%=rs1.getString(1)%></option>
                    <%}
                            }
                            j++;
                            l++;
                            year1--;
                        }
                    %></select><%

                    %>

                <input type="Submit" value="Go" style="display:none;" onclick="">
                </form>
                </body>
                </html>
