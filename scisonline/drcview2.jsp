<%-- 
    Document   : drcview2
    Created on : Jun 13, 2013, 2:14:50 AM
    Author     : root
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@include file="dbconnection.jsp"%>  
<%@include file="university-school-info.jsp"%> 
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
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
            
            Statement st1 = con2.createStatement();
            Statement st2 = con2.createStatement();
            Statement st3 = con2.createStatement();
            String studentid = request.getParameter("studentid");
            if (studentid.equals("none")) {
                out.println("<center><h3>please select student id</h3></center>");
                return;
            }
            //out.println(studentid);
            ResultSet rs1 = st1.executeQuery("select * from drcreports_" + cyear + " where StudentId='" + studentid + "'");
            if (rs1.next() == true) {
        %>
    <center><b><%=UNIVERSITY_NAME%></b></center>
    <center><b><%=SCHOOL_NAME%></b></center>
    <center><b>DRC Report dates of a student <font color="blue"><%=studentid%></font></b></center>
    <center>
        </br>
        </br>
        <%
            int i = 1, j = 1;
            while (i <= 12) {
                if (rs1.getString("date" + i) != null) {
        %><b><%=j%>  .</b><a href="drcview3.jsp?studentid=<%=studentid%>&date=<%=rs1.getString("date" + i)%>"><%=rs1.getString("date" + i)%></a>
        </br><%
                        j++;
                    }
                    i++;
                }
            }
//st1.closeOnCompletion();
//st2.closeOnCompletion();
//st3.closeOnCompletion();
//con2.close();
       %>
    </center>
</body>
</html>
