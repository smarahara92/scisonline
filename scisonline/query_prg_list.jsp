<%-- 
    Document   : query_prg_list
    Created on : 18 Feb, 2015, 12:22:21 PM
    Author     : nwlab
--%>

<%@page  import = "java.sql.ResultSet"%>
<%@include file="programmeRetrieveBeans.jsp" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="./css/query_display_style.css">
    </head>
    <body>
<%
        String title = "List of all programmes offered by the school";
        String msg_exp = "";
        String msg_emp = "";

        ResultSet rs = null;
        try {
            rs = scis.getProgramme();
            
            if(rs == null) {
%>
                <h3 style="color:#c2000d" align="center"><%=msg_exp%></h3>
<%                
                return;
            }
            if (!rs.next()) {
%>
                <h3 style="color:#c2000d" align="center"><%=msg_emp%></h3>
<%                
                return;
            }
            int slno = 1;
%>
            <h3 style="color:#c2000d" align="center"><%=title%></h3>
            <table align="center" border="1" class = "maintable">
            <tr>
                <th class="heading" align="center">S.no</th>
                <th class="heading" align="center">Programme</th>
                <th class="heading" align="center">Status</th>
            </tr>
<%
            do {
%>
                <tr>
                    <th class="style30" ><%=slno++%></th>
                    <td class = "cellpad"><%=rs.getString("Programme_name")%></td>
<%
                    int status = rs.getInt("Programme_status");
                    if(status == 1) {
%>
                        <td class = "cellpad">ACTIVE</td>
<%
                    } else {
%>
                        <td class = "cellpad">DELETED</td>
<%
                    }
%>
                </tr>
<%
            } while (rs.next());
%>
        </table>&nbsp;
<%
        } catch(Exception e) {
            System.out.println(e);
        }
        scis.close();
%>
    </body>
</html>