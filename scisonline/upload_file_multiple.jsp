<%-- 
    Document   : upload_file_multiple
    Created on : Jan 6, 2012, 12:24:06 PM
    Author     : jagan
--%>

<%@ page import="java.util.List" %>
   <%@ page import="java.util.Iterator" %>
   <%@ page import="java.io.File" %>
   <%@ page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
   <%@ page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
   <%@ page import="org.apache.commons.fileupload.*"%>
   <%@ page contentType="text/html;charset=UTF-8" language="java" %>
 
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
         <center>
<table border="2">
        <tr>
        <td>
        <h1>Your files  uploaded </h1>
        </td>
        </tr>
   <%
 boolean isMultipart = ServletFileUpload.isMultipartContent(request);
 if (!isMultipart) {
 } else {
           FileItemFactory factory = new DiskFileItemFactory();
           ServletFileUpload upload = new ServletFileUpload(factory);
           List items = null;
           try {
                   items = upload.parseRequest(request);
           } catch (FileUploadException e) {
                   e.printStackTrace();
           }
           Iterator itr = items.iterator();
           while (itr.hasNext()) {
           FileItem item = (FileItem) itr.next();
           if (item.isFormField()) {
               
           } else {
                   try {
                           String itemName = item.getName();
                           File savedFile = new File(config.getServletContext().getRealPath("/")+"files/"+itemName);
                           item.write(savedFile);  
                            out.println("<tr><td><b>Your file has been saved at the loaction:</b></td></tr><tr><td><b>"+config.getServletContext().getRealPath("/")+"files"+"\\"+itemName+"</td></tr>");
                   } catch (Exception e) {
                           e.printStackTrace();
                   }
           }
           }
   }
   %>
    </table>
   </center>
    </body>
</html>
