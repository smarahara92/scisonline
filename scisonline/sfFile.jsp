<%-- 
    Document   : sfFile
    Created on : Mar 12, 2012, 4:58:44 PM
    Author     : admin
--%>


<%@include file="checkValidity.jsp"%>
<%@page import="com.hcu.mysql.connection.ConnectionDemo3"%>
<%@page import="com.hcu.mysql.connection.ConnectionDemo1"%>
<%@page import="com.hcu.mysql.connection.ConnectionDemo2"%>
<%@page import="com.hcu.mysql.connection.ConnectionDemo"%>
<%@page import="java.io.OutputStream"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.File"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
        Statement st2=ConnectionDemo1.getStatementObj().createStatement();
        Statement st12=ConnectionDemo1.getStatementObj().createStatement();
        Statement st13=ConnectionDemo1.getStatementObj().createStatement();
        Statement st14=ConnectionDemo1.getStatementObj().createStatement();
        Statement st=ConnectionDemo2.getStatementObj().createStatement();
        Statement st10=ConnectionDemo2.getStatementObj().createStatement();
        Statement st1=ConnectionDemo3.getStatementObj().createStatement();
        Statement st11=ConnectionDemo3.getStatementObj().createStatement();
        
     Calendar now = Calendar.getInstance();
   
   /* System.out.println("Current date : " + (now.get(Calendar.MONTH) + 1)
                        + "-"
                        + now.get(Calendar.DATE)
                        + "-"
                        + now.get(Calendar.YEAR));*/
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
       // System.out.println("p1: "+p1+" p2: "+p2+" p3: "+p3);
        if(p2.equals("Jan"))
                       {
            p2=Integer.toString(01);
                       }
        //changing the data format 1 -> 01 for all single digit integers
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
          File f1 = new File("/home/admin/NetBeansProjects/AttendanceSystem/build/web/"+saveFile);
  File f2 = new File("/var/lib/mysql/dcis_automation/"+saveFile);
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
      /*    ConnectionDemo.getStatementObj().executeUpdate("delete from current_session1");
    ConnectionDemo.getStatementObj().executeUpdate("insert into current_session1 values('"+semester+"','"+session_date+"')"); 
    //update session semester date
    ResultSet rs = (ResultSet)ConnectionDemo.getStatementObj().executeQuery("");
    String date="insert into current_session1 values('"+semester+"','"+session_date+"');";
   //String date="update current_session1 set sessiont_date='"+session_date+"' session_name='"+semester+"'";
   // ConnectionDemo.getStatementObj().executeUpdate("delete from subject_faculty");
    ResultSet rs9 = (ResultSet)ConnectionDemo.getStatementObj().executeQuery("select Day(sessiont_date) from current_session1");
    
    String day="";
    
    while(rs9.next())
               {
        day=rs9.getString(1);
               }*/
  String day="2";
    st2.executeUpdate("create table if not exists subj_fac(subjectId varchar(50),facultyId varchar(50),primary key(subjectId,facultyId))");
    st2.executeUpdate("delete from subj_fac");
    st2.executeUpdate("LOAD DATA INFILE '"+saveFile+"' INTO TABLE subj_fac FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '\"' LINES TERMINATED BY '\n' (subjectId,facultyId)"); 
     
    //ConnectionDemo2.getStatementObj().executeUpdate("drop table subject_attendance");
    
    if(semester.equals("Winter"))
               {
        st.executeUpdate("create table if not exists subject_attendance(subjectId varchar(20),JAN"+day+"toJAN31 int(20),FEB1toFEB29 int(20),MAR1toMAR31 int(20),APR1toAPR30 int(20),cumatten int(20),primary key(subjectId))");
        
    }
       else if(semester.equals("Monsoon"))
                     {
           st.executeUpdate("create table if not exists subject_attendance(subjectId varchar(20),JULY15toAUG14 int(20),AUG15toSEP14 int(20),SEP15toOCT14 int(20),OCT15toNOV14 int(20),cumatten int(20),primary key(subjectId))");
           
       }
    //dropping previous semester tables;
    ResultSet rs10 = (ResultSet)st10.executeQuery("show tables like '"+semester+"_"+year+"_%'");
    
    while(rs10.next())
               {
               st.executeUpdate("drop table "+rs10.getString(1) +"");
               
    }
    ResultSet rs11 = (ResultSet)st11.executeQuery("show tables like '"+semester+"_"+year+"_%'");
    
    while(rs11.next())
               {
               st1.executeUpdate("drop table "+rs11.getString(1) +"");
               
    }
    
    ResultSet rs3 = (ResultSet)st12.executeQuery("select subjectId from subj_fac");
    
    while(rs3.next())
               {
        //insert data into the subject_attendance table
        
        st.executeUpdate("insert into subject_attendance values('"+rs3.getString(1)+"',0,0,0,0,0)");
        
      if(semester.equals("Winter"))
      {          
     st.executeUpdate("create table if not exists "+semester+"_"+year+"_"+rs3.getString(1)+"(StudentId varchar(20) not null,StudentName varchar(50),JAN"+day+"toJAN31 int(20),FEB1toFEB29 int(20),MAR1toMAR31 int(20),APR1toAPR30 int(20),cumatten int(20),percentage float,primary key(StudentId))");
     st1.executeUpdate("create table if not exists Assessment_"+semester+"_"+year+"_"+rs3.getString(1)+"(Reg_no varchar(20) not null,Name varchar(50),Minor_1 int(5),Minor_2 int(5),Minor_3 int(5),Major int(5),Final varchar(5),InternalMarks int(5),TotalMarks int(5),primary key(Reg_no))");
         }
      else
                   {
           st.executeUpdate("create table if not exists "+semester+"_"+year+"_"+rs3.getString(1)+"(StudentId varchar(20) not null,StudentName varchar(50),JULY15toAUG14 int(20),AUG15toSEP14 int(20),SEP15toOCT14 int(20),OCT15toNOV14 int(20),cumatten int(20),percentage float,primary key(StudentId))");
           st1.executeUpdate("create table if not exists Assessment_"+semester+"_"+year+"_"+rs3.getString(1)+"(Reg_no varchar(20) not null,Name varchar(50),Minor_1 int(5),Minor_2 int(5),Minor_3 int(5),Major int(5),Final varchar(5),InternalMarks int(5),TotalMarks int(5),primary key(Reg_no))");
             }
    //start loading data
      ResultSet rs4 = (ResultSet)st13.executeQuery("select semester from subject_data where subjId='"+rs3.getString(1)+"'");
      while(rs4.next())
                   {
          if(rs4.getString(1).equals("MCA-I"))
                   {
          int batch=year;
          ResultSet rs5 = (ResultSet)st14.executeQuery("select StudentId,StudentName from MCA_"+batch+"");
        
    while(rs5.next())
               {
        System.out.println("MCA subject:"+rs3.getString(1));
        st.executeUpdate("insert into "+semester+"_"+year+"_"+rs3.getString(1)+" values('"+rs5.getString(1)+"','"+rs5.getString(2)+"',0,0,0,0,0,0)");
        
        st1.executeUpdate("insert into Assessment_"+semester+"_"+year+"_"+rs3.getString(1)+" values('"+rs5.getString(1)+"','"+rs5.getString(2)+"',0,0,0,0,'NULL',0,0)");
        ConnectionDemo3.getStatementObj().close();
       }
          
      }
          else
      if(rs4.getString(1).equals("MCA-II"))
                   {
          int batch=year-1;
          ResultSet rs5 = (ResultSet)st14.executeQuery("select StudentId,StudentName from MCA_"+batch+"");
        
    while(rs5.next())
               {
        System.out.println("MCA subject:"+rs3.getString(1));
        st.executeUpdate("insert into "+semester+"_"+year+"_"+rs3.getString(1)+" values('"+rs5.getString(1)+"','"+rs5.getString(2)+"',0,0,0,0,0,0)");
        
        st1.executeUpdate("insert into Assessment_"+semester+"_"+year+"_"+rs3.getString(1)+" values('"+rs5.getString(1)+"','"+rs5.getString(2)+"',0,0,0,0,'NULL',0,0)");
        ConnectionDemo3.getStatementObj().close();
       }
          
      }
          else if(rs4.getString(1).equals("MCA-III"))
                   {
          int batch=year-1;
          ResultSet rs5 = (ResultSet)st14.executeQuery("select StudentId,StudentName from MCA_"+batch+"");
        
    while(rs5.next())
               {
        System.out.println("MCA subject:"+rs3.getString(1));
        st.executeUpdate("insert into "+semester+"_"+year+"_"+rs3.getString(1)+" values('"+rs5.getString(1)+"','"+rs5.getString(2)+"',0,0,0,0,0,0)");
        
        st1.executeUpdate("insert into Assessment_"+semester+"_"+year+"_"+rs3.getString(1)+" values('"+rs5.getString(1)+"','"+rs5.getString(2)+"',0,0,0,0,'NULL',0,0)");
        ConnectionDemo3.getStatementObj().close();
       }
          
      }
                   else if(rs4.getString(1).equals("MCA-IV"))
                   {
          int batch=year-2;
          ResultSet rs5 = (ResultSet)st14.executeQuery("select StudentId,StudentName from MCA_"+batch+"");
        
    while(rs5.next())
               {
        System.out.println("MCA subject:"+rs3.getString(1));
        st.executeUpdate("insert into "+semester+"_"+year+"_"+rs3.getString(1)+" values('"+rs5.getString(1)+"','"+rs5.getString(2)+"',0,0,0,0,0,0)");
        
        st1.executeUpdate("insert into Assessment_"+semester+"_"+year+"_"+rs3.getString(1)+" values('"+rs5.getString(1)+"','"+rs5.getString(2)+"',0,0,0,0,'NULL',0,0)");
        ConnectionDemo3.getStatementObj().close();
       }
          
      } else if(rs4.getString(1).equals("MCA-V"))
                   {
          int batch=year-2;
          ResultSet rs5 = (ResultSet)st14.executeQuery("select StudentId,StudentName from MCA_"+batch+"");
        
    while(rs5.next())
               {
        System.out.println("MCA subject:"+rs3.getString(1));
        st.executeUpdate("insert into "+semester+"_"+year+"_"+rs3.getString(1)+" values('"+rs5.getString(1)+"','"+rs5.getString(2)+"',0,0,0,0,0,0)");
        
        st1.executeUpdate("insert into Assessment_"+semester+"_"+year+"_"+rs3.getString(1)+" values('"+rs5.getString(1)+"','"+rs5.getString(2)+"',0,0,0,0,'NULL',0,0)");
        ConnectionDemo3.getStatementObj().close();
       }
          
      }
                   else if(rs4.getString(1).equals("MTech-CS-I"))
                   {
          int batch=year;
          ResultSet rs5 = (ResultSet)st14.executeQuery("select StudentId,StudentName from MTech_CS_"+batch+"");
        
    while(rs5.next())
               {
        
        st.executeUpdate("insert into "+semester+"_"+year+"_"+rs3.getString(1)+" values('"+rs5.getString(1)+"','"+rs5.getString(2)+"',0,0,0,0,0,0)");
        
        st1.executeUpdate("insert into Assessment_"+semester+"_"+year+"_"+rs3.getString(1)+" values('"+rs5.getString(1)+"','"+rs5.getString(2)+"',0,0,0,0,'NULL',0,0)");
        ConnectionDemo3.getStatementObj().close();
       }
          
      } else if(rs4.getString(1).equals("MTech-CS-II"))
                   {
          int batch=year-1;
          ResultSet rs5 = (ResultSet)st14.executeQuery("select StudentId,StudentName from MTech_CS_"+batch+"");
        
    while(rs5.next())
               {
        
        st.executeUpdate("insert into "+semester+"_"+year+"_"+rs3.getString(1)+" values('"+rs5.getString(1)+"','"+rs5.getString(2)+"',0,0,0,0,0,0)");
        
        st1.executeUpdate("insert into Assessment_"+semester+"_"+year+"_"+rs3.getString(1)+" values('"+rs5.getString(1)+"','"+rs5.getString(2)+"',0,0,0,0,'NULL',0,0)");
        ConnectionDemo3.getStatementObj().close();
       }
          
      } else if(rs4.getString(1).equals("MTech-AI-I"))
                   {
          int batch=year;
          ResultSet rs5 = (ResultSet)st14.executeQuery("select StudentId,StudentName from MTech_AI_"+batch+"");
        
    while(rs5.next())
               {
        
        st.executeUpdate("insert into "+semester+"_"+year+"_"+rs3.getString(1)+" values('"+rs5.getString(1)+"','"+rs5.getString(2)+"',0,0,0,0,0,0)");
        
        st1.executeUpdate("insert into Assessment_"+semester+"_"+year+"_"+rs3.getString(1)+" values('"+rs5.getString(1)+"','"+rs5.getString(2)+"',0,0,0,0,'NULL',0,0)");
        ConnectionDemo3.getStatementObj().close();
       }
          
      } else if(rs4.getString(1).equals("MTech-AI-II"))
                   {
          int batch=year-1;
          ResultSet rs5 = (ResultSet)st14.executeQuery("select StudentId,StudentName from MTech_AI_"+batch+"");
        
    while(rs5.next())
               {
        
        st.executeUpdate("insert into "+semester+"_"+year+"_"+rs3.getString(1)+" values('"+rs5.getString(1)+"','"+rs5.getString(2)+"',0,0,0,0,0,0)");
        
        st1.executeUpdate("insert into Assessment_"+semester+"_"+year+"_"+rs3.getString(1)+" values('"+rs5.getString(1)+"','"+rs5.getString(2)+"',0,0,0,0,'NULL',0,0)");
        ConnectionDemo3.getStatementObj().close();
       }
          
      } else if(rs4.getString(1).equals("MTech-IT-I"))
                   {
          int batch=year;
          ResultSet rs5 = (ResultSet)st14.executeQuery("select StudentId,StudentName from MTech_IT_"+batch+"");
        
    while(rs5.next())
               {
        
        st.executeUpdate("insert into "+semester+"_"+year+"_"+rs3.getString(1)+" values('"+rs5.getString(1)+"','"+rs5.getString(2)+"',0,0,0,0,0,0)");
        
        st1.executeUpdate("insert into Assessment_"+semester+"_"+year+"_"+rs3.getString(1)+" values('"+rs5.getString(1)+"','"+rs5.getString(2)+"',0,0,0,0,'NULL',0,0)");
        ConnectionDemo3.getStatementObj().close();
       }
          
      } else if(rs4.getString(1).equals("MTech-IT-II"))
                   {
          int batch=year-1;
          ResultSet rs5 = (ResultSet)st14.executeQuery("select StudentId,StudentName from MTech_IT_"+batch+"");
        
    while(rs5.next())
               {
        System.out.println("MCA subject:"+rs3.getString(1));
        st.executeUpdate("insert into "+semester+"_"+year+"_"+rs3.getString(1)+" values('"+rs5.getString(1)+"','"+rs5.getString(2)+"',0,0,0,0,0,0)");
        
        st1.executeUpdate("insert into Assessment_"+semester+"_"+year+"_"+rs3.getString(1)+" values('"+rs5.getString(1)+"','"+rs5.getString(2)+"',0,0,0,0,'NULL',0,0)");
        ConnectionDemo3.getStatementObj().close();
       }
          
      }
      
        }
    
       }
    ConnectionDemo1.getStatementObj().close();
    ConnectionDemo2.getStatementObj().close();
    ConnectionDemo3.getStatementObj().close();
