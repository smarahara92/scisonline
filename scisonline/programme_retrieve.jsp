<%-- 
    Document   : programme_retrieve
    Created on : Jan 27, 2014, 5:10:27 PM
    Author     : veeru
--%>
<%@include file="checkValidity.jsp"%>
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
            Statement st = con.createStatement();

            
            ResultSet rs = (ResultSet) st.executeQuery("select Programme_name from programme_table where Programme_status='1' and not programme_group='PhD'");


        %>
    </body>
</html>
