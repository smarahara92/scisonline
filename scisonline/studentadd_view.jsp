<%-- 
    Document   : studentadd_upload_view
--%>
<%@include file="connectionBean.jsp" %>
<%@page import="java.sql.*"%>
<%@page import="java.util.Calendar"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
            Connection con2 = conn2.getConnectionObj();
            
            int v = 0;

            String year1 = request.getParameter("year2");
            String stream = request.getParameter("streamname");
            Statement st1;
            Statement st3= null;
            if (stream.equalsIgnoreCase("PhD")) {
                st1 = con2.createStatement();
                st3 = con2.createStatement();
            } else {
                st1 = con.createStatement();
            }
            ResultSet rs1 = null;

            try {
                stream = stream.replace('-', '_');
                String stream3 = stream.replace('_', '-');
                rs1 = st1.executeQuery("select * from " + stream + "_" + year1 + "");
        %>
        <form name="frm3">
            <table align="center" border="1" >
                <caption align="center"><h3>Student data of <%=stream3%>-<%=year1%></h3></caption>
                <tr>
                    <th class="heading">Student ID </th>
                    <th class="heading">Student Name</th>                    
                </tr> 
                <%  
                    while (rs1.next()) {%>
                <tr>
                    <td><%=rs1.getString(1)%></td>
                    <%
                       if (stream.equalsIgnoreCase("PhD")) {
                        ResultSet rs2 = st3.executeQuery(" select StudentName from " + stream +"_Student_info_" + year1 + " where StudentId = '" + rs1.getString(1) + "'");
                       rs2.next();
                       
                       System.out.println("Name is: " +rs2.getString(1));
                    %>
                    <td><%=rs2.getString(1)%></td>
                    <%}
                    else
                    {%>
                        <td><%=rs1.getString(2)%></td>
                    
                   <% }%>
                </tr>
                <%
                    }%> 
            </table>
        <%
            } catch (Exception e) {
                out.println("<center><h1>Student data does not exist</h1></center>");
                e.printStackTrace();
            }
        conn.closeConnection();
        con = null;
        conn2.closeConnection();
        con2 = null;
        %>
        </form>
    </body>
</html>