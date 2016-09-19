<%-- 
    Document   : phd_electives1
    Created on : Jun 6, 2013, 12:13:16 PM
    Author     : root
--%>
<%@include file="checkValidity.jsp"%>
<%@page import="java.io.*"%>
<%@page import ="javax.sql.*" %>
<%@page import="java.sql.*" %>
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
        String p1=(String)request.getAttribute("name1");
        String saveFile=(String)request.getAttribute("filename");
        try
      {
          //File f1 = new File("/home/laxman/NetBeansProjects/AttendanceSystem/build/web/"+saveFile);
     String realPath =getServletContext().getRealPath("/");
           //realPath=realPath+"/";
          File f1 = new File(realPath+saveFile);
    File f2 = new File("/var/lib/mysql/PhD/"+saveFile);
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
          
     
  
   
    Statement st1=con2.createStatement();
    Statement st2=con2.createStatement();
    Statement st3=con2.createStatement();
   
    //String qry1="delete from subject_database";
   // st1.executeUpdate(qry1);
    st1.executeUpdate("drop table if  exists PhD_electives");
    st1.executeUpdate("create table if not exists PhD_electives(subjectid varchar(20),subjectname varchar(100),shortcut varchar(20),primary key(subjectid))");
    String qry2="LOAD DATA INFILE '"+saveFile+"' INTO TABLE PhD_electives FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '\"' LINES TERMINATED BY '\n' (subjectid,subjectname,shortcut)"; 
    st2.executeUpdate(qry2);   
out.println("<center><h1>File uploaded sucessfully</h1></center>"); 
     }
      catch(Exception e)
                           {
          out.println("<center><h1>Problem in uploading file check again</h1></center>");
          e.printStackTrace();
      }
    %>
    </body>
</html>
