<%-- 
    Document   : Q_FINAL_READMIN1
    Created on : Mar 3, 2015, 12:32:14 PM
    Author     : richa
--%>

<%@include file="checkValidity.jsp"%>
<%@page import="com.hcu.mysql.connection.ConnectionDemo"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="connectionBean.jsp" %>
<%@page import="java.util.Calendar"%>
<%@page import="java.sql.*"%>


<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
         <link rel="stylesheet" href="./css/query_display_style.css">
         <%
         String StreamName = request.getParameter("pname");
         String BatchYear = request.getParameter("pyear");
%>    
      
                   
          </head>
    <body>
        
        <%
            
            
            String stream1 = StreamName;
            Connection con=null;
             String sql = null;
             int n =  0 ;
             int sno =1 ;
             String id = BatchYear.substring(2,4);
           int i= Integer.parseInt(id);
           StreamName = StreamName.replace('-', '_');
           try{  
                 con = conn.getConnectionObj();
                    ResultSet rs=null;
            Statement stmt =con.createStatement();
            Statement stmt1 =con.createStatement();
            sql ="select StudentId,StudentName FROM "+StreamName+"_"+BatchYear+" WHERE StudentId NOT LIKE '"+id+"MC%' ";
          
            rs =stmt.executeQuery(sql);
            if(!rs.next()){%>
                    <center><h3 style="color: red">There are no re-admission students in <font style="color:blue"><%= stream1%> <%=BatchYear%></font> batch</h3></center>
          <%  }
            else{ n++;%>
                    <center><h3 style="color:red"> List of all re-admission students in a particular stream and batch <h3></center>
              <center><h3 style="color: red">Stream: <font style="color:blue"><%=stream1 %></font>  Batch: <font style="color:blue"><%=BatchYear%></font></h3></center>
                <table align ='center' border="1" class = "maintable">
                                      <col width="15%">
                                     <col width="25%">  
                                    <col width="60%">
                                    
                 <tr>
                     <th  class="heading" align="center">SNo</th>
                      <th  class="heading" align="center">Student ID</th>
                      <th  class="heading" align="center">Student NAME</th>
                  </tr>
                      <tr>
                          <td class = "cellpad" ><%=sno++%></td>
                          <td class = "cellpad" ><%=rs.getString(1)%></td>
                          <td class = "cellpad" ><%=rs.getString(2)%></td>
               
      </tr>
     
        <%    while(rs.next()){
                n++;
                %>
              <tr>
                  <td class = "cellpad" ><%=sno++%></td>
                  <td class = "cellpad" ><%=rs.getString(1)%></td>
                  <td class = "cellpad"><%=rs.getString(2)%></td>
               </tr>
            <%}
           
            }

            
           }catch(Exception e){
              e.printStackTrace() ;
           }finally{
               conn.closeConnection();
               con = null ;
           }
          %>
          </table>
          <%if(n >0){
%>                 
<%}
          %>
                     </body>
                </html>