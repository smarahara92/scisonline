<%-- 
    Document   : Q_Patfinal_15
    Created on : Mar 2, 2015, 10:34:54 PM
    Author     : richa
--%>
<%@include file="checkValidity.jsp"%>
<%@page import="com.hcu.mysql.connection.ConnectionDemo"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%--<%@ include file="dbconnection.jsp" %>--%>
<%@ include file="connectionBean.jsp" %>
<%@include file="programmeRetrieveBeans.jsp"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.sql.*"%>


<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="./css/query_display_style.css">
   
      </head>
    <body>
    
      
      <%  Connection con = conn.getConnectionObj();
      try{
         String month = request.getParameter("month");
          int sno =1;
          // String month ="1";
         System.out.println(month);
         String  m ="";
         String sem =scis.getLatestSemester();
         if(sem.equalsIgnoreCase("winter")){
            if(month.equals("1")){
                m ="January";
            }
            else if(month.equals("2")){
                m ="February";
            }
             else if(month.equals("3")){
                m ="March";
            }
             else if(month.equals("4")){
                m ="April";
            }
         }
          if(sem.equalsIgnoreCase("monsoon")){
            if(month.equals("1")){
                m ="July";
            }
            else if(month.equals("2")){
                m ="August";
            }
             else if(month.equals("3")){
                m ="September";
            }
             else if(month.equals("4")){
                m ="October";
            }
         }
         %>
    <center><h3 style="color:red"> List of all subjects for which attendance has not been  given for <font style="color: blue"><%=m%></font><h3></center>
            <table align ='center' border="1" class = "maintable">
                                      <col width="15%">
                                     <col width="25%">  
                                    <col width="60%">
                                    
                                    <tr>
         <th class="heading" align="center">SNo</th>
       <th class="heading" align="center">Subject Id </th>
      <th class="heading" align="center">Subject Name</th>
  
      </tr>
         <%
         Statement stmt = con.createStatement();
         Statement stmt1 = con.createStatement();
         ResultSet rs = stmt.executeQuery("select * from subject_attendance_Winter_2015 where month"+month+ " IS NULL");
         while(rs.next())
         {    System.out.println("hhi jrj");
              ResultSet rs1 = stmt1.executeQuery("select * from subjecttable where Code='"+rs.getString(1)+"'");    rs1.next();%>
               <tr>
                 <td class = "cellpad" ><%=sno++%></td>
                <td class = "cellpad" ><%=rs.getString(1)%></td>
                <td class = "cellpad" ><%=rs1.getString(2)%></td>
                <%
             
         }
      }catch(Exception e){
          System.out.println(e);
          
      }finally{
          conn.closeConnection();
          con = null ;
      }
      %></table>
              
    </body>
</html>


