<%-- 
    Document   : demo
    Created on : Oct 18, 2011, 11:48:48 AM
    Author     : admin
--%>

<%@include file="checkValidity.jsp"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Calendar"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*"%>
<%@ page import="javax.sql.*"%>
<%@ page import="org.apache.poi.hssf.usermodel.HSSFWorkbook"%>
<%@page import="org.apache.poi.hssf.util.HSSFColor"%>
<%@ page import="org.apache.poi.ss.usermodel.Workbook"%>
<%@ page import="org.apache.poi.ss.usermodel.Font"%>
<%@ page import="org.apache.poi.ss.usermodel.CellStyle"%>
<%@ page import="org.apache.poi.ss.usermodel.IndexedColors"%>
<%@ page import="org.apache.poi.ss.usermodel.Sheet"%>
<%@ page import="org.apache.poi.ss.usermodel.Cell"%>
<%@ page import="org.apache.poi.ss.usermodel.Row"%>
<%@include file="dbconnection.jsp"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <script language="javascript" src="print.js"></script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style type="text/css">

            @media print {

                .noPrint
                {
                    display:none;
                }
            }
            .td
            {
                border-collapse:collapse;
                border: 1px solid green;
                white-space:nowrap;
                background-color: #F5F5F5;
                padding: 2px;
            }
            .table
            {

                border-collapse:collapse;
                border: 1px solid green;
                white-space:nowrap;
                background-color: #F5F5F5;
                padding: 4px;

            }
            .th{
                background-color: #c2000d;
                border: 1px solid #c2000d;
                color:white;
            }

        </style>

    </head>
    <body>


        <%            PreparedStatement pst = null;
            PreparedStatement pst1 = null;
            try {

                System.out.println("=======================");
                Workbook workbook = new HSSFWorkbook();
                Sheet s = workbook.createSheet();

                String year = request.getParameter("year");
                String from = request.getParameter("mySelect");
                String to = request.getParameter("mySelect1");
                String semester = request.getParameter("semester");
                String subjectName = request.getParameter("subjname");
                String subjectId = request.getParameter("subjid");

                String pa = request.getParameter("pa");
                String ca = request.getParameter("ca");
                String pta = request.getParameter("pta");
                String sd = (String) session.getAttribute("sd");
                System.out.println(subjectId);

        %>

        <%if (request.getParameter("pq") != null) {%>
        <%!                            String[] ItemNames;
            String[] ItemNames1;
            String[] ItemNames2;
            String[] ItemNames3;
        %>
        <%
            ItemNames = request.getParameterValues("pq");
            ItemNames1 = request.getParameterValues("pq1");
            ItemNames2 = request.getParameterValues("pq2");
            ItemNames3 = request.getParameterValues("pq3");

        %>

        <%}%>


        <%
            int i = 1;
            String fid = (String) session.getAttribute("user");

            ResultSet rs1 = null;
            String fname = null;
            Statement st3 = con.createStatement();

            try {

                con.setAutoCommit(false);//Transaction start@@@ 

                pst = con.prepareStatement("select Faculty_Name from faculty_data where ID=?");
                pst.setString(1, fid);
                ResultSet rs6 = pst.executeQuery();

                if (rs6.next()) {
                    fname = rs6.getString(1);
                }

                pst1 = con.prepareStatement("select StudentId,StudentName,cumatten,percentage from " + subjectId + "_Attendance_" + semester + "_" + year);
                pst = con.prepareStatement("update subject_attendance_" + semester + "_" + year + " set  month" + sd + "=" + ca + " where subjectId=?");
                pst.setString(1, subjectId);
                pst.executeUpdate();

                pst = con.prepareStatement("show columns from subject_attendance_" + semester + "_" + year + "");
                ResultSet rs30 = pst.executeQuery();
                int columnnumber = 0;
                while (rs30.next()) {
                    columnnumber++;
                }
                columnnumber = columnnumber - 2;

                pst = con.prepareStatement("select * from subject_attendance_" + semester + "_" + year + " where subjectId=?");
                pst.setString(1, subjectId);
                ResultSet rs20 = pst.executeQuery();

                int totalclasses = 0, p = 1;
                while (rs20.next()) {
                    while (p <= columnnumber) {
                        totalclasses = totalclasses + rs20.getInt(p + 1);
                        p++;
                    }
                }

                pst = con.prepareStatement("update subject_attendance_" + semester + "_" + year + " set  cumatten=" + totalclasses + " where subjectId=?");
                pst.setString(1, subjectId);
                pst.executeUpdate();
                rs1 = pst1.executeQuery();

                String qry3 = "";
                int k = 0;
                int tclasses1 = 0;
                while (rs1.next()) {

                    ItemNames1[k] = ItemNames1[k].replaceAll(" ", "");

                    pst = con.prepareStatement("update " + subjectId + "_Attendance_" + semester + "_" + year + " set month" + sd + "=" + Integer.parseInt(ItemNames1[k]) + " where StudentId=?");
                    pst.setString(1, rs1.getString(1));
                    pst.executeUpdate();

                    int x = 1, attendedclasses = 0;

                    pst = con.prepareStatement("select * from " + subjectId + "_Attendance_" + semester + "_" + year + " where StudentId=?");
                    pst.setString(1, rs1.getString(1));
                    ResultSet rs60 = pst.executeQuery();

                    while (rs60.next()) {
                        while (x <= columnnumber) {
                            attendedclasses = attendedclasses + rs60.getInt(x + 2);
                            x++;
                        }
                    }

                    pst = con.prepareStatement("update " + subjectId + "_Attendance_" + semester + "_" + year + " set cumatten=? where StudentId=? ");
                    pst.setString(1, Integer.toString(attendedclasses));
                    pst.setString(2, rs1.getString(1));
                    pst.executeUpdate();

                    double d = (double) attendedclasses / totalclasses;
                    d = d * 100;

                    pst = con.prepareStatement("update " + subjectId + "_Attendance_" + semester + "_" + year + " set percentage=? where StudentId=?");
                    
                    pst.setString(1, Double.toString(d));
                    pst.setString(2, rs1.getString(1));
                    pst.executeUpdate();

                    k++;
                }

                con.commit();//Transactions commited.

            } catch (Exception ex) {

                con.rollback();//Transactions roll back.
                System.out.println(ex);
                System.out.println("Transcation rollback!!!");
            }
           
            if(fid.equalsIgnoreCase("staff"))
            {
             %>
        <script>
          
            window.open("subjsummary_1.jsp?subjectname=" + '<%=subjectName%>'+"&subjectid="+'<%=subjectId%>'+"&mnum="+'<%=sd%>', "staffaction");//here check =6 means error number (if condition number.)
        </script> 
        <%   
            }else{
        %>
        <script>
          
            window.open("subjsummary_1.jsp?subjectname=" + '<%=subjectName%>'+"&subjectid="+'<%=subjectId%>'+"&mnum="+'<%=sd%>', "facultyaction");//here check =6 means error number (if condition number.)
        </script> 
        <%
            }
            } catch (Exception ex) {
                System.out.println(ex);
            } finally {
                if (pst != null) {
                    pst.close();
                }
                if (pst1 != null) {
                    pst1.close();
                }
                if (con != null) {
                    con.close();
                }
            }
        %>

    </body>
</html>
