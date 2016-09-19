<%-- 
    Document   : Q_GetSubjectWithF_15
    Created on : Apr 20, 2015, 3:00:27 PM
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
        
        // String id = request.getParameter("studentid");
        String id ="13MCMC38";
        Connection con = conn.getConnectionObj();
          int year =scis.studentBatchYear("id");
         String pname = scis.getStreamOfProgramme("id");
          
        System.out.println(pname +""+id);
       
        String stuname = scis.studentName(id);
        out.println(id+"-----"+year+"------"+pname+"-------"+stuname);
        int flag =0;
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
        try{
            int sno =1;
            Statement stmt1 = con.createStatement();
            Statement stmt2 = con.createStatement();
            ResultSet rs1 = null;
            ResultSet rs2 = null;
            String sql1 ="select * from "+pname+"_"+year+" where StudentId = '"+id+"'";
            rs1 = stmt1.executeQuery(sql1);
            ResultSetMetaData rsd = rs1.getMetaData();
            int column = rsd.getColumnCount();
            int i = 3 ;
            int j = 4;
            System.out.println(j +" "+i);
            while(rs1.next() ){
                while(j<column){
               String course = rs1.getString(i);
               String grade = rs1.getString(j);
              // out.println(course +" "+grade);
               if( !(course.equalsIgnoreCase(null)) && !(course.equalsIgnoreCase("NR")) ){
                   if(grade.equalsIgnoreCase("F")){
                      String sname =scis.subjectName(course);
                      System.out.println(course+"\t\t\t"+sname+"\t\t\t" +grade);
                      flag = 1;
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
            }
            if(flag == 0){%>
                <script>
                    alert("There is no subject with F grade");
                </script>
           <% }
        }catch(Exception e){
          System.out.println();  
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
