<%-- 
    Document   : studentadd_upload
--%>
<%@ include file="connectionBean.jsp" %>
<%@page import="java.sql.*"%>
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
            Connection con = conn.getConnectionObj();
            
            int v = 0;
            String year1 = request.getParameter("year2");
            String stream = request.getParameter("streamname");
            Statement st1 = con.createStatement();
            ResultSet rs1 = null;
            session.setAttribute("yearn", year1);
            session.setAttribute("pnamen", stream);


            try {
                stream = stream.replace('-', '_');
                String stream3 = stream.replace('_', '-');
                rs1 = st1.executeQuery("select * from " + stream + "_" + year1 + "");
                if (rs1.next()) {
                    v = 1;
                }rs1.beforeFirst();
        %>

        <% if (v == 1) {%>
        <script type="text/javascript">

            var r = confirm("Data already exist for this batch.Do you want to Redo?");
            if (r === true) {
                window.open('addingstudent.jsp', '_self', false);
            }

        </script> 

        <form name="frm3">

            <table align="center" border="1" >
                <caption><h3>Student data of <%=stream3%>-<%=year1%></h3></caption>
                <tr>

                    <th class="heading">Student Id </th>
                    <th class="heading"> Student Name</th>                    
                </tr> 
                <%
                    int i = 1;
                    while (rs1.next()) {
                %>
                <tr>

                    <td><%=rs1.getString(1)%></td>
                    <td><%=rs1.getString(2)%></td>
                </tr>

                <%
                        i++;
                    }
                %> 

            </table>

        </form>      


        <% }

            } catch (Exception e) {
                e.printStackTrace();
            }
        %>

        <%if (v != 1) {
        %>   
        <script type="text/javascript">


            window.open('addingstudent.jsp', '_self', false);


        </script> 
        <%}%>
        <%
        conn.closeConnection();
        con = null;
        %>
    </body>
</html>
