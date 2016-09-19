<%-- 
    Document   : StudentDb
    Created on : Apr 28, 2015, 10:38:47 AM
    Author     : richa
--%>
<%@page import ="javax.sql.*" %>
<%@include file="connectionBean.jsp"%>
<%@page import ="java.sql.*" %>
<%@include file="programmeRetrieveBeans.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
         <link rel="stylesheet" href="./css/query_display_style.css">
   
    </head>
   
    <body>
        <%
        // String pname ="MCA";
        // int year = 2014;
       // String id ="13MCMt16";
        String id= request.getParameter("studentid").trim().toUpperCase();
          //   String id = request.getParameter("studentid");
                if (id.equals("none")) {
                    out.println("<center><h3>please select student id</h3></center>");
                }
         int year = scis.studentBatchYear(id);
         //out.println(year);
         if(year==0) {
             %>
        
        <center><h3 style="color:red">Invalid Student ID</h3></center>
        
        <%
             return;
         }
         String pname = scis.studentProgramme(id);
         if(pname == null) {
             %>
        
        <center><h3 style="color:red">Invalid Student ID</h3></center>
        
        <%
             return;
         }
        // out.println(pname+"---"+year+""+id);
        Connection con = conn.getConnectionObj();
        String stuname = scis.studentName(id);
        if(stuname == null) {
             %>
        
        <center><h3 style="color:red">Student ID doesn't exist</h3></center>
        
        <%
             return;
         }
        
        int flag =0;
        int n = 1;
        %>
    
                                   
        <%
        try{
            int sno =1;
            Statement stmt1 = con.createStatement();
            Statement stmt2 = con.createStatement();
            ResultSet rs1 = null;
            ResultSet rs2 = null;
            String sql1 ="select * from "+pname.replace('-', '_')+"_"+year+" where StudentId = '"+id+"'";
            rs1 = stmt1.executeQuery(sql1);
            if(!(rs1.next())) {
                %>
        <center><h3 style="color:red">Student ID not found</h3></center>
        <%
            }
            ResultSetMetaData rsd = rs1.getMetaData();
            int column = rsd.getColumnCount();
            int i = 3 ;
            int j = 4;
            System.out.println(j +" "+i); 
%>
 
<%            
            do {
                while(j<column){
               String course = rs1.getString(i);
               String grade = rs1.getString(j);
              // out.println(course +" "+grade);
               if( !(course.equalsIgnoreCase(null)) && !(course.equalsIgnoreCase("NR")) ){
                   if(grade.equalsIgnoreCase("F")){
                      String sname =scis.subjectName(course);
                      System.out.println(course+"\t\t\t"+sname+"\t\t\t" +grade);
                      flag = 1;
                      if ( n==1){
%>                  
    <center><h3 style="color:red">List of all subjects that a student has failed</h3></center>
    <center><h3 style="color:red">Student Id: <font style="color: blue"><%=id%></font><br>Student Name: <font style="color: blue"><%=stuname%></font></h3></center>
         <table align ='center' border="1" class = "maintable">
                                      <col width="15%">
                                     <col width="25%">  
                                    <col width="60%">
                                    <tr>
         <th class="heading" align="center">SNo</th>
       <th class="heading" align="center">Subject Id </th>
      <th class="heading" align="center">Subject Name</th>
  
      </tr>
                                    
<%
                        n++;
                      } 
%>
                 <tr>
                 <td class = "cellpad" ><%=sno++%></td>
                <td class = "cellpad" ><%=course%></td>
                <td class = "cellpad" ><%=sname%></td>     
                  <%    
                   }
               }
               i +=2;
               j+=2;
            }
            } while(rs1.next() );
            if(flag == 0){%>
                
                <center><h3 style="color: red"><font style="color: blue"><%=stuname%></font> is not failed in any subject </h3></center>
           <% }
        }catch(Exception e){
          out.println();  
        }finally{
            scis.close();
            conn.closeConnection();
            con = null;
        }
                %>
                </tr>
                </table>
    </body>
</html>
