<%-- 
    Document   : imageretrieveservlet
    Created on : May 28, 2014, 11:38:53 AM
    Author     : veeru
--%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@include file="dbconnection.jsp"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    </head>
    <body>

        <%            
            String Userid=request.getParameter("Userid");
            ResultSet rs = null;
            PreparedStatement pstmt = null;
            OutputStream oImage;
            try {
                pstmt = con.prepareStatement("select photo from userinfo where Userid=?");
                pstmt.setString(1, Userid);
                rs = pstmt.executeQuery();
                if (rs.next()) {
                    byte barray[] = rs.getBytes(1);
                    response.setContentType("image/gif");
                    oImage = response.getOutputStream();
                    oImage.write(barray);
                    oImage.flush();
                    oImage.close();
                }
            } catch (Exception ex) {
    //ex.printStackTrace();
            } finally {
                try {
                    if (con != null) {
                        con.close();
                    }
                } catch (Exception ex) {
                    // ex.printStackTrace();
                }
            }
             %>
    </body>
</html>