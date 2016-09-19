<%-- 
    Document   : update2
    Created on : Nov 14, 2011, 11:24:21 AM
    Author     : admin
--%>
<%@include file="checkValidity.jsp"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.sql.*"%>
<%@ page import="java.io.*" %>
<%@ page import="java.net.*"%>
<%@ page import="javax.swing.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
       
         <% 
         String year=request.getParameter("year");
    String semester=request.getParameter("semester");
            String pa=request.getParameter("pa");
            String ca=request.getParameter("ca");
            int tch=Integer.parseInt(pa)+Integer.parseInt(ca);
            
            System.out.println("total classes held:"+tch);
            String subjectid=(String) session.getAttribute("subjid");
        String sname=(String) session.getAttribute("subjname");
           /* String saveFile=request.getParameter("F1");
            System.out.println(saveFile);
            String file = application.getRealPath("/") + saveFile;
            System.out.println(file);
            String filename=request.getParameter("F2");
            System.out.println(filename);
            int tclasses1=Integer.parseInt(request.getParameter("tclasses"));
            
*/
            
            %>
            
            <%
           // String saveFile="";
           // System.out.println("validating file");
        //to get the content type information from JSP Request Header
       /* String contentType = request.getContentType();
        //here we are checking the content type is not equal to Null and
 //as well as the passed data from mulitpart/form-data is greater than or
 //equal to 0
        if ((contentType != null) && (contentType.indexOf("multipart/form-data") >= 0)) {
            System.out.println("validated file");
                DataInputStream in = new DataInputStream(request.
getInputStream());
                //we are taking the length of Content type data
                int formDataLength = request.getContentLength();
                byte dataBytes[] = new byte[formDataLength];
                int byteRead = 0;
                int totalBytesRead = 0;
                //this loop converting the uploaded file into byte code
                while (totalBytesRead < formDataLength) {
                        byteRead = in.read(dataBytes, totalBytesRead, 
formDataLength);
                        totalBytesRead += byteRead;
                        }
                                        String file = new String(dataBytes);
                //for saving the file name
                saveFile = file.substring(file.indexOf("filename=\"") + 10);
                saveFile = saveFile.substring(0, saveFile.indexOf("\n"));
                saveFile = saveFile.substring(saveFile.lastIndexOf("\\")
 + 1,saveFile.indexOf("\""));
                int lastIndex = contentType.lastIndexOf("=");
                String boundary = contentType.substring(lastIndex + 1,
contentType.length());
                int pos;
                //extracting the index of file 
                pos = file.indexOf("filename=\"");
                pos = file.indexOf("\n", pos) + 1;
                pos = file.indexOf("\n", pos) + 1;
                pos = file.indexOf("\n", pos) + 1;
                int boundaryLocation = file.indexOf(boundary, pos) - 4;
                int startPos = ((file.substring(0, pos)).getBytes()).length;
                int endPos = ((file.substring(0, boundaryLocation)).getBytes()).length;
                // creating a new file with the same name and writing the 
//content in new file
                FileOutputStream fileOut = new FileOutputStream(saveFile);
                fileOut.write(dataBytes, startPos, (endPos - startPos));
                fileOut.flush();
                fileOut.close();*/
                                %> <!-- <Br><table border="2"><tr><td><b>You have successfully upload the file by the name of:</b>
                <%// out.println(saveFile);%></td></tr></table> -->
                <% 
                                              %>
                
                
         <%/*
                String x="/home/admin/Documents/"+saveFile;        
                 try{
  File f1 = new File(file);
  File f2 = new File("/var/lib/mysql/dcis_attendance_system/"+saveFile);
  FileInputStream in1 = new FileInputStream(f1);
  
  //For Append the file.
//  OutputStream out = new FileOutputStream(f2,true);

  //For Overwrite the file.
  OutputStream out1 = new FileOutputStream(f2);

  byte[] buf = new byte[1024];
  int len;
  while ((len = in1.read(buf)) > 0){
  out1.write(buf, 0, len);
  }
  in1.close();
  out1.close();
  System.out.println("File copied.");
  }
  catch(FileNotFoundException ex){
  System.out.println(ex.getMessage() + " in the specified directory.");
  System.exit(0);
  }
  catch(IOException e){
  System.out.println(e.getMessage());  
  }
  
                      
%>           
       
                
                
                
                
                
                
                                
                                
                                
      <%
      
     String subjectid=(String) session.getAttribute("subjid");
        String sname=(String) session.getAttribute("subjname");
       
        System.out.println("**************************************************************************");
     /*   String sname=request.getParameter("subjname");
     if(sname==null) sname="";

//session.setAttribute("facultyname",fname);
    System.out.println(sname);
    System.out.println("***************************************");
        String subjectid="";
        String subjectname="";*/
        String username=(String) session.getAttribute("facultyid");
        
