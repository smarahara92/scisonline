<%-- 
    Document   : thesistitle1
    Created on : Jun 6, 2013, 11:45:36 AM
    Author     : root
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.Calendar"%>
<%@include file="dbconnection.jsp"%>  
<%@include file="university-school-info.jsp"%> 
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
    <center><b><%=UNIVERSITY_NAME%></b></center>
    <center><b><%=SCHOOL_NAME%></b></center>
    <center><b>Ph.D. Students Thesis titles</b></center>
    </br></br>
    <table border="1" cellspacing="5" cellpadding="5" style="color:blue;background-color:#CCFFFF;" align="center">

        <tr>
            <th>Student ID</th>
            <th>Student Name</th>
            <th>Thesis title</th>

        </tr>
        <%
        try{
            Calendar now = Calendar.getInstance();
            System.out.println("Current date : " + (now.get(Calendar.MONTH) + 1)
                    + "-"
                    + now.get(Calendar.DATE)
                    + "-"
                    + now.get(Calendar.YEAR));
            int month = now.get(Calendar.MONTH) + 1;
            int cyear = now.get(Calendar.YEAR);
            if (month >= 1 && month <= 6) {
                cyear--;
            }

            String totalstudents = request.getParameter("totalstudents");
            String id[] = request.getParameterValues("id");
            String name[] = request.getParameterValues("name");
            String area[] = request.getParameterValues("area");
            Statement st1 = con2.createStatement();
            int i = 0;
            for (i = 0; i < Integer.parseInt(totalstudents); i++) {
        %>
        <tr>
            <td><%=id[i]%></td>
            <td><%=name[i]%></td>
            <%
                if (area[i].equals("") != true) {
            %><td><%=area[i]%></td><%
                    st1.executeUpdate("update PhD_" + cyear + " set thesistitle='" + area[i] + "' where StudentId='" + id[i] + "'");

                } else {
            %><td></td><%
                        st1.executeUpdate("update PhD_" + cyear + " set thesistitle=null where StudentId='" + id[i] + "'");
                    }
            %></tr><%
                }
                st1 = null;
            }
            catch(Exception e){
                System.out.println(e);
            }
            finally{
                con.close();
                //con1.close();
                con2.close();
            }
            %>
    </body>
</html>
