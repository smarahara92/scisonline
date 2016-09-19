<%-- 
    Document   : query_std_pair_sub
    Created on : 18 Feb, 2015, 1:04:10 PM
    Author     : nwlab
--%>

<%@page import="java.sql.ResultSet" %>
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
        //Read subjects using form
        String sub1 = request.getParameter("sub1");
        String sub2 = request.getParameter("sub2");
        String sess = request.getParameter("sess");
        String year = request.getParameter("year");
        if(sub1.equals("") || sub2.equals("")) {
            return;
        }
        
        String title = "Common students between "+"<span style=\"color:blue;\">"+scis.subjectName(sub1)+"</span>"+" and "+"<span style=\"color:blue;\">"+scis.subjectName(sub2)+"</span>";
        scis.close();
        String table1 = sub1 + "_Attendance_" + sess + "_" + year;
        String table2 = sub2 + "_Attendance_" + sess + "_" + year;
        
        String query = "SELECT A.StudentId, A.StudentName from " + table1 + " AS A, " + table2 + " AS B WHERE A.StudentId = B.StudentId";
        
        String msg_exp = "";
        String msg_emp = "There are no common students";
        
        ResultSet rs = null;
        try {
            rs = scis.executeQuery(query);
            
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
                <col width="20%">
                <col width="70%">
            <tr>
                <th class="heading" align="center">S.no</th>
                <th class="heading" align="center">Student ID</th>
                <th class="heading" align="center">Student Name</th>
            </tr>
<%
            do {
%>
                <tr>
                    <th class="style30" ><%=slno++%></th>
                    <td class = "cellpad"><%=rs.getString(1)%></td>
                    <td class = "cellpad"><%=rs.getString(2)%></td>
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