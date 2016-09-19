<%-- 
    Document   : login2
    Created on : Nov 29, 2011, 8:17:42 AM
    Author     : admin
--%>
<%@include file="checkValidity.jsp"%>
<%@page import ="javax.sql.*" %>
<%@page import="java.sql.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            System.out.println("username is:" + request.getAttribute("user"));
            System.out.println("passwd is:" + request.getParameter("password"));
            if (request.getParameter("user").equals("admin")) {
                if (request.getParameter("password").equals("admin321")) {
                    session.setAttribute("user", request.getParameter("user"));
        %>
        <jsp:forward page="facultymain.jsp"/>
        <%
            }
            // if(request.getParameter("user").equals("student"))
            if (request.getParameter("password").equals("passwd")) {
                session.setAttribute("studentid", request.getParameter("user"));
        %>
        <jsp:forward page="studentmain.jsp" />
        <%
            }
            System.out.println("I am in faculty login page");
        %>
        <%! String fname = "";%>
        <%
            try {
                Class.forName("com.mysql.jdbc.Driver").newInstance();
                System.out.println("driver connected");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/dcis_attendance_system", "root", "");
                System.out.println("database connected");
                Statement st10 = con.createStatement();
                fname = (String) request.getParameter("user");
                String passwd = "";
                String qry10 = "select password from faculty_registration where ID='" + fname + "'";
                ResultSet rs10 = st10.executeQuery(qry10);
                while (rs10.next()) {
                    passwd = rs10.getString(1);
                    System.out.println("password is:" + passwd);
                }
                if (request.getParameter("password").equals(passwd)) {
                    if (fname == null) {
                        fname = "";
                    }
                    session.setAttribute("facultyname", fname);
                    System.out.println(fname);
                    String id = "";
                    //String qry="create table temp(fid varchar(20))";
                    String qry1 = "select ID from faculty_registration where ID='" + fname + "'";
                    String qry2 = "select subjectid,subjectname from subject_faculty where facultyid in (select ID from faculty_registration where ID='" + fname + "') ";
                    Statement st1 = con.createStatement();
                    Statement st2 = con.createStatement();
                    ResultSet rs = st1.executeQuery(qry1);
                    ResultSet rs1 = st2.executeQuery(qry2);
                    while (rs.next()) {
                        System.out.println("" + rs.getString(1));
                        session.setAttribute("user", rs.getString(1));
                    }
                    /* String qry3="select subjectid,subjectname from subject_faculty where facultyid='"+rs.getString(1)+"'";
                     System.out.println("jagan");
                     rs1=st1.executeQuery(qry3);
                     System.out.println("jagan");*/
                    while (rs1.next()) {
                        System.out.println("jagan");
                        System.out.println("" + rs1.getString(1) + "" + rs1.getString(2));
                    }
        %>
        <jsp:forward page="facultymain.jsp" />
        <% }
            } catch (Exception e) {
                e.printStackTrace();
            }
        %>
        <jsp:forward page="login.jsp" />
        <script>
            alert("Invalid password");
        </script>
    </body>
</html>
