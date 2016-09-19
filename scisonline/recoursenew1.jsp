<%-- 
    Document   : recoursenew1
    Created on : Apr 6, 2013, 5:52:11 PM
    Author     : root
--%>
<%@include file="checkValidity.jsp"%>
<%--<%@ include file="dbconnection.jsp" %>--%>
<%@include file ="connectionBean.jsp" %>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import ="javax.sql.*" %>
<%@page import="java.sql.*" %>
<%@page errorPage="error.jsp?msg=Application Generated an error!" %>
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

           
            function checked1()
            {
                var pname = document.getElementById("pg").value;
                if (pname === "-Programme-")
                {

                    parent.facultyaction.location = "./BalankPage2.jsp";
                    document.getElementById("errfn").innerHTML = "*Select Programme.";
                    document.getElementById("pg").focus();
                } else {

                    document.getElementById("errfn").innerHTML = "";

                    window.document.forms["frm"].submit();

                }

            }
        </script>
    </head>
    <body>
        <%
             Connection con = conn.getConnectionObj();
            String username = (String) session.getAttribute("user");
            if (username == null) {
                username = "";
            }

            try {

        %>
        <form name="frm" action="recoursenew2.jsp" target="facultyaction" method="POST">

            <table>
                <caption><h3>By Stream :</h3></caption>
                <tr>
                    <td>
                        <select id="pg" name="pg" onchange="checked1();">
                            <option value="-Programme-">-Programme-</option>
                            <%
                                ResultSet rs = null;
                                Statement st1 = con.createStatement();
                                rs = st1.executeQuery("select Programme_name from programme_table where (Programme_status='1' and not Programme_name ='PhD')");
                                while (rs.next()) {

                            %>
                            <option value="<%=rs.getString(1)%>"><%=rs.getString(1)%></option>

                            <%}%>    
                    </td>
                </tr>
            </table>
            </br>
            <br>

            <div id="errfn" style="color: red" align="left"></div>
            <!--<input type="Submit" value="Go">-->
        </form>
        <%   } catch (Exception e) {
                out.println(e);
            } finally{
              conn.closeConnection();
              con = null;
        }
        %>
    </body>
</html>
