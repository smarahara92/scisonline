<%-- 
    Document   : phd_assessment
    Created on : Jun 7, 2013, 10:44:57 PM
    Author     : root
--%>
<%@include file="checkValidity.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.Calendar"%>
<%@include file="dbconnection.jsp"%>   
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
         <style>
.style30{width:150px;color:#000000}
.style31 {color: white}
</style>
    </head>
    <body>
        <form name="frm" action="phd_assessment3.jsp"  method="POST" onsubmit="">
        <%
           Calendar now = Calendar.getInstance();
           System.out.println("Current date : " + (now.get(Calendar.MONTH) + 1)
                        + "-"
                        + now.get(Calendar.DATE)
                        + "-"
                        + now.get(Calendar.YEAR));
           int month=now.get(Calendar.MONTH)+1;
           int cyear=now.get(Calendar.YEAR); 
           Statement st1=con2.createStatement();
          Statement st2=con2.createStatement();
          Statement st3=con2.createStatement();
          String user=(String)session.getAttribute("user");
          String sid=request.getParameter("studentid");
          
          ResultSet rs2=st2.executeQuery("select * from PhD_electives");
          ResultSet rs3=st3.executeQuery("select * from PhD_curriculum offset limit 1");
          rs3.next();
          int noofelectives=Integer.parseInt(rs3.getString(2));
          int noofcores=Integer.parseInt(rs3.getString(1));
          if(sid.equals("none"))
            {
            out.println("<center><h3>please select student id</h3></center>");
            }
          else
            {
             ResultSet rs1=st1.executeQuery("select * from PhD_"+cyear+" where StudentId='"+sid+"'");
             int i=1;
             
          
            }                       
          
          %>
        </form>
    </body>
</html>
