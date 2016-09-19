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
<%--<%@include file="dbconnection.jsp"%>--%>
<%@include file ="connectionBean.jsp" %>
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
            Connection con = conn.getConnectionObj();
            Connection con1 = conn1.getConnectionObj();
            try{
            int recourse = 0;
            int month = now.get(Calendar.MONTH) + 1;
            int cyear = now.get(Calendar.YEAR);

            String semester = "";

            if (month == 1 || month == 2 || month == 3 || month == 4 || month == 5 || month == 6) {
                semester = "Winter";
            } else {
                semester = "Monsoon";
            }

            Statement st1 = con.createStatement();
            Statement st2 = con.createStatement();

            String streamName = request.getParameter("streamto");
            streamName = streamName.replace('-', '_');
            String studentid = request.getParameter("studentId");
            String batchYear = request.getParameter("batchYear");
            String latestCurriculumYear = request.getParameter("latestCurriculum");
            String[] oldsubject = request.getParameterValues("oldsubject");
            String[] newsubject = request.getParameterValues("newsubject");

            String[] check = request.getParameterValues("check");

            int i = 0;

            String year = "";
            String mastertable = "";

            for (i = 0; i < check.length; i++) {



                mastertable = streamName + "_" + batchYear;

                ResultSet rs = st1.executeQuery("select * from " + mastertable + " where StudentId='" + studentid + "'");
                rs.next();
                ResultSetMetaData rsmd = rs.getMetaData();
                int noOfColumns = rsmd.getColumnCount();
                int temp = (noOfColumns - 2) / 2;
                int j = 0;
                String type = oldsubject[i].substring(0, 1);

                if (newsubject[i].equals("none") != true || type.equals("C") == true) {
                    String old = oldsubject[i].substring(1);
                    if (type.equals("C")) {
                        newsubject[i] = oldsubject[i].substring(1);
                    }
                    while (temp > 0) {

                        int m = j + 3;
                        String columnname = rsmd.getColumnName(m);
                        String columnname1 = rsmd.getColumnName(m + 1);
                        String F = "F";
                        if (old.equals(rs.getString(m)) == true && F.equals(rs.getString(m + 1))) {
                            String modified = newsubject[i];
                            //*******************************************************************
                            Statement st3 = con.createStatement();
                            ResultSet rs11 = st3.executeQuery("select Alias from " + streamName + "_" + latestCurriculumYear + "_curriculum where SubCode='" + modified + "'");
                            while (rs11.next()) {
                                if (rs11.getString(1) != null) {
                                    modified = rs11.getString(1);
                                }
                            }
                            Statement st4 = con.createStatement();
                            Statement st5 = con1.createStatement();
                            try {
                                // out.println(modified);
                                st4.executeUpdate("delete from " + modified + "_Attendance_" + semester + "_" + cyear + " where StudentId='" + studentid + "'");
                                st5.executeUpdate("delete from " + modified + "_Assessment_" + semester + "_" + cyear + " where StudentId='" + studentid + "'");
                                st4.executeUpdate("insert into " + modified + "_Attendance_" + semester + "_" + cyear + " (StudentId,StudentName) values('" + studentid + "','" + rs.getString(2) + "')");
                                st5.executeUpdate("insert into " + modified + "_Assessment_" + semester + "_" + cyear + " (StudentId,StudentName) values('" + studentid + "','" + rs.getString(2) + "')");
                                System.out.println(columnname);
                                st2.executeUpdate("update " + mastertable + " set " + columnname + "='" + newsubject[i] + "'," + columnname1 + "='R' where StudentId='" + studentid + "'");
                                break;
                            } catch (Exception ex) {
                                Statement st9 = con.createStatement();
                                ResultSet rs9 = st9.executeQuery("select * from subjecttable where Code='" + modified + "'");
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

            if (recourse == 0) {
                out.println("<center><h2>Recourse registration successfully done</h2></center>");
            }
            }catch(Exception e){
                    e.printStackTrace();
                }finally{
                                conn.closeConnection();
                               
                                con = null ;
                                
                            }

        %>
    </body>
</html>
