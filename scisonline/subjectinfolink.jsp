<%-- 
    Document   : subjectinfolink
    Created on : Oct 11, 2013, 2:52:42 PM
    Author     : veeru
--%>
<%@page import="java.io.*"%>
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
            String saveFile = (String) request.getAttribute("filename");
            try {
                String realPath = getServletContext().getRealPath("/");
                File f1 = new File(realPath + saveFile);
                File f2 = new File("/var/lib/mysql/dcis_attendance_system/" + saveFile);
                InputStream in = new FileInputStream(f1);
                OutputStream out1 = new FileOutputStream(f2);
                byte[] buf = new byte[1024];
                int len;
                while ((len = in.read(buf)) > 0) {
                    out1.write(buf, 0, len);
                }
                System.out.println("File copied.");
                Class.forName("com.mysql.jdbc.Driver").newInstance();
                System.out.println("driver connected");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/dcis_attendance_system", "root", "");
                Statement st1 = con.createStatement();
                Statement st2 = con.createStatement();
                Statement st3 = con.createStatement();
                st1.executeUpdate("create table if not exists subjecttable(Code varchar(20),Subject_Name varchar(100),credits varchar(20),type varchar(20),primary key(Code))");
                String qry2 = "LOAD DATA INFILE '" + saveFile + "' INTO TABLE subjecttable FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '\"' LINES TERMINATED BY '\n' (Code,Subject_Name,credits,type)";
                st2.executeUpdate(qry2);
                out.println("<center><h1>File uploaded sucessfully</h1></center>");
            } catch (Exception e) {
                out.println("<center><h1>File not uploaded sucessfully</h1></center>");
                e.printStackTrace();
            }
        %>
    </body>
</html>
