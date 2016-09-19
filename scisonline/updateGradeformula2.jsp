<%-- 
    Document   : updateGradeformula2
    Created on : 4 Apr, 2012, 2:15:16 PM
    Author     : khushali
--%>

<%@page import="java.sql.DriverManager"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.io.FileReader"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="java.io.DataInputStream"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<%
String stream=(String) session.getAttribute("stream1");
System.out.println("stream name is:"+stream);
String contentType = request.getContentType();
if ((contentType != null) && (contentType.indexOf("multipart/form-data") >= 0)) {
DataInputStream in = new DataInputStream(request.getInputStream());
int formDataLength = request.getContentLength();
byte dataBytes[] = new byte[formDataLength];
int byteRead = 0;
int totalBytesRead = 0;

while (totalBytesRead < formDataLength) {
byteRead = in.read(dataBytes, totalBytesRead, formDataLength);
totalBytesRead += byteRead;
}
String file = new String(dataBytes);
String saveFile = file.substring(file.indexOf("filename=\"") + 10);
System.out.println("saveFile=" + saveFile);
saveFile = saveFile.substring(saveFile.lastIndexOf("\\")+ 1,saveFile.indexOf("\""));
System.out.println("saveFile" + saveFile);
saveFile = file.substring(file.indexOf("filename=\"") + 10);
saveFile = saveFile.substring(0, saveFile.indexOf("\n"));
saveFile = saveFile.substring(saveFile.lastIndexOf("\\")+ 1,saveFile.indexOf("\""));
int lastIndex = contentType.lastIndexOf("=");
String boundary = contentType.substring(lastIndex + 1,contentType.length());
int pos;

pos = file.indexOf("filename=\"");
pos = file.indexOf("\n", pos) + 1;
pos = file.indexOf("\n", pos) + 1;
pos = file.indexOf("\n", pos) + 1;
int boundaryLocation = file.indexOf(boundary, pos) - 4;
int startPos = ((file.substring(0, pos)).getBytes()).length;
int endPos = ((file.substring(0, boundaryLocation)).getBytes()).length;

FileOutputStream fileOut = new FileOutputStream(saveFile);
fileOut.write(dataBytes, startPos, (endPos - startPos));
%>
<b>File <% out.println(saveFile); %> has been uploaded and inserted into Database.</b>
<%Connection con=null;
Statement pst=null;
String line = null;
String value=null;
try{
StringBuilder contents = new StringBuilder();
BufferedReader input = new BufferedReader(new FileReader(saveFile));
while (( line = input.readLine()) != null){
contents.append(line);
}
value = contents.toString();
System.out.println("Value:"+value);
Class.forName("com.mysql.jdbc.Driver");
con=DriverManager.getConnection
   ("jdbc:mysql://localhost:3306/dcis_assessment", "root", ""); 
 Statement st1=con.createStatement();
 String qry1="delete from "+stream+"_grade_table ";
 st1.executeUpdate(qry1);
 System.out.println(qry1);
pst=con.createStatement();
int val = pst.executeUpdate("LOAD DATA INFILE '"+saveFile+"' INTO TABLE "+stream+"_grade_table FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '\"' LINES TERMINATED BY '\n' ");
}
catch(Exception e)
{}
}
%>
</html>