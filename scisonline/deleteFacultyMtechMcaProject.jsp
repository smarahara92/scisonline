<%-- 
    Document   : deleteFacultyMtechMcaProject
    Created on : 2 Apr, 2013, 5:24:37 PM
    Author     : varun
--%>

<%@include file="checkValidity.jsp"%>
<%@include file="programmeRetrieveBeans.jsp"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.Collection"%>
<%@page import="java.util.*"%>
<%@page import="com.hcu.mysql.connection.ConnectionDemo1"%>

<%@include file="dbconnection.jsp"%>
<%@include file="id_parser.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.hcu.mysql.connection.ConnectionDemo1"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script type="text/javascript">

            function validate()      // Checking if all checkBoxes are ticked or not..
            {
                var hmapSize = document.getElementById("rc").value;
                var i;

                for (i = 0; i < hmapSize; i++)
                {
                    var a = document.getElementById(i).checked;
                    var sup1 = document.getElementById("sup1" + i).value;
                    var sup2 = document.getElementById("sup2" + i).value;
                    var sup3 = document.getElementById("sup3" + i).value;
                    var flag = 0;
                    if (sup1 !== "")
                    {
                        flag++;
                    }
                    if (sup2 !== "")
                    {
                        flag++;
                    }
                    if (sup3 !== "")
                    {
                        flag++;
                    }

                    if (a == false && (flag == 1 || flag == 0))
                    {
                        alert("Some Project Students are not reassigned");
                        return false;
                    }
                }
                return true;
            }

            function link1(a, b, p, s, py, c, id)
            {

                if (c == true) {
                    window.open("deleteFacultyMtechMcaProject1.jsp?studentid=" + a + "&batchYear=" + b + "&pgname=" + p + "&sname=" + s + "&pyear=" + py, "_blank", "directories=no, status=no, menubar=no, scrollbars=yes, resizable=no,width=900, height=240,top=230,left=300");
                }

            }

            function CallFunction() {
                GetFeed();
                setInterval("GetFeed()", 1000);
            }
            function GetFeed() {

                var j;
                var hmapSize = document.getElementById("rc").value;


                for (j = 0; j < hmapSize; j++) {
                    var studid = document.getElementById("sid" + j).value;

                    GetFeed1(studid, j);

                }
            }
            function GetFeed1(id, j) {


                var xmlhttp;
                if (window.XMLHttpRequest)
                {// code for IE7+, Firefox, Chrome, Opera, Safari
                    xmlhttp = new XMLHttpRequest();
                }
                else
                {// code for IE6, IE5   xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
                    xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
                }
                xmlhttp.onreadystatechange = function()
                {
                    if (xmlhttp.readyState === 4 && xmlhttp.status === 200)
                    {

                        var x = xmlhttp.responseText;



                        if (x == 1) {
                            if (document.getElementById(j).disabled == false) {
                                document.getElementById(j).checked = true;
                            }

                        } else if (x == 2) {
                            if (document.getElementById(j).disabled == false) {
                                document.getElementById(j).checked = false;
                            }
                        }
                    }
                };

                xmlhttp.open("GET", "ajax.jsp?stuId=" + id + "&choice=1", true);
                xmlhttp.send();

            }

        </script>	

        <link rel="stylesheet" type="text/css" href="table_css.css">
        <style>
            <%--body {color:white}--%>
            .style11 {color :red}
            .style12 {color :white}
            .style13 {color :yellow}
        </style>
    </head>
    <body bgcolor="#E0FFFF" onload="CallFunction();">
        <form  id="form" method="POST"  action="deleteFacultyPhDProject.jsp" onSubmit="return validate();">
            <table align="center" border="1">
                <caption><h2 style=" color: darkred">Reassign Project Students</h2></caption>
                <th></th>
                <th>Student Id</th>
                <th>Student Name</th>
                <th>Project Title</th>
                <th>Supervisor1</th>
                <th>Supervisor2</th>
                <th>Supervisor3</th>

                <%                    PreparedStatement pst = null;
                    try {

                        Calendar now = Calendar.getInstance();
                        int year = now.get(Calendar.YEAR);
                        int year1 = year;
                        int month = now.get(Calendar.MONTH);
                        String semester = "";
                        int rb = 0;
                        if (month <= 6) {
                            semester = "Winter";
                            year = year - 1;
                            year1 = year1 - 1;
                        } else {
                            semester = "Monsoon";
                        }

                        String oldfaculty = (String) session.getAttribute("oldfaculty");

                        HashMap<String, String> hmap = (HashMap) session.getAttribute("hashmap");

                        //************************************************
                        ResultSet rss = null;
                        ResultSet rss1 = null;
                        ResultSet rss2 = null;
                        ResultSet rss3 = null;

                        try {
                     rss = scis.getStream("PhD");//get all stream except phd.

                        } catch (Exception e) {
                            System.out.println(e);

                        }
                        int rowcount = 0, flag1 = 0, flag2 = 0;
                        while (rss.next()) {
                            String projectMasterTable = rss.getString(1).replace('-', '_') + "_project_" + year1;
                            try {
                                pst = con.prepareStatement("select * from  " + projectMasterTable + " where Allocated=? and( SupervisorId1=? OR SupervisorId2=?)");
                                pst.setString(1, "yes");
                                pst.setString(2, oldfaculty);
                                pst.setString(3, oldfaculty);
                                rss1 = (ResultSet) pst.executeQuery();
                                flag1++;
                            } catch (Exception ex) {
                                // continue;
                            }
                            while (rss1.next()) {
//                                pst = con.prepareStatement("select Programme_name from  programme_table where not Programme_group=? and Programme_group=? and Programme_status=?");
//                                pst.setString(1, "PhD");
//                                pst.setString(2, rss.getString(1));
//                                pst.setString(3, "1");
//                                rss2 = (ResultSet) pst.executeQuery();
                                rss2 = scis.getProgramme(rss.getString(1), 1);
                                while (rss2.next()) {
                                    String projectStudentTable = rss2.getString(1).replace('-', '_') + "_Project_Student_" + year1;
                                    System.out.println(projectStudentTable + ";;;;;;;;;;;;;;");
                                    try {
                                        pst = con.prepareStatement("select * from " + projectStudentTable + " where ProjectId=?");
                                        pst.setString(1, rss1.getString(1));

                                        rss3 = (ResultSet) pst.executeQuery();
                                        flag2++;
                                    } catch (Exception ex) {
                                        // continue;

                                    }

                                    while (rss3.next()) {
                                        rowcount++;

                                        int projectId = 0;
                                        String code = "";                 // Respective Branch Project Student Data Table  
                                        String table = "";
                                        String masterProjectTable = "";   // Master table of Projects
                                        String studId = rss3.getString(1);

                                        code = projectStudentTable;
                                        masterProjectTable = projectMasterTable;

//                                        for (int j = 0; j < 2; j++) {
//                                            int flag = 0;
//
//                                            table = rss2.getString(1).replace('-', '_') + "_" + year3;
//                                            ResultSet rs4 = null;
//                                            try {
//                                                pst = con.prepareStatement("select StudentName from " + table + " where StudentId=?");
//                                                pst.setString(1, studId);
//                                                rs4 = (ResultSet) pst.executeQuery();
//
//                                                while (rs4.next()) {
//
//                                                    Name = rs4.getString(1);
//                                                    batchYear = year3;
//                                                    flag++;
//                                                    break;
//                                                }
//                                            } catch (Exception e) {
//                                            }
//                                            if (flag > 0) {
//                                                break;
//                                            }
//
//                                            year3 = year3 + 1;
//                                        }
                                        String Name = scis.studentName(studId);
                                        int batchYear = scis.studentBatchYear(studId);
                %>
                <tr>
                    <%
                        //--------------Fetching Project Id corressponding to a Student-----------
                        pst = con.prepareStatement("select ProjectId from " + code + " where StudentId=?");
                        pst.setString(1, studId);
                        ResultSet rs5 = (ResultSet) pst.executeQuery();

                        while (rs5.next()) {

                            projectId = Integer.parseInt(rs5.getString(1));
                        }

                        try {
                            //---------------Fetching Data from Project Master Table based on Project Id-----------
                            pst = con.prepareStatement("select * from " + masterProjectTable + " where ProjectId=?");
                            pst.setInt(1, projectId);
                            ResultSet rs6 = (ResultSet) pst.executeQuery();
                            rs6.next();
                  // --------------------			

                            // If case true then disabling the checkbox indicating that Co-Supervisors are present..
                            if (((rs6.getString(3) != null && !rs6.getString(3).equalsIgnoreCase("none")) && (rs6.getString(4) != null && !rs6.getString(4).equalsIgnoreCase("none"))) && ((rs6.getString(4) != null && !rs6.getString(4).equalsIgnoreCase("none")) && (rs6.getString(5) != null && !rs6.getString(5).equalsIgnoreCase("none"))) && ((rs6.getString(3) != null && !rs6.getString(3).equalsIgnoreCase("none")) && (rs6.getString(5) != null && !rs6.getString(5).equalsIgnoreCase("none")))) {
                                if (rs6.getString(6).equals("uoh")) {
                    %>
                    <td><input type="checkbox" id="<%=rb%>" name="rb" value="" disabled="true" checked="true"></td>

                    <%} else if (!rs6.getString(6).equals("uoh")) {%>
                    <td><input type="checkbox" id="<%=rb%>" name="rb" value="" onchange="link1('<%=rss3.getString(1)%>', '<%=batchYear%>', '<%=rss2.getString(1)%>', '<%=rss.getString(1)%>', '<%=year1%>', this.checked, this.id)"></td>

                    <%}
                    } else // No Disabling the checkbox indicating only Single Supervisor is present..
                    {%>
                    <td><input type="checkbox" id="<%=rb%>" name="rb" value="" onchange="link1('<%=rss3.getString(1)%>', '<%=batchYear%>', '<%=rss2.getString(1)%>', '<%=rss.getString(1)%>', '<%=year1%>', this.checked, this.id)"></td>

                    <%}
                    %>
                    <td><input type="text" value="<%=rss3.getString(1)%>" readonly id="sid<%=rb%>" name="pid" size="5" onclick="f(this.id);"></td>
                    <td><input type="text" value="<%=Name%>" readonly id="sidd" name="sname" size="15" ></td>
                    <td><input type="text" value="<%=rss1.getString(2)%>"  readonly id="pid" name="pname" size="25"></td>

                    <%if (rss1.getString(3) != null && rss1.getString(3).equalsIgnoreCase("none") == false) {
                            pst = con.prepareStatement("select Faculty_Name from  faculty_data where ID=?");
                            pst.setString(1, rss1.getString(3));
                            ResultSet rss5 = (ResultSet) pst.executeQuery();

                            if (rss5.next()) {
                    %>  
                    <td><input type="text" value="<%=rss5.getString(1)%>"  readonly id="sup1<%=rb%>" name="sup1" size="8"></td>
                        <%}
                        } else {%>
                    <td><input type="text" value=""  readonly id="sup1<%=rb%>" name="sup1" size="8"></td>
                        <%}

                            if (rss1.getString(4) != null && rss1.getString(4).equalsIgnoreCase("none") == false) {
                                System.out.println(rss1.getString(4));
                                pst = con.prepareStatement("select Faculty_Name from  faculty_data where ID=?");
                                pst.setString(1, rss1.getString(4));
                                ResultSet rss6 = (ResultSet) pst.executeQuery();
                                if (rss6.next()) {
                        %>
                    <td><input type="text" value="<%=rss6.getString(1)%>"  readonly id="sup2<%=rb%>" name="sup2" size="8"></td> 
                        <%}
                        } else {%>
                    <td><input type="text" value=""  readonly id="sup2<%=rb%>" name="sup2" size="8"></td>
                        <%}

                            if (rss1.getString(5) != null && rss1.getString(3) != null && rss1.getString(5).equalsIgnoreCase("none") == false) {
                                pst = con.prepareStatement("select Faculty_Name from  faculty_data where ID=?");
                                pst.setString(1, rss1.getString(5));
                                ResultSet rss7 = (ResultSet) pst.executeQuery();
                                if (rss7.next()) {
                        %>
                    <td><input type="text" value="<%=rss7.getString(1)%>"  readonly id="sup3<%=rb%>" name="sup3" size="8"></td>
                        <%}
                        } else {%>
                    <td><input type="text" value=""  readonly id="sup3<%=rb%>" name="sup3" size="8"></td>
                        <%}%>
                </tr>
                <%rb++;
                                    } catch (Exception ex) {
                                        System.out.println(ex);
                                    }
                                }
                            }
                        }

                    }

                    if (rowcount == 0 || flag1 == 0) {
                        pst = con.prepareStatement("select Faculty_Name from  faculty_data where ID=?");
                        pst.setString(1, oldfaculty);
                        ResultSet rsss7 = (ResultSet) pst.executeQuery();
                        if (rsss7.next()) {

                        }
                    }

                %>

                <script>
                    function onload1() {
                        document.getElementById("xx1").focus();
                    }

                    function Cancelto() {
                        window.open("deleteFaculty.jsp", "subdatabase");//here check =6 means error number (if condition number.)
                    }
                </script> 

                <input type="hidden" value="<%=rowcount%>" id="rc" name="rowcount">

            </table> <br>
            <div align="center"> <input type="button" id="xx1" value="Cancel" onclick="Cancelto();">&nbsp;&nbsp;&nbsp;&nbsp;

                <input type="submit" id ="xx" value="Continue" > </div>
        </form>
        <%
            } catch (Exception ex) {
                System.out.println(ex);
            } finally {
                if (con != null && pst != null) {
                    pst.close();
                    con.close();
                }
            }
        %>
    </body>
</html>
