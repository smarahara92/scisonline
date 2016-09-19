<%-- 
    Document   : addstudentlink
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@include file="checkValidity.jsp"%>
<%@include file="connectionBean.jsp"%>
<%@include file="programmeRetrieveBeans.jsp" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    </head>
    <body bgcolor="#CCFFFF">
<%
        Connection con = conn.getConnectionObj();
        Connection con1 = conn1.getConnectionObj();
        
//        int cur_year = scis.getLatestYear();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy");
        Date d = new Date();
        int cur_year = Integer.parseInt(sdf.format(d));
        
        String[] sid = request.getParameterValues("sid");
        String[] sname = request.getParameterValues("sname");
        String[] branch = request.getParameterValues("pg");

        int count = 0;
        String table = "";
        
        Statement st1 = con.createStatement();
        Statement st2 = con.createStatement();
        Statement st4 = con.createStatement();
        Statement st5 = con.createStatement();
        Statement st6 = con.createStatement();
        Statement st7 = con.createStatement();
        Statement st8 = con.createStatement();
        
        int latestYear = 0;
        String studentId = null;
        String studentName = null;
        for (int j = 0; j < sid.length; j++) {
            if (sid[j].equalsIgnoreCase("") || sid[j] == "") {
                continue;
            }
            studentId = sid[j].trim();
            studentId = studentId.toUpperCase();
            
            studentName = sname[j].trim();
            studentName = studentName.toUpperCase();
            
            String programmeName = branch[j].replace('-', '_');
            table = branch[j].replace('-', '_') + "_" + cur_year;
            ResultSet rs22 = null;
            try {
                rs22 = (ResultSet) st1.executeQuery("select StudentId from " + table + " where StudentId = '" + studentId + "'");
            } catch(Exception e) {
                System.out.println(e);
                out.println("<center><h3>"+programmeName.replace('_', '-')+" "+ cur_year + " batch does not exist."+"</center></h3>");
                out.println("<center><h3>"+studentName + " ("+studentId+") "+ "is not added.</center></h3>");
                continue;
            }
            
            if (rs22.next()) { %>
                <h3><center>already one student exist with same id  <%=studentId%></center></h3> <%
                out.println("<center><h3>"+studentName + " ("+studentId+") "+ "is not added.</center></h3>");
                continue;
            }
            
            count++;
            
            st2.executeUpdate("insert ignore into " + table + "(StudentId,StudentName)values('" + studentId + "','" + studentName + "')");

            latestYear =scis.latestCurriculumYear(programmeName, cur_year);
            
            int core = 0, electives = 0, labs = 0, project = 0, total = 0;
            ResultSet rs11 = st4.executeQuery("SELECT SUM(Cores), SUM(Electives),SUM(Labs), BIT_OR(Projects) FROM " + programmeName + "_" + latestYear + "_currrefer");
            rs11.next();
            
            core = Integer.parseInt(rs11.getString(1));
            electives = Integer.parseInt(rs11.getString(2));
            labs = Integer.parseInt(rs11.getString(3));
            project = Integer.parseInt(rs11.getString(4));
            total = core + labs + electives + project;
            System.out.println("total" + total);
            
            ResultSet rs2 = st5.executeQuery("select * from " + programmeName + "_" + latestYear + "_curriculum where Type='C'");
            rs2.next();
            int i = 1;
            while (i <= core) {
                System.out.println(programmeName + "_" + cur_year + "--" + rs2.getString(2) + "--" + studentId);
                if(rs2.getString(1).equals("I")) {
                    st2.executeUpdate("update " + programmeName + "_" + cur_year + " set core" + i + "='" + rs2.getString(2) + "',c" + i + "grade='R' where StudentId='" + studentId + "'");
                } else {
                    st2.executeUpdate("update " + programmeName + "_" + cur_year + " set core" + i + "='" + rs2.getString(2) + "',c" + i + "grade='NR' where StudentId='" + studentId + "'");
                }
                rs2.next();
                i++;
            }
            
            ResultSet rs3 = st6.executeQuery("select * from " + programmeName + "_" + latestYear + "_curriculum where Type='L'");
            rs3.next();
            i = 1;
            while (i <= labs) {
                if(rs3.getString(1).equals("I")) {
                    st2.executeUpdate("update " + programmeName + "_" + cur_year + " set lab" + i + "='" + rs3.getString(2) + "',l" + i + "grade='R' where StudentId='" + studentId + "'");
                } else {
                    st2.executeUpdate("update " + programmeName + "_" + cur_year + " set lab" + i + "='" + rs3.getString(2) + "',l" + i + "grade='NR' where StudentId='" + studentId + "'");
                }
                rs3.next();
                i++;
            }
            
            ResultSet rs4 = st7.executeQuery("select * from " + programmeName + "_" + latestYear + "_curriculum where Type='P'");
            rs4.next();
            i = 1;
            while (i <= project) {
                st2.executeUpdate("update " + programmeName + "_" + cur_year + " set project" + i + "='" + rs4.getString(2) + "',p" + i + "grade='NR' where StudentId='" + studentId + "'");
                rs4.next();
                i++;
            }
            
            ResultSet rs5 = st8.executeQuery("select * from " + programmeName + "_" + latestYear + "_curriculum where Type='E'");
            rs5.next();
            i = 1;
            while (i <= electives) {
                st2.executeUpdate("update " + programmeName + "_" + cur_year + " set e" + i + "grade='NR' where StudentId='" + studentId + "'");
                rs5.next();
                i++;
            }
            /**Updation of Assessment and Attendance tables**/
            Statement st_up = con.createStatement();
            Statement st_att = con.createStatement();
            Statement st_ass = con1.createStatement();
            String start_sess = "Monsoon";
            int year = cur_year;
            ResultSet rs_up = st_up.executeQuery("SELECT ifnull(Alias, SubCode) FROM " + programmeName +"_" + latestYear + "_curriculum WHERE Semester = 'I'");
            while(rs_up.next()) {
                String sub = rs_up.getString(1);
                try {
                    st_att.executeUpdate("insert ignore into " + sub + "_Attendance_" + start_sess + "_" + year + " (StudentId , StudentName) values('" + studentId + "','" + studentName + "')");
                    st_ass.executeUpdate("insert ignore into " + sub + "_Assessment_" + start_sess + "_" + year + " (StudentId , StudentName) values('" + studentId + "','" + studentName + "')");
                } catch(Exception e) {
                    System.out.println(e);
                }
            }
        }
        if (count != 0) {
%>
            <h1><center>students added to database</center></h1>
<%
        }
        conn.closeConnection();
        con = null;
        conn1.closeConnection();
        con1 = null;
%>
    </body>
</html>