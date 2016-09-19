<%-- 
    Document   : fileupload
    Created on : Dec 27, 2011, 4:18:51 PM
    Author     : jagan
--%>

<%@include file="checkValidity.jsp"%>

<%@page import ="java.io.File" %>
<%@page import ="java.io.IOException" %>
<%@page import ="java.io.PrintWriter" %>
<%@page import ="java.util.Iterator" %>
<%@page import ="java.util.List" %>
<%@page import ="java.io.File" %>
<%@page import ="javax.servlet.ServletConfig" %>
<%@page import ="javax.servlet.ServletException" %>
<%@page import ="javax.servlet.http.HttpServlet" %>
<%@page import ="javax.servlet.http.HttpServletRequest" %>
<%@page import ="javax.servlet.http.HttpServletResponse" %>
<%@page import ="java.io.File" %>
<%@page import ="org.apache.commons.fileupload.FileItem" %>
<%@page import ="org.apache.commons.fileupload.FileUploadException" %>
<%@page import ="org.apache.commons.fileupload.disk.DiskFileItemFactory" %>
<%@page import ="org.apache.commons.fileupload.servlet.ServletFileUpload" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%!
      private static final String TMP_DIR_PATH = "c:\\tmp";
	private File tmpDir;
	private static final String DESTINATION_DIR_PATH ="/files";
	private File destinationDir;
 
	public void init(ServletConfig config) throws ServletException {
		super.init(config);
		tmpDir = new File(TMP_DIR_PATH);
		if(!tmpDir.isDirectory()) {
			throw new ServletException(TMP_DIR_PATH + " is not a directory");
		}
		String realPath = getServletContext().getRealPath(DESTINATION_DIR_PATH);
		destinationDir = new File(realPath);
		if(!destinationDir.isDirectory()) {
			throw new ServletException(DESTINATION_DIR_PATH+" is not a directory");
		}
 
	}
 
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    PrintWriter out = response.getWriter();
	    response.setContentType("text/plain");
	    out.println("<h1>Servlet File Upload Example using Commons File Upload</h1>");
	    out.println();
 
		DiskFileItemFactory  fileItemFactory = new DiskFileItemFactory ();
		/*
		 *Set the size threshold, above which content will be stored on disk.
		 */
		fileItemFactory.setSizeThreshold(1*1024*1024); //1 MB
		/*
		 * Set the temporary directory to store the uploaded files of size above threshold.
		 */
		fileItemFactory.setRepository(tmpDir);
 
		ServletFileUpload uploadHandler = new ServletFileUpload(fileItemFactory);
		try {
			/*
			 * Parse the request
			 */
			List items = uploadHandler.parseRequest(request);
			Iterator itr = items.iterator();
			while(itr.hasNext()) {
				FileItem item = (FileItem) itr.next();
				/*
				 * Handle Form Fields.
				 */
				if(item.isFormField()) {
					out.println("File Name = "+item.getFieldName()+", Value = "+item.getString());
				} else {
					//Handle Uploaded files.
					out.println("Field Name = "+item.getFieldName()+
						", File Name = "+item.getName()+
						", Content type = "+item.getContentType()+
						", File Size = "+item.getSize());
					/*
					 * Write file to the ultimate location.
					 */
					File file = new File(destinationDir,item.getName());
					item.write(file);
				}
				out.close();
			}
		}catch(FileUploadException ex) {
			log("Error encountered while parsing the request",ex);
		} catch(Exception ex) {
			log("Error encountered while uploading file",ex);
		}
 
	}
               
        %>
        <h1>Hello World!</h1>
    </body>
</html>
