<%-- 
    Document   : studentinfo2
    Created on : 18 May, 2014, 8:04:00 PM
    Author     : srinu
--%>

<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@page import="java.io.OutputStream"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.GregorianCalendar"%>
<%@page import="java.io.File"%>
<%@page import="com.hcu.mysql.connection.ConnectionDemo3"%>
<%@page import="com.hcu.mysql.connection.ConnectionDemo1"%>
<%@page import="com.hcu.mysql.connection.ConnectionDemo"%>
<%@page import="java.sql.*"%>
<%@page import="com.mysql.jdbc.Statement"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@include file="dbconnection.jsp" %>
<%@include file="checkValidity.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>


        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title></title>
        <style type="text/css">
            .style30 {color: black}
            .style31 {color: white}
            .style32 {color: green}

            #div1
            {

                width:100%;
            }
            .pos_fixed
            {
                position:fixed;
                bottom:0px;
                background-color: #CCFFFF;
                border-color: red;
            }
            .border
            {
                background-color: #c2000d;
            }
            .heading
            {
                color: white;
                background-color: #c2000d;
            }
            td,table
            {
                border-collapse:collapse;
                border: 1px solid green;
                white-space:nowrap;
                background-color: #F5F5F5;
                padding: 4px;
            }
            .td1{
                text-align: center;
                color: blue;
            }
            .table1{

                border: 1px solid black;
                border-collapse: collapse;

            }

        </style>

    </head>

    <body bgcolor="#CCFFFF">
        <%
            /**
             * ****************************************************************************
             * Get year , and retrive that batch information from the
             * PhD_Student_info_year
             *
             ******************************************************************************
             */
            String selected_year = request.getParameter("selected_year");
            String r_id[] = request.getParameterValues("id");
            String r_name[] = request.getParameterValues("name");
            String r_caddr[] = request.getParameterValues("ca");
            String r_paddr[] = request.getParameterValues("pa");
            String r_mail[] = request.getParameterValues("mail");
            String r_cell[] = request.getParameterValues("cell");
            String r_land[] = request.getParameterValues("landline");
            String r_gender[] = request.getParameterValues("gender");


            Statement st1 = (Statement) con2.createStatement();
            Statement st2 = (Statement) con2.createStatement();
            Statement st3 = (Statement) con2.createStatement();
            Statement st4 = (Statement) con2.createStatement();
            System.out.println(" total" + r_id.length);
            for (int k = 0; k < r_id.length; k++) {

                //System.out.println(r_id[k]+" total"+r_id.length);
                st1.executeUpdate("update PhD_Student_info_" + selected_year + " set Caddress ='" + r_caddr[k] + "', Paddress ='" + r_paddr[k] + "',Email='" + r_mail[k] + "', Cell_number ='" + r_cell[k] + "', Landline ='" + r_land[k] + "', Gender ='" + r_gender[k] + "' where StudentId='" + r_id[k] + "'");

            }
        %>
        <table align="center" border="1" >
            <caption><h2>Student-Information</h2></caption>

            <th class="heading" ><b>Student ID</b></th>
            <th class="heading" ><b>Student Name</b></th>
            <th class="heading">Current Address</th>
            <th class="heading">Permanent Address</th>
            <th class="heading">Email</th>
            <th class="heading">Cell</th>
            <th class="heading">Land Line</th>
            <th  class="heading">Gender</th>


            <%
                for (int k = 0; k < r_id.length; k++) {
            %>
            <tr>
                <td align="left"><%=r_id[k]%></td>
                <td align="left"><%=r_name[k]%></td>
                <td align="left"><%=r_caddr[k]%></td>
                <td align="left"><%=r_paddr[k]%></td>
                <td align="left"><%=r_mail[k]%></td>
                <td align="left"><%=r_cell[k]%></td>
                <td align="left"><%=r_land[k]%></td>
                <td align="left"><%=r_gender[k]%></td>
            </tr>

            <%  }
            %>          




        </table>

        <table width="100%" class="pos_fixed">
            <tr>
                <td align="center" class="border"> <input  type="button" class="border" value="Print" id="p1" style="width: 50px; color: white; background-color: #6d77d9; border-color: red;" class="noPrint" onclick="window.print();" />
                </td>
            </tr>
        </table>       
    </body>
</html>
