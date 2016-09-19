<%-- 
    Document   : userinfolink
    Created on : May 27, 2014, 7:38:11 PM
    Author     : veeru
--%>
<%@page import="java.io.InputStream"%>
<%@page import="java.io.FileReader"%>
<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.File"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>

<%@ include file="dbconnection.jsp" %>
<%@include file="programmeRetrieveBeans.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>

        <%            System.out.println("jjjjj");
            String userId = (String) request.getAttribute("par1");
            session.setAttribute("useriiiiid", userId);
            String emailId = (String) request.getAttribute("par2");
            String mobileNo = (String) request.getAttribute("par3");
            String dob = (String) request.getAttribute("par4");
            try {
                dob = dob.replace('/', '-');
            } catch (Exception e) {
            }

            String address = (String) request.getAttribute("par5");

            String gendar = (String) request.getAttribute("par6");
            String userRole = (String) request.getAttribute("par7");
            String strpath = (String) request.getAttribute("filename");
            System.out.println(userId + emailId + mobileNo + dob + address + gendar + userRole + strpath);

            String realPath = getServletContext().getRealPath("/");
            File f1 = new File(realPath + "/" + strpath);
            FileInputStream fin = new FileInputStream(f1);

            PreparedStatement pst = null;
            try {
                con.setAutoCommit(false);
                pst = con.prepareStatement("delete from userinfo where userId=?");
                pst.setString(1, userId);
                pst.executeUpdate();
                pst = con.prepareStatement("insert into userinfo values(?,?,?,?,?,?,?,?);");
                pst.setString(1, userId);
                pst.setString(2, emailId);
                pst.setString(3, mobileNo);
                pst.setString(4, dob);
                pst.setString(5, address);
                pst.setString(6, gendar);
                pst.setString(7, userRole);
                pst.setBinaryStream(8, fin, fin.available());

                pst.executeUpdate();

                con.commit();
            } catch (Exception e) {
                con.rollback();
                System.out.println(e);
            } finally {
                con.setAutoCommit(true);
            }


        %>
        <table align="center" border="1">
            <tr>
                <td>
                    <table align=center width="100%"><tr height=20%>
                        <tr>
                            <td width="50%"><p  align="left">
                                    <img src="imageretrieveservlet.jsp?Userid=12MCMT54" width="100" height="150" /><br>
                                    <b>Veeranna Badavath</b>
                                    entrepreneur<br>
                                    <font size="-1">MTech., University of Hyderabad, India</font></p></td>
                            <td width="15%">&nbsp;</td>
                            <td width="100%"><h2>Contact Address:</h2>
                                SCIS, University of Hyderabad,<br>
                                Central University P.O,<br>
                                Hyderabad - 500 046.<br>
                                INDIA.<br><br>
                                Phone: 9618931363<br>
                                <b>benny.victor91@gmail.com</b></td>

                            <td width="25%">
                                <%//                                    pst = con.prepareStatement("SELECT photo FROM userinfo WHERE Userid = ?");
//                                    pst.setString(1, userId); // here integer number '11' is image id from the table
//                                    ResultSet rs = pst.executeQuery();
//                                     
//                                   
//                                    if (rs.next()) {
//                                        byte[] bytearray = new byte[1048576];
//                                        
//                                        int size = 0;
//                                        InputStream sImage = rs.getBinaryStream(1);
//                                        response.reset();
//                                        response.setContentType("image/jpeg");
//                                         out.println(bytearray);
//                                        while ((size = sImage.read(bytearray)) != -1) {
//                                            response.getOutputStream().write(bytearray, 0, size);
//                                        }
//                                    }

                                %>
                            </td>


                        </tr>
                    </table>

                </td>
            </tr>
        </table>   
    </body>
</html>
