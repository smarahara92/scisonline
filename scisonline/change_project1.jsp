<%-- 
    Document   : change_project1
    Created on : 21 Feb, 2013, 3:11:07 PM
    Author     : varun
--%>
<%@include file="checkValidity.jsp"%>
<%@page import="com.hcu.mysql.connection.ConnectionDemo1"%>
<%@page import="com.mysql.jdbc.ResultSet"%>
<%@page import="java.util.*"%>

<%@include file="dbconnection.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        
         <script type="text/javascript">
            function migrate()
            {
                 window.document.forms["form"].submit(); 
              
            }
        </script>
    </head>
    <body>
         <form  id="form" name="form" method="POST"  action="projectRegistrationInterns.jsp">
           <%
            String user= (String)session.getAttribute("user");
            int i=0;
           
            Statement st1=con.createStatement();
            Statement st2=con.createStatement();
            Statement st3=con.createStatement();
            
           
            while(i<6)
             {
            System.out.println("vpp");
           // String ptid = request.getParameter("pid"+Integer.toString(i)); 
            String sid = request.getParameter("sid"+Integer.toString(i));
          
            System.out.println(sid);
              
            Calendar now = Calendar.getInstance();
            int year=now.get(Calendar.YEAR);
            
            try
             {
                if(sid.equals("")!=true)
                 {
                   
                   st1.executeUpdate("delete from project"+"_"+"student"+"_"+"data where StudentId='"+sid+"'");
             
                          }
                %><script>
                        migrate();
                 </script><%
            }
            catch(Exception ex)
            {
                 ex.printStackTrace();
            }
            i++;
            }%>
        
       </form> 
    </body>
</html>
