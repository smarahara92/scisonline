<%-- 
    Document   : updateCsvData
    Created on : 7 Feb, 2012, 9:56:01 AM
    Author     : khushali
--%>
<%@page import="com.hcu.mysql.connection.ConnectionDemo3"%>
<%@ include file="dbconnection.jsp" %>
<%@ page import="java.sql.*"%>
<%@ include file="id_parser.jsp" %>
<%@ page import="java.io.*" %>
<%@page import="jxl.*"%>
<%@page import="java.util.*"%>
<%@ page import="java.net.*"%>
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

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" type="text/css" href="table_css.css">
        <style type="text/css">

            @media print {

                .noPrint
                {
                    display:none;
                }
            }
        </style>
    </head>
    <body>

        <%!
            Float maxvalue(Float a, Float b, Float c) {
                Float max = 0f;
                if (a >= b && a >= c) {
                    if (b >= c) {
                        return (a + b);
                    } else {
                        return (a + c);
                    }
                } else if (b >= a && b >= c) {
                    if (a >= c) {
                        return (b + a);
                    } else {
                        return (b + c);
                    }
                } else if (c >= a && c >= b) {
                    if (a >= b) {
                        return (c + a);
                    } else {
                        return (c + b);
                    }
                }
                return max;
            }
        %>

        <%            PreparedStatement pst = null;
            try {

                Calendar now = Calendar.getInstance();

                int month = now.get(Calendar.MONTH) + 1;
                int cyear = now.get(Calendar.YEAR);
                int cyear1 = cyear;
                int flag1 = 0, year1 = 0;
                int curriculumYear = 0, latestYear = 0, masterTableBatchYear = cyear, studentBatchYear = 0, programmeDuration = 0, flag = 0;
                String programmeName = "", programmeGroup = "", studentStream = "";
                String sem = "";

                Statement st_other = con.createStatement();

                if (month >= 7) {
                    sem = "Monsoon";
                } else if (month >= 1 && month <= 6) {
                    sem = "Winter";
                }

                String grade;
                String name, rsubj, gsubj;
                int arr[] = new int[60];
                int credit[] = new int[60];
                String subjectid = (String) session.getAttribute("subjid");
                String sname = (String) session.getAttribute("subjname");
                String MARKS = (String) session.getAttribute("selectmarks");

                String username = request.getParameter("facultyid");
                String saveFile = (String) session.getAttribute("filename");

                String format = "none";
                String csvfile = "none";
                int index = saveFile.lastIndexOf(".");
                if (index > 0) {
                    format = saveFile.substring(index + 1);
                    csvfile = saveFile.substring(0, index + 1);
                    csvfile = csvfile + "csv";
                    format = format.toLowerCase();
                }
                //**********************************************************************
                if (format.equals("xls")) {
                    //*****************************************************************

                    try {
                        //String saveFile=(String)session.getAttribute("saveFile");
                        String realPath = getServletContext().getRealPath("/");
                        String filename = realPath + saveFile;
                        WorkbookSettings ws = new WorkbookSettings();
                        ws.setLocale(new Locale("en", "EN"));
                        Workbook w = Workbook.getWorkbook(new File(filename), ws);

                        System.out.println(realPath);
                        //realPath=realPath+"/";
                        // File f1 = new File(realPath+saveFile);
                        File f = new File(realPath + csvfile);
                        OutputStream os = (OutputStream) new FileOutputStream(f);
                        String encoding = "UTF8";
                        OutputStreamWriter osw = new OutputStreamWriter(os, encoding);
                        BufferedWriter bw = new BufferedWriter(osw);

                        for (int sheet = 0; sheet < w.getNumberOfSheets(); sheet++) {
                            Sheet s = w.getSheet(sheet);

                            //bw.write(s.getName());
                            //bw.newLine();
                            Cell[] row = null;

                            for (int i = 0; i < s.getRows(); i++) {
                                row = s.getRow(i);

                                if (row.length > 0) {
                                    bw.write(row[0].getContents());
                                    for (int j = 1; j < row.length; j++) {
                                        bw.write(',');
                                        bw.write(row[j].getContents());
                                    }
                                }
                                bw.newLine();
                            }
                        }
                        bw.flush();
                        bw.close();
                        saveFile = csvfile;
                    } catch (Exception e) {
                        System.err.println(e);
                    }

                    //*****************************************************************
                }
                //******************************************************************************

                pst = con1.prepareStatement("drop table if exists tmp");

                pst.executeUpdate();
                pst = con1.prepareStatement("create table if not exists tmp(StudentId varchar(30),StudentName varchar(100),marks1 varchar(20),major varchar(20), primary key(StudentId))");
                pst.executeUpdate();
                // st1.executeUpdate("create table if not exists tmp(StudentId varchar(30),StudentName varchar(100),marks1 varchar(20),major varchar(20), primary key(StudentId))");
                //String qry = "LOAD DATA INFILE '" + saveFile + "' INTO TABLE tmp FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '\"' LINES TERMINATED BY '\n' (StudentId,StudentName,marks1)";
                // String qry2 = "LOAD DATA INFILE '" + saveFile + "' INTO TABLE tmp FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '\"' LINES TERMINATED BY '\n' (StudentId,StudentName,marks1,Major)";
                //String qry7 = "select * from tmp";
                //String qry9 = "delete from tmp";
                //String qry1 = "select StudentId from " + subjectid + "_Assessment_" + sem + "_" + cyear + " ";
                pst = con1.prepareStatement("select StudentId from " + subjectid + "_Assessment_" + sem + "_" + cyear + " ");

                ResultSet rs1 = pst.executeQuery();

                try {
                    if (MARKS.equals("Internal_Major Marks")) {
                        pst = con1.prepareStatement("LOAD DATA INFILE '" + saveFile + "' INTO TABLE tmp FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '\"' LINES TERMINATED BY '\n' (StudentId,StudentName,marks1,Major)");

                        pst.executeUpdate();
                    } else {
                        pst = con1.prepareStatement("LOAD DATA INFILE '" + saveFile + "' INTO TABLE tmp FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '\"' LINES TERMINATED BY '\n' (StudentId,StudentName,marks1)");

                        pst.executeUpdate();
                    }
                } catch (Exception ex) {
                    System.out.println(ex);
                    out.println("<center><h1>Inavlid File Formate</h1></center>");
                    out.println("<left><h2>Instructions :</h2></left>");
                    out.println("<left><h2>1.Each row in the file should be of the fallwoing formate</h2></left>");
                    out.println("<left><h3>For minor/major marks :rollno,name,marks</h3></left>");
                    out.println("Example :<br>");
                    out.println("12mcmi28,srinivas,19<br>");
                    out.println("12mcmi30,sushma,20<br>");
                    out.println("<left><h3>For semester marks: rollno,name,total-internal,major</h3></left>");
                    out.println("Example :<br>");
                    out.println("12mcmi28,srinivas,19,50<br>");
                    out.println("12mcmi30,sushma,20,78<br>");
                    out.println("<left><h2>1.Any empty row in the file is not allowed</h2></left>");
                    return;
                }
                pst = con1.prepareStatement("select * from tmp");
                ResultSet rs7 = pst.executeQuery();
                //deleting the file 
                String fileName = "/var/lib/mysql/dcis_assessment/" + saveFile;
                // A File object to represent the filename
                File f = new File(fileName);

                // Make sure the file or directory exists and isn't write protected
                if (!f.exists()) {
                    throw new IllegalArgumentException(
                            "Delete: no such file or directory: " + fileName);
                };

                if (!f.canWrite()) {
                    throw new IllegalArgumentException("Delete: write protected: "
                            + fileName);
                }

                // If it is a directory, make sure it is empty
                if (f.isDirectory()) {
                    String[] files = f.list();
                    if (files.length > 0) {
                        throw new IllegalArgumentException(
                                "Delete: directory not empty: " + fileName);
                    }
                }

                //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$444
// Add students from the input file to the database, check whether that student is valid or not.  
                String[] miss_students = new String[300];
                int studentcheck_flag = 1;
                int count = 0;
                int assess_infile = 0;
                int assess_flag = 1;
                // atleast one student not match in the input file with the database then dont allow to do add students from file to database.                                                                                                                               
                while (rs7.next()) {
                    //  assess_infile = rs7.getInt(3);
                    // if (assess_infile > 20) {
                    //   assess_flag = 0;
                    //  break;
                    //}
                    pst = con1.prepareStatement("select  StudentId from " + subjectid + "_Assessment_" + sem + "_" + cyear + " where StudentId=?");
                    pst.setString(1, rs7.getString(1));
                    // String qry10 = "select  StudentId from " + subjectid + "_Assessment_" + sem + "_" + cyear + " where StudentId='" + rs7.getString(1) + "'";//set cumatten=cumatten+rs7.getInt(3)

                    ResultSet rs_test = pst.executeQuery();
                    if (!(rs_test.next())) {
                        studentcheck_flag = 0;
                        count++;
                        miss_students[count] = rs7.getString(1);
                    }
                }

                rs7.beforeFirst();
                // end here

                if (studentcheck_flag == 1) {
                    try {
                        con.setAutoCommit(false);
                        con1.setAutoCommit(false);
                        while (rs7.next()) {

                            if (MARKS.equals("Minor_1")) {
                                pst = con1.prepareStatement("update " + subjectid + "_Assessment_" + sem + "_" + cyear + " set Minor_1=? where StudentId=?");
                                pst.setString(1, rs7.getString(3));
                                pst.setString(2, rs7.getString(1));
                                pst.executeUpdate();
                            } else if (MARKS.equals("Minor_2")) {
                                pst = con1.prepareStatement("update " + subjectid + "_Assessment_" + sem + "_" + cyear + " set Minor_2=? where StudentId=?");
                                pst.setString(1, rs7.getString(3));
                                pst.setString(2, rs7.getString(1));
                                pst.executeUpdate();
                            } else if (MARKS.equals("Minor_3")) {
                                pst = con1.prepareStatement("update " + subjectid + "_Assessment_" + sem + "_" + cyear + " set Minor_3=? where StudentId=?");
                                pst.setString(1, rs7.getString(3));
                                pst.setString(2, rs7.getString(1));
                                pst.executeUpdate();
                            } else if (MARKS.equals("Major")) {
                                pst = con1.prepareStatement("update " + subjectid + "_Assessment_" + sem + "_" + cyear + " set Major=? where StudentId=?");
                                pst.setString(1, rs7.getString(3));
                                pst.setString(2, rs7.getString(1));
                                pst.executeUpdate();
                            } else if (MARKS.equals("Internal_Major Marks")) {
                                pst = con1.prepareStatement("update " + subjectid + "_Assessment_" + sem + "_" + cyear + " set InternalMarks=?,Major=? where StudentId=?");
                                pst.setString(1, rs7.getString(3));
                                pst.setString(2, rs7.getString(4));
                                pst.setString(3, rs7.getString(1));
                                pst.executeUpdate();
                            }
                            //st1.executeUpdate(qry11);
                        }
                        rs1.close();
                        rs7.close();

                        //*****************************************************************************************      
                        String AB = "AB";
                        if (MARKS.equals("Internal_Major Marks") != true) {
                            pst = con1.prepareStatement("select * from " + subjectid + "_Assessment_" + sem + "_" + cyear + "");

                            //String qry8 = "select * from " + subjectid + "_Assessment_" + sem + "_" + cyear + "";
                            ResultSet rs8 = pst.executeQuery();
                            while (rs8.next()) {
                                float a, b, c;

                                if (AB.equals(rs8.getString(3)) || rs8.getString(3) == null) {
                                    a = 0;
                                } else {
                                    a = Float.parseFloat(rs8.getString(3));
                                }

                                if (AB.equals(rs8.getString(4)) || rs8.getString(4) == null) {
                                    b = 0;
                                } else {
                                    b = Float.parseFloat(rs8.getString(4));
                                }

                                if (AB.equals(rs8.getString(5)) || rs8.getString(5) == null) {
                                    c = 0;
                                } else {
                                    c = Float.parseFloat(rs8.getString(5));
                                }

                                System.out.println("kkkk");
                                Float max = maxvalue(a, b, c);
                                pst = con1.prepareStatement("update " + subjectid + "_Assessment_" + sem + "_" + cyear + " set InternalMarks=? where StudentId=?");
                                pst.setFloat(1, max);
                                pst.setString(2, rs8.getString(1));
                                pst.executeUpdate();
                                //st6.executeUpdate("update " + subjectid + "_Assessment_" + sem + "_" + cyear + " set InternalMarks='" + max + "' where StudentId='" + rs8.getString(1) + "'");
                            }
                        }
                        //****************************************************************************************  
                        // System.out.println("kkkk");
                        pst = con1.prepareStatement("select * from " + subjectid + "_Assessment_" + sem + "_" + cyear + " ");

                        //String qry3 = "select * from " + subjectid + "_Assessment_" + sem + "_" + cyear + " ";
                        ResultSet rs3 = pst.executeQuery();

                        while (rs3.next()) {
                            programmeGroup = " ";
                            String student_id = rs3.getString(1);

                            cyear1 = cyear;
                            if (sem.equalsIgnoreCase("winter")) {
                                cyear1 = cyear - 1;
                            }

                            //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
                            // FIND THE STUDENT BATCHYEAR, PROGRAMME GROUP USING FUNCTIONS THAT WE CREATED FOR THE PARSING STUDENT ID.
                            String PROGRAMME_NAME = student_id.substring(SPRGM_PREFIX, EPRGM_PREFIX);
                            int BATCH_YEAR = Integer.parseInt(CENTURY + student_id.substring(SYEAR_PREFIX, EYEAR_PREFIX));
                            System.out.println("student id , prgm , batch " + student_id + ", " + PROGRAMME_NAME + ", " + BATCH_YEAR);
                            pst = con.prepareStatement(" select Programme_group from programme_table where Programme_code =?");
                            pst.setString(1, PROGRAMME_NAME);
                            ResultSet rs_pgm = pst.executeQuery();
                            if (rs_pgm.next())// means belongs to our school.
                            {
                                programmeGroup = rs_pgm.getString(1);
                                //  System.out.println("student id , group "+student_id+", "+programmeGroup);                      
                            } else { // belongs to others schools. so check in the master table of other schools, if exits that 
                                // get the corresponding grade table name . ie programmegroup
                                //System.out.println("he is other school");              
                                pst = con1.prepareStatement("select Grade_Formula from Other_Schools_" + sem + "_" + cyear + " where StudentID=?");
                                pst.setString(1, student_id);
                                ResultSet rs_other = pst.executeQuery();
                                if (rs_other.next()) {
                                    programmeGroup = rs_other.getString(1);
                                    System.out.println("other schools student id ,grade " + student_id + ", " + programmeGroup + "");

                                }

                            }

                            if (!(programmeGroup.equalsIgnoreCase(" "))) {
                                String pgroup = programmeGroup;
                                // /stream = studentStream;
                                // year = Integer.toString(BATCH_YEAR);
                                pst = con1.prepareStatement("select * from " + programmeGroup + "_grade_table Order By Marks DESC");

                                //String qry4 = "select * from " + programmeGroup + "_grade_table Order By Marks DESC";
                                ResultSet rs4 = pst.executeQuery();
                                String Grade = "";
                                float Majorvalue;
                                if (rs3.getString(6) == null || AB.equals(rs3.getString(6))) {
                                    Majorvalue = 0;
                                } else {
                                    Majorvalue = Float.parseFloat(rs3.getString(6));
                                }

                                Float total = Majorvalue + Float.parseFloat(rs3.getString(8));
                                while (rs4.next()) {
                                    if (total >= rs4.getInt(2)) {
                                        Grade = rs4.getString(1);
                                        break;
                                    } else {
                                        Grade = "F";
                                    }
                                }
                                pst = con1.prepareStatement("update " + subjectid + "_Assessment_" + sem + "_" + cyear + " set Final=?,TotalMarks=? where StudentId=?");
                                pst.setString(1, Grade);
                                pst.setFloat(2, total);
                                pst.setString(3, rs3.getString(1));
                                // String qry5 = "update " + subjectid + "_Assessment_" + sem + "_" + cyear + " set Final='" + Grade + "',TotalMarks='" + total + "' where StudentId='" + rs3.getString(1) + "'";
                                pst.executeUpdate();
                            } else {// studnetid not found in our own school and not in the other schools.

                                out.println(student_id + " not present in the records");
                            }
                        }

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
                        // logic for major marks update.  
                        //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
                        if (MARKS.equals("Internal_Major Marks") == true || MARKS.equals("Major") == true) {
                            pst = con1.prepareStatement("select StudentId,Final from " + subjectid + "_Assessment_" + sem + "_" + cyear + " ");

                            // String qry30 = "select StudentId,Final from " + subjectid + "_Assessment_" + sem + "_" + cyear + " ";
                            ResultSet rs30 = pst.executeQuery();

                            int i = 0;
                            String stream = "";
                            String year = "";
                            String mastertable = "";
                            while (rs30.next()) {
                                //retrieving stream name and batch year according to studnet id.********************
                                programmeGroup = " ";
                                String student_id = rs30.getString(1);
                                cyear1 = cyear;
                                if (sem.equalsIgnoreCase("winter")) {
                                    cyear1 = cyear - 1;
                                }
                                //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
                                // FIND THE STUDENT BATCHYEAR, PROGRAMME GROUP USING FUNCTIONS THAT WE CREATED FOR THE PARSING STUDENT ID.

                                String PROGRAMME_NAME = student_id.substring(SPRGM_PREFIX, EPRGM_PREFIX);
                                int BATCH_YEAR = Integer.parseInt(CENTURY + student_id.substring(SYEAR_PREFIX, EYEAR_PREFIX));

                                //System.out.println(" major student id , prgm , batch "+student_id+", "+PROGRAMME_NAME+", "+BATCH_YEAR);
                                pst = con.prepareStatement(" select Programme_group,Programme_name from programme_table where Programme_code =?");
                                pst.setString(1, PROGRAMME_NAME);
                                ResultSet rs_pgm = pst.executeQuery();
                                if (!(rs_pgm.next())) {
                                    System.out.println("stream code in other schools");
                                    //may belongs to others schools. so check in the master table of other schools.                          
                                    pst = con.prepareStatement("select * from Other_Schools_" + sem + "_" + cyear + " where StudentID=?");
                                    pst.setString(1, student_id);
                                    ResultSet rs_other = pst.executeQuery();
                                    if (rs_other.next()) {
                                        // student present in the table.
                                        // get the column name of the subject in the other schools master table to update the grade.
                                        String sub_code = "";
                                        String sub_grade = "";
                                        int fg = 0;
                                        for (int col = 1; col <= 4; col++) {
                                            sub_code = rs_other.getString("Elective" + col);
                                            if (sub_code.equalsIgnoreCase(subjectid)) {
                                                System.out.println("matched subject at Elective" + col);
                                                st_other.executeUpdate("update Other_Schools_" + sem + "_" + cyear + " set E" + col + "_Grade ='" + rs30.getString(2) + "' where StudentId='" + rs30.getString(1) + "'");
                                                fg = 1;
                                                break;

                                            }
                                        }
                                        if (fg == 0) {

                                            out.println("Student id " + student_id + "has no subject : " + subjectid + " in the otheschools master table.");
                                        }

                                    } else {
                                        out.println("Student id " + student_id + " is not present in records");

                                    }
                                } else {  // stuent belongs to our own schools

                                    programmeGroup = rs_pgm.getString(1);
                                    stream = rs_pgm.getString(2);
                                    String pgroup = programmeGroup;
                                    year = Integer.toString(BATCH_YEAR);

                                    //***********************************************************************************
                                    int finding = 0;
                                    while (finding < 2) {
                                        mastertable = stream + "_" + year;

                                        try {
                                            pst = con.prepareStatement("select * from " + mastertable + " where StudentId=?");
                                            pst.setString(1, rs30.getString(1));
                                            ResultSet rs31 = pst.executeQuery();
                                            rs31.next();
                                            ResultSetMetaData rsmd = rs31.getMetaData();
                                            int noOfColumns = rsmd.getColumnCount();
                                            int temp = (noOfColumns - 2) / 2;
                                            int j = 0;

                                            while (temp > 0) {

                                                int m = j + 3;
                                                String columnname = rsmd.getColumnName(m);
                                                String columnname1 = rsmd.getColumnName(m + 1);

                                                String modified = subjectid;
                                                //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% taking related curriculum version for programme.%%%%%%%%%%%%
                                                year1 = Integer.parseInt(year);
                                                pst = con.prepareStatement("select * from " + stream + "_curriculumversions order by Year desc");
                                                //pst.setString(1, rs30.getString(1));
                                                ResultSet res2 = pst.executeQuery();
                                                while (res2.next()) {
                                                    curriculumYear = res2.getInt(1);
                                                    if (curriculumYear <= year1) {
                                                        latestYear = curriculumYear;
                                                        System.out.println("curricululm version year====" + latestYear);
                                                        break;
                                                    }
                                                }
                                                //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                                pst = con.prepareStatement("select SubCode from " + stream + "_" + latestYear + "_curriculum where Alias=?");
                                                pst.setString(1, modified);
                                                ResultSet rs33 = pst.executeQuery();
                                                while (rs33.next()) {
                                                    if (rs33.getString(1) != null) {
                                                        modified = rs33.getString(1);
                                                    }
                                                }

                                                if (modified.equals(rs31.getString(m)) == true) {
                                                    // System.out.println(columnname);
                                                    pst = con.prepareStatement("update " + mastertable + " set " + columnname1 + "=? where StudentId=?");
                                                    pst.setString(1, rs30.getString(2));
                                                    pst.setString(2, rs30.getString(1));
                                                    pst.executeUpdate();
                                                    break;
                                                }

                                                j = j + 2;
                                                temp--;
                                            }
                                            finding++;
                                            year = Integer.toString(Integer.parseInt(year) + 1);
                                        } catch (Exception ex) {
                                            finding++;
                                            year = Integer.toString(Integer.parseInt(year) + 1);
                                        }
                                    }
                                }
                            }
                        }
                        con.commit();
                        con1.commit();
                    } catch (Exception ex) {
                        con.rollback();
                        con1.rollback();
                        System.out.println(ex);
                        System.out.println();

                    }
                    con.setAutoCommit(true);
                    con1.setAutoCommit(true);
                    //***************************************************************************************            
                    pst = con1.prepareStatement("select * from " + subjectid + "_Assessment_" + sem + "_" + cyear + " ");

                    // String qry11 = "select * from " + subjectid + "_Assessment_" + sem + "_" + cyear + " ";
                    ResultSet rs11 = pst.executeQuery();

        %>

    <center><b>University of Hyderabad</b></center>
    <center><b>School of Computer and Information Sciences</b></center>
    <center><b><%=MARKS%> exam Assessment</b></center>
    <center><b>Subject Name :</b> <b style="color:blue"><%=sname%></b>&nbsp;<b>Subject Code :</b><b style="color:blue"><%=subjectid%></b></center>
    &nbsp;&nbsp;
    <%
        if (MARKS.equals("Internal_Major Marks") != true) {
            pst = con1.prepareStatement("select StudentId, StudentName," + MARKS + " from " + subjectid + "_Assessment_" + sem + "_" + cyear + " ");

            // String qry10 = ;
            ResultSet rs10 = pst.executeQuery();
            MARKS = MARKS.replace('_', '-');%>            
    <table align="center" border="2"  cellpadding="" cellspacing="0" cellpadding="0">

        <th>Student Id</th>
        <th>Student Name</th>
        <th><%=MARKS%></th>

        <%
            while (rs10.next()) {
        %>
        <tr>
            <td><%=rs10.getString(1)%></td>
            <td><%=rs10.getString(2)%></td>
            <%
                if (rs10.getString(3) == null) {%><td> </td>
            <%                   } else {
            %><td><%=rs10.getString(3)%></td><%
                }%>
        </tr>
        <%
            }%>
    </table>   
    <%} else {%>
    <table align="center" border="2"  cellpadding="" cellspacing="0" cellpadding="0">

        <th>Student Id</th>
        <th>Student Name</th>
        <th>Internal</th>
        <th>Major</th>
            <%
                while (rs11.next()) {
            %>
        <tr>
            <td><%=rs11.getString(1)%></td>
            <td><%=rs11.getString(2)%></td>
            <%
                if (rs11.getString(8) == null) {%><td> </td>
            <%                   } else {
            %><td><%=rs11.getString(8)%></td><%
                }%>

            <%
                if (rs11.getString(6) == null) {%><td> </td>
            <%                   } else {
            %><td><%=rs11.getString(6)%></td><%
                }%>
        </tr>
        <%
            }%>
    </table>   

    <%  }
    %>
    </br></br>
    <div align="center">
        <input type="button" value="Print" id="p1" class="noPrint" onclick="window.print();" />
    </div>
    <%
    } else { // students are not in the database.
    %> </br> <br>
    <table border="0" align="center">
        <tr style="color:red"><td><b>Following students are not present in the records.</b></td></tr>
    </table>

    <%
        for (int l = 1; l <= count; l++) {
    %>
    <br>  <%=miss_students[l]%>

    <%

                }

            }
            //*******************************************************************************************                                         
        } catch (Exception e) {
            System.out.println(e);
        } finally {
            if (con != null && con1 != null && pst != null) {
                pst.close();
                con.close();
                con1.close();
            }
        }
    %>


</body>
</html>

