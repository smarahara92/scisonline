<%-- 
    Document   : subjectwise
    Created on : Aug 30, 2011, 5:42:43 AM
    Author     : admin
--%>
<%@page import="com.hcu.mysql.connection.ConnectionDemo1"%>
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
   semester="Monsoon";
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
    
    System.out.println("database connected");
   
    String qry="select code from subjecttable where Subject_Name='"+sname+"'";
    Statement st1=ConnectionDemo1.getStatementObj().createStatement();
    Statement st2=ConnectionDemo1.getStatementObj().createStatement();
    Statement st3=ConnectionDemo1.getStatementObj().createStatement();
    Statement st4=ConnectionDemo1.getStatementObj().createStatement();
    Statement st9=ConnectionDemo1.getStatementObj().createStatement();
    ResultSet rs=st1.executeQuery(qry);
    String subjid=request.getParameter("subjectid");
    while(rs.next())
               {
        //subjid=rs.getString(1);
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
     String qry2="select * from subject_attendance where subjectId='"+subjid+"'";
     
     ResultSet rs2=st3.executeQuery(qry2);
     String qry3="select count(*) from "+semester+"_"+year+"_"+subjid+"";
     
     ResultSet rs3=st4.executeQuery(qry3);
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
        <script language="javascript" src="print.js"></script>
    </head>
    <body>
        <center>University of Hyderabad</center>
        <center>Department of Computer and Information Sciences</center>
        <center><%=sname%> Subject Attendance</center>
        <table border="1" cellspacing="5" cellpadding="5" style="color:blue;background-color:#CCFFFF;" align="center">
            <%if(semester.equals("Monsoon"))
                           {%>
                           <tr>
        <th>StudentID</th>
        <th>StudentName</th>
        <th>July15-Aug14</th>
        <th>Aug15-Sep14</th>
        <th>Sep15-Oct14</th>
        <th>Oct15-Nov14</th>
        <th>Overall Percentage</th>
      
    </tr>
                           <%}
         else if(semester.equals("Winter"))
           {      rs2.next();
                  rs3.next();
    %>
    <tr>
        <th>StudentID<br/><font color="green">(<%=rs3.getInt(1)%>)</font></th>
        <th>StudentName</th>
        <th>Jan<%=day%>-Jan31<br/><font color="green">(<%=rs2.getInt(2)%>)</font></th>
        <th>Feb1-Feb29<br/><font color="green">(<%=rs2.getInt(3)%>)</font></th>
        <th>Mar1-Mar31<br/><font color="green">(<%=rs2.getInt(4)%>)</font></th>
        <th>Apr1-Apr30<br/><font color="green">(<%=rs2.getInt(5)%>)</font></th>
        <th>Overall Percentage</th>
      
    </tr>
    <%
       }%>
    
    
    <%while(rs1.next())
     {
        %>
        
            <%
            if(Math.ceil(rs1.getFloat(8)) < 75){
            %>
            <tr style="background-color:yellow">
            <td><%=rs1.getString(1)%></td>
            <td><%=rs1.getString(2)%></td>
            <td><%=rs1.getInt(3)%></td>
            <td><%=rs1.getInt(4)%></td>
            <td><%=rs1.getInt(5)%></td>
            <td><%=rs1.getInt(6)%></td>
            <td><font><%=Math.ceil(rs1.getFloat(8))%></font></td>
            <%}else
                               {
            %>
            <tr>
            <td><%=rs1.getString(1)%></td>
            <td><%=rs1.getString(2)%></td>
            <td><%=rs1.getInt(3)%></td>
            <td><%=rs1.getInt(4)%></td>
            <td><%=rs1.getInt(5)%></td>
            <td><%=rs1.getInt(6)%></td>
            <td><%=Math.ceil(rs1.getFloat(8))%></td>
            <%}%>
        </tr>
        
        <%
        
    ConnectionDemo1.getStatementObj().close();
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
<table align="center"><tr><td><div align="center">
    <input type="button" value="Print" id="p1" style="width: 50px; color: white; background-color: #6d77d9; border-color: red;" onclick="p1();" />
</div>
        </td></tr></table> 
    </body>
</html>
