<%-- 
    Document   : projectFacultyModifyMCA1
    Created on : 27 May, 2013, 7:23:45 AM
    Author     : varun
--%>
<%@page import="java.sql.*"%>
<%@include file="connectionBean.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body bgcolor="E0FFFF">
        <%
            Connection con = conn.getConnectionObj();
            
            Statement st1 = con.createStatement();
            Statement st2 = con.createStatement();
            Statement st3 = con.createStatement();
            String user = (String) session.getAttribute("user");

            int i = 0;
            String[] pid = request.getParameterValues("pid");
            Integer rows = pid.length;
            String[] ptid = request.getParameterValues("ptid");

            String[] sid3 = request.getParameterValues("sel2");
            String[] sid4 = request.getParameterValues("sel3");
            Integer ptidlength = ptid.length;
            
             int pyear ;
            

            ResultSet rs1 = (ResultSet) st2.executeQuery("select * from  MCA_project" + "_" + pyear + " where (SupervisorId1='" + user + "' or SupervisorId2='" + user + "' or SupervisorId3='" + user + "') and Organization='uoh' ");

            while (i < rows && rs1.next()) {
                try {

                    // ----------------------------------


                    if (sid3[i].equals("None")) {
                        sid3[i] = "none";
                    }
                    if (sid4[i].equals("None")) {
                        sid4[i] = "none";
                    }

                    //------------- Modified -------------------

                    int fid1 = 0, fid2 = 0, fid3 = 0;

                    if (user.equals(rs1.getString(3))) {
                        fid1 = 1;
                        st1.executeUpdate("update MCA_project" + "_" + pyear + "  set ProjectTitle='" + ptid[i] + "', SupervisorId2='" + sid3[i] + "',SupervisorId3='" + sid4[i] + "' where ProjectId='" + pid[i] + "'");

                        // ------- Handling of null supervisors in project master table -------
                        if (sid3[i] == null) {
                            st1.executeUpdate("update MCA_project" + "_" + pyear + "  set ProjectTitle='" + ptid[i] + "', SupervisorId2=" + sid3[i] + " where ProjectId='" + pid[i] + "'");

                        }

                        if (sid4[i] == null) {
                            st1.executeUpdate("update MCA_project" + "_" + pyear + "  set ProjectTitle='" + ptid[i] + "', SupervisorId3=" + sid4[i] + " where ProjectId='" + pid[i] + "'");

                        }

                        // ----------------------- End -------------------------------------

                    } else if (user.equals(rs1.getString(4))) {
                        fid2 = 1;
                        st1.executeUpdate("update MCA_project" + "_" + pyear + " set ProjectTitle='" + ptid[i] + "', SupervisorId1='" + sid3[i] + "',SupervisorId3='" + sid4[i] + "' where ProjectId='" + pid[i] + "'");

                        // ------- Handling of null supervisors in project master table -------
                        if (sid3[i] == null) {
                            st1.executeUpdate("update MCA_project" + "_" + pyear + "  set ProjectTitle='" + ptid[i] + "', SupervisorId1=" + sid3[i] + " where ProjectId='" + pid[i] + "'");

                        }

                        if (sid4[i] == null) {
                            st1.executeUpdate("update MCA_project" + "_" + pyear + "  set ProjectTitle='" + ptid[i] + "', SupervisorId3=" + sid4[i] + " where ProjectId='" + pid[i] + "'");

                        }

                        // ----------------------- End -------------------------------------


                    } else if (user.equals(rs1.getString(5))) {
                        fid3 = 1;
                        st1.executeUpdate("update MCA_project" + "_" + pyear + "  set ProjectTitle='" + ptid[i] + "', SupervisorId1='" + sid3[i] + "',SupervisorId2='" + sid4[i] + "' where ProjectId='" + pid[i] + "'");

                        // ------- Handling of null supervisors in project master table -------
                        if (sid3[i] == null) {
                            st1.executeUpdate("update MCA_project" + "_" + pyear + "  set ProjectTitle='" + ptid[i] + "', SupervisorId1=" + sid3[i] + " where ProjectId='" + pid[i] + "'");

                        }

                        if (sid4[i] == null) {
                            st1.executeUpdate("update MCA_project" + "_" + pyear + "  set ProjectTitle='" + ptid[i] + "', SupervisorId2=" + sid4[i] + " where ProjectId='" + pid[i] + "'");

                        }

                        // ----------------------- End -------------------------------------


                    }



                } catch (Exception ex) {

                    ex.printStackTrace();
                }
                i++;
            }
            
            rs1.close();
            st1.close();
            st2.close();
            st3.close();
            conn.closeConnection();
            con = null;

        %>

        <h2>Project Modifications Successfully completed.</h2>
    </body>
</html>
