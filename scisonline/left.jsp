
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
        <script language="javaScript" type="text/javascript" src="calendar.js"></script>
<link href="calendar.css" rel="stylesheet" type="text/css">
<style>

    .myButton {
        
        -moz-box-shadow: 3px 4px 0px 0px #1564ad;
        -webkit-box-shadow: 3px 4px 0px 0px #1564ad;
        box-shadow: 3px 4px 0px 0px #1564ad;
        
        background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #79bbff), color-stop(1, #378de5));
        background:-moz-linear-gradient(top, #79bbff 5%, #378de5 100%);
        background:-webkit-linear-gradient(top, #79bbff 5%, #378de5 100%);
        background:-o-linear-gradient(top, #79bbff 5%, #378de5 100%);
        background:-ms-linear-gradient(top, #79bbff 5%, #378de5 100%);
        background:linear-gradient(to bottom, #79bbff 5%, #378de5 100%);
        filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#79bbff', endColorstr='#378de5',GradientType=0);
        
        background-color:#79bbff;
        
        -moz-border-radius:5px;
        -webkit-border-radius:5px;
        border-radius:5px;
        
        border:1px solid #337bc4;
        
        display:inline-block;
        color:#ffffff;
        font-family:arial;
        font-size:17px;
        font-weight:bold;
        padding:12px 44px;
        text-decoration:none;
        
        text-shadow:0px 1px 0px #528ecc;
        
    }
    .myButton:hover {
        
        background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #378de5), color-stop(1, #79bbff));
        background:-moz-linear-gradient(top, #378de5 5%, #79bbff 100%);
        background:-webkit-linear-gradient(top, #378de5 5%, #79bbff 100%);
        background:-o-linear-gradient(top, #378de5 5%, #79bbff 100%);
        background:-ms-linear-gradient(top, #378de5 5%, #79bbff 100%);
        background:linear-gradient(to bottom, #378de5 5%, #79bbff 100%);
        filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#378de5', endColorstr='#79bbff',GradientType=0);
        
        background-color:#378de5;
    }
    .myButton:active {
        position:relative;
        top:1px;
    }

</style>
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
    int sys_date=now.get(Calendar.DATE);  
    int sys_month=now.get(Calendar.MONTH)+1;
    int sys_year=now.get(Calendar.YEAR);
    String semester="";
    if(sys_month<=6)
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
     

     if((sy>sys_year)||(  (sy==sys_year) && (sm>=sys_month) && (sd>=sys_date) ))
     {
          
       if(sy<=ey)
        {
        if(sy==ey)
           {
             if(sm>=em)
               {
                  if(sm==em && sd<ed)
                   {
                      %>
                      
         <p align="center"> <a href="right1.jsp" target="right_f" class="myButton" style="height: 10px; width: 50px">New</a><br>
                  <p align="center"> <a href="#"  class="myButton" style="height: 10px; width: 50px">Modify</a><br>
                      <p align="center"> <a href="#" class="myButton "style="height: 10px; width: 50px">View</a><br>
                          <p align="center"> <a href="#" class="myButton" style="height: 10px; width: 70px">DeleteAll</a>
                  <%
                      //st1.executeUpdate("create table if not exists session(name varchar(20),start date,end date,primary key(name,start,end))");
                      //st1.executeUpdate("insert into session values('"+current_session+"','"+startdate+"','"+enddate+"')");
                      //st1.executeUpdate("drop table if exists "+semester+"_subjectfaculty");
                      //st1.executeUpdate("create table if not exists "+semester+"_subjectfaculty(subjectid varchar(20),facultyid1 varchar(20),facultyid2 varchar(20),primary key(subjectId))");
                      //st1.executeUpdate("delete from "+semester+"_subjectfaculty");
                      
                   }
                  else
                   {
                     %>
                      <script>
                       window.alert("Enter dates correctly");
                      </script>
        
                     <%
                   }
               }
             else
               {
                 %>
           <<p align="center"> <a href="right1.jsp"  target="right_f" class="myButton" style="height: 10px; width: 50px">New</a><br>
           <p align="center"> <a href="#"  class="myButton" style="height: 10px; width: 50px">Modify</a><br>
           <p align="center"> <a href="#"  class="myButton "style="height: 10px; width: 50px">View</a><br>
           <p align="center"> <a href="#"  class="myButton" style="height: 10px; width: 70px">DeleteAll</a>
                    <%
                      //st1.executeUpdate("drop table if exists session");
                      //st1.executeUpdate("create table if not exists session(name varchar(20),start date,end date,primary key(name,start,end))");
                      //st1.executeUpdate("insert into session values('"+current_session+"','"+startdate+"','"+enddate+"')");
                    //st1.executeUpdate("drop table if exists "+semester+"_subjectfaculty");
      //st1.executeUpdate("create table if not exists "+semester+"_subjectfaculty(subjectid varchar(20),facultyid1 varchar(20),facultyid2 varchar(20),primary key(subjectId))");
                     //st1.executeUpdate("delete from "+semester+"_subjectfaculty");
                     
               }
           } // == if
        else
           { 
            %>
          <p align="center"> <a href="right1.jsp" target="right_f"class="myButton" style="height: 10px; width: 50px">New</a><br>
                  <p align="center"> <a href="#"  class="myButton" style="height: 10px; width: 50px">Modify</a><br>
                      <p align="center"> <a href="#"  class="myButton "style="height: 10px; width: 50px">View</a><br>
                          <p align="center"> <a href="#" class="myButton" style="height: 10px; width: 70px">DeleteAll</a>
                   <%
        //    st1.executeUpdate("drop table if exists session");
           // st1.executeUpdate("create table if not exists session(name varchar(20),start date,end date,primary key(name,start,end))");
           // st1.executeUpdate("insert into session values('"+current_session+"','"+startdate+"','"+enddate+"')");
            // st1.executeUpdate("drop table if exists "+semester+"_subjectfaculty");
      //st1.executeUpdate("create table if not exists "+semester+"_subjectfaculty(subjectid varchar(20),facultyid1 varchar(20),facultyid2 varchar(20),primary key(subjectId))");
        //   st1.executeUpdate("delete from "+semester+"_subjectfaculty");
                 
           }
        }// < if
        else
      {%>
          <script>
        

        window.alert("Enter dates correctly");
        </script>
        
       
      <%
      }
           } 
     else
      {
        %>

                   <p align="center"> <a href="#" class="myButton" style="height: 10px; width: 50px">New</a><br>
                  <p align="center"> <a href="right2.jsp" target="right_f" class="myButton" style="height: 10px; width: 50px">Modify</a><br>
                      <p align="center"> <a href="right_view.jsp" target="right_f" class="myButton "style="height: 10px; width: 50px">View</a><br>
                          <p align="center"> <a href="right_delete.jsp" target="right_f" class="myButton" style="height: 10px; width: 70px">DeleteAll</a>  
             <%
      }
             }
    %>
   
    
 
 
      
 </body>
</html>
