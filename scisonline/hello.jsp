<%-- 
    Document   : hello
    Created on : Feb 29, 2012, 7:05:47 PM
    Author     : jagan
--%>

<%@page import="com.hcu.mysql.connection.ConnectionDemo"%>
<%@page import="com.mysql.jdbc.ResultSet"%>
<%@page import="com.mysql.jdbc.Statement"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        
        <%
            String table = "Winter_2012_AI773";
            String query1="select StudentId from "+table;
            
            ResultSet rs1 = (ResultSet)ConnectionDemo.getStatementObj().executeQuery(query1);
            String[] names = new String[100];
            int i=0;
            System.out.println("start*********");
            while(rs1.next())
                               {
                names[i] = rs1.getString(1);
                System.out.println(names[i]);
                i++;
            }
             System.out.println("stop*********");
            rs1.close();
            for(int j=0; j<names.length ; j++)
                           {
              
            ConnectionDemo.getStatementObj().executeUpdate("update "+table+" set StudentId = '"+names[j]+"' where StudentId='"+names[j]+"'");
           
                               }
                   
            
        %>
    </body>
</html>
