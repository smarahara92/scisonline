<%-- 
    Document   : Q_Subjectwise_Atten2_15
    Created on : 26 Mar, 2015, 7:24:15 PM
    Author     : richa
--%>

<%@include file="checkValidity.jsp"%>
<%@page import ="javax.sql.*" %>
<%@page import="java.sql.*" %>
<%@page import="java.util.Calendar"%>
<%--<%@include file="dbconnection.jsp"%>--%>
<%@include file="connectionBean.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page errorPage="error.jsp?msg=Application Generated an error!" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script language="javascript">
            function fun1() {

                document.getElementById("mySelect1").focus();
            }
            function display1()
            {
                var x = document.getElementById("mySelect1").selectedIndex;

                if (document.form1.mySelect1.options[x].selected)
                    document.form1.mySelect2.options.selectedIndex = (x);
                if (document.getElementById("mySelect1").value === "Select Subject")
                {
                    parent.staffaction.location = "./BalankPage2.jsp";
                    document.getElementById("errfn").innerHTML = "*Please select Subject";
                    document.getElementById("mySelect1").focus();
                } else {
                    document.getElementById("errfn").innerHTML = "";
                    document.form1.submit();
                }


            }
        </script>
    </head>
    <body onload="fun1();">
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
            String username = (String) session.getAttribute("facultyid");
            if (username == null) {
                username = "";
            }
            System.out.println(username);

            String facultyname1 = request.getParameter("facultyname");
            System.out.println(facultyname1);
            Connection con = conn.getConnectionObj();
            try {

                String qry = "create table temp(fid varchar(20))";
                //String qry1="select ID from faculty_registration where Faculty_Name='"+username+"'";
                String qry2 = "select Code,Subject_Name from subjecttable as a, subject_faculty_" + semester + "_" + year + " as b where a.Code=b.subjectid  order By Subject_Name";
                Statement st1 = con.createStatement();
                Statement st2 = con.createStatement();
                ResultSet rs = st1.executeQuery(qry2);
                //ResultSet rs1=st2.executeQuery(qry2);
                //List subj=new ArrayList();
                int i = 0;
        %>
        <%
            //writing usual code for checking
            int x = 0;
            if (x == 0) {
        %>
        <form name="form1" action="Q_Subjectwise_AttenFINAL_15.jsp" target="staffaction" method="POST">
            <select align="left" valign="bottom" style="width:175px" name="subjectname" id="mySelect1" onchange="display1();"> 
                <option>Select Subject</option>
                <%  while (rs.next()) {%>
                <option><%=rs.getString(2)%> </option>
                <% }
                    rs.beforeFirst();
                %>
            </select>

            <select  align="left" valign="bottom" style="display:none;" name="subjectid" id="mySelect2"> 
                <option>Select Subject</option>
                <%  while (rs.next()) {%>
                <option> <%=rs.getString(1)%> </option>
                <%
                    }
                %>
            </select>

            &nbsp;
            <div id="errfn" align="left" style="color: red"></div>
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
