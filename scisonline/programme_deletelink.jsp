<%-- 
    Document   : programme_deletelink
    Created on : Oct 24, 2013, 3:09:52 PM
    Author     : veeru
--%>
<%@include file="checkValidity.jsp"%>
<%@page import ="javax.sql.*" %>
<%@page import="java.sql.*" %>
<%@include file="dbconnection.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            String pname1 = request.getParameter("pname");
            
            Statement st1 = con.createStatement();
            try {
                
                st1.executeUpdate("update programme_table SET Programme_status='0'  WHERE Programme_name= '"+pname1+"' ");
                out.println("<h2> "+pname1+" deleted sucssfully</h2>");
            } catch (Exception e) {
                
            }
        %>
<%
    st1.close();
    try {
        con.close();
        con1.close();
        con2.close();
    } catch(Exception e) {
        System.out.println(e);
    } finally {
        con.close();
        con1.close();
        con2.close();
    }
%>
    </body>
</html>
