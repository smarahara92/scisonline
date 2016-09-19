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
     Connection con = conn.getConnectionObj();
     int year = scis.getLatestYear();
     int flag = 0;
     String StreamName = request.getParameter("pname");
     String BatchYear = request.getParameter("pyear");
     String stream = StreamName.replace("-", "_");
      out.println(StreamName+"   "+BatchYear+"  %%"+stream);
      try{
          Statement stmt1 = con.createStatement();
          Statement stmt2 = con.createStatement();
          Statement stmt3 = con.createStatement();
          ResultSet rs1 = null;
          ResultSet rs2 = null;
          ResultSet rs3 = null;
          String Sql1 = "";
          String Sql2 = "";
          String Sql3 = "";
          String id =""; //student id
          String name = "";
          String sid =""; //subject id
          String sname ="";
          String sgrade ="";
          int i = 4;
          int sno =1;
%>
          <table  align="center" border="1" class = "maintable">
                                        <col width="10%">
                                    <col width="15%">
                                     <col width="25%">  
                                    <col width="50%">   
                             <tr>
                                                             <tr>
         <th class="heading" align="center">SNo</th>
       <th class="heading" align="center">Subject Id </th>
      <th class="heading" align="center">Subject Name</th>
  
      </tr>
<%          Sql1 = "select * from "+stream+"_"+BatchYear;
          rs1 =stmt1.executeQuery(Sql1);
          ResultSetMetaData rsmd = rs1.getMetaData();
          int colmn = rsmd.getColumnCount();
          while(rs1.next()){
              i = 4;
              id  = rs1.getString(1);
              name = rs1.getString(2);
              sid = rs1.getString(i-1);
              sgrade = rs1.getString(i);
%>
<tr>
                            <td class = "cellpad"><%=sno++%></td>
                             <td class = "cellpad"><%=id%></td>
                             <td class = "cellpad"><%=name%></td>
                             
                   </tr>
<%
              while(i<colmn){
                  if(sgrade.equalsIgnoreCase("F")){
                      flag = 1;
%>

<%
                  }
                  i+=2;
              }
          }
      }catch(Exception ex){
          System.out.println(ex);
      }finally{
          scis.close();
          conn.closeConnection();
          con = null;
      }
 %>
     
 </body>    