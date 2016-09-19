<%-- 
    Document   : query_course_list
    Created on : 18 Feb, 2015, 12:27:40 PM
    Author     : nwlab
--%>

<%@page import = "java.sql.ResultSet"%>
<%@include file="programmeRetrieveBeans.jsp" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="./css/query_display_style.css">
    </head>
    <body>
<%
        String sess = request.getParameter("sess");
        if(sess.equals("none")) {
            return;
        }
        
        String year_str = request.getParameter("year").trim();
        int year;
        try {
            year = Integer.parseInt(year_str);
        } catch (NumberFormatException nfe) {
            System.out.println(nfe);
            return;
        }
        
        String title = "List of all courses offered in " + "<span style=\"color:blue;\">"+sess+ "-" +year+"</span>";
        String table = "subject_faculty_" + sess + "_" + year;
        String query = "SELECT Subject_Name FROM " + table +", subjecttable WHERE subjectId = Code order by Subject_Name";
        String msg_exp = "Course allocation is not done";
        String msg_emp = "No courses are offered";
        
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
                    <td class = "cellpad"><%=rs.getString("Subject_Name")%></td>
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