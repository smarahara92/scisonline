<%-- 
    Document   : query_curr_last_modification
    Created on : 18 Feb, 2015, 12:12:37 PM
    Author     : nwlab
--%>

<%@page import = "java.sql.ResultSet"%>
<%@include file = "programmeRetrieveBeans.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="./css/query_display_style.css">
    </head>
    <body>
        
<%
        String title = "Last time the curriculum was modified for each programme";
        String msg_exp = "";
        String msg_emp = "";
        int ACTIVE = 1;
        
        ResultSet rs = null;
        try {
            rs = scis.getProgramme(ACTIVE);
            
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
                <th class="heading" align="center">Year</th>
            </tr>
<%         
            do {
                String stream = rs.getString(1);
                int year = scis.latestCurriculumYear(stream);
%>
                    <tr>
                        <th class="style30" ><%=slno++%></th>
                        <td class = "cellpad"><%=stream%></td>
                        <td class = "cellpad"><%=year%></td>
                    </tr>
<%
            } while(rs.next());
%>
        </table>
<%
        } catch(Exception e) {
            System.out.println(e);
        }
        scis.close();
%>
    </body>
</html>
