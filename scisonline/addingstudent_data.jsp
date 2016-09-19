<%-- 
    Document   : addSubject_link
    Created on : Dec 4, 2012, 12:12:33 PM
    Author     : root
--%>

<%@include file="checkValidity.jsp"%>
<%@page import="com.hcu.mysql.connection.ConnectionDemo1"%>
<%@include file="dbconnection.jsp"%>
<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@page import="java.lang.*"%>
<%@page import="java.util.regex.Matcher"%>
<%@page import="java.util.regex.Pattern"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body bgcolor="#CCFFFF">
        <%
          try
           {
           String sid[]=request.getParameterValues("stdid");
           String sname[]=request.getParameterValues("stdname");
           Class.forName("com.mysql.jdbc.Driver").newInstance();
           System.out.println("driver connected");
           //Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/dcis_attendance_system", "root", "");
           Statement st1=con.createStatement();
           Statement st2=con.createStatement();
           Statement st3=con.createStatement();
           st1.executeUpdate("create table if not exists subjecttable(Code varchar(20),Subject_Name varchar(100),credits varchar(20),type varchar(20),primary key(Code))");

           int count=0;
           for(int i=0;i<sid.length;i++)
                {
                  if(sid[i].equals("")==false&&sname[i].equals("")==false)
                    {
                       count++;
                        st1.execute("insert into subjecttable(Code,Subject_Name,credits,type)values('"+sid[i]+"','"+sname[i]+"','"+credits[i]+"','E')");
                    }
                }
           if(count==0)
                             {
                              %><center><h2> at least enter one subject details</h2></center> <%
                              }
           
                    else if(count!=0)
                        {
                              %><center><h1>details added successfully</h1></center> <%
                              }
           
           
           }
          catch(Exception e)
           {
             out.println(e);
           }
         %> 
    </body>
</html>
