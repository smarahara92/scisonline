<%-- 
    Document   : programme_mang_uploadlink
    Created on : Oct 20, 2013, 2:02:22 PM
    Author     : veeru
--%>
<%@include file="checkValidity.jsp"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.io.*"%>
<%@page import ="javax.sql.*" %>
<%@page import="java.sql.*" %>
<%@include file="dbconnection.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%            try {
                int p, n, l, n1, m, cn, cn1 = 0, z = 0;
                Calendar now = Calendar.getInstance();
                System.out.println("Current date : " + (now.get(Calendar.MONTH) + 1)
                        + "-"
                        + now.get(Calendar.DATE)
                        + "-"
                        + now.get(Calendar.YEAR));
                int month = now.get(Calendar.MONTH) + 1;
                int cyear = now.get(Calendar.YEAR);
                String pname;
                Statement st = null;
                String colName;
                String colDataType;
                st = con.createStatement();
                int ri;
                boolean rb;
                ResultSet rrs = null;

                PreparedStatement pst = null;

                String dataType[] = {"VARCHAR(100)", "INT", "DOUBLE", "TINYINT", "BIT"};
                String coltype = "";
                String colValue_string = "";
                int colValue_int;
                float colValue_float;

                String colDataType1 = "";
                String pname1 = (String) request.getAttribute("name1");
                pname = pname1.replace('-', '_');
                String year = (String) request.getAttribute("name2");
                String saveFile = (String) request.getAttribute("filename");

                Savepoint pointOne = con.setSavepoint("pointOne");

                Statement st1 = con.createStatement();

                if (pname.equals("PhD") != true) {

                    try {
                        String realPath = getServletContext().getRealPath("/");

                        File f1 = new File(realPath + "/" + saveFile);

                        File f2 = new File("/var/lib/mysql/dcis_attendance_system/" + saveFile);
                        con.setAutoCommit(false);
                        pointOne = con.setSavepoint("pointOne");
                        /*
                         *programmes insertion.
                         * create programme_curriculumversions table.
                         * create programme_year_curriculum with Sno column for dynamic column creation
                         */

                        /*
                         * creating currrefer table.##########################starting########################################
                         * 
                         */
                        pst = con.prepareStatement("DROP TABLE IF EXISTS " + pname + "_" + year + "_currrefer");
                        pst.executeUpdate();
                        pst = con.prepareStatement("create table if not exists " + pname + "_" + year + "_currrefer(Sno int NOT NULL, UNIQUE(Sno)) ");
                        pst.executeUpdate();

                        //add column dynamically**********************************************
                        int k3 = 0;
                        FileReader ff = new FileReader(f1);
                        BufferedReader br = new BufferedReader(ff);

                        String line = null, line1 = null;

                        while ((line = br.readLine()) != null) {

                            if (k3 > 1 && k3 < 3) {

                                String[] cval = line.split(",");

                                n = cval.length;

                                for (l = 0; l < n; l++) {
                                    String originalString = cval[l];
                                    System.out.println(originalString);
                                    int startIndex = originalString.indexOf("(");

                                    int endIndex = originalString.indexOf(")");

                                    colName = originalString.substring(0, startIndex);

                                    colDataType = originalString.substring(startIndex + 1, endIndex);

                                    if (colDataType.equalsIgnoreCase("varchar")) {

                                        coltype = dataType[0];

                                    } else if (colDataType.equalsIgnoreCase("int")) {

                                        coltype = dataType[1];

                                    } else if (colDataType.equalsIgnoreCase("FLOAT")) {

                                        coltype = dataType[2];

                                    } else if (colDataType.equalsIgnoreCase("boolean")) {

                                        coltype = dataType[3];
                                    }

                                    if (coltype.equalsIgnoreCase("boolean")) {
                                        pst = con.prepareStatement("Alter table " + pname + "_" + year + "_currrefer Add " + colName + " " + coltype + " DEFAULT '0'");

                                        pst.executeUpdate();
                                    } else {
                                        pst = con.prepareStatement("Alter table " + pname + "_" + year + "_currrefer Add " + colName + " " + coltype + "");

                                        pst.executeUpdate();
                                    }
                                }
                            }
                            k3++;
                        }

                        /*
                         * Update programme_year_currrefer table.
                         */
                        pst = con.prepareStatement("select * from " + pname + "_" + year + "_currrefer");
                        ResultSet rs = pst.executeQuery();

                        ResultSetMetaData metadata = rs.getMetaData();

                        BufferedReader br1 = new BufferedReader(new FileReader(f1));

                        int q = 0, k = 0, minSemValue;

                        line1 = br1.readLine();

                        line1 = br1.readLine();

                        String[] minSem = line1.split(",");

                        minSemValue = Integer.parseInt(minSem[0]);

                        minSemValue = minSemValue + 1;
                        try {
                            con.setAutoCommit(false);
                            while ((line1 = br1.readLine()) != null) {

                                if (k > 0 && k < minSemValue) {

                                    int o = 2;
                                    String[] splits = line1.split(",");

                                    n1 = splits.length;

                                    for (m = 0; m < n1; m++) {

                                        colDataType1 = metadata.getColumnTypeName(o);

                                        //giving data type to columns..dynamically*******************
                                        if (colDataType1.equalsIgnoreCase("varchar")) {

                                            colValue_string = splits[m];
                                            pst = con.prepareStatement("insert ignore into " + pname + "_" + year + "_currrefer(Sno)values(?)");
                                            pst.setInt(1, q);
                                            pst.executeUpdate();

                                            pst = con.prepareStatement("UPDATE " + pname + "_" + year + "_currrefer SET " + metadata.getColumnName(o) + "=? WHERE Sno=?");
                                            pst.setString(1, colValue_string);
                                            pst.setInt(2, q);
                                            pst.executeUpdate();

                                            o++;

                                        } else if (colDataType1.equalsIgnoreCase("integer")) {

                                            colValue_int = Integer.parseInt(splits[m]);
                                            colValue_string = splits[m];
                                            pst = con.prepareStatement("insert ignore into " + pname + "_" + year + "_currrefer(Sno)values(?)");
                                            pst.setInt(1, q);
                                            pst.executeUpdate();

                                            pst = con.prepareStatement("UPDATE " + pname + "_" + year + "_currrefer SET " + metadata.getColumnName(o) + "=? WHERE Sno=?");
                                            pst.setString(1, colValue_string);
                                            pst.setInt(2, q);
                                            pst.executeUpdate();

                                            o++;

                                        } else if (colDataType1.equalsIgnoreCase("DOUBLE")) {

                                            colValue_float = Float.parseFloat(splits[m]);
                                            colValue_string = splits[m];
                                            pst = con.prepareStatement("insert ignore into " + pname + "_" + year + "_currrefer(Sno)values(?)");
                                            pst.setInt(1, q);
                                            pst.executeUpdate();

                                            pst = con.prepareStatement("UPDATE " + pname + "_" + year + "_currrefer SET " + metadata.getColumnName(o) + "=? WHERE Sno=?");
                                            pst.setString(1, colValue_string);
                                            pst.setInt(2, q);
                                            pst.executeUpdate();

                                            o++;

                                        } else if (colDataType1.equalsIgnoreCase("TINYINT")) {

                                            colValue_int = Integer.parseInt(splits[m]);
                                            colValue_string = splits[m];
                                            pst = con.prepareStatement("insert ignore into " + pname + "_" + year + "_currrefer(Sno)values(?)");
                                            pst.setInt(1, q);
                                            pst.executeUpdate();

                                            pst = con.prepareStatement("UPDATE " + pname + "_" + year + "_currrefer SET " + metadata.getColumnName(o) + "=? WHERE Sno=?");
                                            pst.setString(1, colValue_string);
                                            pst.setInt(2, q);
                                            pst.executeUpdate();

                                            o++;

                                        }

                                    }
                                    q++;
                                }

                                k++;
                            }
                            con.commit();
                        } catch (Exception ex) {
                            con.rollback();
                            pst = con.prepareStatement("DROP TABLE IF EXISTS " + pname + "_" + year + "_currrefer");
                            pst.executeUpdate();
                            out.println("Some internal error..");
                            return;
                        } finally {
                            con.setAutoCommit(true);
                        }
                        pst = con.prepareStatement("ALTER TABLE " + pname + "_" + year + "_currrefer ADD PRIMARY KEY(Semester)");
                        pst.executeUpdate();

                        pst = con.prepareStatement("ALTER TABLE " + pname + "_" + year + "_currrefer DROP COLUMN Sno, DROP INDEX Sno");
                        pst.executeUpdate();


                        /*
                         * ######################################ending###################################################################
                         *
                         *
                         *
                         *creating stream_year_curriculum table.###############################starting#################################### 
                         */
                        pst = con.prepareStatement("DROP TABLE IF EXISTS " + pname + "_" + year + "_curriculum");
                        pst.executeUpdate();
                        pst = con.prepareStatement("create table if not exists " + pname + "_" + year + "_curriculum(Sno int NOT NULL, UNIQUE(Sno))");

                        pst.executeUpdate();

                        // adding column to stream_year_curriculum table dynamically, by reading values from curriculum csv file.*******
                        int k4 = 0;

                        br1 = new BufferedReader(new FileReader(f1));

                        String line3, line4;

                        line3 = br1.readLine();

                        line3 = br1.readLine();

                        String semvalue[] = line3.split(",");

                        int semvalue1 = Integer.parseInt(semvalue[0]);

                        while ((line3 = br1.readLine()) != null) {

                            if (k4 > semvalue1 && k4 < semvalue1 + 2) {

                                String[] cval1 = line3.split(",");//split line with ','

                                n = cval1.length;

                                for (l = 0; l < n; l++) {

                                    String originalString = cval1[l];
                                    System.out.println(originalString);

                                    int startIndex = originalString.indexOf("(");

                                    int endIndex = originalString.indexOf(")");

                                    colName = originalString.substring(0, startIndex);

                                    colDataType = originalString.substring(startIndex + 1, endIndex);

                                    if (colDataType.equalsIgnoreCase("varchar")) {

                                        coltype = dataType[0];

                                    } else if (colDataType.equalsIgnoreCase("int")) {

                                        coltype = dataType[1];

                                    } else if (colDataType.equalsIgnoreCase("FLOAT")) {

                                        coltype = dataType[2];

                                    } else if (colDataType.equalsIgnoreCase("boolean")) {

                                        coltype = dataType[3];
                                    }
                                    if (coltype.equalsIgnoreCase("boolean")) {

                                        pst = con.prepareStatement("Alter table " + pname + "_" + year + "_curriculum Add " + colName + " " + coltype + " DEFAULT '0'");

                                        pst.executeUpdate();

                                        //st.executeUpdate(sql);
                                    }
                                    pst = con.prepareStatement("Alter table " + pname + "_" + year + "_curriculum Add " + colName + " " + coltype + "");
                                    pst.executeUpdate();

                                    // st.executeUpdate(sql);
                                }
                            }

                            k4++;
                        }

                        //updating stream_year_curriculum table************************************************
                        pst = con.prepareStatement("select * from " + pname + "_" + year + "_curriculum");

                        ResultSet rs2 = pst.executeQuery();

                        ResultSetMetaData metadata1 = rs2.getMetaData();
                        BufferedReader br3 = new BufferedReader(new FileReader(f1));

                        q = 0;
                        k = 0;
                        minSemValue = 0;

                        line1 = br3.readLine();
                        line1 = br3.readLine();

                        minSem = line1.split(",");

                        minSemValue = Integer.parseInt(minSem[0]);
                        minSemValue = minSemValue + 1;
                        try {
                            con.setAutoCommit(false);
                            while ((line1 = br3.readLine()) != null) {

                                if (k > minSemValue) {

                                    int o = 2;

                                    String[] splits2 = line1.split(",");

                                    n1 = splits2.length;

                                    for (m = 0; m < n1; m++) {

                                        colDataType1 = metadata1.getColumnTypeName(o);

                                        if (colDataType1.equalsIgnoreCase("varchar")) {

                                            colValue_string = splits2[m];

                                            pst = con.prepareStatement("insert ignore into " + pname + "_" + year + "_curriculum(Sno)values(?)");
                                            pst.setInt(1, q);
                                            pst.executeUpdate();

                                            pst = con.prepareStatement("UPDATE " + pname + "_" + year + "_curriculum SET " + metadata1.getColumnName(o) + "=? WHERE Sno=?");
                                            pst.setString(1, colValue_string);
                                            pst.setInt(2, q);

                                            pst.executeUpdate();

                                            o++;

                                        } else if (colDataType1.equalsIgnoreCase("integer")) {

                                            colValue_int = Integer.parseInt(splits2[m]);
                                            pst = con.prepareStatement("insert ignore into " + pname + "_" + year + "_curriculum(Sno)values(?)");
                                            pst.setInt(1, q);

                                            pst.executeUpdate();

                                            pst = con.prepareStatement("UPDATE " + pname + "_" + year + "_curriculum SET " + metadata1.getColumnName(o) + "=? WHERE Sno=?");
                                            pst.setInt(1, colValue_int);
                                            pst.setInt(2, q);

                                            pst.executeUpdate();

                                            o++;

                                        } else if (colDataType1.equalsIgnoreCase("DOUBLE")) {

                                            colValue_float = Float.parseFloat(splits2[m]);
                                            pst = con.prepareStatement("insert ignore into " + pname + "_" + year + "_curriculum(Sno)values(?)");
                                            pst.setInt(1, q);

                                            pst.executeUpdate();

                                            pst = con.prepareStatement("UPDATE " + pname + "_" + year + "_curriculum SET " + metadata1.getColumnName(o) + "=? WHERE Sno=?");
                                            pst.setFloat(1, colValue_float);
                                            pst.setInt(2, q);

                                            pst.executeUpdate();

                                            o++;

                                        } else if (colDataType1.equalsIgnoreCase("TINYINT")) {

                                            colValue_int = Integer.parseInt(splits2[m]);

                                            pst = con.prepareStatement("insert ignore into " + pname + "_" + year + "_curriculum(Sno)values(?)");
                                            pst.setInt(1, q);

                                            pst.executeUpdate();

                                            pst = con.prepareStatement("UPDATE " + pname + "_" + year + "_curriculum SET " + metadata1.getColumnName(o) + "=? WHERE Sno=?");
                                            pst.setInt(1, colValue_int);
                                            pst.setInt(2, q);

                                            pst.executeUpdate();

                                            o++;

                                        }

                                    }
                                    q++;
                                }

                                k++;
                            }
                            con.commit();
                        } catch (Exception ex) {
                            con.rollback();
                            pst = con.prepareStatement("DROP TABLE IF EXISTS " + pname + "_" + year + "_currrefer");
                            pst.executeUpdate();
                            pst = con.prepareStatement("DROP TABLE IF EXISTS " + pname + "_" + year + "_curriculum");
                            pst.executeUpdate();
                            out.println("Some internal error..");
                            return;
                        } finally {
                            con.setAutoCommit(true);
                        }
                        pst = con.prepareStatement("ALTER TABLE " + pname + "_" + year + "_curriculum ADD PRIMARY KEY(Semester,SubCode)");

                        pst.executeUpdate();

                        pst = con.prepareStatement("ALTER TABLE " + pname + "_" + year + "_curriculum DROP COLUMN Sno, DROP INDEX Sno");

                        pst.executeUpdate();

                        /*
                         *#######################################end stream_year_curriculum table############################## 
                         *
                         * 
                         * 
                         *subject_data_stream_year table creation************************************
                         * 
                         *subjecttable table creation***********************************************
                         * 
                         */
                        pst = con.prepareStatement("DROP TABLE IF EXISTS subject_data_" + pname + "_" + year + "");

                        pst.executeUpdate();

                        pst = con.prepareStatement("create table if not exists subject_data(subjId varchar(20),subjName varchar(100),credits int(20),semester varchar(20),primary key(subjId))");

                        pst.executeUpdate();

                        pst = con.prepareStatement("create table if not exists subject_data_" + pname + "_" + year + "(subjId varchar(20),subjName varchar(100),credits int(20),semester varchar(20),primary key(subjId))");

                        pst.executeUpdate();

                        pst = con.prepareStatement("create table if not exists subjecttable(Code varchar(20),Subject_Name varchar(100),credits varchar(20),type varchar(20),primary key(Code))");
                        pst.executeUpdate();

                        pst = con.prepareStatement("select * from " + pname + "_" + year + "_curriculum");

                        ResultSet rs4 = pst.executeQuery();

                        /*
                         * find out column number for "Alias"
                         */
                        int ncol = rs4.getMetaData().getColumnCount();

                        for (cn = 1; cn <= ncol; cn++) {

                            if (rs4.getMetaData().getColumnName(cn).equals("Alias") == true) {
                                cn1 = cn;

                            }

                        }
                        pst = con.prepareStatement("select * from " + pname + "_" + year + "_curriculum");

                        ResultSet rs3 = pst.executeQuery();

                        String pname3 = "";

                        pname3 = pname;
                        try {
                            con.setAutoCommit(false);
                            while (rs3.next()) {

                                pname = pname.replace('_', '-');

                                /*
                                 * Alias if it is null.
                                 */
                                if (rs3.getString(cn1) != null) {
                                    pst = con.prepareStatement("insert ignore into subject_data values(?,?,?,?)");
                                    pst.setString(1, rs3.getString(cn1));
                                    pst.setString(2, rs3.getString(3));
                                    pst.setString(3, rs3.getString(4));
                                    pst.setString(4, pname + "-" + rs3.getString(1));

                                    pst.executeUpdate();

                                    pst = con.prepareStatement("insert ignore into subject_data_" + pname3 + "_" + year + " values(?,?,?,?)");
                                    pst.setString(1, rs3.getString(cn1));
                                    pst.setString(2, rs3.getString(3));
                                    pst.setString(3, rs3.getString(4));
                                    pst.setString(4, pname + "-" + rs3.getString(1));

                                    pst.executeUpdate();

                                    pst = con.prepareStatement("insert ignore into subjecttable values(?,?,?,?)");
                                    pst.setString(1, rs3.getString(cn1));
                                    pst.setString(2, rs3.getString(3));
                                    pst.setString(3, rs3.getString(4));
                                    pst.setString(4, "C");

                                    pst.executeUpdate();

                                } else {

                                    pst = con.prepareStatement("insert ignore into subject_data values(?,?,?,?)");
                                    pst.setString(1, rs3.getString(2));
                                    pst.setString(2, rs3.getString(3));
                                    pst.setString(3, rs3.getString(4));
                                    pst.setString(4, pname + "-" + rs3.getString(1));

                                    pst.executeUpdate();

                                    pst = con.prepareStatement("insert ignore into subject_data_" + pname3 + "_" + year + " values(?,?,?,?)");
                                    pst.setString(1, rs3.getString(2));
                                    pst.setString(2, rs3.getString(3));
                                    pst.setString(3, rs3.getString(4));
                                    pst.setString(4, pname + "-" + rs3.getString(1));

                                    pst.executeUpdate();

                                    pst = con.prepareStatement("insert ignore into subjecttable values(?,?,?,?)");
                                    pst.setString(1, rs3.getString(2));
                                    pst.setString(2, rs3.getString(3));
                                    pst.setString(3, rs3.getString(4));
                                    pst.setString(4, "C");

                                    pst.executeUpdate();

                                }
                            }
                            con.commit();
                            pname = pname.replace('-', '_');
                        } catch (Exception ex) {
                            con.rollback();
                            pst = con.prepareStatement("DROP TABLE IF EXISTS " + pname + "_" + year + "_currrefer");
                            pst.executeUpdate();
                            pst = con.prepareStatement("DROP TABLE IF EXISTS " + pname + "_" + year + "_curriculum");
                            pst.executeUpdate();
                            pst = con.prepareStatement("DROP TABLE IF EXISTS subject_data_" + pname + "_" + year + "");
                            pst.executeUpdate();
                            out.println("Some internal error..");
                            return;
                        } finally {
                            con.setAutoCommit(true);
                        }
                        pst = con.prepareStatement("create table if not exists " + pname + "_curriculumversions(Year int NOT NULL ,Curriculum_name varchar(200),primary key(Year))");
                        pst.executeUpdate();
                        try {
                            con.setAutoCommit(false);
                            pst = con.prepareStatement("insert ignore into " + pname + "_curriculumversions(Year,Curriculum_name)values(?,?)");
                            pst.setInt(1, Integer.parseInt(year));
                            pst.setString(2, pname + "_" + year + "_curriculum");
                            pst.executeUpdate();
                            con.commit();
                            z++;
                            out.println("<h3>" + pname3 + " added successfully. </h3>");
                        } catch (Exception ex) {
                            con.rollback();
                            pst = con.prepareStatement("DROP TABLE IF EXISTS " + pname + "_" + year + "_currrefer");
                            pst.executeUpdate();
                            pst = con.prepareStatement("DROP TABLE IF EXISTS " + pname + "_" + year + "_curriculum");
                            pst.executeUpdate();
                            pst = con.prepareStatement("DROP TABLE IF EXISTS subject_data_" + pname + "_" + year + "");
                            pst.executeUpdate();
                            out.println("Some internal error..");
                            return;
                        }

                    } catch (Exception e) {
                        System.out.println(e);
                    }
                } /*##########################################################################################################
                 * 
                 * 
                 * phd....
                 * 
                 * 
                 * #####################################################starting############################################
                 */ else {

                    try {
                        String realPath = getServletContext().getRealPath("/");

                        File f3 = new File(realPath + "/" + saveFile);

                        File f4 = new File("/var/lib/mysql/phd/" + saveFile);
                        pst = con2.prepareStatement("DROP TABLE IF EXISTS " + pname + "_" + year + "_currrefer");
                        pst.executeUpdate();
                        pst = con2.prepareStatement("create table if not exists " + pname + "_" + year + "_currrefer(Sno int NOT NULL, UNIQUE(Sno)) ");
                        pst.executeUpdate();


                        /*
                         * 
                         *creating PhD_currrefer table*********************************************** 
                         * 
                         */
                        int k3 = 2;

                        BufferedReader br = new BufferedReader(new FileReader(f3));

                        String line, line1;

                        while ((line = br.readLine()) != null) {

                            if (k3 > 1 && k3 < 3) {
                                String[] cval = line.split(",");

                                n = cval.length;

                                for (l = 0; l < n; l++) {

                                    String originalString = cval[l];

                                    int startIndex = originalString.indexOf("(");

                                    int endIndex = originalString.indexOf(")");

                                    colName = originalString.substring(0, startIndex);

                                    colDataType = originalString.substring(startIndex + 1, endIndex);

                                    if (colDataType.equalsIgnoreCase("varchar")) {

                                        coltype = dataType[0];

                                    } else if (colDataType.equalsIgnoreCase("int")) {

                                        coltype = dataType[1];

                                    } else if (colDataType.equalsIgnoreCase("FLOAT")) {

                                        coltype = dataType[2];

                                    } else if (colDataType.equalsIgnoreCase("boolean")) {

                                        coltype = dataType[3];
                                    }
                                    if (coltype.equalsIgnoreCase("boolean")) {
                                        pst = con2.prepareStatement("Alter table " + pname + "_" + year + "_currrefer Add " + colName + " " + coltype + " DEFAULT '0'");
                                        pst.executeUpdate();

                                    }
                                    pst = con2.prepareStatement("Alter table " + pname + "_" + year + "_currrefer Add " + colName + " " + coltype + "");
                                    pst.executeUpdate();

                                }
                            }
                            k3++;
                        }
                        //updating PhD_year_currrefer table******************************
                        pst = con2.prepareStatement("select * from " + pname + "_" + year + "_currrefer");

                        ResultSet rs = pst.executeQuery();
                        ResultSetMetaData metadata = rs.getMetaData();

                        BufferedReader br1 = new BufferedReader(new FileReader(f3));

                        int q = 0, k = 0;
                        try {
                            con2.setAutoCommit(false);
                            while ((line1 = br1.readLine()) != null) {

                                if (k > 0 && k < 2) {

                                    int o = 2;
                                    String[] splits = line1.split(",");

                                    n1 = splits.length;

                                    for (m = 0; m < n1; m++) {

                                        colDataType1 = metadata.getColumnTypeName(o);

                                        //giving data type to columns..dynamically*******************
                                        if (colDataType1.equalsIgnoreCase("varchar")) {

                                            colValue_string = splits[m];

                                            pst = con2.prepareStatement("insert ignore into " + pname + "_" + year + "_currrefer(Sno)values(?)");
                                            pst.setInt(1, q);

                                            pst.executeUpdate();

                                            pst = con2.prepareStatement("UPDATE " + pname + "_" + year + "_currrefer SET " + metadata.getColumnName(o) + "=? WHERE Sno=?");
                                            pst.setString(1, colValue_string);
                                            pst.setInt(2, q);
                                            pst.executeUpdate();

                                            o++;

                                        } else if (colDataType1.equalsIgnoreCase("integer")) {

                                            colValue_int = Integer.parseInt(splits[m]);
                                            pst = con2.prepareStatement("insert ignore into " + pname + "_" + year + "_currrefer(Sno)values(?)");
                                            pst.setInt(1, q);

                                            pst.executeUpdate();

                                            pst = con2.prepareStatement("UPDATE " + pname + "_" + year + "_currrefer SET " + metadata.getColumnName(o) + "=? WHERE Sno=?");
                                            pst.setInt(1, colValue_int);
                                            pst.setInt(2, q);
                                            pst.executeUpdate();

                                            o++;

                                        } else if (colDataType1.equalsIgnoreCase("DOUBLE")) {

                                            colValue_float = Float.parseFloat(splits[m]);

                                            pst = con2.prepareStatement("insert ignore into " + pname + "_" + year + "_currrefer(Sno)values(?)");
                                            pst.setInt(1, q);

                                            pst.executeUpdate();

                                            pst = con2.prepareStatement("UPDATE " + pname + "_" + year + "_currrefer SET " + metadata.getColumnName(o) + "=? WHERE Sno=?");
                                            pst.setFloat(1, colValue_float);
                                            pst.setInt(2, q);
                                            pst.executeUpdate();

                                            o++;

                                        } else if (colDataType1.equalsIgnoreCase("TINYINT")) {

                                            colValue_int = Integer.parseInt(splits[m]);

                                            pst = con2.prepareStatement("insert ignore into " + pname + "_" + year + "_currrefer(Sno)values(?)");
                                            pst.setInt(1, q);

                                            pst.executeUpdate();

                                            pst = con2.prepareStatement("UPDATE " + pname + "_" + year + "_currrefer SET " + metadata.getColumnName(o) + "=? WHERE Sno=?");
                                            pst.setInt(1, colValue_int);
                                            pst.setInt(2, q);
                                            pst.executeUpdate();

                                            o++;

                                        }

                                    }
                                    q++;
                                }

                                k++;
                            }
                            con2.commit();
                        } catch (Exception ex) {
                            con2.rollback();
                            pst = con2.prepareStatement("DROP TABLE IF EXISTS " + pname + "_" + year + "_currrefer");
                            pst.executeUpdate();
                            return;
                        } finally {
                            con2.setAutoCommit(true);
                        }
                        pst = con2.prepareStatement("ALTER TABLE " + pname + "_" + year + "_currrefer ADD PRIMARY KEY(Cores)");
                        pst.executeUpdate();

                        pst = con2.prepareStatement("ALTER TABLE " + pname + "_" + year + "_currrefer DROP COLUMN Sno, DROP INDEX Sno");
                        pst.executeUpdate();


                        /*
                         * 
                         *###################### End for PhD_year_currrefer table ###############################
                         * 
                         * 
                         * 
                         * 
                         * ##################### Starting for PhD_year_curriculum table ##########################
                         */
                        pst = con2.prepareStatement("DROP TABLE IF EXISTS " + pname + "_" + year + "_curriculum");
                        pst.executeUpdate();

                        pst = con2.prepareStatement("create table if not exists " + pname + "_" + year + "_curriculum(Sno int NOT NULL, UNIQUE(Sno)) ");
                        pst.executeUpdate();

                        // adding column to stream_year_curriculum table dynamically, by reading values from curriculum csv file.*******
                        int k4 = 0;

                        br1 = new BufferedReader(new FileReader(f3));

                        String line3, line4;

                        while ((line3 = br1.readLine()) != null) {

                            if (k4 > 1 && k4 < 3) {

                                String[] cval1 = line3.split(",");//split line with ','

                                n = cval1.length;

                                for (l = 0; l < n; l++) {

                                    String originalString = cval1[l];

                                    int startIndex = originalString.indexOf("(");

                                    int endIndex = originalString.indexOf(")");

                                    colName = originalString.substring(0, startIndex);

                                    colDataType = originalString.substring(startIndex + 1, endIndex);

                                    if (colDataType.equalsIgnoreCase("varchar")) {

                                        coltype = dataType[0];

                                    } else if (colDataType.equalsIgnoreCase("int")) {

                                        coltype = dataType[1];

                                    } else if (colDataType.equalsIgnoreCase("FLOAT")) {

                                        coltype = dataType[2];

                                    } else if (colDataType.equalsIgnoreCase("boolean")) {

                                        coltype = dataType[3];
                                    }
                                    if (coltype.equalsIgnoreCase("boolean")) {
                                        pst = con2.prepareStatement("Alter table " + pname + "_" + year + "_curriculum Add " + colName + " " + coltype + " DEFAULT '0'");
                                        pst.executeUpdate();

                                        //st3.executeUpdate(sql);
                                    } else {
                                        pst = con2.prepareStatement("Alter table " + pname + "_" + year + "_curriculum Add " + colName + " " + coltype + "");
                                        pst.executeUpdate();

                                        //st3.executeUpdate(sql);
                                    }

                                }
                            }

                            k4++;
                        }

                        //updating PhD_year_curriculum table************************************************
                        pst = con2.prepareStatement("select * from " + pname + "_" + year + "_curriculum");

                        ResultSet rs2 = pst.executeQuery();

                        ResultSetMetaData metadata1 = rs2.getMetaData();

                        BufferedReader br3 = new BufferedReader(new FileReader(f3));

                        q = 0;
                        k = 0;
                        int minSemValue;
                        try {
                            con2.setAutoCommit(false);
                            while ((line1 = br3.readLine()) != null) {

                                if (k > 2) {

                                    int o = 2;

                                    String[] splits2 = line1.split(",");

                                    n1 = splits2.length;

                                    for (m = 0; m < n1; m++) {

                                        colDataType1 = metadata1.getColumnTypeName(o);

                                        if (colDataType1.equalsIgnoreCase("varchar")) {

                                            colValue_string = splits2[m];
                                            pst = con2.prepareStatement("insert ignore into " + pname + "_" + year + "_curriculum(Sno)values(?)");
                                            pst.setInt(1, q);
                                            pst.executeUpdate();

                                            pst = con2.prepareStatement("UPDATE " + pname + "_" + year + "_curriculum SET " + metadata1.getColumnName(o) + "=? WHERE Sno=?");
                                            pst.setString(1, colValue_string);
                                            pst.setInt(2, q);
                                            pst.executeUpdate();

                                            o++;

                                        } else if (colDataType1.equalsIgnoreCase("integer")) {

                                            colValue_int = Integer.parseInt(splits2[m]);
                                            pst = con2.prepareStatement("insert ignore into " + pname + "_" + year + "_curriculum(Sno)values(?)");
                                            pst.setInt(1, q);
                                            pst.executeUpdate();
                                            pst = con2.prepareStatement("UPDATE " + pname + "_" + year + "_curriculum SET " + metadata1.getColumnName(o) + "=? WHERE Sno=?");
                                            pst.setInt(1, colValue_int);
                                            pst.setInt(2, q);
                                            pst.executeUpdate();

                                            o++;

                                        } else if (colDataType1.equalsIgnoreCase("DOUBLE")) {

                                            colValue_float = Float.parseFloat(splits2[m]);

                                            pst = con2.prepareStatement("insert ignore into " + pname + "_" + year + "_curriculum(Sno)values(?)");
                                            pst.setInt(1, q);
                                            pst.executeUpdate();
                                            pst = con2.prepareStatement("UPDATE " + pname + "_" + year + "_curriculum SET " + metadata1.getColumnName(o) + "=? WHERE Sno=?");
                                            pst.setFloat(1, colValue_float);
                                            pst.setInt(2, q);
                                            pst.executeUpdate();

                                            o++;

                                        } else if (colDataType1.equalsIgnoreCase("TINYINT")) {

                                            colValue_int = Integer.parseInt(splits2[m]);

                                            pst = con2.prepareStatement("insert ignore into " + pname + "_" + year + "_curriculum(Sno)values(?)");
                                            pst.setInt(1, q);
                                            pst.executeUpdate();
                                            pst = con2.prepareStatement("UPDATE " + pname + "_" + year + "_curriculum SET " + metadata1.getColumnName(o) + "=? WHERE Sno=?");
                                            pst.setInt(1, colValue_int);
                                            pst.setInt(2, q);
                                            pst.executeUpdate();

                                            o++;

                                        }

                                    }
                                    q++;
                                }

                                k++;
                            }
                            con2.commit();
                        } catch (Exception ex) {
                            con2.rollback();
                            pst = con2.prepareStatement("DROP TABLE IF EXISTS " + pname + "_" + year + "_curriculum");
                            pst.executeUpdate();
                            pst = con2.prepareStatement("DROP TABLE IF EXISTS " + pname + "_" + year + "_currrefer");
                            pst.executeUpdate();
                            return;
                        } finally {

                        }

                        con2.setAutoCommit(true);
                        pst = con2.prepareStatement("ALTER TABLE " + pname + "_" + year + "_curriculum ADD PRIMARY KEY(Subject_ID)");
                        pst.executeUpdate();
                        pst = con2.prepareStatement("ALTER TABLE " + pname + "_" + year + "_curriculum DROP COLUMN Sno, DROP INDEX Sno");
                        pst.executeUpdate();
                        pst = con2.prepareStatement("create table if not exists " + pname + "_curriculumversions(Year int NOT NULL ,Curriculum_name varchar(200),primary key(Year))");
                        pst.executeUpdate();
                        try {
                            pst = con2.prepareStatement("insert ignore into " + pname + "_curriculumversions(Year,Curriculum_name)values(?,?)");
                            pst.setInt(1, Integer.parseInt(year));
                            pst.setString(2, pname + "_" + year + "_curriculum");
                            pst.executeUpdate();
                            con2.commit();
                            out.println(pname + " added successfully");
                        } catch (Exception ex) {
                            con2.rollback();
                            pst = con2.prepareStatement("DROP TABLE IF EXISTS " + pname + "_" + year + "_curriculum");
                            pst.executeUpdate();
                            pst = con2.prepareStatement("DROP TABLE IF EXISTS " + pname + "_" + year + "_currrefer");
                            pst.executeUpdate();
                            return;
                        } finally {
                            con2.setAutoCommit(true);
                        }

                    } catch (Exception e) {

                    }
                    /*
                     * 
                     *##################### End for PhD_year_curriculum table ############################### 
                     * 
                     */

                }

            } catch (Exception ex) {
                System.out.println(ex);
            }
        %> 
    </body>
</html>