<%-- 
    Document   : browseMarks
    Created on : 7 Feb, 2012, 1:00:06 AM
    Author     : khushali
--%>
<%@include file="checkValidity.jsp"%>
<%@page import="com.hcu.mysql.connection.ConnectionDemo3"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.sql.*"%>
<%@ page import="java.io.*" %>
<%@ page import="javax.swing.*"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.io.File"%>
<%@page import="java.io.IOException"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="javax.servlet.RequestDispatcher"%>
<%@page import="javax.servlet.ServletConfig"%>
<%@page import="javax.servlet.ServletException"%>
<%@page import="javax.servlet.http.HttpServlet"%>
<%@page import="javax.servlet.http.HttpServletRequest"%>
<%@page import="javax.servlet.http.HttpServletResponse"%>
<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@page import="org.apache.commons.fileupload.FileUploadException"%>
<%@page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@page errorPage="error.jsp?msg=Application Generated an error!" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" type="text/css" href="button.css">

        <script>
            function change()
            {
                document.forms.frm.submit();
            }
        </script>
    </head>
    <body>
        <%
            Calendar now = Calendar.getInstance();

            System.out.println("Current date : " + (now.get(Calendar.MONTH) + 1)
                    + "-"
                    + now.get(Calendar.DATE)
                    + "-"
                    + now.get(Calendar.YEAR));
            int month = now.get(Calendar.MONTH) + 1;
            int year = now.get(Calendar.YEAR);
            int flag = 0;
            System.out.println("Current Month:" + month);
            System.out.println("Current Year:" + year);
            String sem = "";
            if (month >= 7) {
                sem = "Monsoon";
            } else if (month >= 1 && month <= 6) {
                sem = "Winter";
            }
            System.out.println("************************browseMarks*********************************");
            System.out.println("**************************************************************************");
            String MARKS = (String) session.getAttribute("selectmarks");
            System.out.println(MARKS);
            System.out.println("**************************************************************************");
            System.out.println("**************************************************************************");
            String subjectid = (String) session.getAttribute("subjid");
            String sname = (String) session.getAttribute("subjname");
            //String marks=(String) session.getAttribute("marks");  
%>
        <FORM   id="frm1" name="frm" ACTION="updateCsvData.jsp" METHOD=POST>

            <table align="center" border="0"  cellspacing="5" cellpadding="5" style="color:blue;background-color:#CCFFFF;" width="100%">
                <tr>
                    <th>Subject<br/><input type="text" name="subjname" value="<%=sname%>" size="25" readonly="readonly" />                    
                    </th>
                    <th>Code<br/><input type="text" name="subjid" value="<%=subjectid%>" size="10" readonly="readonly" />                            
                    </th>
                </tr>
            </table>&nbsp;&nbsp;

            <%       try {
                    // Class.forName("com.mysql.jdbc.Driver").newInstance();
                    System.out.println("driver connected");
                    // Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/dcis_assessment", "root", "");
                    System.out.println("database connected");
                    String qry10 = "select * from " + subjectid + "_Assessment_" + sem + "_" + year;
                    Statement st10 = ConnectionDemo3.getStatementObj().createStatement();
                    ResultSet rs10 = st10.executeQuery(qry10);
                    while (rs10.next()) {
                        String reg_num = rs10.getString(1);
                    }
                    /*String qry4="select cumatten from subject_attendance where subjectId='"+subjectid+"'";
                     String qry5="select StudentId,StudentName,cumatten,percentage from july_2011_"+subjectid+" ";
                     Statement st2=con.createStatement();
                     Statement st3=con.createStatement();
                     ResultSet rs4=st3.executeQuery(qry4);    
                     ResultSet rs1=st2.executeQuery(qry5);*/
                } catch (Exception e) {
                    e.printStackTrace();
                }
            %>
        </form>
        <FORM  id="frm2" name="frm2" action="#" ENCTYPE="multipart/form-data"  METHOD=POST>

            <center>
                <table border="0">
                    <tr>
                        <td><b>Choose the file To Upload:</b>
                            <INPUT NAME="F1" TYPE="file" class="Button">&nbsp;&nbsp;&nbsp;<INPUT TYPE="submit" VALUE="Upload" class="Button" onclick=" change();"/>
                            <%
                                try {
                                    //to get the content type information from JSP Request Header
                                    String contentType = request.getContentType();
                                    System.out.println("step1");
                                    //here we are checking the content type is not equal to Null andas well as the passed data from mulitpart/form-data is greater than orequal to 0
                                    if ((contentType != null) && (contentType.indexOf("multipart/form-data") >= 0)) {
                                        System.out.println("step2");
                                        DataInputStream in = new DataInputStream(request.getInputStream());
                                        //we are taking the length of Content type data
                                        int formDataLength = request.getContentLength();
                                        formDataLength = formDataLength;
                                        System.out.println(formDataLength);
                                        byte dataBytes[] = new byte[formDataLength];
                                        int byteRead = 0;
                                        int totalBytesRead = 0;
                                        //this loop converting the uploaded file into byte code
                                        while (totalBytesRead < formDataLength) {
                                            System.out.println("step3");
                                            byteRead = in.read(dataBytes, totalBytesRead, formDataLength);
                                            System.out.println(byteRead);
                                            totalBytesRead += byteRead;
                                            System.out.println(totalBytesRead);
                                        }
                                        System.out.println("step4");
                                        String file = new String(dataBytes);
                                        //for saving the file name
                                        String saveFile = file.substring(file.indexOf("filename=\"") + 10);
                                        System.out.println(saveFile);
                                        saveFile = saveFile.substring(0, saveFile.indexOf("\n"));
                                        // System.out.println( saveFile);
                                        saveFile = saveFile.substring(saveFile.lastIndexOf("\\") + 1, saveFile.indexOf("\""));
                                        int lastIndex = contentType.lastIndexOf("=");
                                        String boundary = contentType.substring(lastIndex + 1, contentType.length());
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
                                        //   String realPath =getServletContext().getRealPath("/");
                                        // System.out.println(realPath);
                                        FileOutputStream fileOut = new FileOutputStream("/var/lib/mysql/dcis_assessment/" + saveFile);
                                        fileOut.write(dataBytes, startPos, (endPos - startPos));
                                        System.out.println("step6");
                                        fileOut.flush();
                                        fileOut.close();
                            %><table border="0" align="center">
                                <tr>
                                    <td
                                        <b>You have successfully upload the file by the name of:</b>
                                        <% out.println(saveFile);
                                            session.setAttribute("filename", saveFile);
                                            flag++;
                                        %>
                                    </td>
                                </tr>
                                &nbsp;  &nbsp;  
                                <tr>
                                    <td align="center"><b style="color: royalblue"> **Now click on Next button to submit**</b></td>
                                </tr>

                            </table> 

                            <%
                                    }
                                } catch (Exception e) {
                                    e.printStackTrace();
                                    System.out.println(e);
                                }

                                i++;
                            %>
                            &nbsp;
                            <%if (flag > 0) {%>
                    <center><input type="button" name="submit" value="Next"  class="Button" onclick="javascript:document.frm.submit();" /></center></td></tr></table></center>
                        <%}%>
        </form>
        <%!public static int i = 0;
            public static String name = "";
        %>

    </body>
</html>
