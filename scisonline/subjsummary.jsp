<%-- 
    Document   : summary
    Created on : Sep 15, 2011, 6:01:41 PM
    Author     : admin
--%>
<%@page import="java.util.Calendar"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.sql.*"%>
<%@include file="checkValidity.jsp"%>
<%
Calendar now = Calendar.getInstance();
   
    System.out.println("Current date : " + (now.get(Calendar.MONTH) + 1)
                        + "-"
                        + now.get(Calendar.DATE)
                        + "-"
                        + now.get(Calendar.YEAR));
    int month=now.get(Calendar.MONTH)+1;
    int year=now.get(Calendar.YEAR);
    String semester="";
    if(month==7 || month==8 || month==9 || month==10 || month==11 || month==12)
               {
   semester="Monsoonr";
    }else if (month==1 || month==2 || month==3 || month==4 || month==5 || month==6)
               {
         semester="Winter";
    }


System.out.println("**************************************************************************");
        String sname=request.getParameter("subjectname");
     if(sname==null) sname="";

//session.setAttribute("facultyname",fname);
    System.out.println(sname);
    System.out.println("***************************************");
    try {
    Class.forName("com.mysql.jdbc.Driver").newInstance();
    System.out.println("driver connected");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/dcis_attendance_system", "root", "");
    System.out.println("database connected");
   
    String qry="select code from subject_database where Subject_Name='"+sname+"'";
    Statement st1=con.createStatement();
    Statement st2=con.createStatement();
    Statement st9=con.createStatement();
    ResultSet rs=st1.executeQuery(qry);
    String subjid="";
    while(rs.next())
               {
        subjid=rs.getString(1);
    }
    String day="";
    String qry9="select Day(sessiont_date) from current_session1";
    ResultSet rs9=st9.executeQuery(qry9);
    while(rs9.next())
               {
        day=rs9.getString(1);
               }
    System.out.println("subjectid=="+subjid);
     String qry1="select * from "+semester+"_"+year+"_"+subjid+"";
     
     ResultSet rs1=st1.executeQuery(qry1);
    %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
       <!-- <style type="text/css">
        center
        {
        visibility:hidden;
        }
        </style> -->
        
    </head>
    <body>
        <center>University of Hyderabad</center>
        <center>Department of Computer and Information Sciences</center>
        <center><%=sname%> Subject Attendance</center>
        <table border="1" cellspacing="10" cellpadding="10" style="color:blue;background-color:#CCFFFF;" align="center">
            <%if(semester.equals("Monsoon"))
                           {%>
                           <tr>
        <th>StudentID</th>
        <th>StudentName</th>
        <th>Overall Percentage</th>
      
    </tr>
                           <%}
         else if(semester.equals("Winter"))
           {      
    %>
    <tr>
        <th>StudentID</th>
        <th>StudentName</th>
        <th>Overall Percentage</th>
      
    </tr>
    <%
       }%>
    
    
    <%while(rs1.next())
     {
        %>
        <tr>
            <td><%=rs1.getString(1)%></td>
            <td><%=rs1.getString(2)%></td>
            <td><%=rs1.getInt(8)%></td>
        </tr>
        
        <%
    
               }
}
catch(Exception e)
           {
    System.out.println("Caught the exception");
    out.println("<h1><center>Data is not Available</center></h1>");
       e.printStackTrace();
   }
%>
</table>
<div align="center">
		<input type="button" value="Print" style="width: 50px; color: white; background-color: #6d77d9; border-color: red;" onclick="window.print();" />
</div>
    </body>
</html>