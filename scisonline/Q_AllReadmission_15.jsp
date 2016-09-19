<%-- 
    Document   : Q_AllReadmission_15
    Created on : 17 Apr, 2015, 8:17:46 PM
    Author     : richa
--%>
<%@include file="checkValidity.jsp"%>
<%@page import="com.hcu.mysql.connection.ConnectionDemo"%>
<%@ include file="connectionBean.jsp" %>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="./css/query_display_style.css">
              
        <center><h3 style="color:red"> List of all re-admission students across all streams and batches <h3></center>
    </head>
    <body>
        
        <%
             Connection con=null;
             try{
                 int n = 1;
                 con = conn.getConnectionObj();
                 Statement stmt1 =null ;
              Statement stmt2 = null;
              ResultSet rs2 = null;
              ResultSet rs1 = null;
              String sql2 ="";
              int i =1;
              int sno =1;
              String course ="";
              String batchyear ="";
              String id="";
              String pyear="";
              String cid ="";
              stmt1 =con.createStatement();
              stmt2=con.createStatement();
              String sql ="Select * from active_batches ";
              rs1 = stmt1.executeQuery(sql);
              %>
              <table align ='center' border="1" class = "maintable">
                                      <col width="15%">
                                     <col width="25%">  
                                    <col width="60%">
                                    
                 <tr>
                     <th  class="heading" align="center">SNo</th>
                      <th  class="heading" align="center">Student ID</th>
                      <th  class="heading" align="center">Student NAME</th>
                  </tr>
              <% while(rs1.next()){
                  course = rs1.getString(1);
                  batchyear = rs1.getString(2);
               // out.println(course);
                  id = batchyear.substring(2,4);
              //    out.println(id);
              if(course.equalsIgnoreCase("mtech") && i <4){
                      switch(i){
                          case 1 : cid =course+"_CS";
                                 //out.println(cid);
                                  break ;
                          case 2 : cid = course+"_AI";
                                   //out.println(cid);
                                  
                                  break ;
                          case 3 : cid = course+"_IT";
                                   //out.println(cid);
                                  
                                  break ;
                      }i++;
                      sql2="select StudentId,StudentName FROM "+cid+"_"
                              +batchyear+" WHERE StudentId NOT LIKE '"+id+"MC%'";
                      rs2 =stmt2.executeQuery(sql2);
                      while(rs2.next()){
                             n++;
                //          out.print(rs2.getString(1));
                  //        out.println("\t\t"+rs2.getString(2));%>
                          <tr>
                          <td class = "cellpad" ><%=sno++%></td>
                          <td class = "cellpad" ><%=rs2.getString(1)%></td>
                          <td class = "cellpad" ><%=rs2.getString(2)%></td>
               
      </tr>
                      <%}
                  }
                  else{
                      sql2="select StudentId,StudentName from "+course+"_"+batchyear+" where StudentId NOT LIKE '"+id+"MC%'";
                      rs2 =stmt2.executeQuery(sql2);
                      while(rs2.next()){
                    //     out.print(rs2.getString(1)+"\t\t");
                      //   out.println(rs2.getString(2));%>
                        <tr>
                          <td class = "cellpad" ><%=sno++%></td>
                          <td class = "cellpad" ><%=rs2.getString(1)%></td>
                          <td class = "cellpad" ><%=rs2.getString(2)%></td>
               
      </tr>  
                      <%}
                  }
                  
                //  System.out.println(i);
              }
              if(n == 1){
%>
<center><h3>There are no re-admission students </h3></center>
<%
              }
             }catch(Exception e){
                 System.out.println(e);
             }finally{
                 conn.closeConnection();
                 con = null;
             }
        %>
    </body>
</html>
