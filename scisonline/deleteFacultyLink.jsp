<%-- 
    Document   : deleteFacultyLink
    Created on : 17 Nov, 2012, 6:57:03 PM
    Author     : varun
--%>

<%@include file="checkValidity.jsp"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.hcu.mysql.connection.ConnectionDemo1"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.Calendar"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
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
    int year=now.get(Calendar.YEAR);
    String semester="";
    if(month<=6)
     {
       semester="Winter";
     }
     else
     {
       semester="Monsoon";
     }
         String faculty=request.getParameter("sel");
         session.setAttribute("oldfaculty",faculty);
         Statement st1=ConnectionDemo1.getStatementObj().createStatement();
         Statement st2=ConnectionDemo1.getStatementObj().createStatement();
         ResultSet rs= st1.executeQuery("Select * from subjecttable where Code in(Select subjectid from "+semester+"_subjectfaculty where facultyid1 in (Select ID from faculty_data where Faculty_Name='"+faculty+"') or facultyid2 in (Select ID from faculty_data where Faculty_Name='"+faculty+"') )");
         //ResultSet rs= st1.executeQuery("Select * from subjecttable where Code in(Select subjectid from subjectfaculty as a,faculty_data as b where facultyid1 in (Select ID from faculty_data where Faculty_Name='"+faculty+"'))");
         //ResultSet rs1=st2.executeQuery("Select subjectname from subject_faculty where subjectid in '"+rs.getString(1)+"'");
        // System.out.println("varun");
         if(faculty.equals("none")==true)
            
             {%>
                         <h1> Please enter a valid faculty name. </h1>
             <%}
         
         
          else
             {%>
             <form action="deleteFacultyLink1.jsp" name="form">
                
                 <h3>You have selected faculty &nbsp<%= faculty%>.</h3> 
                 <%if(rs.next())
                   {
                 %>
                 <b>The faculty is teaching subject(s)</b> <br><br>
                 <%try
                 {//rs.beforeFirst();
                     int rowcount = 0;
                     if (rs.last()) 
                    {
                     rowcount = rs.getRow();
                     rs.beforeFirst(); 
                     System.out.println(rowcount+"v");
                    }
                     
                     HashMap<String,String> hmap = new HashMap<String,String>();
                     ArrayList a=new ArrayList(100);
                     //rs.beforeFirst();
                     
                     while(rs.next())
                 
                     {
                       hmap.put(rs.getString(1),rs.getString(2));
                       a.add(rs.getString(1));%>
                       
                       <table border="1" width="400">
                        <tr >
                       <td width="auto"><%=rs.getString(1)%></td>
                       <td><%=rs.getString(2)%> <br></td>
                       </tr>
                       </table>  
                       
                     <%}
                    
                     session.setAttribute("arraylist",a);
                     session.setAttribute("hashmap",hmap);
                    
                     System.out.println(hmap);
                     
                 }
                 catch(Exception ex)
                 {
                     ex.printStackTrace();
                 }
                  %>
                     <br><br>
                     <input type="submit" value="OK">
            
              </form>
             
             
             
            <%}
                    else{%>
                        <b>The faculty is not teaching subject(s).</b> <br><br>
                   <% }
          }%>
                        
                 
         
         
         
       
       
    </body>
</html>