out.println("<center><h1>File uploaded sucessfully</h1></center>");
     }
      catch(Exception e)
                           {
          e.printStackTrace();
      }
    %>
    </body>
</html>

<%/* if(rs3.getString(2).equalsIgnoreCase("MCA"))
               {
        
        ResultSet rs5 = (ResultSet)ConnectionDemo.getStatementObj().executeQuery("select StudentId,StudentName from MCA_"+rs3.getInt(3)+"");
        
    while(rs5.next())
               {
        System.out.println("MCA subject:"+rs3.getString(1));
        ConnectionDemo.getStatementObj().executeUpdate("insert into "+semester+"_"+year+"_"+rs3.getString(1)+" values('"+rs5.getString(1)+"','"+rs5.getString(2)+"',0,0,0,0,0,0)");
       // String qry6="update "+semester+"_"+year+"_"+rs3.getString(1)+" set StudentId='"+rs5.getString(1)+"',StudentName='"+rs5.getString(2)+"'";
    
       }
               }
               else if(rs3.getString(2).equalsIgnoreCase("CS"))
               {
        ResultSet rs5 = (ResultSet)ConnectionDemo.getStatementObj().executeQuery("select StudentId,StudentName from MTech_CS_"+rs3.getInt(3)+"");
        
    while(rs5.next())
               {
    ConnectionDemo.getStatementObj().executeUpdate("insert into "+semester+"_"+year+"_"+rs3.getString(1)+" values('"+rs5.getString(1)+"','"+rs5.getString(2)+"',0,0,0,0,0,0)");
    
       }
       }
    else if(rs3.getString(2).equalsIgnoreCase("AI"))
               {
        ResultSet rs5 = (ResultSet)ConnectionDemo.getStatementObj().executeQuery("select StudentId,StudentName from MTech_AI_"+rs3.getInt(3)+"");
        
    while(rs5.next())
               {
    ConnectionDemo.getStatementObj().executeUpdate("insert into "+semester+"_"+year+"_"+rs3.getString(1)+" values('"+rs5.getString(1)+"','"+rs5.getString(2)+"',0,0,0,0,0,0)");
    
       }
       }
    else if(rs3.getString(2).equalsIgnoreCase("IT"))
               {
        ResultSet rs5 = (ResultSet)ConnectionDemo.getStatementObj().executeQuery("select StudentId,StudentName from MTech_IT_"+rs3.getInt(3)+"");
        
    while(rs5.next())
               {
    ConnectionDemo.getStatementObj().executeUpdate("insert into "+semester+"_"+year+"_"+rs3.getString(1)+" values('"+rs5.getString(1)+"','"+rs5.getString(2)+"',0,0,0,0,0,0)");
    
       }
       }*/
%>