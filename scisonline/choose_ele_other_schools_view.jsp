<%-- 
    Document   : choose_ele_other_schools_stored
--%>

<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.io.OutputStream"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.GregorianCalendar"%>
<%@page import="java.io.File"%>
<%@page import="java.sql.*"%>
<%@page import="com.mysql.jdbc.Statement"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@include file="connectionBean.jsp" %>
<%@include file="checkValidity.jsp"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style type="text/css">
            .pos_fixed
            {
                position:fixed;
                bottom:0px;
                background-color: #CCFFFF;
                border-color: red;
            }
            .head_pos
            {
                position:fixed;
                top:0px;
                background-color: #CCFFFF;
            }
            .menu_pos
            {
                position:fixed;
                top:105px;
                background-color: #CCFFFF;
            }
            .table_pos
            {
                top:300px;
            }
            .border
            {
                background-color: #c2000d;
            }
            .fix
            {   
                background-color: #c2000d;
                color: white;
            }
        </style>
    </head>
    <body>
<%
        Connection con = conn.getConnectionObj();
        String student_id = "";
        String elective_code = "";
        String grade_formula = "";
        String student_index = "sid";
        String column_index = "select";
        String given_session = request.getParameter("given_session");
        String given_year = request.getParameter("given_year");
        String student_name = "";
        
        Statement st5 = (Statement) con.createStatement();
        Statement st10 = (Statement) con.createStatement();
        ResultSet rs10 = null;
        ResultSet rs_cname = null;
%>
        <table align="center" border="1">
            
<%
            try {
                //StudentID varchar(20),Name varchar(100),Elective1 varchar(20),E1_Grade varchar(20),Elective2 varchar(20),E2_Grade varchar(20),Elective3 varchar(20),E3_Grade varchar(20),Elective4 varchar(20),E4_Grade varchar(20),Grade_Formula varchar(40),primary key(StudentID))");
                rs10 = (ResultSet) st10.executeQuery("select StudentID, Name ,Elective1,  Elective2, Elective3, Elective4, Grade_Formula from Other_Schools_" + given_session + "_" + given_year);
            } catch(Exception e) {
                System.out.println(e);
%>
            <h2><center>There are no electives to be registered for other schools</center></h2>
<%
                return;
            }
%>
            <tr class="fix">
                <th class="style31" align="center">Student ID</th>
                <th class="style31" align="center">Name</th>
                <th class="style31" align="center">Course 1</th>
                <th class="style31" align="center">Course 2</th>
                <th class="style31" align="center">Course 3</th>
                <th class="style31" align="center">Course 4</th>
                <th class="style31" align="center">Grade Formula</th>
            </tr>
<%
            while (rs10.next()) {
%>
                <tr>
                    <td><%=rs10.getString(1)%></td>
                    <td><%=rs10.getString(2)%></td>
<%
                    for(int j = 3; j <= 6; j++) {
                        rs_cname = st5.executeQuery(" select Subject_Name from  subjecttable where Code='" + rs10.getString(j) + "'");
                        if( rs_cname.next()) {
%>
                            <td><%=rs_cname.getString(1)%></td> 
<%
                        } else {
%>
                            <td>None</td>
<%
                        }
                    }
%>
                    <td><%=rs10.getString(7)%></td>
                </tr>
<%
            }
%>
        </table>
        <table width="100%" class="pos_fixed">
            <tr>
                <td align="center" class="border"> <input  type="button" class="border" value="Print" id="p1" style="width: 50px; color: white; background-color: #6d77d9; border-color: red;" class="noPrint" onclick="window.print();" />
                </td>
            </tr>
        </table>
<%
        rs10.close();
        rs_cname.close();
        
        st5.close();
        st10.close();
        
        conn.closeConnection();
        con = null;
%>        
    </body>
</html>