<%--Document: GetParameterMethod Created on: 4 Feb, 2012, 12: 09: 22 PM Author:khushali--%>
<%--<%@page import="com.hcu.mysql.connection.ConnectionDemo3"%>--%>
<%--<%@ include file="dbconnection.jsp" %>--%>
<%@ include file="connectionBean.jsp" %>
<%@ include file="id_parser.jsp" %>
<%@ page import="org.apache.poi.hssf.usermodel.HSSFWorkbook"%>
<%@ page import="java.io.*"%>
<%@ page import="java.math.*"%>
<%@ page import="org.apache.poi.ss.usermodel.Workbook"%>
<%@ page import="org.apache.poi.ss.usermodel.Font"%>
<%@ page import="org.apache.poi.ss.usermodel.CellStyle"%>
<%@ page import="org.apache.poi.ss.usermodel.IndexedColors"%>
<%@ page import="org.apache.poi.ss.usermodel.Sheet"%>
<%@ page import="org.apache.poi.ss.usermodel.Cell"%>
<%@ page import="org.apache.poi.ss.usermodel.Row"%>
<%@page import = "java.sql.*" %>
<%@page import="java.util.Calendar"%>
<%@page errorPage="error.jsp?msg=Application Generated an error!" %>
<%@include file="checkValidity.jsp"%>
<%@page contentType = "text/html" pageEncoding ="UTF-8"%>
<!DOCTYPE html > <%@page import ="java.util.*"%>
<html > 
    <head > 
        <script language="javascript" src="print.js"></script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="table_css1.css" rel="stylesheet" type="text/css">

        <title>JSP Page</title>
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

        <%            
                Connection con = conn.getConnectionObj();
                Connection con1 = conn1.getConnectionObj();
                PreparedStatement pst = null;
                 
            try {
                String username = (String) session.getAttribute("user");
                Calendar now = Calendar.getInstance();
                int cyear = now.get(Calendar.YEAR);
                int cyear1 = 0;
                int year1 = 0;
                float total=0f;
                int curriculumYear = 0, latestYear = 0, masterTableBatchYear = cyear, studentBatchYear = 0, programmeDuration = 0, flag = 0;
                int flag1 = 0;
                int month = now.get(Calendar.MONTH) + 1;
                int CurriculumYear = 0, LatestYear = 0;

                String sem = "";
                String student_id = "";

                if (month >= 7) {
                    sem = "Monsoon";
                } else if (month >= 1 && month <= 6) {
                    sem = "Winter";
                }
                String subjectname = (String) request.getParameter("subjname");
                String subjectid = (String) request.getParameter("subjid");
                String Marks = (String) request.getParameter("selectmarks");
                System.out.println(Marks+"===============================");
                String programmeName = "", programmeGroup = "", studentStream = "";
                String stream = "";
                String year = "";
                String AB = "AB";
                try {
                    con.setAutoCommit(false);
                    con1.setAutoCommit(false);
                    pst = con1.prepareStatement("select * from " + subjectid + "_Assessment_" + sem + "_" + cyear);

                    ResultSet rs = pst.executeQuery();

                    String[] ItemNames = request.getParameterValues("marks");
                    String[] ItemsNames1=null;
                    if( Marks.equals("Internal_Major Marks") )
                    {
                        ItemsNames1 = request.getParameterValues("marks1");
                    }
                    int i = 0;
                    while (rs.next()) {
                            
                        if( Marks.equals("Internal_Major Marks") && ItemsNames1 != null )
                        {
                            pst = con1.prepareStatement("update " + subjectid + "_Assessment_" + sem + "_" + cyear + " set " + "Major=?,InternalMarks=? where StudentId=?");
                            pst.setString(1, ItemNames[i]);
                             pst.setString(2, ItemsNames1[i]);
                            pst.setString(3, rs.getString(1));
                            pst.executeUpdate();
                            i++;
                        }
                        else
                        {
                        pst = con1.prepareStatement("update " + subjectid + "_Assessment_" + sem + "_" + cyear + " set " + Marks + "=? where StudentId=?");
                        pst.setString(1, ItemNames[i]);
                        pst.setString(2, rs.getString(1));
                         pst.executeUpdate();
                          i++;
                        }
                                            
                    }

                    //***************************************
                    pst = con1.prepareStatement("select * from " + subjectid + "_Assessment_" + sem + "_" + cyear);

                    ResultSet rs8 = pst.executeQuery();
                    while (rs8.next() && ! Marks.equals("Internal_Major Marks")) {
                        float a, b, c;

                        if (AB.equalsIgnoreCase(rs8.getString(3)) || rs8.getString(3) == null) {
                            a = 0;
                            
                        } else {
                            a = Float.parseFloat(rs8.getString(3));
                        }

                        if (AB.equalsIgnoreCase(rs8.getString(4)) || rs8.getString(4) == null) {
                            b = 0;
                        } else {
                            b = Float.parseFloat(rs8.getString(4));
                        }

                        if (AB.equalsIgnoreCase(rs8.getString(5)) || rs8.getString(5) == null) {
                            c = 0;
                        } else {
                            c = Float.parseFloat(rs8.getString(5));
                        }

                        Float max = maxvalue(a, b, c);
                        pst = con1.prepareStatement("update " + subjectid + "_Assessment_" + sem + "_" + cyear + " set InternalMarks=? where StudentId=?");
                        pst.setFloat(1, max);
                        pst.setString(2, rs8.getString(1));
                        pst.executeUpdate();
                    }
                    //****************************************

                    pst = con1.prepareStatement("select * from " + subjectid + "_Assessment_" + sem + "_" + cyear);

                    ResultSet rs3 = pst.executeQuery();
//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$                               
                    while (rs3.next()) {
                        programmeGroup = " ";
                        student_id = rs3.getString(1);
                        String qry4 = "";
                        cyear1 = cyear;
                        if (sem.equalsIgnoreCase("winter")) {
                            cyear1 = cyear - 1;
                        }
  //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                        // old code removed in this part
                        //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

                        //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
                        // FIND THE STUDENT BATCHYEAR, PROGRAMME GROUP USING FUNCTIONS THAT WE CREATED FOR THE PARSING STUDENT ID.
                        String PROGRAMME_NAME = student_id.substring(SPRGM_PREFIX, EPRGM_PREFIX);
                        int BATCH_YEAR = Integer.parseInt(CENTURY + student_id.substring(SYEAR_PREFIX, EYEAR_PREFIX));
                        pst = con.prepareStatement(" select Programme_group from programme_table where Programme_code =?");
                        pst.setString(1, PROGRAMME_NAME);

                        ResultSet rs_pgm = pst.executeQuery();
                        if (rs_pgm.next())// means belongs to our school.
                        {
                            programmeGroup = rs_pgm.getString(1);
                        } else { // belongs to others schools. so check in the master table of other schools, if exits that 
                            // get the corresponding grade table name . ie programmegroup
                            pst = con1.prepareStatement("select Grade_Formula from Other_Schools_" + sem + "_" + cyear + " where StudentID=?");
                            pst.setString(1, student_id);

                            ResultSet rs_other = pst.executeQuery();
                            if (rs_other.next()) {
                                programmeGroup = rs_other.getString(1);

                            }

                        }
                        if (!(programmeGroup.equalsIgnoreCase(" "))) {
                            String pgroup = programmeGroup;
                            stream = studentStream;
                            year = Integer.toString(BATCH_YEAR);
                            // grade table lookup after finding the program that student belongs to
                            pst = con1.prepareStatement("select * from " + pgroup + "_grade_table Order By Marks DESC");
                            String majorvalue = rs3.getString(6);
                            ResultSet rs4 = pst.executeQuery();
                            String Grade = "";
                            float Majorvalue;
                            if (rs3.getString(6) == null || AB.equalsIgnoreCase(majorvalue)) {
                                if(AB.equalsIgnoreCase(rs3.getString(6))){
                                   majorvalue = majorvalue.toUpperCase() ;
                                   pst = con1.prepareStatement("update " + subjectid + "_Assessment_" + sem + "_" + cyear + " set Major=? where StudentId=?");
                                   pst.setString(1, majorvalue);
                                   pst.setString(2,rs3.getString(1));
                                   pst.executeUpdate();
                                }
                                Majorvalue = 0;
                                Grade = "F";
                                  total = (float)Math.ceil(Float.parseFloat(rs3.getString(8)));
                            } else {
                                Majorvalue = Float.parseFloat(rs3.getString(6));
                                 total = (float)Math.ceil(Majorvalue + Float.parseFloat(rs3.getString(8)));
                            while (rs4.next()) {
                                if (total >= rs4.getInt(2)) {
                                    Grade = rs4.getString(1);
                                    
                                    break;
                                } else {
                                    Grade = "F";
                                }
                            }
                            }
                            pst = con1.prepareStatement("update " + subjectid + "_Assessment_" + sem + "_" + cyear + " set Final=?,TotalMarks=? where StudentId=?");
                            pst.setString(1, Grade);
                            pst.setFloat(2, total);
                            pst.setString(3, rs3.getString(1));
                            pst.executeUpdate();
                        } else {// studnetid not found in our own school and not in the other schools.

                            out.println(student_id + " not present in the records");
                        }
                    }

//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
//$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
                    // logic for major marks update.  
                    //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
                    // we have to update the master table once we enter the major marks. so                      
                    //***************************************************************************************
                    if (Marks.equals("Internal_Major Marks") == true || Marks.equals("Major") == true) {
                        pst = con1.prepareStatement("select StudentId,Final from " + subjectid + "_Assessment_" + sem + "_" + cyear);

                        ResultSet rs30 = pst.executeQuery();

                        String mastertable = "";
                        while (rs30.next()) {
                            programmeGroup = " ";
                            student_id = rs30.getString(1);
                            //retrieving stream according to studnet id..

                            cyear1 = cyear;
                            if (sem.equalsIgnoreCase("winter")) {
                                cyear1 = cyear - 1;
                            }

                            //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
                            // FIND THE STUDENT BATCHYEAR, PROGRAMME GROUP USING FUNCTIONS THAT WE CREATED FOR THE PARSING STUDENT ID.
                            String PROGRAMME_NAME = student_id.substring(SPRGM_PREFIX, EPRGM_PREFIX);
                            int BATCH_YEAR = Integer.parseInt(CENTURY + student_id.substring(SYEAR_PREFIX, EYEAR_PREFIX));

                            pst = con.prepareStatement(" select Programme_group,Programme_name from programme_table where Programme_code =?");
                            pst.setString(1, PROGRAMME_NAME);
                            ResultSet rs_pgm = pst.executeQuery();
                            if (!(rs_pgm.next())) {
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
                                            pst = con.prepareStatement("update Other_Schools_" + sem + "_" + cyear + " set E" + col + "_Grade =? where StudentId=?");
                                            pst.setString(1, rs30.getString(2));
                                            pst.setString(2, rs30.getString(1));
                                            pst.executeUpdate();
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

                                //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                // old code removed from this part
                                //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                int finding = 0;
                                while (finding < 2) {
                                   
                                    String stream1 = stream.replace('-', '_');
                                     System.out.println(stream1+"agh");
                                    mastertable = stream1 + "_" + year;
                                    System.out.println(mastertable+" jkfdg");
                                    try {
                                        pst = con.prepareStatement("select * from " + mastertable + " where StudentId=?");
                                        System.out.println(rs30.getString(1));
                                        pst.setString(1, rs30.getString(1));

                                        ResultSet rs31 = pst.executeQuery();
                                        rs31.next();
                                        ResultSetMetaData rsmd = rs31.getMetaData();
                                        int noOfColumns = rsmd.getColumnCount();
                                        int temp = (noOfColumns - 2) / 2;
                                        int j = 0;

                                        while (temp > 0) {
                                            System.out.println("Helloo");
                                            int m = j + 3;
                                            String columnname = rsmd.getColumnName(m);
                                            String columnname1 = rsmd.getColumnName(m + 1);

                                            String modified = subjectid;

                                            //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% taking related curriculum version for programme.%%%%%%%%%%%%
                                            year1 = Integer.parseInt(year);
                                            pst = con.prepareStatement("select * from " + stream1 + "_curriculumversions order by Year desc");

                                            ResultSet res2 = pst.executeQuery();
                                            while (res2.next()) {
                                               CurriculumYear = res2.getInt(1);
                                                if (CurriculumYear <= year1) {
                                                    LatestYear = CurriculumYear;
                                                    System.out.println("curricululm version year====" + LatestYear);
                                                    break;
                                                }
                                            }
                                            //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                            pst = con.prepareStatement("select SubCode from " + stream1 + "_" + LatestYear + "_curriculum where Alias=?");
                                            pst.setString(1, modified);

                                            ResultSet rs33 = pst.executeQuery();
                                            while (rs33.next()) {
                                                if (rs33.getString(1) != null) {
                                                    modified = rs33.getString(1);
                                                }
                                            }
                                            System.out.println(modified+"  fhg  "+columnname+"   "+temp);
                                            if (modified.equals(rs31.getString(m)) == true) {
                                                System.out.println(columnname);
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
                        }// while loop
                    }// major if loop
                    con.commit();
                    con1.commit();
                } catch (Exception ex) {
                    con.rollback();
                    con1.rollback();
                    System.out.println(ex);
                    System.out.println("Transaction rollback!!!");
                }
                con1.setAutoCommit(true);
                //***************************************************************************************            
                if(Marks.equals("Internal_Major Marks"))
                {
                          pst = con1.prepareStatement("select StudentId, StudentName,InternalMarks,Major" +  " from " + subjectid + "_Assessment_" + sem + "_" + cyear);
                }
                else
                {
                    pst = con1.prepareStatement("select StudentId, StudentName," + Marks + " from " + subjectid + "_Assessment_" + sem + "_" + cyear);
                }
                ResultSet rs10 = pst.executeQuery();
                Marks = Marks.replace('_', '-');

                Workbook workbook = new HSSFWorkbook();
                Sheet s = workbook.createSheet();
                int rowcount = 0, columncount = 0;
                Row row1 = s.createRow(rowcount++);
        %>
        
        <script>
           /// alert("<%=subjectname%>");
           window.open("Internalmarks2.jsp?subjectname=" + '<%=subjectname%>'+"&subjectid=" + '<%=subjectid%>'+"&fid="+'<%=username%>'+"&month="+'<%=Marks%>'+"&checkk=yes","facultyaction");//here check =6 means error number (if condition number.)
        </script> 
    &nbsp;&nbsp;
    <div align="center">
        <input type="button" value="Print" id="p1" class="noPrint" onclick="window.print();" />
        <input type="button" value="Export as xls" id="p2" class="noPrint" onclick="window.location.href = 'download.xls'"/>
    </div>
    <%        } catch (Exception e) {
            System.out.println(e);

        } finally {
            if (con != null && con1 != null && pst != null) {
               pst.close();
                conn.closeConnection();
                conn1.closeConnection();
                con = null;
                con1 = null;
                
            }
        }

    %>

</body > 
</html>