if(username==null) username="";
System.out.println(username);
//String facultyname=request.getParameter("facultyname");
        //System.out.println(facultyname);
String from=request.getParameter("mySelect");
String to=request.getParameter("mySelect1");
                try {
                     String saveFile=(String) session.getAttribute("filename");
    Class.forName("com.mysql.jdbc.Driver").newInstance();
    System.out.println("driver connected");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/dcis_attendance_system", "root", "");
    System.out.println("database connected");
    //String qry="LOAD DATA INFILE '"+saveFile+"' INTO TABLE july_2011_"+subjectid+" FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '\"' LINES TERMINATED BY '\n' (StudentId,StudentName,"+from+"to"+to+")";
    String qry="LOAD DATA INFILE '"+saveFile+"' INTO TABLE temp1 FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '\"' LINES TERMINATED BY '\n' (StudentId,StudentName,column1)";
   // String qry12="LOAD DATA LOCAL INFILE 'temp.csv' INTO TABLE july_2011_"+subjectid+" FIELDS TERMINATED BY ' ' OPTIONALLY ENCLOSED BY ' ' LINES TERMINATED BY '\n' (StudentId,StudentName,JULY15toAUG14,AUG15toSEP14,SEP15toOCT14,OCT15toNOV14,cumatten,percentage)";
    //String qry1="delete from july_2011_"+subjectid+"";
    String qry9="select * from temp1";
    String qry7="delete from temp1";
    String qry2="update subject_attendance set  cumatten='"+tch+"'-"+from+"to"+to+" where subjectId='"+subjectid+"'";
    String qry3="update subject_attendance set  "+from+"to"+to+"='"+ca+"' where subjectId='"+subjectid+"'";
    String qry4="select cumatten from subject_attendance where subjectId='"+subjectid+"'";
    
    
    Statement st1=con.createStatement();
    Statement st5=con.createStatement();
    Statement st6=con.createStatement();
     Statement st10=con.createStatement();
    
   // st1.executeUpdate(qry1);
    st1.executeUpdate(qry7);
    st1.executeUpdate(qry);
    //deleting the file 
     String fileName = "/var/lib/mysql/dcis_attendance_system/"+saveFile;
    // A File object to represent the filename
    File f = new File(fileName);

    // Make sure the file or directory exists and isn't write protected
    if (!f.exists())
      throw new IllegalArgumentException(
          "Delete: no such file or directory: " + fileName);

    if (!f.canWrite())
      throw new IllegalArgumentException("Delete: write protected: "
          + fileName);

    // If it is a directory, make sure it is empty
    if (f.isDirectory()) {
      String[] files = f.list();
      if (files.length > 0)
        throw new IllegalArgumentException(
            "Delete: directory not empty: " + fileName);
         }

    // Attempt to delete it
    boolean success = f.delete();

    if (!success)
      throw new IllegalArgumentException("Delete: deletion failed");
  
                
    st1.executeUpdate(qry2);
    st1.executeUpdate(qry3);
    ResultSet rs7=st6.executeQuery(qry9);
    while(rs7.next())
               {
        String a=rs7.getString(1);
        int b=rs7.getInt(3);
        String qry8="update "+semester+"_"+year+"_"+subjectid+" set  cumatten=cumatten-"+from+"to"+to+" where StudentId='"+rs7.getString(1)+"'";
        String qry10="update "+semester+"_"+year+"_"+subjectid+" set "+from+"to"+to+"='"+rs7.getInt(3)+"' where StudentId='"+rs7.getString(1)+"'";
        st1.executeUpdate(qry8);
        st1.executeUpdate(qry10);
    }
    
    
                
            
         String day="";
    String qry10="select Day(sessiont_date) from current_session1";
    ResultSet rs10=st10.executeQuery(qry9);
    while(rs10.next())
               {
        day=rs10.getString(1);
               }
      
    
                        
    %>
   
      <form action="#" name="frm" method="post">  
    <table align="center" border="0"  cellspacing="5" cellpadding="5" style="color:blue;background-color:#CCFFFF;" width="100%">
            <tr>
                <th>Year<br/><input type="text" name="year" value="<%=year%>" size="10" readonly="readonly" /></th>
                
                <th>From<br/><input type="text" name="from" value="<%=from%>" readonly="readonly"/></th>
 <!--   <select name="mySelect" onChange="display1();">
        <option value=JULY15>JULY15</option>
        <option value=AUG15>AUG15</option>
        <option value=SEP15>SEP15</option>
        <option value=OCT15>OCT15</option>
        <option value=NOV15>NOV15</option>
      </select> -->
     
     
     
                
                <th>To<br/><input type="text" name="from" value="<%=to%>" readonly="readonly"/></th>
                   <!-- <select name="mySelect1">
        <option value=AUG14>AUG14</option>
        <option value=SEP14>SEP14</option>
        <option value=OCT14>OCT14</option>
        <option value=NOV14>NOV14</option>
        <option value=DEC14>DEC14</option>
      </select> -->
                  
                <th>Semester<br/><input type="text" name="semester" value="<%=semester%>" size="10" readonly="readonly" /></th>
                
           <!--     <th>Semester<br/><select width="30" style="width:100px">
                        
                        <option>Winter</option>
                        <option>Summer</option>
                    </select>                   
                </th>
           -->
 <% /* while(rs.next())
                              {
                            System.out.println("within while loop");
                            
                        //System.out.print(""+rs.getString(2)); 
                        subjectid=rs.getString(1);
                        //subjectname=rs.getString(2);
                                               }
                      */ %>
                                   
                <th>Subject<br/><input type="text" name="subjname" value="<%=sname%>" size="25" readonly="readonly" /></th>
                
                <th>Code<br/><input type="text" name="subjid" value="<%=subjectid%>" size="10" readonly="readonly" /></th>
                
            </tr>
    </table>     
           
       <!--     <tr>
                <td> <input type="text" name="Text" value="2011" size="10" readonly="readonly" /></td>
                <td> <input type="text" name="From" value="July15" size="10" readonly="readonly" /></td>
                <td> <input type="text" name="To" value="Aug14" size="10" readonly="readonly" /></td>
                <td>
                    <select width="30" style="width:100px">
                        
                        <option>July</option>
                        <option>January</option>
                    </select>
                </td>
                <td>
                     <form method="POST" action="previousdetails.jsp">
                    <select name="subjectname" >
                        <option>Algorithms</option>
                        
                    </select>
                        
                    </form>
                </td>
                <td><input type="text" name="pa" value="CS708" size="10" readonly="readonly" /></td>
            </tr>
        </table> -->
       <%ResultSet rs2=st5.executeQuery(qry4);
       
       %>
       
       <table border="0" style="color:blue;background-color:#CCFF99" cellspacing="10" cellpadding="0" >
            <tr>
                <td><center>Number of Hours<br/>taught:</center></td>
                <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                
                <%int prev=0;
                    if(rs2.next())
                     { 
        prev=rs2.getInt(1);
prev=prev-Integer.parseInt(ca);%>
                <td>Previous Total<input type="text" name="pa" value="<%=prev%>" readonly="readonly" size="15"/></td>
                <%}else
                                       {%>
                <td>Previous Total<input type="text" name="pa" value="<%=prev%>" readonly="readonly" size="15"/></td>
                
                <% }%>
                
                <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                <td>Current Month<input type="text" name="ca" value="<%=ca%>"  size="15" readonly="readonly" onchange="pta();"/></td>
                <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                <td>Total<input type="text" name="pta" value="<%=Integer.parseInt(ca)+prev%>" readonly="readonly" size="15"/></td>
            </tr>
        </table>
       
       
  <%
                   
   
    System.out.println("database connected");
    String qry8="select * from "+semester+"_"+year+"_"+subjectid+"";
    //String qry4="select attendance from subject_database where Code='"+subjectid+"'";
    String qry5="select StudentId,StudentName,cumatten,percentage from "+semester+"_"+year+"_"+subjectid+" ";
    String qry12="select cumatten from subject_attendance where subjectId='"+subjectid+"'";
    Statement st2=con.createStatement();
    Statement st3=con.createStatement();
    Statement st4=con.createStatement();
   ResultSet rs=st3.executeQuery(qry8);    
   // ResultSet rs1=st2.executeQuery(qry8);
   int tclasses1=0;
    
   ResultSet rs3=st4.executeQuery(qry12);
    
       %>
       
       <%
        while(rs3.next())
                       {
            
            
             tclasses1=rs3.getInt(1);
                         
    %>
   
   <!-- Total number of hours taught:<input type="text" name="pta" value="<%//=rs3.getInt(1)%>" readonly="readonly" size="15"/> -->
    
    <%
            }// rs3.beforeFirst();
       System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"+tclasses1);
    %>
       <br/>
       
       <table border="1" cellspacing="5" cellpadding="5"  align="center">
    <% if(semester.equals("Monsoon"))
        {%>
    <tr>
        <th>Student ID</th>
        <th>Student Name</th>
        <th>July15-Aug14</th>
        <th>Aug15-Sep14</th>
        <th>Sep15-Oct14</th>
        <th>Oct15-Nov14</th>
        <th>Cumulative Attendance</th>
        <th>Overall Percentage</th>
              
    </tr>
   <% }else
             {%>
             <tr>
        <th>Student ID</th>
        <th>Student Name</th>
        <th>Jan<%=day%>-Jan31</th>
        <th>Feb1-Feb29</th>
        <th>Mar1-Mar31</th>
        <th>Apr1-Apr30</th>
        <th>Cumulative Attendance</th>
        <th>Overall Percentage</th>
              
    </tr>
             
             <%}%>
    
    
    <% while(rs.next())
     {
        %>
        <tr>
            <td><%=rs.getString(1)%></td>
            <td><%=rs.getString(2)%></td>
            <td><%=rs.getInt(3)%></td>
            <td><%=rs.getInt(4)%></td>
            <td><%=rs.getInt(5)%></td>
            <td><%=rs.getInt(6)%></td>
            <% int l=(rs.getInt(3)+rs.getInt(4)+rs.getInt(5)+rs.getInt(6));
            %>
            <td><%=l%></td>
            <% float k=(float)l/tclasses1;
            System.out.println(k);
            k=k*100;
        %>
            <td><%=k%> </td>
        </tr>
       <%
       
       String qry6="update "+semester+"_"+year+"_"+subjectid+" set cumatten='"+l+"', percentage='"+k+"' where StudentId='"+rs.getString(1)+"' ";
       st4.executeUpdate(qry6);
             
      
             }
       %> 
        
    
</table>
       
      <%
             }
             catch(Exception e)
             {
                 e.printStackTrace();
                                 }
        
       
      %>
         
</form>
            
            
 
<%
    
%>
    </body>
</html>
