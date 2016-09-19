<%-- 
    Document   : GradeFormula1
    Created on : 12 Apr, 2012, 11:17:29 AM
    Author     : khushali
--%>
<%@page import = "javax.sql.*" %>
<%@page import =  "java.sql.*" %>
<%@ include file="dbconnection.jsp" %>
<%@page errorPage="error.jsp?msg=Application Generated an error!" %>
<%@include file="checkValidity.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>

        <link rel="stylesheet" type="text/css" href="table_css.css">

        <style type="text/css">

            @media print {

                .noPrint
                {
                    display:none;
                }
            }

        </style>
    </head>
    <body>
        <%
            String stream = (String) request.getParameter("streamName1");

            stream = stream.replace('-', '_');
            System.out.println("stream name is:" + stream);
            try {
                Class.forName("com.mysql.jdbc.Driver").newInstance();
                System.out.println("driver connected");

                System.out.println("database connected");
                String qry1 = "drop table if exists  " + stream + "_grade_table ";
                Statement st1 = con1.createStatement();
                String qry10 = "create table if not exists " + stream + "_grade_table(Grade varchar(20),Marks Int(10),primary key(Grade))";
                st1.executeUpdate(qry1);
                st1.executeUpdate(qry10);
                System.out.println(qry10);

// insert the other programe into table, before that check whether it is other school prgm or not.
                
                Statement st10 = con.createStatement();
                Statement st11 = con.createStatement();
                ResultSet rs11=(ResultSet)st11.executeQuery("select * from  programme_table where Programme_group='"+stream+"'");
                if(!(rs11.next())){
                st10.executeUpdate("insert ignore into Other_schools(Name) values('" + stream + "' )");
                               }
                Statement st2 = con1.createStatement();
                Statement st3 = con1.createStatement();

                int i = 1;


                String[] grade = request.getParameterValues("grade");
                System.out.println("Updation is going on.....");
                while (i <= 6) {

                    String marks = request.getParameter("m" + i);
                    String qry2 = "insert into " + stream + "_grade_table(Grade,Marks) values('" + grade[i - 1] + "','" + marks + "')";
                    st2.executeUpdate(qry2);

                    i = i + 1;
                }



                String qry9 = "select * from " + stream + "_grade_table Order By Marks DESC";
                Statement st9 = con1.createStatement();
                //Statement st1=ConnectionDemo3.getStatementObj().createStatement();
                ResultSet rs9 = st9.executeQuery(qry9);

        %>
        <form name="frm" method="post"> 
            <center>University of Hyderabad</center>
            <center>School of Computer and Information Sciences</center>
            <center><%=stream%> Grade Formula Table</center>

            <br>
            <table align="center">

                <th>Grade</th>
                <th>Marks</th> 

                <%
                    while (rs9.next()) {
                %>
                <tr>
                    <td><%=rs9.getString(1)%></td>
                    <TD><%=rs9.getString(2)%></td>
                </tr>
                <%

                    }
                %>
            </table>     
            </br></br>
            <div align="center">
                <input type="button" value="Print" id="p1"  class="noPrint" onclick="window.print();" />
            </div>
            <%
                    con1.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }

            %>




    </body>
</html>
