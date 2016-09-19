<%-- 
    Document   : header
    Created on : Aug 27, 2011, 11:07:16 AM
    Author     : admin
--%>

<%@page import="java.util.Calendar"%>
<%@page import="java.util.TimeZone"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.text.ParseException"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ include file="dbconnection.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
       

    </head>
    <body bgcolor="#c2000d">

        <%            try {

                String lastlogin = null;
                String user = (String) session.getAttribute("user");
                String ip = (String) session.getAttribute("yip");
                lastlogin = (String) session.getAttribute("lostseen");//from auth.jsp

                try {
                    String[] tokens = lastlogin.split(",");

                    Calendar calendar = Calendar.getInstance();
                    String currentDate = new SimpleDateFormat("yyyy/MM/dd").format(calendar.getTime());

                    String[] tokens1 = currentDate.split("/");
                    String[] tokens2 = tokens[1].split("/");
                    int yesterDay = (Integer.parseInt(tokens1[2]) - 1);
                    int yesterDay1 = (Integer.parseInt(tokens2[2]));

                    if (currentDate.trim().equalsIgnoreCase(tokens[1].trim())) {
                        lastlogin = "last seen today at " + tokens[0];
                    } else if (tokens1[0].trim().equalsIgnoreCase(tokens2[0].trim()) && tokens1[1].trim().equalsIgnoreCase(tokens2[1].trim()) && yesterDay == yesterDay1) {
                        lastlogin = "last seen yesterday at " + tokens[0];
                    } else {
                        lastlogin = "last seen at " + lastlogin;
                    }
                } catch (Exception e) {
                }


        %>
        <table align="center">
            <tr rowspan="4">
                <td align="left"><img src="uohlogo2.jpeg" alt="UOH" width="100" height="80" /></td>
                <td align="center"><h1><font color="white">UNIVERSITY OF HYDERABAD</font></h1></td> 

            </tr>

        </table>
        <table align="center" width="100%">
            <tr>

                <%               
                    try{
                    PreparedStatement ps;
                    ResultSet rs = null;

                    ps = con.prepareStatement("SELECT lastlogin FROM loginactivity where userid=? ");
                    ps.setString(1, user);
                    rs = ps.executeQuery();

                    if (rs.next()) {

                        if (lastlogin != null) {
                %>
                <td align="left" style=" color: black; font-size: 13px;"><%=lastlogin%></td> 
                <%}
                    }
                    if (ip != null) {
                %>
                <td align="right" style=" color: black; font-size: 13px;"> Your ip address:<%=ip%></td>
                <%
                    }
                     rs.close();
                     ps.close();
                    }catch(Exception e){ 
                        
                    }
                %>
            </tr>

        </table>

        <%
            } catch (Exception e) {
                System.out.println(e);
            }
        
        %>
    </body>
</html>
