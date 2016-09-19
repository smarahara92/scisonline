<%-- 
    Document   : temp
    Created on : Mar 26, 2014, 2:16:40 PM
    Author     : veeru
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="dbconnection.jsp"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <script>
        function fun()
        {

            var index = document.getElementById("pg1").selectedIndex;
            var index1 = document.getElementById("pg2").selectedIndex;
            var pid1 = document.getElementById("pg1").options[index].id;
            var pid2 = document.getElementById("pg2").options[index1].id;
            document.getElementById("pg11").value = pid1;
            document.getElementById("pg12").value = pid2;


        }

    </script>
    <body onload="fun();">
        <form method="POST" action="temp1.jsp" id="frrm" name="formmm1" target="facultyaction111">
            <input type="hidden" id="pg11" name="pg1" value="">
            <input type="hidden" id="pg12" name="pg2" value="">
            <table align="center">

                <%
                %>
                <tr>

                    <td><select id="pg1"  name="pg" onchange="fun();">

                            <%                                ResultSet rs = null;
                                Statement st1 = con.createStatement();
                                rs = st1.executeQuery("select * from subjecttable as a where a.Code in (select b.subjectId from subject_attendance_Winter_2014 as b)");
                                while (rs.next()) {

                            %>
                            <option id="<%=rs.getString(1)%>"><%=rs.getString(2)%></option>

                        <%}%>  </td>
                    <td>
                        <select id="pg2" name="pg" onchange="fun();">

                            <%
                                rs.beforeFirst();
                                while (rs.next()) {

                            %>
                            <option id="<%=rs.getString(1)%>"><%=rs.getString(2)%></option>

                            <%}%>    
                    </td>
                    <td><input type="submit" name="submit" value="submit" class="Button"  onclick="fun();"></td>
                </tr>

            </table>



        </form>
    </body>
</html>
