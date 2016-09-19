<%-- 
    Document   : facultyinfo
--%>

<%@include file="checkValidity.jsp"%>
<%@page import="java.io.*"%>
<%@page import ="javax.sql.*" %>
<%@include file="connectionBean.jsp"%>
<%@page import="java.sql.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page errorPage="error.jsp?msg=Application Generated an error!" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <form action="Commonsfileuploadservlet1" enctype="multipart/form-data" method="POST">
            <input type="hidden" name="check" value="2" />
            <table align="center" border="0" cellpadding="5" cellspacing="5">
                <tr> <th colspan="2"><font size="6">Faculty Information </font></th></tr>

                <tr><td align="center"><font size="5">Upload the faculty file(.csv)</font></td></tr>
                <tr><td colspan="2" align="center"><input type="file" name="file1" />
                        <input type="Submit" value="Upload File"/><br></td></tr>
            </table>
        </form>
    </body>
    <%
        Connection con = conn.getConnectionObj();
    
        String p1 = (String) request.getAttribute("name1");
        String saveFile = (String) request.getAttribute("filename");
        try {
            //File f1 = new File("/user/jagan/NetBeansProjects/AttendanceSystem/build/web/"+saveFile);
            String realPath = getServletContext().getRealPath("/");
            //realPath=realPath+"/";
            File f1 = new File(realPath + saveFile);

            File f2 = new File("/var/lib/mysql/dcis_attendance_system/" + saveFile);
            InputStream in = new FileInputStream(f1);

            //For Append the file.
//  OutputStream out = new FileOutputStream(f2,true);

            //For Overwrite the file.
            OutputStream out1 = new FileOutputStream(f2);

            byte[] buf = new byte[1024];
            int len;
            while ((len = in.read(buf)) > 0) {
                out1.write(buf, 0, len);
            }


            System.out.println("File copied.");


            Statement st1 = con.createStatement();
            Statement st2 = con.createStatement();
            Statement st3 = con.createStatement();

            st1.executeUpdate("drop table if exists faculty_data");
            st3.executeUpdate("create table faculty_data(ID varchar(20),Faculty_Name varchar(30),Organization varchar(30),primary key(ID))");


            String qry2 = "LOAD DATA INFILE '" + saveFile + "' INTO TABLE faculty_data FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '\"' LINES TERMINATED BY '\n' (ID,Faculty_Name,Organization)";
            st2.executeUpdate(qry2);
            out.println("<center><h1>File uploaded sucessfully</h1></center>");
            f1.delete();
            f2.delete();
            
            st1.close();
            st2.close();
            st3.close();
        } catch (Exception e) {
            e.printStackTrace();
            //out.println("<center><h1>File not  uploaded sucessfully</h1></center>");
        }
        
        conn.closeConnection();
        con = null;
    %>
    
</html>
