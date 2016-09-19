<%-- 
    Document   : loginactivity1
    Created on : May 29, 2014, 11:26:59 PM
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
                String check = "1";
                if (request.getParameter("check") != null) {
                    check = request.getParameter("check");
                }

                String user = (String) session.getAttribute("user");

                if (check.equalsIgnoreCase("1")) {

                    PreparedStatement pstmt = con.prepareStatement("select a.lastlogin,a.ipaddress,a.mackaddress,a.systemname,a.agent from logindetails a, loginactivity b where ((a.userid =b.userid ) and (a.count=b.count)and (b.userid=?))");
                    pstmt.setString(1, user);
                    ResultSet rs = pstmt.executeQuery();
                    if (rs.next()) {
        %>

        <table align="center" border="1">
            <tr>
                <td>
                    <p><h3 style=" color: #B40404">Last Login Details</h3></p>

                    <p><font style=" color: blue">Ip Address :</font><%=rs.getString(2)%></p>
                    <p><font style=" color: blue">MAC Address:</font><%=rs.getString(3)%></p>
                    <p><font style=" color: blue">System Name:</font><%=rs.getString(4)%></p>
                    <p><font style=" color: blue">Agent      :</font><%=rs.getString(5)%></p>
                    <p><font style=" color: blue">Date & Time:</font><%=rs.getString(1)%></p>


                </td>
            </tr>
        </table>
        <%}
        } else if (check.equalsIgnoreCase("2")) {
            String one = "";
            String one2 = "";
            String one3 = "";
            String one4 = "";
            String one5 = "";
            PreparedStatement pstmt = con.prepareStatement("select lastlogin, ipaddress, mackaddress, systemname, agent from loginactivity  where userid =?");
            pstmt.setString(1, user);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {

                if (rs.getString(2) != null) {

                    one = rs.getString(2);

                }
                if (rs.getString(3) != null) {

                    one2 = rs.getString(3);

                }
                if (rs.getString(4) != null) {

                    one3 = rs.getString(4);

                }
                if (rs.getString(5) != null) {

                    one4 = rs.getString(5);

                }
                if (rs.getString(1) != null) {

                    one5 = rs.getString(1);

                }
        %>

        <table align="center" border="1">
            <tr>
                <td>
                    <p><h3 style=" color: #B40404">Last Failed Login Details</h3></p>

                    <p><font style=" color: blue">Ip Address :</font><%=one%></p>
                    <p><font style=" color: blue">MAC Address:</font><%=one2%></p>
                    <p><font style=" color: blue">System Name:</font><%=one3%></p>
                    <p><font style=" color: blue">Agent      :</font><%=one4%></p>
                    <p><font style=" color: blue">Date & Time:</font><%=one5%></p>


                </td>
            </tr>
        </table>
        <%}
                }
            } catch (Exception e) {
                out.println("<h3 align=center>No login details found.</h3>");
            }
        %>
    </body>
</html>
