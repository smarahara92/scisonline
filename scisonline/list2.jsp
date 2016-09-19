<%-- 
    Document   : list2
    Created on : 11 Apr, 2012, 2:58:11 PM
    Author     : khushali
--%>

<%@include file="checkValidity.jsp"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import ="javax.sql.*" %>
<%@page import="java.util.Calendar"%>
<%@page import="java.sql.*" %>
<%--<%@include file="dbconnection.jsp" %>--%>
<%@include file="connectionBean.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script type="text/javascript">
            function display1()
            {
                var x = document.getElementById("mySelect1").selectedIndex;
                document.getElementById("mySelect2").selectedIndex = x;

                if (document.getElementById("mySelect1").value === "Select Subject")
                {
                    document.getElementById("errfn").innerHTML = "*Select subject name.";
                    window.document.forms["frm"].action = "BlankPage1.jsp";
                    document.forms.frm.submit();

                } else {
                    document.getElementById("errfn").innerHTML = "";
                    window.document.forms["frm"].action = "assessmentview.jsp";
                    document.forms.frm.submit();
                }

            }
            function display2() {
                var x = document.getElementById("mySelect2").selectedIndex;
                document.getElementById("mySelect1").selectedIndex = x;

                if (document.getElementById("mySelect2").value === "Select Subject")
                {
                    document.getElementById("errfn").innerHTML = "*Select subject name.";
                    window.document.forms["frm"].action = "BlankPage1.jsp";
                    document.forms.frm.submit();

                } else {
                    document.getElementById("errfn").innerHTML = "";
                    window.document.forms["frm"].action = "assessmentview.jsp";
                    document.forms.frm.submit();
                }

            }

        </script>
    </head>
    <body>
        <%
            Calendar now = Calendar.getInstance();

            System.out.println("Current date : " + (now.get(Calendar.MONTH) + 1)
                    + "-"
                    + now.get(Calendar.DATE)
                    + "-"
                    + now.get(Calendar.YEAR));
            int month = now.get(Calendar.MONTH) + 1;
            int year = now.get(Calendar.YEAR);
            String semester = "";
            if (month <= 6) {
                semester = "Winter";
            } else {
                semester = "Monsoon";
            }
            String username = (String) session.getAttribute("user");
            if (username == null) {
                username = "";
            }
            System.out.println(username);
            String facultyname1 = (String) session.getAttribute("facultyname");
            // String facultyname1=request.getParameter("facultyname");
            System.out.println(facultyname1);
            Connection con = conn.getConnectionObj();
            try {
                // Class.forName("com.mysql.jdbc.Driver").newInstance();
                //System.out.println("driver connected");
                //Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/dcis_attendance_system", "root", "");
                // System.out.println("database connected");
                String qry = "create table temp(fid varchar(20))";
                //String qry1="select ID from faculty_registration where Faculty_Name='"+username+"'";
                String qry2 = "select Code,subject_Name from subjecttable as a where a.Code in (select subjectid from subject_faculty_" + semester + "_" + year + " where facultyid1='" + username + "' or facultyid2='" + username + "')";
                Statement st1 = con.createStatement();
                ResultSet rs = st1.executeQuery(qry2);
                List subj = new ArrayList();
                int i = 0;
        %>
        <%

            int x = 0;
            if (x == 0) {
        %>
        <form name="frm" action="assessmentview.jsp" target="act_area" method="POST">
            <select align="left" valign="bottom" style="width:175px" name="subjectname" id="mySelect1" onchange="display1();"> 
                <option>Select Subject</option>
                <%  while (rs.next()) {
                %> <option> <%=rs.getString(2)%> </option> <%

                    }
                %>      </select>
            <select align="left" valign="bottom" style="width:175px" id="mySelect2" hidden="yes" name="subjectid" onchange="display2();"> 
                <option>Select Subject</option>
                <% rs.beforeFirst();
                    while (rs.next()) {
                %> <option> <%=rs.getString(1)%> </option> <%

                    }
                %>      </select>
            &nbsp;&nbsp;
            <div id="errfn" align="center" style="color: red"></div>
        </form>
        <%   }
            } catch (Exception e) {
                e.printStackTrace();
            }finally{
                conn.closeConnection();
                con = null;
            }

        %>

    </body>
</html>
