<%-- 
    Document   : listofstudents_imp
    Created on : May 27, 2013, 11:44:14 PM
    Author     : root
--%>

<%@include file="checkValidity.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.Calendar"%>
<%@ include file="dbconnection.jsp" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style type="text/css">
          
    @media print {
       
        .noPrint
        {
            display:none;
        }
    }
    </style>
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
    int cyear=now.get(Calendar.YEAR);
    String semester="",suptable="";
    if(month<=6)
          {
           semester="Winter";
           }
    else
         { 
          semester="Monsoon";
         }
        
    suptable="imp_"+semester+"_"+cyear;
  Statement st1=con.createStatement();   
  Statement st2=con.createStatement();   
 try
    {              
   ResultSet rs1=st1.executeQuery("select * from "+suptable+"");
   ResultSetMetaData rsmd = rs1.getMetaData();
   int noOfColumns = rsmd.getColumnCount();   
   %>
      <center>
                <center><b>University of Hyderabad</b></center>
        <center><b>School of Computer and Information Sciences</b></center>
        <center><b>List of students registered for improvement</b></center> 
         </br>
          
        
        <table border="1" cellspacing="5" cellpadding="5" style="color:blue;background-color:#CCFFFF;" align="center">
        <tr>
            
            <th>Student ID</th>
            <th colspan="6">Registered subjects</th>
          </tr>       
       <%
         while(rs1.next())
         {
         int k=2;
       %><tr><td><%=rs1.getString(1)%></td><%  
          while(k<noOfColumns)
           {
             if(rs1.getString(k)!=null)
              {
               ResultSet rs2=st2.executeQuery("select * from subjecttable where Code='"+rs1.getString(k)+"'");
               rs2.next();
               String subname=rs2.getString(2);
             %>  <td><%=subname%></td><%
              }
             else
              {
              
              }
             k=k+3;
           }
          %></tr><%
         }
      }
   catch(Exception e)
       {
        out.println("<center><h2>Data not found</h2></center>");
       }
       %>
       
        </br>
    </br>
   <table align="center" cellspacing="20"><tr><td><div align="center">
    <input type="button" value="Print" id="p1" style="width: 50px; color: white; background-color: #6d77d9; border-color: red;" class="noPrint" onclick="window.print();" />
</div>
        </td>
   </table>  
    </body>
</html>
