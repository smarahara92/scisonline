<%-- 
    Document   : example
    Created on : Jan 6, 2012, 8:51:02 PM
    Author     : jagan
--%>
<%@page import ="javax.sql.*" %>
<%@page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page errorPage="error.jsp?msg=Application Generated an error!" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
         <%
          String stream=(String)request.getAttribute("name1");
        String year=(String)request.getAttribute("name2");
        String saveFile=(String)request.getAttribute("filename");
      try
      {
          File f1 = new File("/user/jagan/NetBeansProjects/AttendanceSystem/build/web/"+saveFile);
  File f2 = new File("/var/lib/mysql/dcis_attendance_system/"+saveFile);
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
          
     
    Class.forName("com.mysql.jdbc.Driver").newInstance();
    System.out.println("driver connected");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/dcis_attendance_system", "root", "");
    Statement st7=con.createStatement();
    Statement st8=con.createStatement();
    Statement st9=con.createStatement();
   
    String qry7="create table "+stream+"_"+year+"(StudentId varchar(20),StudentName varchar(50),primary key(StudentId))";
    System.out.println("creating MTech_CS_2011 table");
    st7.executeUpdate(qry7);
    
    String qry8="LOAD DATA INFILE '"+saveFile+"' INTO TABLE "+stream+"_"+year+" FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '\"' LINES TERMINATED BY '\n' (StudentId,StudentName)"; 
    st7.executeUpdate(qry8);    
     
    Class.forName("com.mysql.jdbc.Driver").newInstance();
    System.out.println("driver connected");
    //Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/dcis_attendance_system", "root", "");
    System.out.println("database connected");
    //String qry="create table temp(fid varchar(20))";
    String qry1="select * from "+stream+"_currrefer ";
   // String qry6="alter table mtechcs_2011 drop core0,drop core1,drop core2,drop core3,drop core4,drop core5,drop core6,drop core7,drop core8,drop core9,drop core10,drop core11,drop core12,drop core13,drop core14";
    
    Statement st1=con.createStatement();
    Statement st2=con.createStatement();
    //st2.executeUpdate(qry6);
    ResultSet rs=st1.executeQuery(qry1);
   // ResultSet rs1=st2.executeQuery(qry2);
    int total=0;
    int core=0;
    int electives=0;
    int labs=0;
    int project=0;
    int Sem1=0;
    int Sem2=0;
    int Sem3=0;
    int Sem4=0;
    int Sem5=0;
    int Sem6=0;
     while(rs.next())
     {
         if(rs.getString(1).equals("Sem1"))
                                 {
         Sem1=rs.getInt(2)+rs.getInt(3)+rs.getInt(4)+rs.getInt(5);
         }
         if(rs.getString(1).equals("Sem2"))
                                 {
         Sem2=rs.getInt(2)+rs.getInt(3)+rs.getInt(4)+rs.getInt(5);
         }
         if(rs.getString(1).equals("Sem3"))
                                 {
         Sem3=rs.getInt(2)+rs.getInt(3)+rs.getInt(4)+rs.getInt(5);
         }
         if(rs.getString(1).equals("Sem4"))
                                 {
         Sem4=rs.getInt(2)+rs.getInt(3)+rs.getInt(4)+rs.getInt(5);
         }
         if(rs.getString(1).equals("Sem5"))
                                 {
         Sem5=rs.getInt(2)+rs.getInt(3)+rs.getInt(4)+rs.getInt(5);
         }
         if(rs.getString(1).equals("Sem6"))
                                 {
         Sem6=rs.getInt(2)+rs.getInt(3)+rs.getInt(4)+rs.getInt(5);
         }
         
       }
    total=Sem1+Sem2+Sem3+Sem4+Sem5+Sem6;
    int i=1;
    while(i<=total)
               {
   //String qry7="alter table mtechcs_2011 drop subj"+i+"";
    //st2.executeUpdate(qry7);
    i++;
       }
    System.out.println(total);
    int k=total;
    i=1;
    String qry2="";
   while(k>0)
   {
        qry2="alter table "+stream+"_"+year+" add subj"+i+" varchar(20),add grade"+i+" varchar(10) ";
       st2.executeUpdate(qry2);
       i++;
       k--;
       
    
       
     }
    int total2=core+labs+project;
    String qry3="select column1 from "+stream+"_curriculam limit "+total+" offset 1";
    Statement st3=con.createStatement();
    ResultSet rs3=st3.executeQuery(qry3);
    i=1;
    while(rs3.next())
     {
        System.out.println(rs3.getString(1));
        String qry4="update "+stream+"_"+year+" set subj"+i+"='"+rs3.getString(1)+"'";
        st2.executeUpdate(qry4);
        i++;
       
         }
    
          }
       catch(Exception e)
           {
       e.printStackTrace();
   }
    %>
    <h1>Student Table created</h1>
    </body>
</html>
