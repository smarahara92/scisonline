<%-- 
    Document   : update1
    Created on : Nov 3, 2011, 11:00:10 AM
    Author     : admin
--%>
<%@include file="checkValidity.jsp"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.sql.*"%>
<%@ page import="java.io.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script>
            function display()
            { 
                var str1;
                var str2;
                var str;
                var str6;
                var i=9;
                var j=0;
               // str=document.frm.elements[1].value;
              //document.write(str);
               // document.write("<html><body>str</body></html>");
            var str3=eval(document.frm.elements[6].value);
            var str4=eval(document.frm.elements[7].value);
            var str5=str3 + str4;
            document.frm.elements[8].value=str5;
             while(document.frm.elements[i].value)
                    {
                       
                    //document.write(" ");
                    str1=eval(document.frm.elements[i].value);
                    str2=eval(document.frm.elements[i+1].value);
                    str=str1 + str2;
                    document.frm.elements[i+2].value=str;
                    str6=(str/str5)*100;
                    document.frm.elements[i+3].value=str6;
                
                i=i+4;
                    
                    }    
                  

                    
// some code

                   
                    
            }
            
            function display1()
  {
      if(document.frm.mySelect.options[0].selected)
      document.frm.mySelect1.options.selectedIndex=(0);
  
  if(document.frm.mySelect.options[1].selected)
      document.frm.mySelect1.options.selectedIndex=(1);
  
  if(document.frm.mySelect.options[2].selected)
      document.frm.mySelect1.options.selectedIndex=(2);
  
  if(document.frm.mySelect.options[3].selected)
      document.frm.mySelect1.options.selectedIndex=(3);
  
  if(document.frm.mySelect.options[4].selected)
      document.frm.mySelect1.options.selectedIndex=(4);

  }
        </script>
    </head>
        <body bgcolor="#E6E6FA">
            
            <h1>Welcome to update page</h1>
            <%
        String p1=(String)request.getAttribute("name1");
        String saveFile=(String)request.getAttribute("filename");
        System.out.println("this is p1"+p1);
        System.out.println("filename is:"+saveFile);
        String stream=(String)request.getAttribute("name1");
        String year=(String)request.getAttribute("name2");
        System.out.println("this is stream"+request.getAttribute("name1"));
        System.out.println("this is year"+request.getAttribute("name2"));
        String name=request.getParameter("text1");
        System.out.println("data from servlet----->"+name);
        %>
        <%
        try{
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
  in.close();
  out.close();
  System.out.println("File copied.");
  
        
            
           // String saveFile=(String) session.getAttribute("filename");
            System.out.println("filename in update1:"+saveFile);
            
           
                     
    Class.forName("com.mysql.jdbc.Driver").newInstance();
    System.out.println("driver connected");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/dcis_attendance_system", "root", "");
    System.out.println("database connected");
    String qry1="create table "+stream+"_"+year+"(StudentId varchar(20),StudentName varchar(50),primary key(StudentId))";
    //String qry="LOAD DATA INFILE '"+saveFile+"' INTO TABLE july_2011_"+subjectid+" FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '\"' LINES TERMINATED BY '\n' (StudentId,StudentName,"+from+"to"+to+")";
    String qry="LOAD DATA INFILE '"+saveFile+"' INTO TABLE temp1 FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '\"' LINES TERMINATED BY '\n' (StudentId,StudentName,column1)";
   // String qry12="LOAD DATA LOCAL INFILE 'temp.csv' INTO TABLE july_2011_"+subjectid+" FIELDS TERMINATED BY ' ' OPTIONALLY ENCLOSED BY ' ' LINES TERMINATED BY '\n' (StudentId,StudentName,JULY15toAUG14,AUG15toSEP14,SEP15toOCT14,OCT15toNOV14,cumatten,percentage)";
    //String qry1="delete from july_2011_"+subjectid+"";
    String qry9="select * from temp1";
    String qry7="delete from temp1";
    Statement st1=con.createStatement();
    Statement st5=con.createStatement();
    Statement st6=con.createStatement();
    st1.executeUpdate(qry1);
    st1.executeUpdate(qry7);
    st1.executeUpdate(qry);
    
    
    f1.delete();
    f2.delete();
    
             }
             
       
  catch(FileNotFoundException ex){
  System.out.println(ex.getMessage() + " in the specified directory.");
  System.exit(0);
  }
  catch(IOException e){
  System.out.println(e.getMessage());  
  }
        catch(Exception e)
             {
                 e.printStackTrace();
              }
  
        
       
      %>
        
    </body>
</html>
