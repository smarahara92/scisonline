<%-- 
    Document   : Q_ShortAtten2_15
    Created on : Mar 16, 2015, 2:40:56 PM
    Author     : richa
--%>

<%@include file="checkValidity.jsp"%>
<%@page import="com.hcu.mysql.connection.ConnectionDemo1"%>
<%@page import="java.util.*"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <style>
            .style30 {color: #c2000d}
            .style31 {color: white}
            .style32 {color: green}
        </style>
        
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Insert title here</title>
    </head>
    <body bgcolor="#CCFFFF">

        <table>

            <tr>
                <td> <font color="#c2000d"><b>Choose By</b></font></td> 

                <td> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                    <input type="radio" id="r" name="r" value="faculty"  onclick="to(this.value);"  >Subject </td>
                <td> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="radio" id="r" name="r" value="stream"  onclick="to(this.value);"  >Stream </td>
               

            </tr>           

        </table>

    </body>
</html>
