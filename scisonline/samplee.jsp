<%-- 
    Document   : samplee
    Created on : Aug 25, 2012, 11:04:49 AM
    Author     : veeru
--%>
<%@include file="checkValidity.jsp"%>
<%@page import="com.hcu.mysql.connection.ConnectionDemo1"%>
<%@ page import="java.io.*,java.util.*, javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page import="org.apache.commons.fileupload.*" %>
<%@ page import="org.apache.commons.fileupload.disk.*" %>
<%@ page import="org.apache.commons.fileupload.servlet.*" %>
<%@ page import="org.apache.commons.io.output.*" %>
<%@include file="dbconnection.jsp"%>
<%@page import="java.sql.*"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
   String value="";
   String value3="";
   String filename="";
   int j=0,k,l=0;
   String[] value1 = new String[50];
   String[] file1 = new String[50];
   
   Statement st1=con.createStatement();
   Statement st2=con.createStatement();
   
   int maxFileSize = 5000 * 1024;
   int maxMemSize = 5000 * 1024;
   ServletContext context = pageContext.getServletContext();
   String filePath = context.getInitParameter("file-upload");
   /*
    *Verify the content type
   */
   String contentType = request.getContentType();
   if ((contentType.indexOf("multipart/form-data") >= 0)) {
        /*
         *
         */
      DiskFileItemFactory factory = new DiskFileItemFactory();
        /*
        *maximum size that will be stored in memory
        */
      
      factory.setSizeThreshold(maxMemSize);
        /*
         * Location to save data that is larger than maxMemSize.
         */
      
      //factory.setRepository(new File("c:\\temp"));
      
      /*
      * Create a new file upload handler
      */
      ServletFileUpload upload = new ServletFileUpload(factory);
      /*
       * maximum file size to be uploaded.
       */
      upload.setSizeMax( maxFileSize );
      try{ 
         /* 
          * Parse the request to get file items.
          */
         List fileItems = upload.parseRequest(request);
        /*
         *Process the uploaded file items
         */
         Iterator i = fileItems.iterator();

         
         out.println("<title>JSP File upload</title>");  
         
         while ( i.hasNext () ) 
         {
            FileItem fi = (FileItem)i.next();
            
           if ( fi.isFormField () )	
            {            
                if(fi.getFieldName().equals("text1")){
                value = fi.getString();
               value3 = value.replace('-','_');
                value1[j]=value3;
               
                j++;
                }   
               
            }
            else
            {
            filename = fi.getName();
            file1[l]=filename;
            l++;
            }
          
     }
         
      for(k=0;k<j;k++)
            {   
                st1.executeUpdate("create table if not exists "+value1[k]+"_curriculum(subjid varchar(20),subjname varchar(100),credits varchar(20),semister varchar(20),sno INT) ");
                String qry2="LOAD DATA INFILE '"+file1[k]+"' INTO TABLE "+value1[k]+"_curriculum FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '\"' LINES TERMINATED BY '\n' (subjid,subjname,credits,semister,sno)"; 
                st2.executeUpdate(qry2);
            }  
      }
        catch(Exception ex) {
         System.out.println(ex);
      }
   }
else{
      out.println("<html>");
      out.println("<head>");
      out.println("<title>Servlet upload</title>");  
      out.println("</head>");
      out.println("<body>");
      out.println("<p>No file uploaded</p>"); 
      out.println("</body>");
      out.println("</html>");
   }
%>