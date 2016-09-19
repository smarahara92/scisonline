<%-- 
    Document   : faculties
--%>

<%@include file="checkValidity.jsp"%>
<%@include file="connectionBean.jsp"%>
<%@include file="programmeRetrieveBeans.jsp"%>
<%@page import="java.util.*"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <style type="text/css">
            .style30 {color: black}
            .style31 {color: white}
            .style32 {color: green}
            #div1 {
                width:100%;
            }
            .heading {
                color: white;
                background-color: #c2000d;
            }
            td,table {
                border-collapse:collapse;
                border: 1px solid green;
                white-space:nowrap;
                background-color: #F5F5F5;
                padding: 4px;
            }
            .td1 {
                text-align: center;
                color: blue;
            }
            .table1{

                border: 1px solid black;
                border-collapse: collapse;
            }

        </style>

    </head>
    <body> <%
        Connection con = conn.getConnectionObj(); %>
        <table align="center" border="1" >
            <caption><h2>Faculty-Information</h2></caption>
            <tr>
                <th class="heading">Faculty Code </th>
                <th class="heading">Faculty Name</th>
                <th class="heading">Organization</th>
            </tr> <%
            Statement st = con.createStatement();
            st.executeUpdate("create table if not exists faculty_data (ID varchar(20) not null,Faculty_Name varchar(30),Organization varchar(30),primary key(ID))");

            //ResultSet rs = scis.executeQuery("select * from faculty_data");
            ResultSet rs = scis.facultyList();
            int i = 1;
            while (rs.next()) { %>
                <tr>
                    <td><%=rs.getString(1)%></td>
                    <td><%=rs.getString(2)%></td>
                    <td><%=rs.getString(3)%></td>
                </tr> <%
                i++;
            } %>
        </table> <%
        con = null;
        conn.closeConnection();
        scis.close(); %>
    </body>
</html>
