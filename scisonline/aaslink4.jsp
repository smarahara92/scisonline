<%-- 
    Document   : aaslink4
    Created on : 17 Mar, 2014, 7:22:33 PM
    Author     : veeru
--%>

<%@include file="checkValidity.jsp"%>
<%@page import="com.hcu.mysql.connection.ConnectionDemo1"%>

<%@page import ="javax.sql.*" %>
<%@page import="java.sql.*" %>
<%@page import="java.util.Calendar"%>
<%@page errorPage="error.jsp?msg=Application Generated an error!" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script type="text/javascript">
            function fun1() {
                document.getElementById("mySelect1").focus();
            }


            function display1()
            {
                var x = document.getElementById("mySelect1").selectedIndex;
                var subid = document.getElementsByTagName("option")[x].id;
                var subname = document.getElementsByTagName("option")[x].value;
              


                if (document.getElementById("mySelect1").value === "Select Subject")
                {
                    parent.staffaction.location = "./BalankPage2.jsp";
                    document.getElementById("errfn").innerHTML = "*Select Subject";
                } else {
                    document.getElementById("errfn").innerHTML = "";
                    parent.staffaction.location = "./subsummary.jsp?subjectname=" + subname + "&subjectid=" + subid;
                }

            }


        </script>
    </head>
    <body onload="fun1();">
        <%
            try {

                Calendar now = Calendar.getInstance();
                int month = now.get(Calendar.MONTH) + 1;
                int year = now.get(Calendar.YEAR);
                String semester = "";

                if (month <= 6) {
                    semester = "Winter";
                } else {
                    semester = "Monsoon";
                }

                String qry2 = "select Code,Subject_Name from subjecttable as a, subject_faculty_" + semester + "_" + year + " as b where a.Code=b.subjectid  order By Subject_Name";
                Statement st1 = ConnectionDemo1.getStatementObj().createStatement();
                ResultSet rs = st1.executeQuery(qry2);
                int i = 0;
        %>  
        <form name="frm" target="staffaction" method="POST">
            <select align="left" valign="bottom" style="width:175px"name="subjectname" id="mySelect1" onchange="display1();"> 
                <option>Select Subject</option>
                <%  while (rs.next()) {

                %>
                <option id="<%=rs.getString(1)%>" value="<%=rs.getString(2)%>"> <%=rs.getString(2)%> </option>
                <%}%>                
            </select>


            &nbsp;</br></br>
            <table align="left">
                <tr>
                    <td>
                        <div align="left" id="errfn" style="color: red"></div>
                    </td>
                </tr>
            </table>


        </form>

        <%} catch (Exception e) {
                e.printStackTrace();
            }

        %>
    </body>
</html>
