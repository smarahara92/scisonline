<%-- 
    Document   : Display
    Created on : 23 Feb, 2015, 8:26:24 PM
    Author     : richa
--%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.sun.org.apache.xalan.internal.xsltc.runtime.Hashtable"%>
<%@page import="javax.sound.midi.SysexMessage"%>
<%@page import="java.util.Calendar"%>
<%@page import ="javax.sql.*" %>
<%@page import ="java.sql.*" %>
<jsp:useBean id="prog" class="com.hcu.scis.automation.GetProgramme" scope="session">
</jsp:useBean>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" type="text/css" href="print.css" media="print" />
        <style type="text/css">
            
            .style30 {color: #c2000d}
            .style31 {color: white}
            .style32 {color: green}
            .heading
            {
                color: white;
                background-color: #c2000d;
            }
            .border
            {
                background-color: #c2000d;
            }
            .pos_fixed
            {
                position:fixed;
                bottom:0px;
                background-color: #CCFFFF;
                border-color: red;
            }
            #bold{
                font-weight: bold;
            }
            @media print {

                .noPrint
                {
                    display:none;
                }
            } 

<% String subjectname = request.getParameter("subjectname");%>
        </style>
        <link rel="stylesheet" type="text/css" href="table_css.css">
        
     
    <center><h2 style="color:red"> List of Students who have less than 75% attendance  <h2></center>
    </br></br>
   
  <table align ='center'>
  <tr><th><font color='WHITE'>Student ID</font></th>
      <th><font color='WHITE'>Student NAME</font></th>
      <th><font color='WHITE'>REMARKS</font></th>
  </tr>
    </head>
    <body>
        
        <%
            ArrayList<String> result=new ArrayList<String>();
            System.out.println("name"+subjectname);
             Connection con=null;
           try{  
            Class.forName("com.mysql.jdbc.Driver");
           
                    con = DriverManager.getConnection
                ("jdbc:mysql://localhost/dcis_attendance_system","root","");
                    ResultSet rs=null;
            Statement stmt =con.createStatement();
            Statement stmt1 =con.createStatement();
            if(subjectname.equals("MCA")){
            rs=stmt.executeQuery("select *  from  TEMP_ATTEN where student_id LIKE '%MCMC%' ");
            }
            else if(subjectname.equals("MTech-CS"))
            {
                 rs=stmt.executeQuery("select *  from  TEMP_ATTEN where student_id LIKE '%MCMT%' ");
            }
             else if(subjectname.equals("MTech-IT"))
            {
                 rs=stmt.executeQuery("select *  from  TEMP_ATTEN where student_id LIKE '%MCMB%' ");
            }
             else if(subjectname.equals("MTech-AI"))
            {
                 rs=stmt.executeQuery("select *  from  TEMP_ATTEN where student_id LIKE '%MCMI%' ");
            }
             else if(subjectname.equals("IMTech"))
            {
                 rs=stmt.executeQuery("select *  from  TEMP_ATTEN where student_id LIKE '%MCME%' ");
            }
            while(rs.next()){
                 String Id=rs.getString("student_id");
                 String Name=rs.getString("student_name");
                
                  %>
                <tr>
                <td><b><font color='#663300'><%=Id%></font></b></td>
                <td><b><font color='#663300'><%=Name%></font></b></td>
                 <td><b><font color='#663300'>
                <% 
                    for( int i = 1;i<=10 ;i++  ){
                    
                    int j = 2+2*i-1;
                    String c = rs.getString(j);   
                    String p = rs.getString(j+1);
                       if ( c==null){
                           break ;
                       }
                       else{
                           out.println(c+":"+p + " ");
                       }
                    
                }
                  
                %>
                </font></b></td>
                
                </tr>
                
                <%
                  }%>
             </table><br>
             <table align ='center'>
                <tr><th><font color='WHITE'>Subject ID</font></th>
                <th><font color='WHITE'>Subject NAME</font></th>
                </tr>
        <%
        String sql2="select a.subjectId,b.Subject_Name  from subject_attendance_Winter_2015 a JOIN subjecttable b where a.subjectId = b.code ";
        ResultSet rs1 = stmt1.executeQuery(sql2);
        while(rs1.next()){%>
            <tr>
                <td><b><font color='#663300'><%=rs1.getString(1)%></font></b></td>
                <td><b><font color='#663300'><%=rs1.getString(2)%></font></b></td>
                </tr>
        <%}
            
           }catch(Exception e){
               e.printStackTrace();
           }finally{
               con.close();
           }
                 %>
           </table>     
                
                   <div align="center">
        <input type="button" value="Print" id="p1" class="noPrint" onclick="window.print();" />
            </div>
                     </body>
                </html>
            
         
   