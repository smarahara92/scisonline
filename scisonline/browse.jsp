<%-- 
    Document   : browse
    Created on : Nov 4, 2011, 10:04:38 AM
    Author     : admin
--%>
<%@include file="checkValidity.jsp"%>
<%@page import="java.util.regex.Matcher"%>
<%@page import="java.util.regex.Pattern"%>
<%@page import="java.util.Calendar"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.sql.*"%>
<%@ page import="java.io.*" %>
<%@ page import="javax.swing.*"%>
<%-- <%@include file="dbconnection.jsp"%>--%>
<%@include file="connectionBean.jsp"%>
<%@page errorPage="error.jsp?msg=Application Generated an error!" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <Script Language="JavaScript">
            function doThis() {
                document.frm.submit();

            }
        </Script>
    </head>
    <body>
        <%            PreparedStatement pst = null;
                       Connection con = conn.getConnectionObj();
            try {

                String subjectid = (String) session.getAttribute("subjid");
                String sname = (String) session.getAttribute("subjname");
                Calendar now = Calendar.getInstance();
                int month = now.get(Calendar.MONTH) + 1;
                String from = "";
                String to = "";
                String year = request.getParameter("year");
                String semester = request.getParameter("semester");
                from = request.getParameter("mySelect1");
                String sd = from.substring(0, 1);
                System.out.println("value is");
                session.setAttribute("sd", sd);
                from = from.substring(1);
                to = request.getParameter("mySelect2");
                to = to.substring(1);
                String subjectName = request.getParameter("subjname");
                String subjectId = request.getParameter("subjid");
                String pa = request.getParameter("pa");
                String ca = request.getParameter("ca");
                String pta = request.getParameter("pta");
                pa = pa.trim();// previous attendance
                ca = ca.trim(); // current ''
                pta = pta.trim(); // total '' '
                int cur_attend = Integer.parseInt(ca);
        %>

        <FORM   id="frm1" name="frm" ACTION="update3.jsp" METHOD=POST>
            <table align="center" border="0"  cellspacing="5" cellpadding="5" style="color:blue;background-color:#CCFFFF;" width="100%">
                <tr>
                    <th>Year<br/><input type="text" name="year" value="<%=year%>" size="6" readonly="readonly" /></th>

                    <th>From<br/><input type="text" name="mySelect" value="<%=from%>" size="6" readonly="readonly"/></th>

                    <th>To<br/><input type="text" name="mySelect1" value="<%=to%>" size="6" readonly="readonly"/></th>

                    <th>Semester<br/><input type="text" name="semester" value="<%=semester%>" size="10" readonly="readonly" /></th>

                    <th>Subject<br/><input type="text" name="subjname" value="<%=sname%>" size="25" readonly="readonly" />                    
                    </th>

                    <th>Code<br/><input type="text" name="subjid" value="<%=subjectid%>" size="10" readonly="readonly" />                            
                    </th>
                </tr>
            </table>
            <% 
                try {
                    pst = con.prepareStatement("select cumatten from subject_attendance_" + semester + "_" + year + " where subjectId=?");
                    pst.setString(1, subjectid);
                    ResultSet rs4 = pst.executeQuery();

                    pst = con.prepareStatement("select StudentId,StudentName,cumatten,percentage from " + subjectId + "_Attendance_" + semester + "_" + year + " ");
                    ResultSet rs1 = pst.executeQuery();
            %>
            <table border="0" style="color:blue;background-color:#CCFF99" cellspacing="10" cellpadding="0" >
                <tr>
                    <td><center>Number of Hours<br/>taught:</center></td>
                <td>&nbsp;</td>
                <td>Previous Total<input type="text" name="pa1" value="<%=pa%>" readonly="readonly" size="15"/></td>

                <td>&nbsp;</td>
                <td>Current Month<input type="text" name="ca1" value="<%=ca%>"  readonly="readonly" size="15"/></td>
                <td>&nbsp;</td>
                <td>Total<input type="text" name="pta" value="<%=Integer.parseInt(pa) + Integer.parseInt(ca)%>" readonly="readonly" size="15"/></td>
                </tr>
            </table>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
            <%
                } catch (Exception e) {
                    e.printStackTrace();
                }
            %>
        </form>
        <FORM  id="frm2" name="frm2" action="#" ENCTYPE="multipart/form-data"  METHOD="POST">

            <center>
                <table border="0" align="center">
                    <tr><td><b>Choose the file To Upload:</b>
                            <INPUT NAME="F1" TYPE="file"><INPUT TYPE="submit" VALUE="Upload" onclick=" change();"/>

                            <%
                                try {
                                    con.setAutoCommit(false);
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
                                        saveFile = saveFile.substring(0, saveFile.indexOf("\n"));
                                        saveFile = saveFile.substring(saveFile.lastIndexOf("\\") + 1, saveFile.indexOf("\""));
                                        int lastIndex = contentType.lastIndexOf("=");
                                        String boundary = contentType.substring(lastIndex + 1, contentType.length());
                                        int pos;
                                        pos = file.indexOf("filename=\"");
                                        pos = file.indexOf("\n", pos) + 1;
                                        pos = file.indexOf("\n", pos) + 1;
                                        pos = file.indexOf("\n", pos) + 1;
                                        int boundaryLocation = file.indexOf(boundary, pos) - 4;
                                        int startPos = ((file.substring(0, pos)).getBytes()).length;
                                        int endPos = ((file.substring(0, boundaryLocation)).getBytes()).length;
                                        FileOutputStream fileOut = new FileOutputStream("/var/lib/mysql/dcis_attendance_system/" + saveFile);
                                        fileOut.write(dataBytes, startPos, (endPos - startPos));
                                        fileOut.flush();
                                        fileOut.close();

                                        Pattern p = Pattern.compile("[a-zA-Z0-9_-]*.csv");
                                        Matcher m = p.matcher(saveFile);
                                        boolean z = m.matches();

                                        if (z) {
                                            int tch = Integer.parseInt(pa) + Integer.parseInt(ca);
                                            String username = (String) session.getAttribute("user");

                                            if (username == null) {
                                                username = "";
                                            }
                                            //Class.forName("com.mysql.jdbc.Driver").newInstance();
                                            pst = con.prepareStatement("drop table if exists temp1");
                                            //String qry7 = "drop table if exists temp1";
                                            pst.executeUpdate();
                                            pst = con.prepareStatement("create table if not exists temp1(StudentId varchar(20),StudentName varchar(60),column1 INT,primary key(StudentId))");
                                             pst.executeUpdate();

                                            //st40.executeUpdate("create table if not exists temp1(StudentId varchar(20),StudentName varchar(60),column1 INT,primary key(StudentId))");
                                            //String qry = "LOAD DATA INFILE '" + saveFile + "' INTO TABLE temp1 FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '\"' LINES TERMINATED BY '\n' (StudentId,StudentName,column1)";
                                            int columns = 0;

                                            pst = con.prepareStatement("show columns  from subject_attendance_" + semester + "_" + year + "");
                                            ResultSet rs29 = pst.executeQuery();
                                            while (rs29.next()) {
                                                columns++;
                                            }
                                            columns = columns - 2;
                                            pst = con.prepareStatement("update subject_attendance_" + semester + "_" + year + " set  month" + sd + "=" + Integer.parseInt(ca) + " where subjectId=?");
                                            pst.setString(1, subjectid);
                                            pst.executeUpdate();
                                            //String qry3 = "update subject_attendance_" + semester + "_" + year + " set  month" + sd + "=" + Integer.parseInt(ca) + " where subjectId='" + subjectid + "'";
                                            //st1.executeUpdate(qry3);

                                            pst = con.prepareStatement("select * from subject_attendance_" + semester + "_" + year + " where subjectId=?");
                                            pst.setString(1, subjectid);

                                            // String qrey = "select * from subject_attendance_" + semester + "_" + year + " where subjectId='" + subjectId + "'";
                                            ResultSet rsa1 = pst.executeQuery();
                                            int cum = 0;
                                            while (rsa1.next()) {   //actually here if is enough. i didnt get why they are using while here.
                                                int i = 1;
                                                while (i <= columns) {
                                                    cum = cum + rsa1.getInt(i + 1);
                                                    i++;
                                                }
                                                pst = con.prepareStatement("update subject_attendance_" + semester + "_" + year + " set  cumatten='" + cum + "' where subjectId=?");
                                                pst.setString(1, subjectId);
                                                pst.executeUpdate();
                                                //qry5 = "update subject_attendance_" + semester + "_" + year + " set  cumatten='" + cum + "' where subjectId='" + subjectId + "'";
                                                //st7.executeUpdate(qry5);
                                            }

                                            pst = con.prepareStatement("LOAD DATA INFILE ? INTO TABLE temp1 FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '\"' LINES TERMINATED BY '\n' (StudentId,StudentName,column1)");
                                            pst.setString(1, saveFile);
                                            pst.executeUpdate();

                                            String fileName = "/var/lib/mysql/dcis_attendance_system/" + saveFile;

                                            File f = new File(fileName);
                                            if (!f.exists()) {
                                                throw new IllegalArgumentException(
                                                        "Delete: no such file or directory: " + fileName);
                                            }

                                            if (!f.canWrite()) {
                                                throw new IllegalArgumentException("Delete: write protected: " + fileName);
                                            }

                                            if (f.isDirectory()) {
                                                String[] files = f.list();
                                                if (files.length > 0) {
                                                    throw new IllegalArgumentException(
                                                            "Delete: directory not empty: " + fileName);
                                                }
                                            }
                                            boolean success = f.delete();
                                            if (!success) {
                                                throw new IllegalArgumentException("Delete: deletion failed");
                                            }

                                            pst = con.prepareStatement("select * from temp1");

                                            //String qry9 = "select * from temp1";
                                            ResultSet rs7 = pst.executeQuery();

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$444
// Add students from the input file to the database, check whether that student is valid or not.  
                                            String[] miss_students = new String[300];
                                            int studentcheck_flag = 1;
                                            int count = 0;
                                            int attend_infile = 0;
                                            int attend_flag = 1;
                                            // atleast one student not match in the input file with the database then dont allow to do add students from file to database.                                                                                                                               
                                            while (rs7.next()) {
                                                attend_infile = rs7.getInt(3);
                                                if (attend_infile > cur_attend) {
                                                    attend_flag = 0;
                                                    break;
                                                }
                                                pst = con.prepareStatement("select  StudentId from " + subjectid + "_Attendance_" + semester + "_" + year + " where StudentId=?");
                                                pst.setString(1, rs7.getString(1));
                                                //String qry10 = "select  StudentId from " + subjectid + "_Attendance_" + semester + "_" + year + " where StudentId='" + rs7.getString(1) + "'";//set cumatten=cumatten+rs7.getInt(3)
                                                ResultSet rs_test = pst.executeQuery();
                                                System.out.println("ddd");
                                                if (!(rs_test.next())) {
                                                    studentcheck_flag = 0;
                                                    count++;
                                                    miss_students[count] = rs7.getString(1);
                                                }
                                            }
                                            pst = con.prepareStatement("select * from temp1");

                                            ResultSet rs7_2 = pst.executeQuery();
                                            System.out.println("testing 2");
                                            //  All students are present in the data base, and given attendancein file is <= attendance in gui 
                                            if (studentcheck_flag == 1 && attend_flag == 1) {
                                                while (rs7_2.next()) {
                                                    String a = rs7_2.getString(1);
                                                    int b = rs7_2.getInt(3);
                                                    pst = con.prepareStatement("update " + subjectid + "_Attendance_" + semester + "_" + year + " set month" + sd + "=" + rs7_2.getInt(3) + " where StudentId=?");
                                                    pst.setString(1, rs7_2.getString(1));

                                                    //String qry10 = "update " + subjectid + "_Attendance_" + semester + "_" + year + " set month" + sd + "=" + rs7_2.getInt(3) + " where StudentId='" + rs7_2.getString(1) + "'";//set cumatten=cumatten+rs7.getInt(3)
                                                    pst.executeUpdate();
                                                }
                                                pst = con.prepareStatement("select * from " + subjectid + "_Attendance_" + semester + "_" + year + "");

                                                ResultSet rs30 = pst.executeQuery();

                                                // add the cumulative/ overall percentage of attendace to all the students in the database.
                                                System.out.println("testing 1");
                                                while (rs30.next()) {
                                                    int j = 1, attendedclasses = 0;
                                                    while (j <= columns) {
                                                        attendedclasses = attendedclasses + rs30.getInt(j + 2);
                                                        j++;
                                                    }
                                                    double per = (double) attendedclasses / cum;
                                                    per = per * 100;

                                                    pst = con.prepareStatement("update " + subjectid + "_Attendance_" + semester + "_" + year + " set  cumatten=" + attendedclasses + ",percentage=" + per + " where StudentId=?");
                                                    pst.setString(1, rs30.getString(1));
                                                    pst.executeUpdate();
                                                }
                                                con.commit();

                            %>
                            </br>
                            </br>
                            <table border="0" align="center"><tr><td><b>You have successfully upload the file by the name of:</b>
                                        <% out.println(saveFile);
                                            session.setAttribute("filename", saveFile);%></td></tr></table> 
                                        <%
                                            out.println("<center><input type=\"button\" name=\"submit\" value=\"View Data\" onclick=\"javascript:document.frm.submit();\" /></center>");

                                        } else if (attend_flag == 1) { // students are not in the database.
                                        %> </br> <br>
                            <table border="0" align="center"><tr style="color:red"><td><b>Following students are not present in the records.</b></td></tr>
                            </table>

                            <%
                                for (int l = 1; l <= count; l++) {
                            %>
                            <br>  <%=miss_students[l]%>

                            <%

                                }

                            } else {
                            %> </br> <br>
                            <table border="0" align="center" ><tr style="color:red" align="center"><td ><b>File upload unsuccessful</b></td></tr>
                                <tr style="color:red"><td><b> *** For all students in the input file, attendance should be equal or less than given attendance ***</b></td></tr>
                            </table>

                            <%
                                            }
                                        }
                                    }

                                } catch (Exception e) {
                                    con.rollback();
                                    System.out.println(e);
                                    System.out.println("Transaction rollback!!!");

                                    //out.println(e);
                                }

                                i++;
                            %>
                            <br>         
                            </form>
                            <%!public static int i = 0;
                                public String name = "";
                            %>
                            <%
                                    request.setAttribute(name, "ca");

                                    String username = (String) session.getAttribute("facultyid");
                                    if (username == null) {
                                        username = "";
                                    }
                                    
                                } catch (Exception ex) {
                                    System.out.println(ex);
                                } finally {
                                    conn.closeConnection();
                                    con = null ;
                                    
                                }
                            %>
                            </body>
                            </html>