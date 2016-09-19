<%-- 
    Document   : addFaculty
--%>

<%@include file="checkValidity.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script>
            function disableEnterKey(e) {
                var key;
                if(window.event)
                    key = window.event.keyCode;     //IE
                else
                    key = e.which;     //firefox
                if(key === 13)
                    return false;
                else
                    return true;
            }
        </script>
    </head>
    <body>
        <form action="addFaculty_link.jsp" method="get" name="form1">
            <table align="center">
                <tr><th colspan="3" align="center"><font size="5">Add New Faculty</font></th></tr>
                <tr></tr>
                <tr>
                    <th>Faculty UserId</th>
                    <th>Faculty Name</th>
                    <th>Organization</th>
                </tr> <%
                int i=0;
                while(i < 5) {%>
                    <tr>
                        <td><input type="text" name="fid" value="" onKeyPress="return disableEnterKey(event);"></td>
                        <td><input type="text" name="fname" value="" onKeyPress="return disableEnterKey(event);"></td>
                        <td><input type="text" name="ou" value="" onKeyPress="return disableEnterKey(event);"></td>
                    </tr> <%
                    i++;
                } %>
        
                <tr><td colspan="3" align="center"><input type="submit" value="submit"/></td></tr>
            </table>
        </form>
    </body>
</html>
