<%-- 
    Document   : loginactivity3
    Created on : May 30, 2014, 12:10:35 AM
    Author     : veeru
--%>

<%@ include file="dbconnection.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="table_css.css">
        <title>JSP Page</title>
    </head>
    <body>
        <%            try {
                String user = (String) session.getAttribute("user");
                PreparedStatement pstmt = con.prepareStatement("select lastlogin, ipaddress, mackaddress, systemname, agent from logindetails  where userid =?");
                pstmt.setString(1, user);
                ResultSet rs = pstmt.executeQuery();
        %>
        <table align="center" border="1">
            <th>S.NO</th>
            <th>Time and Date</th>
            <th>Ip Address</th>
            <th>MAC Address</th>
            <th>System Name</th>
            <th>Agent</th>
                <%
                    int i = 1;
                    while (rs.next()) {
                %>
            <tr>
                <td><%=i%></td>
                <td><%=rs.getString(1)%></td>
                <td><%=rs.getString(2)%></td>
                <td><%=rs.getString(3)%></td>
                <td><%=rs.getString(4)%></td>
                <td><%=rs.getString(5)%></td>
            </tr>
            <% i++;
                    }
                } catch (Exception e) {
                    out.println("<h3 align=center>No login details found.</h3>");
                }
            %>
        </table>
    </body>
</html>
