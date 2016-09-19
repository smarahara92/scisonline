<%-- 
    Document   : deletefaculty
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body onload="onload1();">
        <form  id="form" method="POST"  action="deleteFacultyPhDProject.jsp">
            <%
                String facultyName=request.getParameter("facname");
            %>
            <h3 align="center">There are currently no Project students under <%=facultyName%> </h3>
            <script>
            function onload1() {
                document.getElementById("xx1").focus();
            }

            function Cancelto() {
                window.open("deleteFaculty.jsp", "subdatabase");//here check =6 means error number (if condition number.)
            }
        </script> 
        <table align="center">
            <tr>
            <br>
            <td> <input type="button" id="xx1" value="Cancel" onclick="Cancelto();">&nbsp;&nbsp;&nbsp;&nbsp;</td>
            <td > <input type="submit" id="xx" value="Continue" onClick="check(0)"> </td>

        </tr>
    </table>
        </form>
    </body>
</html>
