
<%-- 
    Document   : recoursemodifylink
    Created on : Mar 26, 2013, 3:22:40 PM
    Author     : root
--%>
<%@include file="checkValidity.jsp"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.*"%>
<%@page import="java.lang.*"%>
<%@page import="java.text.SimpleDateFormat.*"%>
<%@page import="java.io.*"%>
<%@page import="java.text.ParseException.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.sql.*"%>
<%--<%@include file="dbconnection.jsp"%>--%>
<%@include file ="connectionBean.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style>
            .style30 {width:300px}
        </style>
        <script>


            function display1(temp, temp1)
            {
                //alert(temp1);
                var x = document.getElementById("selectb" + temp).value;
                //alert(x);
                var s = x.substring(0, 1);


                var i = 0, j = 0;
                for (i = 0; i < temp1 - 1; i++)
                {
                    var check1 = document.getElementById("selectb" + i).value;

                    for (j = i + 1; j < temp1; j++)
                    {
                        var check2 = document.getElementById("selectb" + j).value;
                        if (check1 != "" && check2 != "" && check1 == check2 && check1 != "none" && check2 != "none")
                        {
                            //alert(check1+" already selected");

                            alert("already subject seleted");
                            document.getElementById("selectb" + temp).value = "none";
                            break;

                        }
                    }
                }

            }
            function solve(temp, temp1)
            {
                //alert(temp1);
                if (temp1 == true)
                {
                    //alert(temp1);

                    document.getElementById("sid" + temp).disabled = false;
                    document.getElementById("oldsubject" + temp).disabled = false;

                    document.getElementById("selectb" + temp).disabled = false;
                    document.getElementById("s" + temp).disabled = false;

                    document.getElementById("s" + temp).value = document.getElementById("old" + temp).value;

                }
                else
                {
                    document.getElementById("selectb" + temp).value = "none";
                    document.getElementById("selectb" + temp).disabled = true;
                    document.getElementById("s" + temp).disabled = true;
                    document.getElementById("sid" + temp).disabled = true;
                    document.getElementById("oldsubject" + temp).disabled = true;
                    document.getElementById("s" + temp).value = "Offered in current sem"
                }
            }

            function find(temp)
            {
                var i = 0, j = 0;
                for (i = 0; i < temp; i++)
                {
                    var k = document.getElementById("check" + i).checked;
                    if (k == false)
                        j++;
                    else if (k == true)
                    {
                        if (document.getElementById("selectb" + i).value == "none")
                        {
                            alert("choose subject");
                            document.getElementById("selectb" + i).focus();
                            return false;
                        }
                    }
                }
                if (j == temp)
                {
                    alert("select atleast one subject");
                    return false;
                }
            }
        </script>
    </head>
    <body>
        <table align="center" border="1">
            <tr  bgcolor="#c2000d">
                <td align="center" class="style31"><font size="6">Re-Admission Registration</font></td>
            </tr>
        </table>
        </br>
        </br>
        <%
            //retrieving all this parameters from **readminnew1.jsp*** page

            String batchYear = request.getParameter("batchYear");

            String studentId = request.getParameter("studentId");
            String stream = request.getParameter("stream");
            stream = stream.replace('-', '_');


            String programmeName = request.getParameter("pgname");
            programmeName = programmeName.replace('-', '_');
            String count = request.getParameter("count");

            int nooffailedsubjects = Integer.parseInt(count);



        %>
        <form action="readminnew3.jsp" method="POST" name="form1" onsubmit="return find(<%=nooffailedsubjects%>);">
            <input type="hidden" name="studentId" value="<%=studentId%>">
            <input type="hidden" name="batchYear" value="<%=batchYear%>">
            <input type="hidden" name="stream" value="<%=stream%>">
            <input type="hidden" name="programmeName" value="<%=programmeName%>">
            <table align="center">


                <%
                    Calendar now = Calendar.getInstance();
                    System.out.println("Current date : " + (now.get(Calendar.MONTH) + 1)
                            + "-"
                            + now.get(Calendar.DATE)
                            + "-"
                            + now.get(Calendar.YEAR));
                    int month = now.get(Calendar.MONTH) + 1;
                    int cyear = now.get(Calendar.YEAR);
                    int year1 = cyear;
                    int byear = Integer.parseInt(batchYear);
                    int curriculumYear = 0;
                    int latestYear = 0;
                    int year = Integer.parseInt(batchYear);
                    int i = 0;
                    int find = 0;
                    Connection con = conn.getConnectionObj();
                    String semester = "";
                    String semester1 = "";

                    if (month <= 6) {
                        semester = "Winter";
                        semester1 = "Monsoon";
                        year1 = cyear - 1;
                    } else {
                        semester = "Monsoon";
                        semester1 = "Winter";
                    }

                    Statement st1 = con.createStatement();
                    Statement st2 = con.createStatement();
                    Statement st3 = con.createStatement();
                    Statement st4 = con.createStatement();
                    Statement st5 = con.createStatement();
                    Statement st6 = con.createStatement();
                    ResultSet rs1 = null;


                    //*****************************************************************

                %><input type="hidden" name="year" value="<%=year%>"><%



                    rs1 = st4.executeQuery("select a.Code,a.Subject_Name,b.pre_req_1,b.pre_req_grade1,b.pre_req_2,b.pre_req_grade2 from subjecttable as a," + cyear + "_" + semester + "_elective as b where b.course_name=a.Code  order by a.Subject_Name");


                    String mastertable = "";

                %>  <tr>

                    <th>Old Subject</th>
                    <th></th>
                    <th>New Subject</th>

                </tr><%



                    try{
                    mastertable = programmeName + "_" + batchYear;

                    // counting number of columns in master table. for checking all subjects grades

                    ResultSet rs = st1.executeQuery("select * from " + mastertable + " where StudentId='" + studentId + "'");
                    ResultSetMetaData rsmd = rs.getMetaData();
                    int noOfColumns = rsmd.getColumnCount();
                    int temp = (noOfColumns - 2) / 2;

                    int j = 0;
                    int count1 = 0;
                    while (rs.next()) {
                        count1++;// for checking student id exists.
                    }
                    rs.beforeFirst();

                    int k = 0;

                    // checking grades of all subjects for a student in student master table.

                    while (rs.next())
                        while (temp > 0 && count1 != 0) {
                            int m = j + 3;
                            String F = "F";

                            if (F.equals(rs.getString(m + 1)) == true) {
                                String subjid = rs.getString(m);

                                //latest curriculum

                                ResultSet rs122 = (ResultSet) st5.executeQuery("select * from " + programmeName + "_curriculumversions order by Year desc");
                                while (rs122.next()) {
                                    curriculumYear = rs122.getInt(1);
                                    if (curriculumYear <= byear) {

                                        latestYear = curriculumYear;

                                        break;
                                    }
                                }
                                ResultSet rs13 = st2.executeQuery("select * from " + programmeName + "_" + latestYear + "_curriculum where SubCode='" + subjid + "'");

                                //checking for wheather subject is elective or core.

                                String type = "E";
                                while (rs13.next()) {
                                    type = "C";
                                }

                                //checking for Alias for a subject.

                                ResultSet rs11 = st2.executeQuery("select Alias from " + programmeName + "_" + latestYear + "_curriculum  where SubCode='" + subjid + "'");
                                while (rs11.next()) {
                                    if (rs11.getString(1) != null) {
                                        subjid = rs11.getString(1);
                                    }
                                }

                                //checking for elective subject.

                                ResultSet rs20 = st6.executeQuery("select * from subject_faculty_" + semester + "_" + cyear + "");
                                ResultSet rs12 = st2.executeQuery("select * from subjecttable where Code='" + subjid + "'");
                                rs12.next();
                %>
                <tr>
                <input type="hidden" id="sid<%=k%>" disabled="true" name="sid" value="<%=studentId%>" readonly="readonly">
                <input type="hidden" disabled="true" name="byear" value="<%=batchYear%>" readonly="readonly">
                <td><input type="hidden" id="oldsubject<%=k%>" disabled="true" name="oldsubject" value="<%=type + rs.getString(m)%>" id="<%=k%>">
                    <input type="text" id="old<%=k%>"  class="style30" value="<%=rs12.getString(2)%>" readonly="" ></td>
                    <%

                        //**********************************************************
                        if (type.equals("C") == true) {
                            rs20.beforeFirst();
                            int q = 0;
                            while (rs20.next()) {
                                if (rs20.getString(1).equals(rs12.getString(1))) {
                                    q = 1;
                                    break;
                                }
                            }
                            if (q == 1) {
                    %><td><input type="checkbox" name="check" id="check<%=k%>" onclick="solve(<%=k%>, this.checked)"></td><%
                    } else {
                    %><td><input type="checkbox" name="check" id="check<%=k%>" disabled="true" onclick="solve(<%=k%>, this.checked)"></td><%
                        }
                    } else {
                        System.out.println(":::::::::::::::::::::" + rs.getString(m));
                    %><td><input type="checkbox" name="check" id="check<%=k%>" onclick="solve(<%=k%>, this.checked)"></td><%
                        }

                        //**********************************************************
%>

                <td>
                    <%if (type.equals("C") != true) {%>
                    <select name="newsubject" class="style30"   disabled="true" id="selectb<%=k%>"onchange="display1(<%=k%>,<%=nooffailedsubjects%>);"> 
                        <% } else {%> 
                        <select name="newsubject"  class="style30" style="display:none"  disabled="true" id="selectb<%=k%>"onchange="display1(<%=k%>,<%=nooffailedsubjects%>);">      
                            <% }
                                if (type.equals("C") == true) {
                                    rs20.beforeFirst();
                                    int q = 0;
                                    while (rs20.next()) {
                                        if (rs20.getString(1).equals(rs12.getString(1))) {
                                            q = 1;
                                            break;
                                        }
                                    }
                                    if (q == 1) {
                            %><input type="text"  id="s<%=k%>"class="style30"  disabled="true" value="Offered in current sem" readonly="">
                            <input type="hidden" name="newsubject" value="<%=type + rs.getString(m)%>"><%
                            } else {
                            %><input type="text"  name="newsubject" class="style30" disabled="true" value="Not Offered in current sem" readonly="">

                            <%                              }
                            } else {

                            %><option value="none">none</option><%                           }
                            %>

                            <%
                                rs1.beforeFirst();
                                while (rs1.next() && type.equals("C") != true) {
                                    //***********************************************************************************
                                    // System.out.println(rs1.getString(3)+"   "+rs1.getString(4));
                                    ResultSet rs3 = st3.executeQuery("select * from " + mastertable + " where StudentId='" + studentId + "'");
                                    ResultSetMetaData rsmd1 = rs3.getMetaData();
                                    int noOfColumns1 = rsmd1.getColumnCount();
                                    int temp1 = (noOfColumns1 - 2) / 2;

                                    if (rs1.getString(3).equals("none") != true || rs1.getString(5).equals("none") != true) {
                                        int flag1 = 0, flag2 = 0;
                                        rs3.next();
                                        if (rs1.getString(3).equals("none") != true) {

                                            int r = 0;
                                            int temp2 = temp1;
                                            int t = r + 3;
                                            while (temp2 > 0) {

                                                // System.out.println(rs3.getString(t));
                                                if (rs1.getString(3).equals(rs3.getString(t))) {

                                                    if (rs1.getString(4).equals("")) {
                                                        flag1 = 1;
                                                    } else if (rs1.getString(4).equals(rs3.getString(t + 1))) {
                                                        flag1 = 1;
                                                    } else {
                                                        flag1 = 0;
                                                    }
                                                }
                                                t = t + 2;
                                                temp2--;
                                            }
                                        } else {
                                            flag1 = 1;
                                        }

                                        rs3.beforeFirst();
                                        rs3.next();
                                        if (rs1.getString(5).equals("none") != true) {
                                            int r = 0;
                                            int temp2 = temp1;
                                            int t = r + 3;
                                            while (temp2 > 0) {
                                                //  System.out.println(rs3.getString(t));
                                                if (rs1.getString(5).equals(rs3.getString(t))) {
                                                    //  System.out.println("m");
                                                    if (rs1.getString(6).equals("")) {
                                                        flag2 = 1;
                                                    } else if (rs1.getString(6).equals(rs3.getString(t + 1))) {
                                                        flag2 = 1;
                                                    } else {
                                                        flag2 = 0;
                                                    }
                                                }
                                                t = t + 2;
                                                temp2--;
                                            }
                                        } else {
                                            flag2 = 1;
                                        }

                                        if (flag1 == 1 && flag2 == 1) {
                                            //********************already pass*****************************
                                            ResultSet rs5 = st5.executeQuery("select * from " + mastertable + " where StudentId='" + studentId + "'");
                                            ResultSetMetaData rsmd2 = rs5.getMetaData();
                                            int noOfColumns2 = rsmd2.getColumnCount();
                                            int tempvar = (noOfColumns2 - 2) / 2;
                                            rs5.next();
                                            int flag3 = 0;
                                            int d = 3;
                                            while (tempvar > 0) {
                                                if (rs1.getString(1).equals(rs5.getString(d))) {
                                                    if ("F".equals(rs5.getString(d + 1)) || "NR".equals(rs5.getString(d + 1))) {
                                                        flag3 = 0;
                                                        break;
                                                    } else {
                                                        flag3 = 1;
                                                        break;
                                                    }
                                                }
                                                d = d + 2;
                                                tempvar--;
                                            }
                                            if (flag3 == 0) {
                            %><option value="<%=rs1.getString(1)%>"><%=rs1.getString(2)%></option><%
                                    }
                                }
                            } else {
                                //********************already pass*****************************
                                ResultSet rs5 = st5.executeQuery("select * from " + mastertable + " where StudentId='" + studentId + "'");
                                ResultSetMetaData rsmd2 = rs5.getMetaData();
                                int noOfColumns2 = rsmd2.getColumnCount();
                                int tempvar = (noOfColumns2 - 2) / 2;
                                rs5.next();
                                int flag3 = 0;
                                int d = 3;
                                while (tempvar > 0) {
                                    if (rs1.getString(1).equals(rs5.getString(d))) {
                                        if ("F".equals(rs5.getString(d + 1)) || "NR".equals(rs5.getString(d + 1))) {
                                            flag3 = 0;
                                            break;
                                        } else {
                                            flag3 = 1;
                                            break;
                                        }
                                    }
                                    d = d + 2;
                                    tempvar--;
                                }
                                if (flag3 == 0) {
                            %><option value="<%=rs1.getString(1)%>"><%=rs1.getString(2)%></option><%
                                    }
                                }
                                //***********************************************************************************
%>


                            <%}%>
                        </select>

                </td>
                </tr>
                <%
                                k++;
                            }
                            temp--;
                            j = j + 2;
                        }
                }catch(Exception e){
                     e.printStackTrace();
                 }finally{
                               
                                conn.closeConnection();
                                conn1.closeConnection();
                                con = null ;
                                
                            }
                   

                %>



                <tr ><td colspan="3" align="center"><input type="submit" name="submit" value="submit"></td></tr>
                        <%
                            find++;

                        %>

            </table>
        </form>
    </body>
</html>
