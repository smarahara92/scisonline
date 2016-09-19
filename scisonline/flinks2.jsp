<%-- 
    Document   : flinks2
    Created on : Sep 15, 2011, 5:09:55 PM
    Author     : admin
--%>

<%@include file="checkValidity.jsp"%>

<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import ="javax.sql.*" %>
<%@page import="java.sql.*" %>
<%@page import="java.util.Calendar"%>
<%--<%@include file="dbconnection.jsp"%>--%>
<%@include file="connectionBean.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script language="javascript">
            function display1()
            {
                var x = document.getElementById("mySelect1").selectedIndex;
                document.getElementById("mySelect2").selectedIndex = x;

                if (document.getElementById("mySelect1").value === "Select Subject")
                {
                    document.getElementById("errfn").innerHTML = "*Select subject name.";
                    window.document.forms["form1"].action = "BlankPage1.jsp";
                    document.forms.form1.submit();

                } else {
                    document.getElementById("errfn").innerHTML = "";
                    window.document.forms["form1"].action = "view.jsp";
                    document.forms.form1.submit();
                }

            }
            function display2() {
                var x = document.getElementById("mySelect2").selectedIndex;
                document.getElementById("mySelect1").selectedIndex = x;

                if (document.getElementById("mySelect2").value === "Select Subject")
                {
                    document.getElementById("errfn").innerHTML = "*Select subject name.";
                    window.document.forms["form1"].action = "BlankPage1.jsp";
                    document.forms.form1.submit();

                } else {
                    document.getElementById("errfn").innerHTML = "";
                    window.document.forms["form1"].action = "view.jsp";
                    document.forms.form1.submit();
                }

            }

        </script>

    </head>
    <body>
        <%

            String username = (String) session.getAttribute("user");
            if (username == null) {
                username = "";
            }
            System.out.println(username);
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
            String facultyname1 = request.getParameter("facultyname");
            System.out.println(facultyname1);
            Connection con = conn.getConnectionObj();
            try {

                String qry = "create table temp(fid varchar(20))";
                String qry1 = "select ID,Faculty_Name from faculty_data where ID='" + username + "'";
                String qry2 = "select Code,subject_Name from subjecttable as a where a.Code in (select subjectid from subject_faculty_" + semester + "_" + year + " where facultyid1='" + username + "' or facultyid2='" + username + "');";
                Statement st1 = con.createStatement();
                Statement st2 = con.createStatement();
                ResultSet rs = st1.executeQuery(qry2);
                ResultSet rs1 = st2.executeQuery(qry2);
                List subj = new ArrayList();
                int i = 0;
        %>
        <%
            //writing usual code for checking
            int x = 0;
            if (x == 0) {
        %>
        <form name="form1" target="facultyaction" method="POST">
            <select align="left" valign="bottom" style="width:175px" name="subjectname" id="mySelect1" onchange="display1();"> 
                <option>Select Subject</option>
                <%  while (rs.next()) {

                        System.out.println("" + rs.getString(1) + "" + rs.getString(2));
                %>
                <option> <%=rs.getString(2)%> </option>

                <%
                    session.setAttribute("subj[i]", rs.getString(1));
                    String username1 = (String) session.getAttribute("subj[i]");
                    System.out.println(username1);
                    i++;
                %>

                <%
                    }
                %>
            </select>

            <select align="left" valign="bottom" style="display:none;" name="subjectid" id="mySelect2" onchange="display1();"> 
                <option>Select Subject</option>
                <%  while (rs1.next()) {

                        System.out.println("" + rs1.getString(1) + "" + rs1.getString(2));
                %>

                <option> <%=rs1.getString(1)%> </option>

                <%
                    session.setAttribute("subj[i]", rs1.getString(1));
                    String username1 = (String) session.getAttribute("subj[i]");
                    System.out.println(username1);
                    i++;
                %>

                <%
                    }
                %>
            </select>
            &nbsp;&nbsp;
            <div id="errfn" style="color: red" align="center"></div>
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
