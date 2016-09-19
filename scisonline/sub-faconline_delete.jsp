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
<%@include file="connectionBean.jsp" %>
<%@include file="checkValidity.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Assign Ellectives to Streams</title>
        <script type="text/javascript">
            function select(temp) {
                document.getElementById(temp).select();
            }
        </script>
        <style type="text/css">
            .style30 {color: #c2000d}
            .style31 {color: white}
            .style32 {color: green}
            .pos_fixed {
                position:fixed;
                bottom:0px;
                background-color: #CCFFFF;
                border-color: red;
            }
            .head_pos {
                position:fixed;
                top:0px;
                background-color: #CCFFFF;
            }
            .menu_pos {
                position:fixed;
                top:105px;
                background-color: #CCFFFF;
            }
            .table_pos {
                top:200px;
            }
            .border {
                background-color: #c2000d;
            }
            .fix {
                position:fixed;
                background-color: #c2000d;
            }
        </style>
    </head>
    <body bgcolor="#CCFFFF">
        <form >
<%
            Connection con = conn.getConnectionObj();
            Connection con1 = conn1.getConnectionObj();

            // #### drop session,subject-faculty mapping, attendance, assesment, electives , attendance mater table.

            String given_session = request.getParameter("current_session");
            String given_year = request.getParameter("year2");

            Calendar now = Calendar.getInstance();
            Statement st1 = (Statement) con.createStatement();
            Statement st2 = (Statement) con.createStatement();
            Statement st4 = (Statement) con.createStatement();
            Statement st5 = (Statement) con.createStatement();

            // for assessment con1
            Statement st9 = (Statement) con1.createStatement();
            Statement st11 = (Statement) con1.createStatement();
            try {
                st1.executeUpdate("drop table if exists  subject_faculty_" + given_session + "_" + given_year);
                st1.executeUpdate("drop table if exists " + given_year+"_"+given_session + "_elective");
                st2.executeUpdate("drop table if exists subject_attendance_" + given_session + "_" + given_year + "");
                 
                //dropping current semester tables if it already exists;
                //Attendance tables
                ResultSet rs4 = (ResultSet) st4.executeQuery("show tables like '%_Attendance_" + given_session + "_" + given_year + "'");

                while (rs4.next()) {
                    st5.executeUpdate("drop table " + rs4.getString(1) + "");
                }

                //Assessment tables
                ResultSet rs11 = (ResultSet) st11.executeQuery("show tables like '%_Assessment_" + given_session + "_" + given_year + "'");
                while (rs11.next()) {
                    st9.executeUpdate("drop table " + rs11.getString(1) + "");
                }
                
                //Delete entry in Session table
                st1.executeUpdate("delete from session where name = '" + given_session + "' and start like '" + given_year + "%'");
                rs4.close();
                rs11.close();
            } catch(Exception e) {
                    out.println(e);
            }
            st1.close();
            st2.close();
            st4.close();
            st5.close();
            st9.close();
            st11.close();
            conn.closeConnection();
            con = null;
            conn1.closeConnection();
            con1 = null;
%>
            <center><h1>Allocation Deleted: <%=given_session%>-<%=given_year%></h1></center>
        </form>      
    </body>
</html>