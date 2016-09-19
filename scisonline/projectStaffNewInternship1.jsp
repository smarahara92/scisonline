<%-- 
    Document   : projectStaffNewInternship1
    Created on : 28 Mar, 2013, 4:59:51 AM
    Author     : varun
--%>
<%@include file="checkValidity.jsp"%>
<%@page import="com.hcu.mysql.connection.ConnectionDemo1"%>
<%@page import="com.mysql.jdbc.ResultSet"%>
<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@include file="connectionBean.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>

        <%            try {
                 Connection con = conn.getConnectionObj();
                Statement st1 = con.createStatement();
                Statement st3 = con.createStatement();
                Statement st4 = con.createStatement();

                Integer pidInternProj = 0, p_id = 0;
                String stid = request.getParameter("stid");
                String sname = request.getParameter("sname");
                String orgName = request.getParameter("orgname");
                String projTitle = request.getParameter("projtitle");
                String intSup = request.getParameter("sel3");
                String orgSup = request.getParameter("orgsup");
                String streamName = request.getParameter("streamName");
                String programmeName = request.getParameter("programmeName");

                Calendar now = Calendar.getInstance();
                int year = now.get(Calendar.YEAR);
                int month = now.get(Calendar.MONTH) + 1;

                int curYear = year;
                int pyear = year;
                String semester = null;
                if (streamName.equalsIgnoreCase("MCA") == true) {
                    if (month <= 6) {
                        semester = "Winter";
                        pyear = year;
                    } else {
                        semester = "Monsoon";
                        pyear = year - 1;
                    }
                } else {
                    if (month > 3) {
                        pyear = year;
                    } else {
                        pyear = year - 1;
                    }
                }

                String table = "";
                ResultSet rs1 = null;
                table = programmeName + "_Project_Student_" + pyear;
                rs1 = (ResultSet) st1.executeQuery("select * from  " + programmeName + "_Project_Student_" + pyear + " as a where a.StudentId='" + stid + "' ");
                int projectId = 0;
                while (rs1.next()) {
                    projectId = Integer.parseInt(rs1.getString(2));  //Contains the old project of student(Universtiy Project ID.)
                }

                if (projectId != 0) {

                    try {
                        con.setAutoCommit(false);
                        st3.executeUpdate("insert into  " + streamName + "_project" + "_" + pyear + " (ProjectTitle,SupervisorId1,SupervisorId2,SupervisorId3,Organization,Allocated) values('" + projTitle + "', '" + orgSup + "', '" + intSup + "','none','" + orgName + "','yes')");
                        ResultSet rs4 = (ResultSet) st4.executeQuery("select * from " + streamName + "_project" + "_" + pyear + " where ProjectTitle='" + projTitle + "'");
                        while (rs4.next()) {
                            p_id = Integer.parseInt(rs4.getString(1));
                        }
                        st4.executeUpdate("update  " + table + " set ProjectId='" + p_id + "' where ProjectId='" + projectId + "' ");
                        st4.executeUpdate("update  " + streamName + "_project" + "_" + pyear + "  set Allocated='no' where ProjectId='" + projectId + "' ");
                        con.commit();
                        out.println("<h2>Project Successfully Modified.</h2>");
                        rs4.close();
                    } catch (Exception ex) {
                        con.rollback();
                        System.out.println(ex);
                        System.out.println("Transaction rollback!!!");
                    }
                }
                st1.close();
                st3.close();
                st4.close();
                rs1.close();
                conn.closeConnection();
                con = null;
            } catch (Exception ex) {

            }
        %>

    </body>
</html>
