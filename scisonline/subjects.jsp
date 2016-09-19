<%-- 
    Document   : subjects
--%>

<%@page import="java.util.*"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.Calendar"%>
<%@include file="connectionBean.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style type="text/css">
            .style30 {color: black}
            .style31 {color: white}
            .style32 {color: green}

            #div1
            {

                width:100%;
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
    <body>
        <%
            Connection con = conn.getConnectionObj();
        %>

        <table align="center" border="1" >
            <caption><h2>Subject-Information</h2></caption>
            <tr>

                <th class="heading">Subject Code </th>
                <th class="heading"> Subject Name</th>
                <th class="heading"> Type</th>
                <th class="heading">Credits </th>

            </tr> 

            <%
                Calendar now = Calendar.getInstance();
                int year = now.get(Calendar.YEAR);

                Statement st1 = con.createStatement();

                ResultSet rs1 = null;

                rs1 = (ResultSet) st1.executeQuery("select * from subjecttable");


                int i = 1;
                while (rs1.next()) {
            %>
            <tr>

                <td><%=rs1.getString(1)%></td>
                <td><%=rs1.getString(2)%></td>
                <%if(rs1.getString(4).equalsIgnoreCase("c")){%>
                <td>Core</td>
                <%}else if(rs1.getString(4).equalsIgnoreCase("E")){%>
                <td>Elective</td>
                <%}else{%>
                <td>Optional Core</td>
                <%}%>
                
                <td><%=rs1.getString(3)%></td>
            </tr>

            <%
                    i++;
                }
            %>
        </table>  
        <%
                conn.closeConnection();
                con = null;
        %>

    </body>
</html>
