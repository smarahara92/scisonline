<%-- 
    Document   : sem-duration-stroing
    Created on : 24 Oct, 2012, 12:18:05 PM
    Author     : laxman
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.io.OutputStream"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.File"%>
<%@page import="com.hcu.mysql.connection.ConnectionDemo3"%>
<%@page import="com.hcu.mysql.connection.ConnectionDemo1"%>
<%@page import="com.hcu.mysql.connection.ConnectionDemo"%>
<%@page import="java.sql.*"%>
<%@page import="com.mysql.jdbc.Statement"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@include file="dbconnection.jsp" %>
<%@include file="checkValidity.jsp"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body bgcolor="#CCFFFF">
        
    
    <%
    System.out.println("laxmank");
    
     Calendar now = Calendar.getInstance();
   
    System.out.println("Current date : " + (now.get(Calendar.MONTH) + 1)
                        + "-"
                        + now.get(Calendar.DATE)
                        + "-"
                        + now.get(Calendar.YEAR));
    int month=now.get(Calendar.MONTH)+1;
    int year=now.get(Calendar.YEAR);
    String semester="";
    if(month<=6)
     {
       semester="Winter";
     }
     else
     {
       semester="Monsoon";
     }
    String current_session =request.getParameter("current_session");
    String startdate = request.getParameter("startdate");
    String enddate = request.getParameter("enddate");
    Statement st1 = (Statement)con.createStatement();
    System.out.println(startdate +"   "+enddate);
    
   // System.out.println(sy+"  "+ey+"  "+sm+"  "+em);
    if(startdate.equals("")==false && enddate.equals("")==false)
      {
       
        int sy=Integer.parseInt(startdate.substring(0,4));
        int ey=Integer.parseInt(enddate.substring(0,4));
        int sm=Integer.parseInt(startdate.substring(5,7));
        int em=Integer.parseInt(enddate.substring(5,7));
        int sd=Integer.parseInt(startdate.substring(8,10));
        int ed=Integer.parseInt(enddate.substring(8,10));
        if(sy<=ey)
        {
        if(sy==ey)
           {
             if(sm>=em)
               {
                  if(sm==em && sd<ed)
                   {
                      
                      st1.executeUpdate("create table if not exists session(name varchar(20),start date,end date,primary key(name,start,end))");
                      //st1.executeUpdate("insert into session values('"+current_session+"','"+startdate+"','"+enddate+"')");
                      //st1.executeUpdate("drop table if exists "+semester+"_subjectfaculty");
                      //st1.executeUpdate("create table if not exists "+semester+"_subjectfaculty(subjectid varchar(20),facultyid1 varchar(20),facultyid2 varchar(20),primary key(subjectId))");
                      //st1.executeUpdate("delete from "+semester+"_subjectfaculty");
                      %>
                      <center><h1>Successfully updated sem duration</h1></center>
                      <%
                   }
                  else
                   {
                     %>
                      <center><h1>Enter dates Correctly</h1></center>
                     <%
                   }
               }
             else
               {
                   //st1.executeUpdate("drop table if exists session");
                      st1.executeUpdate("create table if not exists session(name varchar(20),start date,end date,primary key(name,start,end))");
                   //st1.executeUpdate("insert into session values('"+current_session+"','"+startdate+"','"+enddate+"')");
                    //st1.executeUpdate("drop table if exists "+semester+"_subjectfaculty");
      //st1.executeUpdate("create table if not exists "+semester+"_subjectfaculty(subjectid varchar(20),facultyid1 varchar(20),facultyid2 varchar(20),primary key(subjectId))");
                     //st1.executeUpdate("delete from "+semester+"_subjectfaculty");
                     %>
                    <center><h1>Successfully updated sem duration</h1></center>
                   <%
               }
           }
        else
           {
        //    st1.executeUpdate("drop table if exists session");
            st1.executeUpdate("create table if not exists session(name varchar(20),start date,end date,primary key(name,start,end))");
          //  st1.executeUpdate("insert into session values('"+current_session+"','"+startdate+"','"+enddate+"')");
            // st1.executeUpdate("drop table if exists "+semester+"_subjectfaculty");
      //st1.executeUpdate("create table if not exists "+semester+"_subjectfaculty(subjectid varchar(20),facultyid1 varchar(20),facultyid2 varchar(20),primary key(subjectId))");
        //   st1.executeUpdate("delete from "+semester+"_subjectfaculty");
                   %>
            <center><h1>Successfully updated sem duration</h1></center>
            <%
            }
        }
        else
      {
        %>
        <center><h1>Enter dates correctly</h1></center>
      <%
      }
      }
     else
      {
        %>
        <center><h1>Enter dates correctly</h1></center>
      <%
      }
    %>
    </body>
</html>
