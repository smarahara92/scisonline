<%-- 
    Document   : studentadd_addlink
    Created on : Aug 13, 2013, 11:23:40 AM
    Author     : veeru
--%>

<%@ include file="dbconnection.jsp" %>
<%@page import="java.sql.Statement"%>
<%@page import="java.util.Calendar"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <% int v=0;
            String year1=request.getParameter("year2");
            String stream=request.getParameter("streamname");
            String sid[]=request.getParameterValues("sid");
           String sname[]=request.getParameterValues("sname");
            Statement st1=con.createStatement();
            Statement st2=con.createStatement();
            Statement st3=con.createStatement();
            Statement st4=con.createStatement();
            ResultSet rs1=null;
            ResultSet rs2=null;
            ResultSet rs3=null;
            try{
              stream=stream.replace('-', '_');
              String stream3=stream.replace('_','-');
              rs1=st1.executeQuery("select * from "+stream+"_"+year1+"");
              rs2=st2.executeQuery("select * from "+stream+"_currrefer");
              }
                catch(Exception e){
              
                    e.printStackTrace();	
          }
            try{
            st3.executeUpdate("create table if not exists "+stream+"_"+year1+"(ProjectId int(5) NOT NULL AUTO_INCREMENT,ProjectTitle varchar(200),SupervisorId1 varchar(20),SupervisorId2 varchar(20),SupervisorId3 varchar(20),Organization varchar(30),Allocated varchar(10),primary key(ProjectId))");
            st4.executeUpdate("insert into  MCA_project"+"_"+year1+" (ProjectTitle,SupervisorId1,SupervisorId2,SupervisorId3,Organization,Allocated) values('"+ptid+"', '"+user+"', "+sid1+", "+sid2+", 'uoh','no')");

            
            }catch(Exception e){
                e.printStackTrace();
            }
          
                %>
          
    </body>
</html>
