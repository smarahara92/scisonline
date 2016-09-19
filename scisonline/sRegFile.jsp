<%-- 
    Document   : sRegFile
    Created on : Aug 7, 2013, 12:52:34 AM
    Author     : veeru
--%>
<%@include file="checkValidity.jsp"%>
<%@page import="java.sql.*" %>
<%@page import="jxl.*"%>
<%@page import="java.io.*"%>
<%@page import="java.util.*"%>
<%@include file="connectionBean.jsp"%>    
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style>
            #div1
            {

                width:100%;
            }
            .heading
            {
                color: white;
                background-color: green;
            }
            .td
            {
                border-collapse:collapse;
                border: 1px solid green;
                white-space:nowrap;
                background-color: #F5F5F5;
                padding: 2px;
            }
            .td1{
                text-align: center;
                color: blue;
            }
            .table1{


                border: 1px solid black;
                border-collapse: collapse;


            }th{
                background-color: green;
                border: 1px solid green;
                color:white;
            }
            .Button {

                -moz-box-shadow:inset 0px 1px 0px 0px #ffffff;
                -webkit-box-shadow:inset 0px 1px 0px 0px #ffffff;
                box-shadow:inset 0px 1px 0px 0px #ffffff;

                background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #ffffff), color-stop(1, #f6f6f6));
                background:-moz-linear-gradient(top, #ffffff 5%, #f6f6f6 100%);
                background:-webkit-linear-gradient(top, #ffffff 5%, #f6f6f6 100%);
                background:-o-linear-gradient(top, #ffffff 5%, #f6f6f6 100%);
                background:-ms-linear-gradient(top, #ffffff 5%, #f6f6f6 100%);
                background:linear-gradient(to bottom, #ffffff 5%, #f6f6f6 100%);
                filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#ffffff', endColorstr='#f6f6f6',GradientType=0);

                background-color:#ffffff;

                -moz-border-radius:6px;
                -webkit-border-radius:6px;
                border-radius:6px;

                border:1px solid #dcdcdc;

                display:inline-block;
                color:black;
                font-family:arial;
                font-size:15px;
                font-weight:bold;
                padding:6px 24px;
                text-decoration:none;

                text-shadow:0px 1px 0px #ffffff;
                border-color: darkgray;

            }
            .Button:hover {

                background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #f6f6f6), color-stop(1, #ffffff));
                background:-moz-linear-gradient(top, #f6f6f6 5%, #ffffff 100%);
                background:-webkit-linear-gradient(top, #f6f6f6 5%, #ffffff 100%);
                background:-o-linear-gradient(top, #f6f6f6 5%, #ffffff 100%);
                background:-ms-linear-gradient(top, #f6f6f6 5%, #ffffff 100%);
                background:linear-gradient(to bottom, #f6f6f6 5%, #ffffff 100%);
                filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#f6f6f6', endColorstr='#ffffff',GradientType=0);

                background-color:#f6f6f6;
            }
            .Button:active {
                position:relative;
                top:1px;
            }
        </style>
    </head>

    <body>
        <%
        Connection con = conn.getConnectionObj();
        Connection con2 = conn2.getConnectionObj();
        Connection con1=conn1.getConnectionObj();
        int CurriculumYear;
            String stream = (String) session.getAttribute("pname_upload");
            stream = stream.replace('-', '_');
            String year = (String) session.getAttribute("year_upload");
            int year1 = Integer.parseInt(year);
            String saveFile = (String) request.getAttribute("filename");
            System.out.println("stream is:" + stream);
            PreparedStatement pst = null;
            System.out.println("Hii sridhar");
            //*********************************************************************

            //******************************************************************************
            try {

                /*
                 * 
                 * other than phd stream%%%%%%%%%%%%%%%%%%%%%%%%%% start %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                 * 
                 */
                if (stream.equals("PhD") != true) {
                    try {
                        System.out.println("Debug BreakPoint0");
                        con.setAutoCommit(false);
                        con2.setAutoCommit(false);

                        String realPath = getServletContext().getRealPath("/");
                        File f1 = new File(realPath + "/" + saveFile);

                        File f2 = new File("/var/lib/mysql/dcis_attendance_system/" + saveFile);
                        InputStream in = new FileInputStream(f1);
                        OutputStream out1 = new FileOutputStream(f2);
                        
                         System.out.println(f2.getName());

                        byte[] buf = new byte[1024];
                        int len;

                        while ((len = in.read(buf)) > 0) {
                            out1.write(buf, 0, len);
                        }

                        Statement st1 = con.createStatement();
                        Statement st2 = con.createStatement();
                        Statement st3 = con1.createStatement();
                        
                        pst = con.prepareStatement("select * from " + stream + "_curriculumversions order by Year desc");

                        ResultSet rs10 = pst.executeQuery();
                        while (rs10.next()) {
                            CurriculumYear = rs10.getInt(1);
                            if (CurriculumYear <= year1) {

                                year1 = CurriculumYear;
                                System.out.println(year1);
                                break;
                            }
                        }
                       
                        pst = con.prepareStatement("drop table if exists " + stream + "_" + year + "");
                        pst.executeUpdate();
                        pst = con.prepareStatement("create table " + stream + "_" + year + "(StudentId varchar(20),StudentName varchar(50),primary key(StudentId))");
                        pst.executeUpdate();
                      pst = con.prepareStatement("LOAD DATA INFILE '" + saveFile + "' INTO TABLE " + stream + "_" + year + " FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '\"' LINES TERMINATED BY '\n' (StudentId,StudentName) set StudentId = upper(trim(StudentId)), StudentName = upper(trim(StudentName))");
                        pst.executeUpdate();

                        int total = 0;
                        int core = 0;
                        int electives = 0;
                        int labs = 0;
                        int project = 0;
                        int optionalCores = 0;
                        pst = con.prepareStatement("SELECT SUM(Cores), SUM(Labs),SUM(Electives),SUM(OptionalCore), BIT_OR(Projects) FROM " + stream + "_" + year1 + "_currrefer");
                        ResultSet rs = pst.executeQuery();
                        rs.next();

                        core = Integer.parseInt(rs.getString(1));
                        labs = Integer.parseInt(rs.getString(2));
                        electives = Integer.parseInt(rs.getString(3));
                        project = Integer.parseInt(rs.getString(5));
                        optionalCores = Integer.parseInt(rs.getString(4));
                        total = core + labs + electives + project+optionalCores ;
                        pst = con.prepareStatement("select * from " + stream + "_" + year1 + "_curriculum where Type=?");
                        pst.setString(1, "C");
                        ResultSet rs2 = pst.executeQuery();
                        rs2.next();
                        int i = 1;
                        while (i <= core) {
                            pst = con.prepareStatement("alter table " + stream + "_" + year + " add core" + i + " varchar(20),add c" + i + "grade varchar(10)");
                            pst.executeUpdate();
                            pst = con.prepareStatement("update " + stream + "_" + year + " set core" + i + "='" + rs2.getString(2) + "',c" + i + "grade='NR' ");
                            pst.executeUpdate();
                            rs2.next();
                            i++;

                        }
                        System.out.println(" im at core");
                        pst = con.prepareStatement("select * from " + stream + "_" + year1 + "_curriculum where Type=?");
                        pst.setString(1, "L");
                        ResultSet rs3 = pst.executeQuery();
                        rs3.next();
                        i = 1;

                        while (i <= labs) {
                            pst = con.prepareStatement("alter table " + stream + "_" + year + " add lab" + i + " varchar(20),add l" + i + "grade varchar(10)");
                            pst.executeUpdate();
                            pst = con.prepareStatement("update " + stream + "_" + year + " set lab" + i + "='" + rs3.getString(2) + "',l" + i + "grade='NR'");
                            pst.executeUpdate();
                            rs3.next();

                            i++;

                        }
                        System.out.println(" im at lab");
                        pst = con.prepareStatement("select * from " + stream + "_" + year1 + "_curriculum where Type=?");
                        pst.setString(1, "P");
                        ResultSet rs4 = pst.executeQuery();
                        rs4.next();
                        i = 1;
                        while (i <= project) {
                            pst = con.prepareStatement("alter table " + stream + "_" + year + " add project" + i + " varchar(20),add p" + i + "grade varchar(10)");
                            pst.executeUpdate();
                            pst = con.prepareStatement("update " + stream + "_" + year + " set project" + i + "='" + rs4.getString(2) + "',p" + i + "grade='NR'");
                            pst.executeUpdate();
                            rs4.next();

                            i++;

                        }
                        pst = con.prepareStatement("select * from " + stream + "_" + year1 + "_curriculum where Type=?");
                        pst.setString(1, "E");
                        ResultSet rs5 = pst.executeQuery();
                        rs5.next();
                        i = 1;
                        while (i <= electives) {
                            pst = con.prepareStatement("alter table " + stream + "_" + year + " add ele" + i + " varchar(20),add e" + i + "grade varchar(10)");
                            pst.executeUpdate();
                            pst = con.prepareStatement("update " + stream + "_" + year + " set e" + i + "grade='NR'");
                            pst.executeUpdate();
                            rs5.next();

                            i++;
                        }
                        
                         pst = con.prepareStatement("select * from " + stream + "_" + year1 + "_curriculum where Type=?");
                        pst.setString(1, "O");
                        ResultSet rs6 = pst.executeQuery();
                        rs6.next();
                        i = 1;
                        while (i <= optionalCores) {
                            pst = con.prepareStatement("alter table " + stream + "_" + year + " add optCore" + i + " varchar(20),add o" + i + "grade varchar(10)");
                            pst.executeUpdate();
                            pst = con.prepareStatement("update " + stream + "_" + year + " set o" + i + "grade='NR'");
                            pst.executeUpdate();
                            rs6.next();

                            i++;
                        }

                        System.out.println("***upto here running***");

                        if (stream.equalsIgnoreCase("MCA")) {
                            pst = con.prepareStatement("alter table " + stream + "_" + year + " add cgpa varchar(20)");
                            pst.executeUpdate();
                        } else {
                            pst = con.prepareStatement("alter table " + stream + "_" + year + " add cgpa float(20),add gatescore float(20)");
                            pst.executeUpdate();
                        }
                        /* trigger code*/
                        
                        
                       try {
                            String currTable="";
                            String crcCode="" ;
                            Statement stnew=con.createStatement();
                            ResultSet rsCurr=st1.executeQuery("select * from " + stream + "_curriculumversions order by Year desc");
                            ResultSet rsLstStu=st2.executeQuery("select StudentId,StudentName from " + stream + "_" + year);
                            rsCurr.next();
                            currTable=rsCurr.getString("Curriculum_name");
                            rsCurr=st1.executeQuery("select * from " + currTable + " where Semester='I'");
                            while(rsCurr.next()) {
                                crcCode=rsCurr.getString("Alias");
                                if(crcCode==null){
                                    crcCode=rsCurr.getString("SubCode");
                                }
                                //boolean ok = false;
                                while(rsLstStu.next()) {
                                    String stuid = rsLstStu.getString("StudentId");
                                    String stuname = rsLstStu.getString("StudentName");
                                    try {
                                        stnew.executeUpdate("insert into "+crcCode +"_Attendance_Monsoon_"+ year+" (StudentID,StudentName) values('"+stuid+"','"+stuname+"')");
                                        st3.executeUpdate("insert into "+crcCode +"_Assessment_Monsoon_"+ year+" (StudentID,StudentName) values('"+stuid+"','"+stuname+"')");
                                    } catch(SQLException sqle) {
                                        //rsLstStu=st2.executeQuery("select StudentId,StudentName from " + stream + "_" + year);
                                        //ok = true;
                                        break;
                                    }
                                }
                                //System.out.println("studdddddddddddddennnnnnnnnnt "+rsLstStu.getString(1));
                                //rsLstStu.beforeFirst(); }
                                rsLstStu.beforeFirst();
                            }
                            
                       } catch(SQLException | NullPointerException ex) {
                            System.out.println(ex.getMessage());
                        }
                        con.commit();
                        con2.commit();
                    } catch (Exception ex) {
                        con.rollback();
                        con2.rollback();
                    }
                } else if (stream.equals("PhD") == true) {
                    try {
                        con.setAutoCommit(false);
                        con2.setAutoCommit(false);
                           String realPath = getServletContext().getRealPath("/");
                    File f1 = new File(realPath + "/" + saveFile);

                    File f2 = new File("/var/lib/mysql/PhD/" + saveFile);
                    InputStream in = new FileInputStream(f1);
                    OutputStream out1 = new FileOutputStream(f2);

                    byte[] buf = new byte[1024];
                    int len;
            
                    while ((len = in.read(buf)) > 0) {
                        out1.write(buf, 0, len);
                    }
                    Statement st1 = con2.createStatement();
                    Statement st2 = con2.createStatement();
                    ResultSet rs11 = st2.executeQuery("select * from " + stream + "_curriculumversions order by Year desc");
                    while (rs11.next()) {
                        CurriculumYear = rs11.getInt(1);
                        if (CurriculumYear <= year1) {

                            year1 = CurriculumYear;
                            System.out.println(year1);
                            break;
                        }
                    }
                    st1.executeUpdate("drop table if exists " + stream + "_" + year + "");
                    st1.executeUpdate("drop table if exists comprehensive_" + year + "");
                    st1.executeUpdate("drop table if exists drcreports_" + year + "");
                    st1.executeUpdate("drop table if exists PhD_Student_info_" + year + ""); // remov doj
                    st1.executeUpdate("drop table if exists PhD_Student_dates_" + year + ""); // remove name
 System.out.println("test1");
                    st1.executeUpdate("create table drcreports_" + year + "(StudentId varchar(20),StudentName varchar(50),DOJ varchar(50),primary key(StudentId))");
                    st1.executeUpdate("create table comprehensive_" + year + "(StudentId varchar(20),StudentName varchar(50),DOJ varchar(50),primary key(StudentId))");
                    st1.executeUpdate("create table " + stream + "_" + year + "(StudentId varchar(20),StudentName varchar(50),DOJ varchar(50),primary key(StudentId))");
                    st1.executeUpdate("create table PhD_Student_info_" + year + "(StudentId varchar(20),StudentName varchar(50),DOJ varchar(50),primary key(StudentId))");
                    st1.executeUpdate("create table PhD_Student_dates_" + year + "(StudentId varchar(20),StudentName varchar(50),DOJ varchar(50),primary key(StudentId))");
                   
                    st1.executeUpdate("LOAD DATA INFILE '" + saveFile + "' INTO TABLE " + stream + "_" + year + " FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '\"' LINES TERMINATED BY '\n' (StudentId,StudentName,DOJ) set StudentId = upper(trim(StudentId)), StudentName = upper(trim(StudentName)) ");
                    st1.executeUpdate("LOAD DATA INFILE '" + saveFile + "' INTO TABLE drcreports_" + year + " FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '\"' LINES TERMINATED BY '\n' (StudentId,StudentName,DOJ) set StudentId = upper(trim(StudentId)), StudentName = upper(trim(StudentName))");
                    st1.executeUpdate("LOAD DATA INFILE '" + saveFile + "' INTO TABLE comprehensive_" + year + " FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '\"' LINES TERMINATED BY '\n' (StudentId,StudentName,DOJ) set StudentId = upper(trim(StudentId)), StudentName = upper(trim(StudentName))");
                    st1.executeUpdate("LOAD DATA INFILE '" + saveFile + "' INTO TABLE PhD_Student_info_" + year + " FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '\"' LINES TERMINATED BY '\n' (StudentId,StudentName,DOJ) set StudentId = upper(trim(StudentId)), StudentName = upper(trim(StudentName))");
                    st1.executeUpdate("LOAD DATA INFILE '" + saveFile + "' INTO TABLE PhD_Student_dates_" + year +" FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '\"' LINES TERMINATED BY '\n' (StudentId,StudentName,DOJ) set StudentId = upper(trim(StudentId)), StudentName = upper(trim(StudentName))");
                     System.out.println("test2");
//                 
                    // srinivas removing the student name from the drc reports and comprehensive tables.

                    //alter table [table name] drop column [column name];

                    st1.executeUpdate("alter table drcreports_" + year + " drop StudentName ");
                    st1.executeUpdate("alter table comprehensive_" + year + " drop StudentName");
                    st1.executeUpdate("alter table PhD_Student_dates_" + year + " drop StudentName");
                    st1.executeUpdate("alter table PhD_" + year + " drop StudentName");
                    
                    st1.executeUpdate("alter table comprehensive_" + year + " drop DOJ");
                    st1.executeUpdate("alter table drcreports_" + year + " drop DOJ");
                    st1.executeUpdate("alter table PhD_Student_info_" + year + " drop DOJ");
                    st1.executeUpdate("alter table PhD_" + year + " drop DOJ");
                  System.out.println("test3");  
                   // st1.executeUpdate("alter table PhD_Student_dates_" + year+ " drop StudentName");


                    int totalcolumns = 12;
                    int g = 1;
                    while (g <= totalcolumns) {
                        st1.executeUpdate("alter table drcreports_" + year + " add date" + g + " varchar(12),add status" + g + " varchar(15),add progress" + g + " varchar(2000),add suggestions" + g + " varchar(2000)");
                        g++;
                    }

                    ResultSet rs3 = (ResultSet) st2.executeQuery("select * from " + stream + "_" + year1 + "_currrefer");
                    int core = 0;
                    int electives = 0;
                    while (rs3.next()) {
                        //Number of Subjects
                        core = Integer.parseInt(rs3.getString(1));
                        electives = Integer.parseInt(rs3.getString(2));
                    }

                    int i = 1;
                    while (i <= core) {
                       // st1.executeUpdate("alter table " + stream + "_" + year + " add core" + i + " varchar(20),add c" + i + "grade varchar(10)");
                        st1.executeUpdate("alter table comprehensive_" + year + " add core" + i + " varchar(20),add c" + i + "marks varchar(10) ,add c" + i + "grade varchar(10)");
                        st1.executeUpdate("update comprehensive_" + year + " set c" + i + "grade='NR' ");

                        i++;
                    }
                    i = 1;
                    while (i <= electives) {
                        //st1.executeUpdate("alter table " + stream + "_" + year + " add ele" + i + " varchar(20),add e" + i + "grade varchar(10)");
                        st1.executeUpdate("alter table comprehensive_" + year + " add ele" + i + " varchar(20),add e" + i + "marks varchar(10) ,add e" + i + "grade varchar(10)");
                        st1.executeUpdate("update comprehensive_" + year + " set e" + i + "grade='NR'");
                        i++;
                    }
                    st1.executeUpdate("alter table " + stream + "_" + year + " add thesistitle varchar(100),add areaofresearch varchar(100),add supervisor1 varchar(20),add supervisor2 varchar(20),add supervisor3 varchar(20),add status varchar(10),add ft_pt_ex varchar(20),add organization varchar(20),add externalsup varchar(20),add drc1 varchar(20),add drc2 varchar(20)");

                    st1.executeUpdate("alter table PhD_Student_info_" + year + " add Caddress varchar(100), add Paddress varchar(100), add Email varchar(50), add Cell_number varchar(15), add Landline varchar(15), add Gender varchar(7)");
                    st1.executeUpdate("alter table PhD_Student_dates_" + year + " add Extension date, add RRegister date, add DRegister date,add Synopsis_Submit date, add Thesis_Submit date, add Viva_Complete date, add GraduatedOn date");
               
                    
                    
                    
                    
                    // Srinivas adding NR Status to newly added student of phd.
                     st1.executeUpdate("update " + stream + "_" + year + " set status='NR' ");
                    // creating active student list table .
                    st1.executeUpdate("create table if not exists active_students(StudentId varchar(20),primary key(StudentId))");
                    } catch (Exception ex) {
                        con2.rollback();
                        con.rollback();
                    }
                }

                Statement st5;
                if (stream.equals("PhD")) {
                    st5 = con2.createStatement();
                    
                } else {
                    st5 = con.createStatement();
                }

                ResultSet rs5 = st5.executeQuery("select * from " + stream + "_" + year + "");
        %>
    <center><b>University of Hyderabad</b></center>
    <center><b>School of Computer and Information Sciences</b></center>
    <center><b><%=stream%>-<%=year%> students list</b></center>
    &nbsp;
    <table class="table1" align="center">
        <tr>
            <th class="heading">Student ID</th>
            <th class="heading">Student Name</th>
        </tr>
        <%
            while (rs5.next()) {
                String num = rs5.getString(1);
                String name = rs5.getString(2);
                if(stream.equals("PhD"))
                {
                    Statement st6,st_snam;
                    st6 = con2.createStatement();
                    st_snam = con2.createStatement();
                    ResultSet rs_sname=st_snam.executeQuery("select * from  PhD_Student_info_"+year+" where StudentId='"+rs5.getString(1)+"'");
           rs_sname.next();
                    name = rs_sname.getString(2);
                // send all newly added students into the active students table.
                //  st12.executeUpdate("insert into " + sub + "_Attendance_" + given_session + "_" + given_year + " (StudentId , StudentName) values('" + rs.getString(1) + "','" + rs.getString(2) + "')");
               st6.executeUpdate("insert ignore into active_students (StudentId) values('" + rs5.getString(1) + "')");      
                }
        %>  <tr>
            <td class="td"><%=num%></td>
            <td class="td"><%=name%></td>
        </tr>
        <%
            }
        %>
    </table>&nbsp;
    <table align="center">
        <tr>
            <td>
                <input type="button" value="Print" id="p1" onclick="window.print();" class="Button">
            </td>
        </tr>
    </table>
    <%
        } catch (Exception e) {
            out.print(e);
            e.printStackTrace();
        }
    %>


</body>
</html>
