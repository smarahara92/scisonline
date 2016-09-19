<%-- 
    Document   : query_unallocated_core_list
    Created on : 18 Feb, 2015, 12:17:02 PM
    Author     : nwlab
--%>


<%@page import="java.sql.ResultSet"%>
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
        String sess = scis.getLatestSemester();
        scis.close();
        int year = scis.getLatestYear();
        scis.close();
        
        String title = "List of all core courses for which faculty is not allocated";
        String msg_exp = "Course allocation is not done";
        String msg_emp = "All core courses' allocation is done";

        ResultSet rs = null;
        try {
            rs = scis.getUnallocatedCoreCourses(sess, year);
            
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
                <col width="10%">
                <col width="90%">
            <tr>
                <th class="heading" align="center">S.no</th>
                <th class="heading" align="center">Subject</th>
            </tr>
<%
            do {
%>
                <tr>
                    <th class="style30" ><%=slno++%></th>
                    <td class = "cellpad"><%=rs.getString(1)%></td>
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
