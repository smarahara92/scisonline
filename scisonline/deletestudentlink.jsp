<%-- 
    Document   : deletestudentlink
--%>

<%@include file="checkValidity.jsp"%>
<%@include file="connectionBean.jsp"%>
<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body bgcolor="#CCFFFF">
        <% 
            Connection con = conn.getConnectionObj();
            Connection con1 = conn1.getConnectionObj();
            
            try {
                String[] sid = request.getParameterValues("sid");

                int i = 0;

                Statement st1 = con.createStatement();
                Statement st2 = con.createStatement();
                Statement st3 = con.createStatement();
                Statement st4 = con.createStatement();
                Statement st5 = con.createStatement();
                Statement st6 = con1.createStatement();

                String table = "";
                String stream = "";
                String semester = "";
                int curriculumYear = 0;
                int latestYear = 0;
                int month = Calendar.getInstance().get(Calendar.MONTH) + 1;
                int cur_year = Calendar.getInstance().get(Calendar.YEAR);
                int year2 = cur_year;
                if (month <= 6) {
                    semester = "Winter";
                    cur_year = cur_year - 1;
                } else {
                    semester = "Monsoon";
                }
                int flag = 0, flag1 = 0;
                for (i = 0; i < sid.length; i++) {
                    if (sid[i].equals("---Enter Student Id---") == true || sid[i].equals("") == true) {
                    } else {
                        flag1++;
                        System.out.println(sid[i] + "  " + i);
                        sid[i] = sid[i].toUpperCase();
                        String programmeName = null;
                        String table1 = null;
                        int batchYear = 0;
                        String pgName = null;
                        int outtest = 0;

                        //to know batch year and programme name of student according to studentid;
                        ResultSet rs = st1.executeQuery("select Programme_name from programme_table where not Programme_group='PhD' and Programme_status='1'");
                        while (rs.next()) {
                            int start = cur_year;
                            int flag10 =1;
                            programmeName = rs.getString(1).replace('-', '_');
                            ResultSet rs12 = (ResultSet) st2.executeQuery("select * from " + programmeName + "_curriculumversions order by Year desc");
                            while (rs12.next()) {
                                curriculumYear = rs12.getInt(1);
                                if (curriculumYear <= cur_year && flag10 !=0) {

                                    latestYear = curriculumYear;
                                    
                                    flag10 = 0;
                                    //break;
                                }
                                start =  curriculumYear;
                            }
                            //getting batch year for project student
                            ResultSet rs11 = (ResultSet) st3.executeQuery("select count(*) from " + programmeName + "_" + latestYear + "_currrefer");
                            rs11.next();
                            int rowsCount = rs11.getInt(1);
                            rowsCount = rowsCount / 2;// programme duration
                            int year1 = cur_year, test = 0;
                            for (int j = 0; j < rowsCount && start <= year1; j++) {
                                System.out.println("===================================;;;;;;;;;" + programmeName + "_" + year1);

                                ResultSet rs1 = st4.executeQuery("select StudentId from " + programmeName + "_" + year1 + " where StudentId='" + sid[i] + "'");
                                while (rs1.next()) {

                                    stream = programmeName;
                                    batchYear = year1;
                                    System.out.println(stream);
                                    System.out.println(batchYear);
                                    test++;
                                    break;
                                }
                                if (test > 0) {
                                    outtest++;
                                    break;
                                }
                                year1--;
                            }
                            if (outtest > 0) {
                                break;
                            }

                        }

                        try {
                            con.setAutoCommit(false);
                            con1.setAutoCommit(false);
                            int finding = 0;
                            
                            try{
                            ResultSet rs1 = st2.executeQuery("select * from subject_faculty_" + semester + "_" + year2);
                             while (rs1.next()) {

                                String attendancetable = rs1.getString(1) + "_Attendance_" + semester + "_" + year2;
                                String assessmenttable = rs1.getString(1) + "_Assessment_" + semester + "_" + year2;
                                st5.executeUpdate("delete from " + attendancetable + " where StudentId='" + sid[i] + "'");
                                st6.executeUpdate("delete from " + assessmenttable + " where StudentId='" + sid[i] + "'");

                            }
         
                            }
                            catch( Exception e)
                            {
                                
                            }
                                              table = stream + "_" + batchYear;
                            for( int k=0;k<2;k++)
                            {
                                int q = st5.executeUpdate("delete from " + table + " where StudentId='" + sid[i] + "'");
                                if(q > 0)
                                {
                                    break;
                                }
                                else
                                {
                                    table = stream + "_" + (batchYear-1);
                                }
                            }
                            con.commit();
                            con1.commit();
                            flag++;
                        } catch (Exception ex) {
                            con.rollback();
                            con1.rollback();
                            System.out.println(ex);
                            System.out.println("Transaction rollback!!!");
                        }finally{
                            con.setAutoCommit(true);
                            con1.setAutoCommit(true);
                        }
                    }
                }
                if (flag == flag1) {
                    out.println("<center><h2>Delete Student successfully done</h2></center>");

                } else {
                    out.println("<center><h2>Delete Student not done successfully.</h2></center>");
                }

            } catch (Exception e) {
                out.println(e);

            }

        %>
        <%
        conn.closeConnection();
        con = null;
        conn1.closeConnection();
        con1 = null;
        %>
    </body>
</html>
