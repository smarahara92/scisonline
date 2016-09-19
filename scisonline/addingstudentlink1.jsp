<%-- 
    Document   : addingstudentlink
--%>

<%@include file="checkValidity.jsp"%>
<%@page import="java.sql.*"%>
<%@include file="connectionBean.jsp"%>    
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style>
            #div1
            {

                width:100%;
            }
            .heading
            {
                color: white;
                background-color: green;
            }
            .td
            {
                border-collapse:collapse;
                border: 1px solid green;
                white-space:nowrap;
                background-color: #F5F5F5;
                padding: 2px;
            }
            .td1{
                text-align: center;
                color: blue;
            }
            .table1{


                border: 1px solid black;
                border-collapse: collapse;


            }th{
                background-color: green;
                border: 1px solid green;
                color:white;
            }
            .Button {

                -moz-box-shadow:inset 0px 1px 0px 0px #ffffff;
                -webkit-box-shadow:inset 0px 1px 0px 0px #ffffff;
                box-shadow:inset 0px 1px 0px 0px #ffffff;

                background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #ffffff), color-stop(1, #f6f6f6));
                background:-moz-linear-gradient(top, #ffffff 5%, #f6f6f6 100%);
                background:-webkit-linear-gradient(top, #ffffff 5%, #f6f6f6 100%);
                background:-o-linear-gradient(top, #ffffff 5%, #f6f6f6 100%);
                background:-ms-linear-gradient(top, #ffffff 5%, #f6f6f6 100%);
                background:linear-gradient(to bottom, #ffffff 5%, #f6f6f6 100%);
                filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#ffffff', endColorstr='#f6f6f6',GradientType=0);

                background-color:#ffffff;

                -moz-border-radius:6px;
                -webkit-border-radius:6px;
                border-radius:6px;

                border:1px solid #dcdcdc;

                display:inline-block;
                color:black;
                font-family:arial;
                font-size:15px;
                font-weight:bold;
                padding:6px 24px;
                text-decoration:none;

                text-shadow:0px 1px 0px #ffffff;
                border-color: darkgray;

            }
            .Button:hover {

                background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #f6f6f6), color-stop(1, #ffffff));
                background:-moz-linear-gradient(top, #f6f6f6 5%, #ffffff 100%);
                background:-webkit-linear-gradient(top, #f6f6f6 5%, #ffffff 100%);
                background:-o-linear-gradient(top, #f6f6f6 5%, #ffffff 100%);
                background:-ms-linear-gradient(top, #f6f6f6 5%, #ffffff 100%);
                background:linear-gradient(to bottom, #f6f6f6 5%, #ffffff 100%);
                filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#f6f6f6', endColorstr='#ffffff',GradientType=0);

                background-color:#f6f6f6;
            }
            .Button:active {
                position:relative;
                top:1px;
            }
        </style>
    </head>
    <body> <%
        Connection con = conn.getConnectionObj();
        Connection con2 = conn2.getConnectionObj();
        PreparedStatement pst = null;

        try {
            String[] stid = (String[]) request.getParameterValues("stdid");
            String[] stname = (String[]) request.getParameterValues("stdname");
            pst = con.prepareStatement("create table if not exists studentaddtemp(stdid varchar(100),stdname varchar(200),primary key(stdid))");
            pst.executeUpdate();
            int i1 = 0;
            for (i1 = 0; i1 < 30; i1++) {
                stid[i1] = stid[i1].trim().toUpperCase();
                stname[i1] = stname[i1].trim().toUpperCase();
                if (stid.equals("") || stid == null) {
                    continue;
                }
                pst = con.prepareStatement("insert ignore into studentaddtemp values(?,?)");
                pst.setString(1, stid[i1]);
                pst.setString(2, stname[i1]);
                pst.executeUpdate();
            }

            int j, CurriculumYear;

            String pname = (String) session.getAttribute("pnamen");
            String year = (String) session.getAttribute("yearn");
            int year1 = Integer.parseInt(year);
            System.out.println(pname);
            System.out.println(year);
            String stdname[] = request.getParameterValues("stdname");
            String stdid[] = request.getParameterValues("stdid");
            pname = pname.replace('-', '_');

            try {
                if (pname.equals("PhD") != true) {
                    try {
                        con.setAutoCommit(false);
                        pst = con.prepareStatement("select * from studentaddtemp");
                        ResultSet rss = pst.executeQuery();
                        /*
                         * Taking correct version of curriculum for particular programme
                         */
                        pst = con.prepareStatement("select * from " + pname + "_curriculumversions order by Year desc");
                        ResultSet rs10 = pst.executeQuery();
                        while (rs10.next()) {
                            CurriculumYear = rs10.getInt(1);
                            if (CurriculumYear <= year1) {

                                year1 = CurriculumYear;
                                System.out.println(year1);
                                break;
                            }
                        }
                        pst = con.prepareStatement("drop table if exists " + pname + "_" + year + "");
                        pst.executeUpdate();
                        pst = con.prepareStatement("create table if not exists " + pname + "_" + year + "(StudentId varchar(20),StudentName varchar(50),primary key(StudentId))");
                        pst.executeUpdate();

                        while (rss.next()) {
                            if (rss.getString(1).equalsIgnoreCase("") || rss.getString(2).equalsIgnoreCase("")) {
                                continue;
                            }
                            try {
                                pst = con.prepareStatement("insert into " + pname + "_" + year + " values(?,?)");
                                pst.setString(1, rss.getString(1));
                                pst.setString(2, rss.getString(2));
                                pst.executeUpdate();
                            } catch (Exception e) {%>
                                <script>
                                    alert("Duplicate data...");
                                </script> <%
                            }
                        }

                        int total = 0;
                        int core = 0;
                        int electives = 0;
                        int labs = 0;
                        int project = 0;
                        int optionalCores = 0;
                        pst = con.prepareStatement("SELECT SUM(Cores), SUM(Electives),SUM(Labs), SUM(OptionalCore),BIT_OR(Projects) FROM " + pname + "_" + year1 + "_currrefer");
                        ResultSet rs1 = pst.executeQuery();
                        rs1.next();

                        core = Integer.parseInt(rs1.getString(1));
                        electives = Integer.parseInt(rs1.getString(2));
                        labs = Integer.parseInt(rs1.getString(3));
                        project = Integer.parseInt(rs1.getString(5));
                        optionalCores = Integer.parseInt(rs1.getString(4));

                        total = core + labs + electives + project + optionalCores;
                        System.out.println(electives);
                        pst = con.prepareStatement("select * from " + pname + "_" + year1 + "_curriculum where Type=?");
                        pst.setString(1, "C");
                        ResultSet rs2 = pst.executeQuery();
                        rs2.next();
                        int i = 1;
                        while (i <= core) {
                            pst = con.prepareStatement("alter table " + pname + "_" + year + " add core" + i + " varchar(20),add c" + i + "grade varchar(10)");
                            pst.executeUpdate();
                            pst = con.prepareStatement("update " + pname + "_" + year + " set core" + i + "='" + rs2.getString(2) + "',c" + i + "grade='NR' ");
                            pst.executeUpdate();
                            rs2.next();
                            i++;

                        }
                        pst = con.prepareStatement("select * from " + pname + "_" + year1 + "_curriculum where Type=?");
                        pst.setString(1, "L");
                        ResultSet rs3 = pst.executeQuery();
                        rs3.next();
                        i = 1;

                        while (i <= labs) {
                            pst = con.prepareStatement("alter table " + pname + "_" + year + " add lab" + i + " varchar(20),add l" + i + "grade varchar(10)");
                            pst.executeUpdate();
                            pst = con.prepareStatement("update " + pname + "_" + year + " set lab" + i + "='" + rs3.getString(2) + "',l" + i + "grade='NR'");
                            pst.executeUpdate();
                            rs3.next();

                            i++;

                        }
                        pst = con.prepareStatement("select * from " + pname + "_" + year1 + "_curriculum where Type=?");
                        pst.setString(1, "P");
                        ResultSet rs4 = pst.executeQuery();
                        rs4.next();
                        i = 1;
                        while (i <= project) {
                            pst = con.prepareStatement("alter table " + pname + "_" + year + " add project" + i + " varchar(20),add p" + i + "grade varchar(10)");
                            pst.executeUpdate();
                            pst = con.prepareStatement("update " + pname + "_" + year + " set project" + i + "='" + rs4.getString(2) + "',p" + i + "grade='NR'");
                            pst.executeUpdate();
                            rs4.next();

                            i++;

                        }
                        pst = con.prepareStatement("select * from " + pname + "_" + year1 + "_curriculum where Type=?");
                        pst.setString(1, "E");
                        ResultSet rs5 = pst.executeQuery();
                        rs5.next();
                        i = 1;
                        while (i <= electives) {
                            pst = con.prepareStatement("alter table " + pname + "_" + year + " add ele" + i + " varchar(20),add e" + i + "grade varchar(10)");
                            pst.executeUpdate();
                            pst = con.prepareStatement("update " + pname + "_" + year + " set e" + i + "grade='NR'");
                            pst.executeUpdate();
                            rs5.next();

                            i++;
                        }
                        
                        
                        pst = con.prepareStatement("select * from " + pname + "_" + year1 + "_curriculum where Type=?");
                        pst.setString(1, "O");
                        ResultSet rs6 = pst.executeQuery();
                        rs5.next();
                        i = 1;
                        while (i <= electives) {
                            pst = con.prepareStatement("alter table " + pname + "_" + year + " add optCore" + i + " varchar(20),add o" + i + "grade varchar(10)");
                            pst.executeUpdate();
                            pst = con.prepareStatement("update " + pname + "_" + year + " set o" + i + "grade='NR'");
                            pst.executeUpdate();
                            rs6.next();

                            i++;
                        }
                        

                        if (pname.equalsIgnoreCase("MCA")) {
                            pst = con.prepareStatement("alter table " + pname + "_" + year + " add cgpa varchar(20)");
                            pst.executeUpdate();
                        } else {
                            pst = con.prepareStatement("alter table " + pname + "_" + year + " add cgpa float(20),add gatescore float(20)");
                            pst.executeUpdate();
                        }
                        con.commit();
                    } catch (Exception ex) {
                        con.rollback();

                        System.out.println(ex);
                        System.out.println("Transaction rollback!!!");
                    }
                    con.setAutoCommit(true);
                } else if (pname.equals("PhD") == true) {

                    try {
                        con.setAutoCommit(false);
                        con2.setAutoCommit(false);
                        pst = con.prepareStatement("select * from studentaddtemp");
                        ResultSet rss = pst.executeQuery();
                        pst = con2.prepareStatement("select * from " + pname + "_curriculumversions order by Year desc");
                        ResultSet rs11 = pst.executeQuery();
                        while (rs11.next()) {
                            CurriculumYear = rs11.getInt(1);
                            if (CurriculumYear <= year1) {

                                year1 = CurriculumYear;
                                System.out.println(year1);
                                break;
                            }
                        }
                        pst = con2.prepareStatement("create table if not exists drcreports1_" + year + "(StudentId varchar(20),StudentName varchar(50),primary key(StudentId))");
                        pst.executeUpdate();
                        pst = con2.prepareStatement("create table if not exists comprehensive1_" + year + "(StudentId varchar(20),StudentName varchar(50),primary key(StudentId))");
                        pst.executeUpdate();
                        pst = con2.prepareStatement("create table if not exists " + pname + "_" + year + "(StudentId varchar(20),StudentName varchar(50),primary key(StudentId))");
                        pst.executeUpdate();
                        for (j = 0; j < stdid.length; j++) {
                            if (rss.getString(1) == "" && rss.getString(2) == "") {
                                continue;
                            }
                            pst = con2.prepareStatement("insert ignore into " + pname + "_" + year + " values(?,?)");
                            pst.setString(1, rss.getString(1));
                            pst.setString(2, rss.getString(2));
                            pst.executeUpdate();
                            pst = con2.prepareStatement("insert ignore into drcreports1_" + year + " values(?,?)");
                            pst.setString(1, rss.getString(1));
                            pst.setString(2, rss.getString(2));
                            pst.executeUpdate();
                            pst = con2.prepareStatement("insert ignore into comprehensive1_" + year + " values(?,?)");
                            pst.setString(1, rss.getString(1));
                            pst.setString(2, rss.getString(2));
                            pst.executeUpdate();

                        }

                        int totalcolumns = 12;
                        int g = 1;
                        while (g <= totalcolumns) {
                            pst = con2.prepareStatement("alter table drcreports1_" + year + " add date" + g + " varchar(12),add status" + g + " varchar(15),add progress" + g + " varchar(2000),add suggestions" + g + " varchar(2000)");
                            pst.executeUpdate();
                            g++;
                        }
                        pst = con2.prepareStatement("select * from " + pname + "_" + year1 + "_currrefer");

                        ResultSet rs3 = (ResultSet) pst.executeQuery();
                        int core = 0;
                        int electives = 0;
                        while (rs3.next()) {
                            //Number of Subjects
                            core = Integer.parseInt(rs3.getString(1));
                            electives = Integer.parseInt(rs3.getString(2));
                        }

                        int i = 1;
                        while (i <= core) {
                            pst = con2.prepareStatement("alter table " + pname + "_" + year + " add core" + i + " varchar(20),add c" + i + "grade varchar(10)");
                            pst.executeUpdate();
                            pst = con2.prepareStatement("alter table comprehensive1_" + year + " add core" + i + " varchar(20),add c" + i + "marks varchar(10)");
                            pst.executeUpdate();
                            pst = con2.prepareStatement("update " + pname + "_" + year + " set c" + i + "grade='NR' ");
                            pst.executeUpdate();

                            i++;
                        }
                        i = 1;
                        while (i <= electives) {
                            pst = con2.prepareStatement("alter table " + pname + "_" + year + " add ele" + i + " varchar(20),add e" + i + "grade varchar(10)");
                            pst.executeUpdate();
                            pst = con2.prepareStatement("alter table comprehensive1_" + year + " add ele" + i + " varchar(20),add e" + i + "marks varchar(10)");
                            pst.executeUpdate();
                            pst = con2.prepareStatement("update " + pname + "_" + year + " set e" + i + "grade='NR'");
                            pst.executeUpdate();

                            i++;
                        }
                        pst = con2.prepareStatement("alter table " + pname + "_" + year + " add thesistitle varchar(100),add areaofresearch varchar(100),add supervisor1 varchar(20),add supervisor2 varchar(20),add supervisor3 varchar(20),add status varchar(10),add ft_pt_ex varchar(20),add organization varchar(20),add externalsup varchar(20),add drc1 varchar(20),add drc2 varchar(20)");

                        pst.executeUpdate();
                        con.commit();
                        con2.commit();
                    } catch (Exception ex) {
                        con2.rollback();
                        con.rollback();
                    }
                    con.setAutoCommit(true);
                    con2.setAutoCommit(true);
                }

                Statement st5;
                if (pname.equals("PhD")) {
                    st5 = con2.createStatement();
                } else {
                    st5 = con.createStatement();
                }

                ResultSet rs5 = st5.executeQuery("select * from " + pname + "_" + year + ""); %>
                <center><b>University of Hyderabad</b></center>
                <center><b>School of Computer and Information Sciences</b></center>
                <center><b><%=pname%>-<%=year%> students list</b></center>
                &nbsp;
                <table class="table1" align="center">
                    <tr>
                        <th class="heading">Student ID</th>
                        <th class="heading">Student Name</th>
                    </tr> <%
                    while (rs5.next()) { %>
                        <tr>
                            <td class="td"><%=rs5.getString(1)%></td>
                            <td class="td"><%=rs5.getString(2)%></td>
                        </tr> <%
                    } %>
                </table>&nbsp;
                <table align="center">
                    <tr>
                        <td>
                            <input type="button" value="Print" id="p1" onclick="window.print();" class="Button">
                        </td>
                    </tr>
                </table> <%
                Statement stt = con.createStatement();
                stt.executeUpdate("drop table if exists studentaddtemp");
            } catch (Exception e) {
                out.print("<center><h2>Curriculum reference table does not exist...</h2></center>");
                e.printStackTrace();
            }
        } catch (Exception ex) {
            System.out.println(ex);
        } finally {
            if (con != null && con2 != null && pst != null) {
                pst.close();

            }
        }
        conn.closeConnection();
        con = null;
        conn2.closeConnection();
        con2 = null; %>
    </body>
</html>
