<%-- 
    Document   : recoursemodifylink1
    Created on : Mar 26, 2013, 6:24:34 PM
    Author     : root
--%>
<%@include file="checkValidity.jsp"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.*"%>
<%@page import="java.lang.*"%>
<%@page import="java.text.SimpleDateFormat.*"%>
<%@page import="java.io.*"%>
<%@page import="java.text.ParseException.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.sql.*"%>
<%@include file ="connectionBean.jsp" %>
<%--<%@include file="dbconnection.jsp"%>--%>
<%@include file="id_parser.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>

        <%
            Calendar now = Calendar.getInstance();
            int recourse = 0;
           
            int month = now.get(Calendar.MONTH) + 1;
            int cyear = now.get(Calendar.YEAR);
            String semester = "";
            if (month == 1 || month == 2 || month == 3 || month == 4 || month == 5 || month == 6) {
                semester = "Winter";
            } else {
                semester = "Monsoon";
            }
            Connection con = conn.getConnectionObj();
            Connection con1 = conn1.getConnectionObj();
            try{
            Statement st1 = con.createStatement();
            Statement st2 = con.createStatement();
            Statement st3 = con.createStatement();
            Statement st4 = con.createStatement();
            Statement st5 = con.createStatement();
            Statement st6 = con1.createStatement();
            Statement st7 = con.createStatement();
            Statement st8 = con.createStatement();

            String batchYear = request.getParameter("batchYear");
            int byear = Integer.parseInt(batchYear);

            String studentId = request.getParameter("studentId");
            String stream = request.getParameter("stream");
            stream = stream.replace('-', '_');


            String programmeName = request.getParameter("programmeName");
            programmeName = programmeName.replace('-', '_');


            String[] oldsubject = request.getParameterValues("oldsubject");
            String[] newsubject = request.getParameterValues("newsubject");
            String[] check = request.getParameterValues("check");
            String syear = request.getParameter("year");


            int i = 0;
            String    year     = studentId.substring(SYEAR_PREFIX,EYEAR_PREFIX);
            
            year = "20" + year;
            System.out.println(year);
            String mastertable = "";
            int curriculumYear = 0;
            int latestYear = 0;

            for (i = 0; i < check.length; i++) {


                if (batchYear.equals(year) != true) {
                    out.println("<center><h3>" + studentId + " already readmin student</h3></center>");
                    return;
                }



                try {
                    ResultSet rs30 = st1.executeQuery("select * from " + programmeName + "_" + (Integer.parseInt(batchYear) + 1));
                } catch (Exception e) {
                    out.println("<center><h3>" + studentId + " readmission not possible try in next sem</h3></center>");
                    return;
                }
                //year=studentid.substring(0,2);
                mastertable = programmeName + "_" + batchYear;
                ResultSet rs = st2.executeQuery("select * from " + mastertable + " where StudentId='" + studentId + "'");
                rs.next();
                ResultSetMetaData rsmd = rs.getMetaData();
                int noOfColumns = rsmd.getColumnCount();
                int temp = (noOfColumns - 2) / 2;
                int j = 0;
                String type = oldsubject[i].substring(0, 1);

                if (newsubject[i].equals("none") != true || type.equals("C") == true) {
                    System.out.println("laxman");
                    String old = oldsubject[i].substring(1);
                    if (type.equals("C")) {
                        newsubject[i] = oldsubject[i].substring(1);
                    }
                    ResultSet rs122 = (ResultSet) st3.executeQuery("select * from " + programmeName + "_curriculumversions order by Year desc");
                    while (rs122.next()) {
                        curriculumYear = rs122.getInt(1);
                        if (curriculumYear <= byear) {

                            latestYear = curriculumYear;

                            break;
                        }
                    }

                    while (temp > 0) {

                        int m = j + 3;
                        String columnname = rsmd.getColumnName(m);
                        String columnname1 = rsmd.getColumnName(m + 1);
                        String F = "F";
                        if (old.equals(rs.getString(m)) == true && F.equals(rs.getString(m + 1))) {
                            System.out.println(columnname);
                            String modified = newsubject[i];
                            //*******************************************************************
                            

                            ResultSet rs11 = st4.executeQuery("select Alias from " + programmeName + "_" + latestYear + "_curriculum where SubCode='" + modified + "'");
                            while (rs11.next()) {
                                if (rs11.getString(1) != null) {
                                    modified = rs11.getString(1);
                                }
                            }

                            try {
                                 System.out.println(modified+"alaf"+" "+cyear);
                                st5.executeUpdate("delete from " + modified + "_Attendance_" + semester + "_" + cyear + " where StudentId='" + studentId + "'");
                                 System.out.println(modified+"alaf1"+" "+cyear);
                                st6.executeUpdate("delete from " + modified + "_Assessment_" + semester + "_" + cyear + " where StudentId='" + studentId + "'");
                                 System.out.println(modified+"alaf2"+" "+cyear);
                                st5.executeUpdate("insert into " + modified + "_Attendance_" + semester + "_" + cyear + " (StudentId,StudentName) values('" + studentId + "','" + rs.getString(2) + "')");
                                 System.out.println(modified+"alaf3"+" "+cyear);
                                st6.executeUpdate("insert into " + modified + "_Assessment_" + semester + "_" + cyear + " (StudentId,StudentName) values('" + studentId + "','" + rs.getString(2) + "')");
                                 System.out.println(modified+"alaf5"+" "+cyear);
                                st5.executeUpdate("update " + mastertable + " set " + columnname + "='" + newsubject[i] + "'," + columnname1 + "='R' where StudentId='" + studentId + "'");
                                break;
                                
                            } catch (Exception ex) {

                                ResultSet rs9 = st7.executeQuery("select * from subjecttable where Code='" + modified + "'");
                                System.out.println(modified);
                                rs9.next();
                                out.println("<center><h3>" + rs9.getString(2) + "   subject not present in current semester</h3></center>");
                                recourse++;
                            }
                            //*******************************************************************

                        }

                        j = j + 2;
                        temp--;
                    }
                }

            }
            st5.executeUpdate("insert into " + programmeName + "_" + (Integer.parseInt(batchYear) + 1) + " select * from " + programmeName + "_" + batchYear + " where StudentId='" + studentId + "'");
            st5.executeUpdate("delete from " + programmeName + "_" + batchYear + " where StudentId='" + studentId + "'");
            if (recourse == 0) {
                out.println("<center><h2>Readmin registration successfully done</h2></center>");
            }
            } catch( Exception e)
                            {
                                
                            }finally{
                                conn.closeConnection();
                                conn1.closeConnection();
                                con = null ;
                                con1 = null;
                            }


        %>
    </body>
</html>
