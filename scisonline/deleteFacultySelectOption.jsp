<%-- 
    Document   : deleteFacultySelectOption
    Created on : 1 Apr, 2013, 4:05:11 PM
    Author     : varun
--%>

<%@include file="checkValidity.jsp"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.hcu.mysql.connection.ConnectionDemo1"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.Calendar"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>  



        <%

            String faculty = request.getParameter("sel");
            Calendar now = Calendar.getInstance();
            int month = now.get(Calendar.MONTH) + 1;
            int year = now.get(Calendar.YEAR);
            String semester = "";
            if (month <= 6) {
                semester = "Winter";
            } else {
                semester = "Monsoon";
            }
            session.setAttribute("oldfaculty", faculty);
            Statement st1 = ConnectionDemo1.getStatementObj().createStatement();
            Statement st2 = ConnectionDemo1.getStatementObj().createStatement();
            ResultSet rs = st1.executeQuery("Select * from subjecttable where Code in(Select subjectid from subject_faculty_" + semester + "_" + year + " where facultyid1 in (Select ID from faculty_data where ID='" + faculty + "') or facultyid2 in (Select ID from faculty_data where ID='" + faculty + "') )");
            // rs contains the subjects taught by the faculty going to be deleted.

            HashMap<String, String> hmap = new HashMap<String, String>();
            ArrayList a = new ArrayList(100);
            //rs.beforeFirst();
            try {
                while (rs.next()) {
                    hmap.put(rs.getString(1), rs.getString(2));
                    System.out.println(rs.getString(1) + rs.getString(2));
                    a.add(rs.getString(1));
                }

                session.setAttribute("arraylist", a);
                session.setAttribute("hashmap", hmap);

                System.out.println(hmap);
            } catch (Exception ex) {
                ex.printStackTrace();
            }
            response.sendRedirect("deleteFacultyLink1.jsp");
        %>        


    </body>


</html>
