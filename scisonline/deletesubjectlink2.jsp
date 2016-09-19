<%-- 
    Document   : deletesubjectlink2
--%>

<%@include file="checkValidity.jsp"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="connectionBean.jsp"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <% 
        Connection con = conn.getConnectionObj();
        
        try {
                String subject = request.getParameter("subid");
                String subname = request.getParameter("subname");
               // String code = request.getParameter("code");
                
                Statement st1 = con.createStatement();
                Statement st2 = con.createStatement();
                               
                Calendar now = Calendar.getInstance();
                int month = now.get(Calendar.MONTH) + 1;
                int year = now.get(Calendar.YEAR);
                String semester = null;
                
                if (month <= 6) {
                    semester = "Winter";
                } else {
                    semester = "Monsoon";
                }
                
//                if (code == null) {
                    
                    try {
                        con.setAutoCommit(false);
                        
                        st1.executeUpdate("delete from subject_faculty_" + semester + "_" + year + " where subjectid='" + subject + "'");
                        st1.executeUpdate("delete from subject_attendance_" + semester + "_" + year + " where subjectId='" + subject + "'");
                        st1.executeUpdate("delete from " + year + "_" + semester + "_elective where course_name='" + subject + "'");
                       
                        con.commit();
                        out.println("<h2>" + subname + "  deleted successfully. </h2>");
                    } catch (Exception e) {
                        con.rollback();
                        System.out.println(e);
                        out.println("Some internal error...");
                        System.out.println("Transaction rollback.!!!");
                        return;
                    } finally {
                        con.setAutoCommit(true);
                    }
                    st2.executeUpdate("DROP TABLE IF EXISTS " + subject + "_Attendance_" + semester + "_" + year + "");
                    st2.executeUpdate("DROP TABLE IF EXISTS " + subject + "_Assessment_" + semester + "_" + year + "");
                    
//                } else if (code.equalsIgnoreCase("2")) {
//                    try {
//                        con.setAutoCommit(false);
//                        st1.executeUpdate("delete from subjecttable where Code='" + subject + "'");
//                        
//                        out.println("<h2>" + subname + "  deleted successfully. </h2>");
//                        con.commit();
//                    } catch (Exception e) {
//                        con.rollback();
//                        System.out.println("Transaction rollback !!!.");
//                        System.out.println(e);
//                    }
//                    
//                }
            } catch (Exception ex) {
                System.out.println(ex);
            }
        
        conn.closeConnection();
        con = null;
        %>
    </body>
</html>
