<%-- 
    Document   : programme_delete
--%>
<%@include file="checkValidity.jsp"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@include file="programmeRetrieveBeans.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style>
            .style1{color: red}
        </style>
        <script>
            function confirm1() {
                var pname1 = document.getElementById("tmp").value;
                var answer = confirm("This will delete " + pname1 + ". Do you want to continue?");
                return answer;
            }
        </script>
    </head>
    <body onload="one();" >
<%
        try {
            ResultSet rs1 = null;
            rs1 = scis.getProgramme(1);
%>
            <form action="programme_deletelink.jsp" method="POST" name="formd" onsubmit=" return confirm1();">
                <input type="hidden" name="check" value="7" />
                <table align="center" border="0" cellpadding="5" cellspacing="5">
                    <caption> <h2>Delete programme </h2> </caption>
                    <tr>
                        <td>
                            <select name="pname" id="tmp" style="width:200px;">
<%
                                while (rs1.next()) {
%>
                                    <option><%=rs1.getString(1)%></option>
<%
                                }
%>
                            </select>
                        </td>
                        <td><input type="Submit" value="Delete"><br></td>
                    </tr>
                </table>
            </form>
<%
            rs1.close();
        } catch (Exception e) {
%>
            <script type="text/javascript">
                alert("Add at least one programme");
            </script>
<%
        }
        
%>
    </body>
</html>