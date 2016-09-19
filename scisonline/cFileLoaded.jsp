<%-- 
    Document   : cFileLoaded
    Created on : Mar 12, 2012, 10:32:18 AM
    Author     : admin
--%>

<%@include file="checkValidity.jsp"%>
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
        System.out.println("jjjjjjjjjj");
        String stream1=(String)request.getAttribute("name1");
      System.out.println("stream------------------->>>>>>>>>:"+stream1);
      //  String year=(String)request.getAttribute("name2");
        String saveFile=(String)request.getAttribute("filename");
        String stream="";
        if(stream1.equals("MTech-CS"))
      stream="MTech_CS";
   else if(stream1.equals("MTech-AI"))
      stream="MTech_AI";
   else if(stream1.equals("MTech-IT"))
      stream="MTech_IT";
   else if(stream1.equals("MCA"))
      stream="MCA";
   else
       stream="PhD";   
        
    String database="";
        if(stream.equals("PhD"))
            database="PhD";
        else
            database="dcis_attendance_system";     
        
        try
      {
          //File f1 = new File("/home/laxman/NetBeansProjects/AttendanceSystem/build/web/"+saveFile);
              String realPath =getServletContext().getRealPath("/");
           //realPath=realPath+"/";
          File f1 = new File(realPath+saveFile);
            
            File f2 = new File("/var/lib/mysql/"+database+"/"+saveFile);
  InputStream in = new FileInputStream(f1);
  
  //For Append the file.
//  OutputStream out = new FileOutputStream(f2,true);

  //For Overwrite the file.
  OutputStream out1 = new FileOutputStream(f2);

  byte[] buf = new byte[1024];
  int len;
  while ((len = in.read(buf)) > 0){
  out1.write(buf, 0, len);
  }
  
  
  
  System.out.println("File copied.");
     
    
   if(stream.equals("PhD")!=true)
           {
        Statement st1=con.createStatement();
  Statement st2=con.createStatement();
   // ResultSet rs = (ResultSet)ConnectionDemo.getStatementObj().executeQuery("select StudentId, StudentName from "+stream_table+"");
    try
       {
     
     st1.executeUpdate("drop table if exists "+stream+"_curriculum");
    // st1.executeUpdate("drop table if exists subject_data");
       }
    catch(Exception e)
                       {}
    st1.executeUpdate("create table if not exists "+stream+"_curriculum(subjId varchar(20),subjName varchar(100),Credits varchar(20),Semester varchar(20),Alias varchar(20),Sno int(10),primary key(Sno))");
    st1.executeUpdate("create table if not exists subject_data(subjId varchar(20),subjName varchar(100),credits int(20),semester varchar(20),primary key(subjId))"+"");
    st1.executeUpdate("create table if not exists subjecttable(Code varchar(20),Subject_Name varchar(100),credits varchar(20),type varchar(20),primary key(Code))"); 
    System.out.println("File copied.");
    st1.executeUpdate("LOAD DATA INFILE '"+saveFile+"' INTO TABLE "+stream+"_curriculum FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '\"' LINES TERMINATED BY '\n' (subjId,subjName,Credits,Semester,Alias,Sno)");
    
    ResultSet rs = st1.executeQuery("select * from "+stream+"_curriculum limit 1");
    rs.next();
    int limit=Integer.parseInt(rs.getString(1))+Integer.parseInt(rs.getString(2))+Integer.parseInt(rs.getString(3));
    System.out.println(limit);
     Statement st3=con.createStatement(); 
    ResultSet rs1 = st3.executeQuery("select * from "+stream+"_curriculum limit "+limit+" offset 1");
    int i=0;
    while(rs1.next())
               {
         System.out.println(rs1.getString(5));
        //System.out.println(limit);
        if(rs1.getString(5)!=null)
          {
            st1.executeUpdate("insert into subject_data values('"+rs1.getString(5)+"','"+rs1.getString(2)+"',"+rs1.getString(3)+",'"+stream1+"-"+rs1.getString(4)+"')");  
            st1.executeUpdate("insert into subjecttable values('"+rs1.getString(5)+"','"+rs1.getString(2)+"',"+rs1.getString(3)+",'C')");  
        }
        else 
          {
       st1.executeUpdate("insert into subject_data values('"+rs1.getString(1)+"','"+rs1.getString(2)+"',"+rs1.getString(3)+",'"+stream1+"-"+rs1.getString(4)+"')");
       st1.executeUpdate("insert into subjecttable values('"+rs1.getString(1)+"','"+rs1.getString(2)+"',"+rs1.getString(3)+",'C')");  
         //System.out.println(++i);      
           }  
        }
    
    }
  
   else
    {
   Statement st1=con2.createStatement();
   System.out.println("Llllll");
    st1.executeUpdate("drop table if exists "+stream+"_curriculum");  
    st1.executeUpdate("create table if not exists "+stream+"_curriculum(subjId varchar(20),subjName varchar(100),primary key(subjId))");
    st1.executeUpdate("LOAD DATA INFILE '"+saveFile+"' INTO TABLE "+stream+"_curriculum FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '\"' LINES TERMINATED BY '\n' (subjId,subjName)");   
    }
    
      %>
      
    <center><h1><%=stream%> Curriculum loaded</h1></center>
        <% 
        
     }
      catch(Exception e)
                           {
          out.println("<center><h1>"+stream+" Curriculum not loaded successfully</h1></center>");
         // e.printStackTrace();
      }
    %>
        
        
        
        
    </body>
</html>
