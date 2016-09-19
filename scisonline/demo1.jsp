<%-- 
    Document   : demo1
    Created on : Nov 15, 2011, 6:59:30 AM
    Author     : admin
--%>
<%@include file="checkValidity.jsp"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.sql.*"%>
<%@include file="dbconnection.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
        String subjectid=(String) session.getAttribute("subjid");
        String sname=(String) session.getAttribute("subjname");
        String tclasses2=request.getParameter("tclasses");
        int tclasses1=Integer.parseInt(request.getParameter("tclasses"));
        
        System.out.println("demo1 page:"+tclasses1);
        System.out.println("demo1 page:"+tclasses2);
                   
   try {
    
   String qry2="select * from july_2011_"+subjectid+"";
   // String qry4="select attendance from subject_database where Code='"+subjectid+"'";
    //String qry5="select StudentId,StudentName,cumatten,percentage from july_2011_"+subjectid+" ";
    Statement st2=con.createStatement();
    Statement st3=con.createStatement();
    //Statement st4=con.createStatement();
   ResultSet rs=st3.executeQuery(qry2);    
   // ResultSet rs1=st2.executeQuery(qry5);
   // ResultSet rs2=st4.executeQuery(qry2);
    
       %>
       <br/>
    <center><b>Total number of classes:</b><input type="text" name="tclasses" value="<%=request.getParameter("tclasses")%>" readonly="readonly" /></center><br/>
       <table border="1" cellspacing="10" cellpadding="10" style="color:blue;background-color:#CCFFFF;" align="center">
    <tr>
        <th>StudentID</th>
        <th>StudentName</th>
        <th>Cumulative Attendance</th>
        <th>Overall Percentage</th>
      
    </tr>
    
    
    <% while(rs.next())
     {
        %>
        <tr>
            <td><%=rs.getString(1)%></td>
            <td><%=rs.getString(2)%></td>
            <% int l=(rs.getInt(3)+rs.getInt(4)+rs.getInt(5)+rs.getInt(6));
            %>
            <td><%=l%></td>
            <% float k=(float)l/tclasses1;
            System.out.println(k);
            k=k*100;
        %>
            <td><%=k%> </td>
        </tr>
       <%
       String qry5="update july_2011_"+subjectid+" set cumatten='"+l+"', percentage='"+k+"' where StudentId='"+rs.getString(1)+"' ";
       st2.executeUpdate(qry5);
             }
       %> 
        
    
</table>
       
      <%
             }
             catch(Exception e)
             {
                 e.printStackTrace();
                                 }
%>
    </body>
</html>
