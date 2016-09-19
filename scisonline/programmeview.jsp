<%-- 
    Document   : programmeview
    Created on : Oct 22, 2013, 12:40:03 PM
    Author     : veeru
--%>
<%@include file="checkValidity.jsp"%>
<%@ include file="dbconnection.jsp" %>
<%@page import="java.sql.Statement"%>
<%@page import="java.util.Calendar"%>
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
            try {
                Statement st1 = con.createStatement();
                ResultSet rs1;
                rs1 = st1.executeQuery("select * from programme_table");
        %>
        <form name="frm3">
            <div id="div1">
                <table class="table1" align="center" border="1">
                    <caption><h2>Programmes</h2></caption>
                    <tr>
                        <th class="heading">Programme Name</th>
                        <th class="heading">Programme Code</th>
                        <th class="heading">Programme Status</th>
                    </tr> 
                    <%
                        String pname;

                        while (rs1.next()) {

                            int pname1 = Integer.parseInt(rs1.getString(3));
                            if (pname1 == 1) {
                                pname = "ACTIVE";

                    %>
                    <tr>
                        <td><%=rs1.getString(1)%></td>
                        <td align="center"><%=rs1.getString(2)%></td>
                        <td align="center"><%=pname%></td>
                    </tr>
                    <% } else {
                        pname = "DELETED";
                    %>
                    <tr>
                        <td><%=rs1.getString(1)%></td>
                        <td align="center"><%=rs1.getString(2)%></td>
                        <td class="td1"><%=pname%></td>
                    </tr>
                    <%
                            }
                        }%> 
                </table>
            </div>
        </form>      
        <%
            rs1.close();
            st1.close();
        } catch (Exception e) {
        %>
        <table border="0" align="center">
            <tbody>
                <tr>
                    <td><h1>Add Programmes...</h1></td>
                </tr>
            </tbody>
        </table>
        <% }
        %>
        <%
            try {
                con.close();
                con1.close();
                con2.close();
            } catch(Exception e) {
                System.out.println();
            } finally {
                con.close();
                con1.close();
                con2.close();
            }
        %>
    </body>
</html>
