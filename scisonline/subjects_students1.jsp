<%-- 
    Document   : subjects_students
    Created on : Jan 8, 2013, 2:46:23 PM
    Author     : root
--%>
<%@page import="java.io.OutputStream"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.File"%>
<%@page import="com.hcu.mysql.connection.ConnectionDemo3"%>
<%@page import="com.hcu.mysql.connection.ConnectionDemo1"%>
<%@page import="com.hcu.mysql.connection.ConnectionDemo"%>
<%@page import="java.sql.*"%>
<%@page import="com.mysql.jdbc.Statement"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%--<%@include file="dbconnection.jsp" %> --%>
<%@include file="connectionBean.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script>
            function fun1() {
                if (document.getElementById("mySelect1").value === "Select Subject")
                {
                    document.getElementById("errfn").innerHTML = "*Select subject name.";
                    window.document.forms["form1"].action = "BalankPage2.jsp";
                    document.forms.form1.submit();

                } else {
                    document.getElementById("errfn").innerHTML = "";
                    window.document.forms["form1"].action = "subjects_students2.jsp";
                    document.forms.form1.submit();
                }
            }


        </script>
        <style type="text/css">
            .style30 {color: black}
            .style31 {color: white}
            .style32 {color: green}
            .caption{
                font-weight: bold;
            }

            .heading
            {
                color: white;
                background-color: #c2000d;
            }
            .heading1
            {
                color: white;
                background-color:#003399;
            }
            .td1
            {
                border-collapse:collapse;
                border: 1px solid green;
                white-space:nowrap;
                background-color: #F5F5F5;
                padding: 4px;

            }

            .td2
            {
                border-collapse:collapse;
                border: 1px solid green;
                white-space:nowrap;
                background-color: #F5F5F5;
                padding: 4px;
                color: #003399;
            }
            .td3
            {
                border-collapse:collapse;
                border: 1px solid green;
                white-space:nowrap;
                background-color: blue;
                padding: 4px;
            }


        </style>
    </head>

    <body>
        <form name="form1" target="facultyaction" method="POST">
            <%

                Calendar now = Calendar.getInstance();

                System.out.println("Current date : " + (now.get(Calendar.MONTH) + 1)
                        + "-"
                        + now.get(Calendar.DATE)
                        + "-"
                        + now.get(Calendar.YEAR));
                int month = now.get(Calendar.MONTH) + 1;
                int year = now.get(Calendar.YEAR);
                String user = (String) session.getAttribute("user");
                System.out.println("%%%%%%%%%%%%%%%%%%%%%%%" + user);
                String semester = "";
                if (month <= 6) {
                    semester = "Winter";
                } else {
                    semester = "Monsoon";
                }
                Connection con = conn.getConnectionObj();
                Statement st1 = (Statement) con.createStatement();
                ResultSet rs1 = null;
                if (user.equals("admin")) {
                    rs1 = st1.executeQuery("select Code,Subject_Name from subjecttable as a, subject_faculty_" + semester + "_" + year + " as b where b.subjectid=a.Code order BY Subject_Name");
                } else {
                    rs1 = st1.executeQuery("select Code,Subject_Name from subjecttable as a, subject_faculty_" + semester + "_" + year + " as b where b.subjectid=a.Code and (b.facultyid1='" + user + "' or b.facultyid2='" + user + "') order BY Subject_Name");
                }
            %>   <select align="left" valign="bottom" style="width:175px" name="subjectname" id="mySelect1" onchange="fun1();"> 
                <option>Select Subject</option>
                <%  while (rs1.next()) {
                %><option value="<%=rs1.getString(1)%>"><%=rs1.getString(2)%></option><%
                    }
                conn.closeConnection();
                con = null;
                %>
            </select>
            <br>
            &nbsp;&nbsp;&nbsp;&nbsp;
            <div id="errfn" style="color: red" align="center"></div>
        </form>
    </body>
</html>