<%-- 
    Document   : sub-facsuccess
    Created on : Feb 14, 2012, 10:04:06 PM
    Author     : jagan
--%>

<%@page import="java.io.OutputStream"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.File"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.sql.*"%>
<%@include file="checkValidity.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
     Calendar now = Calendar.getInstance();
   
    System.out.println("Current date : " + (now.get(Calendar.MONTH) + 1)
                        + "-"
                        + now.get(Calendar.DATE)
                        + "-"
                        + now.get(Calendar.YEAR));
    int month=now.get(Calendar.MONTH)+1;
    int year=now.get(Calendar.YEAR);
    String semester="";
    if(month==7 || month==8 || month==9 || month==10 || month==11 || month==12)
               {
   semester="Monsoon";
    }else if (month==1 || month==2 || month==3 || month==4 || month==5 || month==6)
               {
         semester="Winter";
    }
    String p1="";
    String p2="";
    String p3="";
        p1=(String)request.getAttribute("name1");
        p2=(String)request.getAttribute("name2");
        p3=(String)request.getAttribute("name3");
        if(p1.equals(null))
                       {
        p1="";
        p2="";
        p3="";
        }
        System.out.println("p1: "+p1+" p2: "+p2+" p3: "+p3);
        if(p2.equals("Jan"))
                       {
            p2=Integer.toString(01);
                       }
        if(p1.equals("1") || p1.equals("2") || p1.equals("3") || p1.equals("4") || p1.equals("5") || p1.equals("6") || p1.equals("7") || p1.equals("8") || p1.equals("9"))
                       {
            p1="0"+p1;
                       }
        String session_date="";
        if(p3.equals(""))
                       {}else
                       {
        
                       
         session_date=p3+"-"+p2+"-"+p1;
               
               }
        String saveFile=(String)request.getAttribute("filename");
        try
      {
          File f1 = new File("/user/jagan/NetBeansProjects/AttendanceSystem/build/web/files/"+saveFile);
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
    Statement st1=con.createStatement();
    Statement st2=con.createStatement();
    Statement st3=con.createStatement();
    Statement st4=con.createStatement();
    Statement st5=con.createStatement();
    Statement st9=con.createStatement();
    Statement st10=con.createStatement();
    Statement st11=con.createStatement();
    //update session semester date
    String qry0="delete from subject_faculty";
    st1.executeUpdate(qry0);
    String date="insert into current_session1 values('"+semester+"','"+session_date+"');";
   //String date="update current_session1 set sessiont_date='"+session_date+"' session_name='"+semester+"'";
    if(session_date.equals(""))
               {}else
                                     {
   st1.executeUpdate(date);
     }
    String qry1="delete from subject_faculty";
    st1.executeUpdate(qry1);
    String qry9="select Day(sessiont_date) from current_session1";  
    String day="";
    ResultSet rs9=st9.executeQuery(qry9);
    while(rs9.next())
               {
        day=rs9.getString(1);
               }
    
    String qry2="LOAD DATA INFILE '"+saveFile+"' INTO TABLE subject_faculty FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '\"' LINES TERMINATED BY '\n' (subjectid,subjectname,facultyid,core,batch)"; 
    st2.executeUpdate(qry2);   
    String qry7="drop table subject_attendance;";
    st1.executeUpdate(qry7);
    if(semester.equals("Winter"))
               {
        String qry8="create table subject_attendance(subjectId varchar(20),JAN"+day+"toJAN31 int(20),FEB1toFEB29 int(20),MAR1toMAR31 int(20),APR1toAPR30 int(20),cumatten int(20),primary key(subjectId))";
        st1.executeUpdate(qry8);
    }
       else if(semester.equals("Monsoon"))
                     {
           String qry8="create table subject_attendance(subjectId varchar(20),JULY15toAUG14 int(20),AUG15toSEP14 int(20),SEP15toOCT14 int(20),OCT15toNOV14 int(20),cumatten int(20),primary key(subjectId))";
           st1.executeUpdate(qry8);
       }
    //dropping tables;
    String qry10="show tables like '"+semester+"_"+year+"_%'";
    ResultSet rs10=st10.executeQuery(qry10);
    while(rs10.next())
               {
               String qry11="drop table "+rs10.getString(1) +"";
               st1.executeUpdate(qry11);
    }
    
    String qry3="select subjectid,core,batch from subject_faculty";
    ResultSet rs3=st3.executeQuery(qry3);
    while(rs3.next())
               {
        //insert data into the subject_attendance table
        //String qry9="insert into table values("+rs3.getString(1)+",0,0,0,0,0)";
        //st1.executeUpdate(qry9);
        String qry4="";
      if(semester.equals("Winter"))
      {          
     qry4="create table "+semester+"_"+year+"_"+rs3.getString(1)+"(StudentId varchar(20) not null,StudentName varchar(50),JAN"+day+"toJAN31 int(20),FEB1toFEB29 int(20),MAR1toMAR31 int(20),APR1toAPR30 int(20),cumatten int(20),percentage float,primary key(StudentId));";
       }
      else
                   {
           qry4="create table "+semester+"_"+year+"_"+rs3.getString(1)+"(StudentId varchar(20) not null,StudentName varchar(50),JULY15toAUG14 int(20),AUG15toSEP14 int(20),SEP15toOCT14 int(20),OCT15toNOV14 int(20),cumatten int(20),percentage float,primary key(StudentId));";
                   }
    try
                       {
    st4.executeUpdate(qry4);
       }
    catch(Exception e)
                           {
          //e.printStackTrace();
      }
    
    if(rs3.getString(2).equalsIgnoreCase("MCA"))
               {
        
        String qry5="select StudentId,StudentName from MCA_"+rs3.getInt(3)+"";
        ResultSet rs5=st5.executeQuery(qry5);
    while(rs5.next())
               {
        System.out.println("MCA subject:"+rs3.getString(1));
        String qry6="insert into "+semester+"_"+year+"_"+rs3.getString(1)+" values('"+rs5.getString(1)+"','"+rs5.getString(2)+"',0,0,0,0,0,0)";
       // String qry6="update "+semester+"_"+year+"_"+rs3.getString(1)+" set StudentId='"+rs5.getString(1)+"',StudentName='"+rs5.getString(2)+"'";
    try
                       {
    st1.executeUpdate(qry6);
       }
    catch(Exception e)
                           {
          e.printStackTrace();
      }
       }
               }
               else if(rs3.getString(2).equalsIgnoreCase("CS"))
               {
        String qry5="select StudentId,StudentName from MTech_CS_"+rs3.getInt(3)+"";
        ResultSet rs5=st5.executeQuery(qry5);
    while(rs5.next())
               {
    String qry6="insert into "+semester+"_"+year+"_"+rs3.getString(1)+" values('"+rs5.getString(1)+"','"+rs5.getString(2)+"',0,0,0,0,0,0)";
    st1.executeUpdate(qry6);
       }
       }
    else if(rs3.getString(2).equalsIgnoreCase("AI"))
               {
        String qry5="select StudentId,StudentName from MTech_AI_"+rs3.getInt(3)+"";
        ResultSet rs5=st5.executeQuery(qry5);
    while(rs5.next())
               {
    String qry6="insert into "+semester+"_"+year+"_"+rs3.getString(1)+" values('"+rs5.getString(1)+"','"+rs5.getString(2)+"',0,0,0,0,0,0)";
    st1.executeUpdate(qry6);
       }
       }
    else if(rs3.getString(2).equalsIgnoreCase("IT"))
               {
        String qry5="select StudentId,StudentName from MTech_IT_"+rs3.getInt(3)+"";
        ResultSet rs5=st5.executeQuery(qry5);
    while(rs5.next())
               {
    String qry6="insert into "+semester+"_"+year+"_"+rs3.getString(1)+" values('"+rs5.getString(1)+"','"+rs5.getString(2)+"',0,0,0,0,0,0)";
    st1.executeUpdate(qry6);
       }
       }
    
       }
out.println("<center><h1>File uploaded sucessfully</h1></center>");
     }
      catch(Exception e)
                           {
          e.printStackTrace();
      }
    %>
    </body>
</html>
