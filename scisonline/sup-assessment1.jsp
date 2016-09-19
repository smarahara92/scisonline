<%-- 
   Document   : sup-assessment1
   Created on : Jul 5, 2013, 12:24:16 PM
   Author     : root
--%>


<%--<%@ include file="dbconnection.jsp" %>--%>
<%@ include file="connectionBean.jsp" %>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import ="javax.sql.*" %>
<%@page import="java.sql.*" %>
<%@page import="java.util.Calendar"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style>
            .style30 {width:300px}
        </style>
        <script type="text/javascript">
            function display1()
            {
                var x = document.getElementById("mySelect1").selectedIndex;
                document.getElementById("mySelect2").selectedIndex = x;
                document.forms.frm.submit();

            }

            function display2()
            {
                var x = document.getElementById("mySelect2").selectedIndex;
                document.getElementById("mySelect1").selectedIndex = x;
                document.forms.frm.submit();
            }

            function checked1()
            {
                window.document.forms["frm"].submit();
            }
        </script>
    </head>
    <body onload="document.forms.frm.submit();">
        <% //String csubj;
            String username = (String) session.getAttribute("user");
            if (username == null) {
                username = "";
            }


            Calendar now = Calendar.getInstance();


            int month = now.get(Calendar.MONTH) + 1;
            int year = now.get(Calendar.YEAR);
            String semester = "";
            if (month <= 6) {
                semester = "Monsoon";
                year = year - 1;
            } else {
                semester = "Winter";
            }
                Connection con = conn.getConnectionObj();
            try {

                System.out.println("driver connected");

                System.out.println("database connected");
                String qry2 = "";
                if (semester.equals("Winter")) {

                    qry2 = "select Code,subject_Name from subjecttable as a where a.Code in (select subjectid from subject_faculty_" + semester + "_" + year + " where facultyid1='" + username + "' or facultyid2='" + username + "');";
                } else {
                    qry2 = "select Code,subject_Name from subjecttable as a where a.Code in (select subjectid from subject_faculty_" + semester + "_" + year + " where facultyid1='" + username + "' or facultyid2='" + username + "');";
                }

                Statement st1 = con.createStatement();
                ResultSet rs = st1.executeQuery(qry2);
                List subj = new ArrayList();
                int i = 0;
        %>
        <form name="frm" action="sup-assessmentchecked.jsp" target="facultyaction" method="POST">
            <input type="hidden" name="fid" value="<%=username%>">
            <select align="left" valign="bottom" style="width:250px" name="subjectname" id="mySelect1" onchange="display1();"> 
                <%  while (rs.next()) {
                %> <option value="<%=rs.getString(2)%>"> <%=rs.getString(2)%> </option> <%

                    }

                %>      </select>
                <select align="left" valign="bottom" style="width:150px" id="mySelect2" name="subjectid" hidden="yes" onchange="display2();"> 
                <% rs.beforeFirst();
                    while (rs.next()) {
                        System.out.println("" + rs.getString(1) + "" + rs.getString(2));
                %> <option value="<%=rs.getString(1)%>"> <%=rs.getString(1)%> </option> <%

                    }

                %>      </select>
            <br> 
            <br>
        </form>
        </br>
        <br>
        <!--<input type="Submit" value="Go">-->

        <%   } catch (Exception e) {
                out.println(e);
            }finally{
                conn.closeConnection();
                con = null;
            }
        %>
    </body>
</html>
