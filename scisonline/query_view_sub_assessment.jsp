<%-- 
    Document   : query_view_sub_assessment
    Created on : 18 Feb, 2015, 12:57:43 PM
    Author     : nwlab
--%>

<%@page import = "java.sql.Statement"%>
<%@page import = "java.sql.ResultSet"%>
<%@page import = "java.sql.Connection"%>
<%@include file = "connectionBean.jsp" %>
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
        String sub = request.getParameter("sub");
        String sess = request.getParameter("sess");
        String year_str = request.getParameter("year").trim();
        
        if(sess.equals("none") || sub.equals("none")) {
            return;
        }
        
        int year;
        try {
            year = Integer.parseInt(year_str);
        } catch (NumberFormatException nfe) {
            System.out.println(nfe);
            return;
        }
        
        String title = "Assessment of "+"<span style=\"color:blue;\">"+scis.subjectName(sub)+"</span>"+" in "+"<span style=\"color:blue;\">"+sess+"-"+year+"</span>";
        scis.close();
        String msg_exp = "";
        String msg_emp = "Course registration of " + "<span style=\"color:blue;\">"+scis.subjectName(sub)+"</span>" + " is not done";
        Connection con1 = conn1.getConnectionObj();
        Statement st = con1.createStatement();
        try {
            ResultSet rs = st.executeQuery("SELECT * FROM " + sub + "_Assessment_" + sess + "_" + year);
            if (!rs.next()) {
%>
                <h3 style="color:#c2000d" align="center"><%=msg_emp%></h3>
<%                
                return;
            }
%>
        <h3 style="color:#c2000d" align="center"><%=title%></h3>
        <table align="center" border="1" class = "maintable">
            <tr>
                <th class="heading" align="center">S.no</th>
                <th class="heading" align="center">Student ID</th>
                <th class="heading" align="center">Student Name</th>
                <th class="heading" align="center">Internal</th>
                <th class="heading" align="center">Major</th>
                <th class="heading" align="center">Total</th>
                <th class="heading" align="center">Grade</th>
            </tr>
<%        
            int i = 1;
            do {
%>
                <tr>
                    <th class="style30"><%=i++%></th>
                    <td class = "cellpad"><%=rs.getString(1)%></td>
                    <td class = "cellpad"><%=rs.getString(2)%></td>
<%
                    String x = rs.getString("InternalMarks");
                    if(x == null) {
%>
                        <td class = "cellpad"></td>
<%                        
                    } else {
%>                    
                        <td class = "cellpad"><%=x%></td>
<%
                    }
                    x = rs.getString("Major");
                    if(x == null) {
%>
                        <td class = "cellpad"></td>
<%                        
                    } else {
%>                    
                        <td class = "cellpad"><%=x%></td>
<%
                    }
                    x = rs.getString("TotalMarks");
                    if(x == null) {
%>
                        <td class = "cellpad"></td>
<%                        
                    } else {
%>                    
                        <td class = "cellpad"><%=x%></td>
<%
                    }
                    x = rs.getString("Final");
                    if(x == null) {
%>
                        <td class = "cellpad"></td>
<%                        
                    } else {
%>                    
                        <td class = "cellpad"><%=x%></td>
<%
                    }
%>
                </tr>
<%            
            } while(rs.next());
%>
        </table>
<%
        } catch(Exception e) {
            System.out.println(e);
%>
            <h3 style="color:#c2000d" align="center"><%=msg_exp%></h3>
<%
        }
        conn1.closeConnection();
        con1 = null;
%>
    </body>
</html>
