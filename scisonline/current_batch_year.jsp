<%-- 
    Document   : temppage
    Created on : Dec 21, 2013, 4:45:38 PM
    Author     : veeru
--%>

<%@include file="checkValidity.jsp"%>
<%@page import="java.util.Calendar"%>
<%@ include file="dbconnection.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            /*
             * creation of table... current_batch_year.... in dcis_attendance_system database.
             */
            System.out.println("programme start");
            Calendar now = Calendar.getInstance();

            int month = now.get(Calendar.MONTH) + 1;
            int cyear = now.get(Calendar.YEAR);
            int cyear1 = cyear;
            int CurriculumYear = 0, year1 = 0, pduration = 0, i;
            Statement stmnt = con.createStatement();
            Statement stmnt1 = con.createStatement();
            Statement stmnt2 = con.createStatement();
            Statement stmnt3 = con.createStatement();
            Statement stmnt4 = con.createStatement();
            Statement stmnt5 = con.createStatement();
            Statement stmnt6 = con.createStatement();
            System.out.println("step======1***********************************************************************8");
            ResultSet res1 = stmnt.executeQuery("select * from programme_table where not Programme_name='PhD'");
            System.out.println("step======2");
            stmnt4.executeUpdate("create table if not exists current_batch_" + cyear1 + "(StudentId varchar(100) not null,StudentName varchar(100), Programme_name varchar(100),Programme_group varchar(100),BatchYear varchar(100),Programme_duration varchar(10), primary key(StudentId))");
            System.out.println("step======3");
            while (res1.next()) {
                cyear = cyear1;
                String pname = res1.getString(1).replace('-', '_');

                ResultSet res2 = stmnt1.executeQuery("select * from " + pname + "_curriculumversions order by Year desc");
                while (res2.next()) {
                    CurriculumYear = res2.getInt(1);
                    if (CurriculumYear <= cyear) {
                        year1 = CurriculumYear;
                        System.out.println(year1);
                        break;
                    }
                }
                System.out.println(year1);
                System.out.println(pname);
                ResultSet res3 = stmnt2.executeQuery("select count(*) from " + pname + "_" + year1 + "_currrefer");
                res3.next();
                pduration = res3.getInt(1) / 2;
                System.out.println("step======4" + pduration);
                for (i = 1; i <= pduration; i++) {
                    //check existence of table in database
                    ResultSet res0 = stmnt6.executeQuery("SHOW TABLES LIKE '" + pname + "_" + cyear + "';");

                    while (res0.next()) {
                        ResultSet res4 = stmnt3.executeQuery("select * from " + pname + "_" + cyear + "");
                        while (res4.next()) {
                            stmnt5.executeUpdate("insert ignore into current_batch_" + cyear1 + " values('" + res4.getString(1) + "','" + res4.getString(2) + "','" + pname + "','" + res1.getString(4) + "','" + cyear + "','" + pduration + "')");
                        }
                    }
                    cyear--;
                }
            }

        %>
    </body>
</html>
