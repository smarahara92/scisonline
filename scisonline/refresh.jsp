<%-- 
    Document   : refresh
    Created on : 19 Nov, 2012, 4:55:28 PM
    Author     : laxman
--%>

<%@page import="com.hcu.mysql.connection.ConnectionDemo1"%>
<%@page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@include file="dbconnection.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
           Statement st1=con.createStatement();
           Statement st2=con.createStatement();
           //st1.executeUpdate("drop table if exists subject_data");
           //st1.executeUpdate("drop table if exists subjecttable");
          //st1.executeUpdate("drop table if exists subjectfaculty");
      //st1.executeUpdate("create table if not exists subjectfaculty(subjectid varchar(20),facultyid1 varchar(20),facultyid2 varchar(20),primary key(subjectId))");
    	
      //st1.executeUpdate("drop table if exists elective_table");
      //st1.executeUpdate("create table if not exists elective_table(course_name	varchar(50),MCA_I int(11),MCA_II int(11),MCA_III int(11),MCA_IV int(11),MCA_V int(11),MCA_VI int(11),MTech_CS_I	int(11),MTech_CS_II int(11),MTech_CS_III int(11),MTech_CS_IV int(11),MTech_AI_I	int(11),MTech_AI_II int(11),MTech_AI_III int(11),MTech_AI_IV int(11),MTech_IT_I int(11),MTech_IT_II int(11),MTech_IT_III int(11),MTech_IT_IV int(11),pre_req_1 varchar(45),pre_req_grade1 varchar(2),pre_req_2 varchar(45),pre_req_grade2 varchar(2),primary key(course_name))");
     
        %>
    </body>
</html>  