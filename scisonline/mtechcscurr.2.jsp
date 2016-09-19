<%-- 
    Document   : mtechcurr
    Created on : Dec 22, 2011, 3:06:53 PM
    Author     : jagan
--%>

<%@include file="checkValidity.jsp"%>
<%@page import ="javax.sql.*" %>
<%@page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        
        <%  
      //String stream=request.getParameter("stream");
      //String year=request.getParameter("year");
      String stream=(String)request.getAttribute("name1");
      System.out.println("stream------------------->>>>>>>>>:"+stream);
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
    Statement st1=con.createStatement();
    Statement st2=con.createStatement();
    Statement st3=con.createStatement();
    
    String qry0="drop table "+stream+"_curriculam";
    st1.executeUpdate(qry0);
    String qry1="create table "+stream+"_curriculam(column1 varchar(20),column2 varchar(20),column3 varchar(20),column4 varchar(20))";
    st1.executeUpdate(qry1);
    
    String qry2="LOAD DATA INFILE '"+saveFile+"' INTO TABLE "+stream+"_curriculam FIELDS TERMINATED BY ' ' OPTIONALLY ENCLOSED BY ' ' LINES TERMINATED BY '\n' (column1,column2,column3,column4)"; 
    st2.executeUpdate(qry2);    
     }
      catch(Exception e)
                           {
          e.printStackTrace();
      }
    %>
         <%
  int c1=0,c2=0,c3=0,c4=0,c5=0,c6=0;
 int l1=0,l2=0,l3=0,l4=0,l5=0,l6=0;
 int e1=0,e2=0,e3=0,e4=0,e5=0,e6=0;
