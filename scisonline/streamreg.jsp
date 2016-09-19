<%-- 
    Document   : streamreg
    Created on : Dec 22, 2011, 3:26:49 PM
    Author     : jagan
--%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.sql.*"%>
<%@ page import="java.io.*" %>
<%@include file="checkValidity.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
      <%  
      String stream=request.getParameter("stream");
      System.out.println(stream);
      String year=request.getParameter("year");
      System.out.println(year);
      try
      {
          ;
     String saveFile=(String) session.getAttribute("streamfile");
    Class.forName("com.mysql.jdbc.Driver").newInstance();
    System.out.println("driver connected");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/dcis_attendance_system", "root", "");
    Statement st1=con.createStatement();
    Statement st2=con.createStatement();
    Statement st3=con.createStatement();
   
    String qry1="create table "+stream+"_"+year+"(studentid varchar(20),studentname varchar(50),primary key(studentid))";
    st1.executeUpdate(qry1);
    
    String qry2="LOAD DATA INFILE '"+saveFile+"' INTO TABLE "+stream+"_"+year+" FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '\"' LINES TERMINATED BY '\n' (studentid,studentname)"; 
    st2.executeUpdate(qry2);    
     }
      catch(Exception e)
                           {
          e.printStackTrace();
      }
    %>
    
    <%
        
        try
                               {
        //to get the content type information from JSP Request Header
        String contentType = request.getContentType();
        System.out.println("step1");
        //here we are checking the content type is not equal to Null andas well as the passed data from mulitpart/form-data is greater than orequal to 0
        if ((contentType != null) && (contentType.indexOf("multipart/form-data") >= 0)) {
            System.out.println("step2");
                DataInputStream in = new DataInputStream(request.getInputStream());
                //we are taking the length of Content type data
                int formDataLength = request.getContentLength();
                byte dataBytes[] = new byte[formDataLength];
                int byteRead = 0;
                int totalBytesRead = 0;
                //this loop converting the uploaded file into byte code
                while (totalBytesRead < formDataLength) {
                     System.out.println("step3");
                        byteRead = in.read(dataBytes, totalBytesRead, formDataLength);
                        totalBytesRead += byteRead;
                        }
                 System.out.println("step4");
                String file = new String(dataBytes);
                //for saving the file name
                String saveFile = file.substring(file.indexOf("filename=\"") + 10);
                saveFile = saveFile.substring(0, saveFile.indexOf("\n"));
                saveFile = saveFile.substring(saveFile.lastIndexOf("\\")+ 1,saveFile.indexOf("\""));
                int lastIndex = contentType.lastIndexOf("=");
                String boundary = contentType.substring(lastIndex + 1,contentType.length());
                int pos;
                //extracting the index of file 
                pos = file.indexOf("filename=\"");
                pos = file.indexOf("\n", pos) + 1;
                pos = file.indexOf("\n", pos) + 1;
                pos = file.indexOf("\n", pos) + 1;
                int boundaryLocation = file.indexOf(boundary, pos) - 4;
                int startPos = ((file.substring(0, pos)).getBytes()).length;
                int endPos = ((file.substring(0, boundaryLocation)).getBytes()).length;
                 System.out.println("step5");
                // creating a new file with the same name and writing the content in new file
                FileOutputStream fileOut = new FileOutputStream("/var/lib/mysql/dcis_attendance_system/"+saveFile);
                fileOut.write(dataBytes, startPos, (endPos - startPos));
                 System.out.println("step6");
                fileOut.flush();
                fileOut.close();
                                %><table border="0" align="center"><tr><td><b>You have successfully upload the file by the name of:</b>
                <% out.println(saveFile);
                session.setAttribute("currfile",saveFile);%></td></tr></table> 
                <%
                }
}
        catch(Exception e)
               {
e.printStackTrace();
}
%>
<form action="mtechcurr.jsp" method="POST">
        <table align="center" border="0"  cellspacing="0" cellpadding="0" style="color:blue;background-color:#CCFFFF;" width="100%"> 
            <tr>
                <th>Stream<input type="text" name="stream" value="<%=stream%>" readonly="readonly"/></th>
                <th>Year<input type="text" name="year" value="<%=year%>" readonly="readonly" /></th>
            </tr>
        </table>
                <FORM  ENCTYPE="multipart/form-data"  METHOD=POST>
                    <center>
          <table border="0">
                    <tr><td><b>Upload the curriculam file:</b></td></tr>
                    <tr><td><INPUT NAME="F1" TYPE="file"><INPUT TYPE="submit" VALUE="Add" ></td></tr>
             </table>    
                    </center>
        </FORM>
           
</form> 
        <h1>Hello World!</h1>
    </body>
</html>
