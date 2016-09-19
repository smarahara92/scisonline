<%-- 
    Document   : Display
    Created on : Feb 23, 2015, 4:17:53 PM
    Author     : richa
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ page import="java.sql.*" %>

<% Class.forName("sun.jdbc.odbc.JdbcOdbcDriver"); %>

<HTML>
    <HEAD>
        <TITLE>The ATTEN1 Database Table </TITLE>
    </HEAD>

    <BODY>
        <H1>The ATTEN1 Database Table </H1>

        <% 
             Class.forName("com.mysql.jdbc.Driver");
      
            Connection connection = DriverManager.getConnection(
                "jdbc:mysql://localhost/jdbc:odbc:data", "root", "");

            Statement statement = connection.createStatement() ;
            ResultSet resultset = 
                statement.executeQuery("select * from ATTEN1 ") ; 
        %>

        <TABLE BORDER="1">
            <TR>
                <TH>student_id</TH>
                <TH>student_name</TH>
                <TH>month1</TH>
                <TH>month2</TH>
                <TH>percentage</TH>
            </TR>
            <% while(resultset.next()){ %>
            <TR>
                <TD> <%= resultset.getString(1) %></td>
                <TD> <%= resultset.getString(2) %></TD>
                <TD> <%= resultset.getString(3) %></TD>
                <TD> <%= resultset.getString(4) %></TD>
                <TD> <%= resultset.getString(8) %></TD>
            </TR>
            <% } %>
        </TABLE>
    </BODY>
</HTML>