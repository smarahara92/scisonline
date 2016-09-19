<%-- 
    Document   : Q_AllReadmission_15
    Created on : 17 Apr, 2015, 8:17:46 PM
    Author     : richa
--%>
<%@include file="checkValidity.jsp"%>
<%@page import="com.hcu.mysql.connection.ConnectionDemo"%>
<%@ include file="connectionBean.jsp" %>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="./css/query_display_style.css">
              
        <center><h3 style="color:red"> List of all re-admission students across all streams and batches <h3></center>
    </head>
    <body>
<%
         Connection con=null;
         try{
             int n = 1;
             con = conn.getConnectionObj();
             Statement stmt1 =null ;
             Statement stmt2 = null;
             ResultSet rs1 = null;
             String StreamName = request.getParameter("pname");
             String BatchYear = request.getParameter("pyear");
         }catch( Exception ex){
             System.out.println(ex);
         }
%>        
  </body>
  
</html>>