int p1=0,p2=0,p3=0,p4=0,p5=0,p6=0;          
      
    try {
    Class.forName("com.mysql.jdbc.Driver").newInstance();
    System.out.println("driver connected");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/dcis_attendance_system", "root", "");
    System.out.println("database connected");
    //String qry="create table temp(fid varchar(20))";
    String qry1="select column2,count(*) from "+stream+"_curriculam group by column2";
   // String qry6="alter table mtechcs_2011 drop core0,drop core1,drop core2,drop core3,drop core4,drop core5,drop core6,drop core7,drop core8,drop core9,drop core10,drop core11,drop core12,drop core13,drop core14";
    
    Statement st1=con.createStatement();
    Statement st2=con.createStatement();
    Statement st4=con.createStatement();
    //st2.executeUpdate(qry6);
    ResultSet rs=st1.executeQuery(qry1);
   // ResultSet rs1=st2.executeQuery(qry2);
   if(stream.equals("MCA"))
             {
       System.out.println("with in mca loop:"+stream);
       //mca students update
     while(rs.next())
     { 
        if(rs.getString(1).equals("1c"))
                       {
        c1=rs.getInt(2);
        System.out.println(c1);
        String qryz="update "+stream+"_currrefer set core='"+c1+"' where Semester='Sem1' ";
        st4.executeUpdate(qryz);
        }
        
        if(rs.getString(1).equals("2c"))
                       {
        c2=rs.getInt(2);
        System.out.println(c2);
         String qryz="update "+stream+"_currrefer set core="+c2+" where Semester='Sem2' ";
        st4.executeUpdate(qryz);
        }
        if(rs.getString(1).equals("3c"))
                       {
        c3=rs.getInt(2);
        System.out.println(c3);
         String qryz="update "+stream+"_currrefer set core="+c3+" where Semester='Sem3' ";
        st4.executeUpdate(qryz);
        }
        if(rs.getString(1).equals("4c"))
                       {
        c4=rs.getInt(2);
        System.out.println(c4);
         String qryz="update "+stream+"_currrefer set core="+c4+" where Semester='Sem4' ";
        st4.executeUpdate(qryz);
        }
         if(rs.getString(1).equals("5c"))
                       {
        c5=rs.getInt(2);
        System.out.println("c5"+c5);
        String qryz="update "+stream+"_currrefer set core='"+c5+"' where Semester='Sem5' ";
        st4.executeUpdate(qryz);
        }
         if(rs.getString(1).equals("6c"))
                       {
        c6=rs.getInt(2);
        System.out.println("c6"+c6);
        String qryz="update "+stream+"_currrefer set core='"+c6+"' where Semester='Sem6' ";
        st4.executeUpdate(qryz);
        }
        if(rs.getString(1).equals("1l"))
                       {
        l1=rs.getInt(2);
        System.out.println(l1);
         String qryz="update "+stream+"_currrefer set lab="+l1+" where Semester='Sem1' ";
        st4.executeUpdate(qryz);
        }
        if(rs.getString(1).equals("2l"))
                       {
        l2=rs.getInt(2);
        System.out.println(l2);
         String qryz="update "+stream+"_currrefer set lab="+l2+" where Semester='Sem2' ";
        st4.executeUpdate(qryz);
        }
        if(rs.getString(1).equals("3l"))
                       {
        l3=rs.getInt(2);
        System.out.println(l3);
         String qryz="update "+stream+"_currrefer set lab="+l3+" where Semester='Sem3' ";
        st4.executeUpdate(qryz);
        }
        if(rs.getString(1).equals("4l"))
                       {
        l4=rs.getInt(2);
       System.out.println(l4);
         String qryz="update "+stream+"_currrefer set lab="+l4+" where Semester='Sem4' ";
        st4.executeUpdate(qryz);
        }
         if(rs.getString(1).equals("5l"))
                       {
        l5=rs.getInt(2);
        System.out.println("l5"+l5);
        String qryz="update "+stream+"_currrefer set lab='"+l5+"' where Semester='Sem5' ";
        st4.executeUpdate(qryz);
        }
         if(rs.getString(1).equals("6l"))
                       {
        l6=rs.getInt(2);
        System.out.println("l6"+l6);
        String qryz="update "+stream+"_currrefer set lab='"+l6+"' where Semester='Sem6' ";
        st4.executeUpdate(qryz);
        }
        //electives
        
if(rs.getString(1).equals("1e"))
                       {
        e1=rs.getInt(2);
        System.out.println(e1);
         String qryz="update "+stream+"_currrefer set elective="+e1+" where Semester='Sem1' ";
        st4.executeUpdate(qryz);
        }
        
        if(rs.getString(1).equals("2e"))
                       {
        e2=rs.getInt(2);
        System.out.println(e2);
         String qryz="update "+stream+"_currrefer set elective="+e2+" where Semester='Sem2' ";
        st4.executeUpdate(qryz);
        }
        if(rs.getString(1).equals("3e"))
                       {
        e3=rs.getInt(2);
        System.out.println(e3);
         String qryz="update "+stream+"_currrefer set elective="+e3+" where Semester='Sem3' ";
        st4.executeUpdate(qryz);
        }
        if(rs.getString(1).equals("4e"))
                       {
        e4=rs.getInt(2);
        System.out.println(e4);
         String qryz="update "+stream+"_currrefer set elective="+e4+" where Semester='Sem4' ";
        st4.executeUpdate(qryz);
        }
         if(rs.getString(1).equals("5e"))
                       {
        e5=rs.getInt(2);
        System.out.println("e5"+e5);
        String qryz="update "+stream+"_currrefer set elective='"+e5+"' where Semester='Sem5' ";
        st4.executeUpdate(qryz);
        }
         if(rs.getString(1).equals("6e"))
                       {
        e6=rs.getInt(2);
        System.out.println("e6"+e6);
        String qryz="update "+stream+"_currrefer set elective='"+e6+"' where Semester='Sem6' ";
        st4.executeUpdate(qryz);
        }
        //projects
        if(rs.getString(1).equals("1p"))
                       {
        p1=rs.getInt(2);
        System.out.println(p1);
         String qryz="update "+stream+"_currrefer set project="+p1+" where Semester='Sem1' ";
        st4.executeUpdate(qryz);
        }
        if(rs.getString(1).equals("2p"))
                       {
        p2=rs.getInt(2);
        System.out.println(p2);
        String qryz="update "+stream+"_currrefer set project="+p2+" where Semester='Sem2' ";
        st4.executeUpdate(qryz);
        }
        if(rs.getString(1).equals("3p"))
                       {
        p3=rs.getInt(2);
        System.out.println(p3);
        String qryz="update "+stream+"_currrefer set project="+p3+" where Semester='Sem3' ";
        st4.executeUpdate(qryz);
        }
        if(rs.getString(1).equals("4p"))
                       {
        p4=rs.getInt(2);
        System.out.println(p4);
        String qryz="update "+stream+"_currrefer set project="+p4+" where Semester='Sem4' ";
        st4.executeUpdate(qryz);
        }
 if(rs.getString(1).equals("5p"))
                       {
        p5=rs.getInt(2);
        System.out.println(p5);
        String qryz="update "+stream+"_currrefer set project='"+p5+"' where Semester='Sem5' ";
        st4.executeUpdate(qryz);
        }
         if(rs.getString(1).equals("6p"))
                       {
        p6=rs.getInt(2);
        System.out.println("p6"+p6);
        String qryz="update "+stream+"_currrefer set project='"+p6+"' where Semester='Sem6' ";
        st4.executeUpdate(qryz);
        }               
        
         
       }
         }
         else
         {
        System.out.println("with in mtech loop:"+stream);
        //mtech students update
            while(rs.next())
     { 
        if(rs.getString(1).equals("1c"))
                       {
        c1=rs.getInt(2);
        System.out.println("c1"+c1);
        String qryz="update "+stream+"_currrefer set core='"+c1+"' where Semester='Sem1' ";
        st4.executeUpdate(qryz);
        }
        
        if(rs.getString(1).equals("2c"))
                       {
        c2=rs.getInt(2);
        System.out.println(c2);
         String qryz="update "+stream+"_currrefer set core="+c2+" where Semester='Sem2' ";
        st4.executeUpdate(qryz);
        }
        if(rs.getString(1).equals("3c"))
                       {
        c3=rs.getInt(2);
        System.out.println(c3);
         String qryz="update "+stream+"_currrefer set core="+c3+" where Semester='Sem3' ";
        st4.executeUpdate(qryz);
        }
        if(rs.getString(1).equals("4c"))
                       {
        c4=rs.getInt(2);
        System.out.println(c4);
         String qryz="update "+stream+"_currrefer set core="+c4+" where Semester='Sem4' ";
        st4.executeUpdate(qryz);
        }
        if(rs.getString(1).equals("1l"))
                       {
        l1=rs.getInt(2);
        System.out.println(l1);
         String qryz="update "+stream+"_currrefer set lab="+l1+" where Semester='Sem1' ";
        st4.executeUpdate(qryz);
        }
        if(rs.getString(1).equals("2l"))
                       {
        l2=rs.getInt(2);
        System.out.println(l2);
         String qryz="update "+stream+"_currrefer set lab="+l2+" where Semester='Sem2' ";
        st4.executeUpdate(qryz);
        }
        if(rs.getString(1).equals("3l"))
                       {
        l3=rs.getInt(2);
        System.out.println(l3);
         String qryz="update "+stream+"_currrefer set lab="+l3+" where Semester='Sem3' ";
        st4.executeUpdate(qryz);
        }
        if(rs.getString(1).equals("4l"))
                       {
        l4=rs.getInt(2);
       System.out.println(l4);
         String qryz="update "+stream+"_currrefer set lab="+l4+" where Semester='Sem4' ";
        st4.executeUpdate(qryz);
        }
        
if(rs.getString(1).equals("1e"))
                       {
        e1=rs.getInt(2);
        System.out.println(e1);
         String qryz="update "+stream+"_currrefer set elective="+e1+" where Semester='Sem1' ";
        st4.executeUpdate(qryz);
        }
        
        if(rs.getString(1).equals("2e"))
                       {
        e2=rs.getInt(2);
        System.out.println(e2);
         String qryz="update "+stream+"_currrefer set elective="+e2+" where Semester='Sem2' ";
        st4.executeUpdate(qryz);
        }
        if(rs.getString(1).equals("3e"))
                       {
        e3=rs.getInt(2);
        System.out.println(e3);
         String qryz="update "+stream+"_currrefer set elective="+e3+" where Semester='Sem3' ";
        st4.executeUpdate(qryz);
        }
        if(rs.getString(1).equals("4e"))
                       {
        e4=rs.getInt(2);
        System.out.println(e4);
         String qryz="update "+stream+"_currrefer set elective="+e4+" where Semester='Sem4' ";
        st4.executeUpdate(qryz);
        }
        if(rs.getString(1).equals("1p"))
                       {
        p1=rs.getInt(2);
        System.out.println(p1);
         String qryz="update "+stream+"_currrefer set project="+p1+" where Semester='Sem1' ";
        st4.executeUpdate(qryz);
        }
        if(rs.getString(1).equals("2p"))
                       {
        p2=rs.getInt(2);
        System.out.println(p2);
        String qryz="update "+stream+"_currrefer set project="+p2+" where Semester='Sem2' ";
        st4.executeUpdate(qryz);
        }
        if(rs.getString(1).equals("3p"))
                       {
        p3=rs.getInt(2);
        System.out.println(p3);
        String qryz="update "+stream+"_currrefer set project="+p3+" where Semester='Sem3' ";
        st4.executeUpdate(qryz);
        }
        if(rs.getString(1).equals("4p"))
                       {
        p4=rs.getInt(2);
        System.out.println(p4);
        String qryz="update "+stream+"_currrefer set project="+p4+" where Semester='Sem4' ";
        st4.executeUpdate(qryz);
        }        
        
         
       }
        
        
         }
   
    
          }
       catch(Exception e)
           {
       e.printStackTrace();
   }
    %>
    <h1><center>Curriculam loaded</center></h1>
        
        <form action="Commonsfileuploadservlet" enctype="multipart/form-data" method="POST">
                    <input type="hidden" name="check" value="5" />
                    <table align="center" border="0" cellpadding="5" cellspacing="5">
                        <tr><td colspan="2"><center><h1>Upload Student File</h1></center></td></tr>
                        <tr>
                            <td>Stream:<input type="text" name="text1" value="<%=stream%>" readonly="readyonly"/></td>
                            <td>Year:<input type="text" name="text2" value="<%=year%>" readonly="readyonly"/></td>
                        </tr>
                        
                    <tr><td colspan="2" align="center"><input type="file" name="file1" />
			<input type="Submit" value="Upload File"><br></td></tr>
                    </table>
		</form>
    </body>
</html>
