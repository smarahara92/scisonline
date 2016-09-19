<%-- 
    Document   : studentadd
    Created on : Oct 25, 2013, 11:53:03 AM
    Author     : veeru
--%>
<%@page import="com.hcu.mysql.connection.ConnectionDemo1"%>
<%@page import="java.sql.*" %>
<%@page import="jxl.*"%>
<%@page import="java.io.*"%>
<%@page import="java.util.*"%>
<%@page import="java.io.*"%>
<%@page import ="javax.sql.*" %>
<%@page import="java.sql.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style type="text/css">
            .print{
                width: 50px; 
                color: white; 
                background-color: #6d77d9; 
                border-color: red;
            }
            table
            {
                border-collapse:collapse;
            }
            table, td
            {
                border:1px solid green;
                padding: 8px;
            }
            th{
                background-color: green;
                border: 1px solid green;
                color:white;
            }
            .table1{
                margin-left:auto; 
                margin-right:auto;
            }
        </style>
    </head>
    <body>
        <%  String stream = (String) request.getAttribute("stream");
            String year = (String) request.getAttribute("year");
            String sid[] = request.getParameterValues("sid");
            String sname[] = request.getParameterValues("sname");
            String database = "";
            Class.forName("com.mysql.jdbc.Driver").newInstance();
            System.out.println("driver connected");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/dcis_attendance_system", "root", "");
            if (stream.equals("PhD")) {
                database = "PhD";
            } else {
                database = "dcis_attendance_system";
            }
            //******************************************************************************
            try {
            
            if (stream.equals("PhD") != true) {
                Statement st1 = con.createStatement();
                Statement st2 = con.createStatement();
                Statement st3 = con.createStatement();
                st1.executeUpdate("drop table if exists " + stream + "_" + year + "");
                st1.executeUpdate("create table " + stream + "_" + year + "(StudentId varchar(20),StudentName varchar(50),primary key(StudentId))");
                System.out.println("veeru");
                ResultSet rs = (ResultSet) st2.executeQuery("select * from " + stream + "_curriculum limit 1");
                int total = 0;
                int core = 0;
                int electives = 0;
                int labs = 0;
                int project = 0;
                while (rs.next()) {
                    //Number of Subjects
                    core = Integer.parseInt(rs.getString(1));
                    labs = Integer.parseInt(rs.getString(2));
                    project = Integer.parseInt(rs.getString(3));
                    electives = Integer.parseInt(rs.getString(4));
                    total = Integer.parseInt(rs.getString(1)) + Integer.parseInt(rs.getString(2)) + Integer.parseInt(rs.getString(3)) + Integer.parseInt(rs.getString(4));
                }
                int columns = 0;
                if (stream.equals("MCA")) {
                    columns = 2 * total + 1;
                } else {
                    columns = 2 * total + 2; //for MTech
                }
                
                int limit = core + labs + project;
                ResultSet rs1 = (ResultSet) st2.executeQuery("select * from " + stream + "_curriculum limit " + limit + " offset 1");
                int k = 1;
                while (rs1.next()) {
                    int i = 1;
                    while (i <= core) {
                        st1.executeUpdate("alter table " + stream + "_" + year + " add core" + i + " varchar(20),add c" + i + "grade varchar(10)");
                        st1.executeUpdate("update " + stream + "_" + year + " set core" + i + "='" + rs1.getString(1) + "',c" + i + "grade='NR' ");
                        rs1.next();
                        i++;
                        k++;
                    }
                    i = 1;
                    while (i <= labs) {
                        st1.executeUpdate("alter table " + stream + "_" + year + " add lab" + i + " varchar(20),add l" + i + "grade varchar(10)");
                        st1.executeUpdate("update " + stream + "_" + year + " set lab" + i + "='" + rs1.getString(1) + "',l" + i + "grade='NR'");
                        rs1.next();
                        i++;
                        k++;
                    }
                    i = 1;
                    while (i <= project) {
                        st1.executeUpdate("alter table " + stream + "_" + year + " add project" + i + " varchar(20),add p" + i + "grade varchar(10)");
                        st1.executeUpdate("update " + stream + "_" + year + " set project" + i + "='" + rs1.getString(1) + "',p" + i + "grade='NR'");
                        rs1.next();
                        i++;
                        k++;
                    }
                    i = 1;
                    while (i <= electives) {
                        st1.executeUpdate("alter table " + stream + "_" + year + " add ele" + i + " varchar(20),add e" + i + "grade varchar(10)");
                        st1.executeUpdate("update " + stream + "_" + year + " set e" + i + "grade='NR'");
                        i++;
                    }
                    if (stream.equals("MCA")) {
                        st1.executeUpdate("alter table " + stream + "_" + year + " add cgpa varchar(20)");
                    } else {
                        st1.executeUpdate("alter table " + stream + "_" + year + " add cgpa float(20),add gatescore float(20)");
                    }
                }
                System.out.println(stream);
            } else if (stream.equals("PhD") == true) {
                Statement st1 = con2.createStatement();
                Statement st2 = con2.createStatement();
                st1.executeUpdate("drop table if exists " + stream + "_" + year + "");
                st1.executeUpdate("drop table if exists comprehensive_" + year + "");
                st1.executeUpdate("drop table if exists drcreports_" + year + "");
                st1.executeUpdate("create table drcreports_" + year + "(StudentId varchar(20),StudentName varchar(50),primary key(StudentId))");
                st1.executeUpdate("create table comprehensive_" + year + "(StudentId varchar(20),StudentName varchar(50),primary key(StudentId))");
                st1.executeUpdate("create table " + stream + "_" + year + "(StudentId varchar(20),StudentName varchar(50),primary key(StudentId))");
                st1.executeUpdate("LOAD DATA INFILE '" + saveFile + "' INTO TABLE " + stream + "_" + year + " FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '\"' LINES TERMINATED BY '\n' (StudentId,StudentName)");
                st1.executeUpdate("LOAD DATA INFILE '" + saveFile + "' INTO TABLE drcreports_" + year + " FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '\"' LINES TERMINATED BY '\n' (StudentId,StudentName)");
                st1.executeUpdate("LOAD DATA INFILE '" + saveFile + "' INTO TABLE comprehensive_" + year + " FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '\"' LINES TERMINATED BY '\n' (StudentId,StudentName)");
                int totalcolumns = 12;
                int g = 1;
                while (g <= totalcolumns) {
                    st1.executeUpdate("alter table drcreports_" + year + " add date" + g + " varchar(12),add status" + g + " varchar(15),add progress" + g + " varchar(2000),add suggestions" + g + " varchar(2000)");
                    g++;
                }
                ResultSet rs = (ResultSet) st2.executeQuery("select * from " + stream + "_curriculum limit 1");
                int core = 0;
                int electives = 0;
                while (rs.next()) {
                    //Number of Subjects
                    core = Integer.parseInt(rs.getString(1));
                    electives = Integer.parseInt(rs.getString(2));
                }
                ResultSet rs1 = (ResultSet) st2.executeQuery("select * from " + stream + "_curriculum limit " + core + " offset 1");
                while (rs1.next()) {
                    int i = 1;
                    while (i <= core) {
                        st1.executeUpdate("alter table " + stream + "_" + year + " add core" + i + " varchar(20),add c" + i + "grade varchar(10)");
                        st1.executeUpdate("alter table comprehensive_" + year + " add core" + i + " varchar(20),add c" + i + "marks varchar(10)");
                        st1.executeUpdate("update " + stream + "_" + year + " set c" + i + "grade='NR' ");
                        rs1.next();
                        i++;
                    }
                    i = 1;
                    while (i <= electives) {
                        st1.executeUpdate("alter table " + stream + "_" + year + " add ele" + i + " varchar(20),add e" + i + "grade varchar(10)");
                        st1.executeUpdate("alter table comprehensive_" + year + " add ele" + i + " varchar(20),add e" + i + "marks varchar(10)");
                        st1.executeUpdate("update " + stream + "_" + year + " set e" + i + "grade='NR'");
                        i++;
                    }
                    st1.executeUpdate("alter table " + stream + "_" + year + " add thesistitle varchar(100),add areaofresearch varchar(100),add supervisor1 varchar(20),add supervisor2 varchar(20),add supervisor3 varchar(20),add status varchar(10),add ft_pt_ex varchar(20),add organization varchar(20),add externalsup varchar(20),add drc1 varchar(20),add drc2 varchar(20)");
                }
            }
            Statement st1;
            if (stream.equals("PhD")) {
                st1 = con2.createStatement();
            } else {
                st1 = con.createStatement();
            }
            ResultSet rs1 = st1.executeQuery("select * from " + stream + "_" + year + "");
        %>
        <center><b>University of Hyderabad</b></center>
        <center><b>School of Computer and Information Sciences</b></center>
        <center><b><%=stream%>-<%=year%> students list</b></center>
        &nbsp;
        <table class="table1">
            <tr>
                <th>Student ID</th>
                <th>Student Name</th>
            </tr>
            <%
                while (rs1.next()) {
            %>  <tr>
                <td><%=rs1.getString(1)%></td>
                <td><%=rs1.getString(2)%></td>
            </tr>
            <%
                }
            %>
        </table>
        <table class="table1">
            <tr>
                <td>
                    <input type="button" value="Print" id="p1" onclick="window.print();">
                </td>
            </tr>
        </table>
        <%
            }
            catch (Exception e

            
                ) {
                out.print("<center><h2>Update File not in Good formate</h2></center>");
                e.printStackTrace();
            }
        %>
    </body>
</html>
