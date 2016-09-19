<%-- 
    Document   : summary
    Created on : Sep 15, 2011, 6:01:41 PM
    Author     : admin
--%>
<%@page import="sun.swing.MenuItemLayoutHelper.ColumnAlignment"%>
<%@page import="java.util.Calendar"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.sql.*"%>
<%@include file="checkValidity.jsp"%>
<%--<%@include file="dbconnection.jsp"%>--%>
<%@include file="connectionBean.jsp"%>
<%    Calendar now = Calendar.getInstance();

    System.out.println("Current date : " + (now.get(Calendar.MONTH) + 1)
            + "-"
            + now.get(Calendar.DATE)
            + "-"
            + now.get(Calendar.YEAR));
    int month = now.get(Calendar.MONTH) + 1;
    int year = now.get(Calendar.YEAR);
    int date = now.get(Calendar.DATE);
    String semester = "";
    if (month == 7 || month == 8 || month == 9 || month == 10 || month == 11 || month == 12) {
        semester = "Monsoon";
    } else if (month == 1 || month == 2 || month == 3 || month == 4 || month == 5 || month == 6) {
        semester = "Winter";
    }

    //*********************************************************************
    Connection con = conn.getConnectionObj();
    Statement st30 = con.createStatement();
    ResultSet rs30 = st30.executeQuery("select * from session");
    String startdate = "";
    String enddate = "";
    int sm = 0, em = 0, sd = 0, ed = 0, gap = 0, findtable = 0;
    while (rs30.next()) {
        startdate = rs30.getDate(2).toString();
        enddate = rs30.getDate(3).toString();

        String table_year = (startdate.substring(0, 4));
        String table_session = rs30.getString(1);

        String session_year = table_session + table_year;
        // System.out.println("table "+session_year+" given "+given_session+given_year);
        if (session_year.equalsIgnoreCase(semester + year)) {
            System.out.println("matched");
            rs30.afterLast();
            findtable = 1;
        }
    }
    if (findtable == 0) {
        startdate = "";
        enddate = "";
    }
    //creates a array of string for months name

    sm = Integer.parseInt(startdate.substring(5, 7));
    em = Integer.parseInt(enddate.substring(5, 7));

    gap = em - sm;
    if (gap < 0) {
        gap = -gap;
    }
    sd = Integer.parseInt(startdate.substring(8));
    ed = Integer.parseInt(enddate.substring(8));
    if (ed - sd > 0) {
        gap = gap + 1;
    }
    System.out.println(gap + month);

    boolean isLeapYear;
    isLeapYear = (year % 4 == 0);

    // divisible by 4 and not 100  
    isLeapYear = isLeapYear && (year % 100 != 0);

    // divisible by 4 and not 100 unless divisible by 400  
    isLeapYear = isLeapYear || (year % 400 == 0);
    String u = "28";
    if (isLeapYear == true) {
        u = "29";
    }
    String[] nameOfMonth = {"Jan", "Feb", "Mar", "Apr",
        "May", "Jun", "Jul", "Aug", "Sep", "Oct",
        "Nov", "Dec"};
    String[] nameOfMonth1 = {"Jan31", "Feb" + u, "Mar31", "Apr30",
        "May31", "Jun30", "Jul31", "Aug31", "Sep30", "Oct31",
        "Nov30", "Dec31"};
    String[] find = {"", "", "", "", "", "", "", "", ""};
    int y = 1, m = sm;
    while (y <= gap) {
        if (y == gap) {
            if (sd > 5) {
                find[y] = nameOfMonth[m - 1] + sd + "-" + nameOfMonth[em - 1] + ed;
            } else {
                find[y] = nameOfMonth[m - 1] + "1" + "-" + nameOfMonth[em - 1] + ed;
            }
        } else {
            if (sd <= 5) {
                if (y == 1) {
                    find[y] = nameOfMonth[m - 1] + sd + "-" + nameOfMonth1[m - 1];
                } else {
                    find[y] = nameOfMonth[m - 1] + "1" + "-" + nameOfMonth1[m - 1];
                }
            } else {
                find[y] = nameOfMonth[m - 1] + sd + "-" + nameOfMonth[m] + (sd - 1);
            }
        }
        y++;
        m++;
    }
//***************************************************************************
    System.out.println("**************************************************************************");
    String sname = request.getParameter("subjectname");
    if (sname == null) {
        sname = "";
    }
//session.setAttribute("facultyname",fname);
    System.out.println(sname);
    System.out.println("***************************************");
    try {
        // Class.forName("com.mysql.jdbc.Driver").newInstance();
        //System.out.println("driver connected");

        // System.out.println("database connected");
        String qry = "select code from subjecttable where Subject_Name='" + sname + "'";
        Statement st1 = con.createStatement();
        Statement st2 = con.createStatement();
        Statement st9 = con.createStatement();
        ResultSet rs = st1.executeQuery(qry);
        String subjid = "";
        int index = 0;
        subjid = request.getParameter("subjectid");
        String day = "";
        //String qry9="select Day(sessiont_date) from current_session1";
        //ResultSet rs9=st9.executeQuery(qry9);
        //while(rs9.next())
        //         {
        //day=rs9.getString(1);
        //     }
        System.out.println("srinu test subjectid==" + subjid);

        //String columnname1="Mar 1 - Mar 31";
        String fid = (String) session.getAttribute("user");
        System.out.println(fid);
        Statement st6 = con.createStatement();
        String fname = "";
        try {
            String qry6 = "select Faculty_Name from faculty_data where ID='" + fid + "'";
            ResultSet rs6 = st6.executeQuery(qry6);
            rs6.next();
            fname = rs6.getString(1);
        } catch (Exception ex) {
        }
        System.out.println(fname);
        String qry50 = "select * from subject_attendance_" + semester + "_" + year + " where subjectId='" + subjid + "'";
        Statement st50 = con.createStatement();
        ResultSet rs50 = st50.executeQuery(qry50);
        ResultSetMetaData rsmd = rs50.getMetaData();
        int noOfColumns = rsmd.getColumnCount();
        noOfColumns = noOfColumns - 2;

        int monthfinding = 1;
        int w = 1;
        rs50.next();
        while (w <= noOfColumns) {
            if (rs50.getInt(w + 1) != 0) {
                monthfinding = w;
            }

            w++;
        }
        try {
            String mnum = request.getParameter("mnum");
            if(mnum !=null)
            {
                monthfinding=Integer.parseInt(mnum);
            }
        } catch (Exception ex) {

        }
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title id="title">JSP Page</title>
        <style type="text/css">

            @media print {

                .noPrint
                {
                    display:none;
                }
            }
            .th
            {
                color: white;
                background-color: #c2000d;
                border-collapse: collapse;
                border: 1px solid green;

            }
            .table
            {
                border-collapse:collapse;
                border: 1px solid green;
                white-space:nowrap;
                background-color: #F5F5F5;
                padding: 5px;
            }
            .td
            {
                border-collapse:collapse;
                border: 1px solid green;
                white-space:nowrap;
                background-color: #F5F5F5;
                padding: 4px;
            }
        </style> 

    </head>
    <body>
    <center>University of Hyderabad</center>
    <center>School of Computer and Information Sciences</center>
    <center><%=sname%> Attendance</center>
    <table  border="0"  cellspacing="0" cellpadding="0" style="color:blue;background-color:#CCFFFF;" width="97%">
        <tr>
            <th>Year<br/><font color="balck"><%=year%></font></th>

            <th>Duration<br><font color="balck"><%=find[monthfinding]%></font></th>

            <th>Semester<br/><font color="balck"><%=semester%></font></th>

            <% session.setAttribute("subjname", sname);%>


            <th>Code<br/><font color="balck"><%=subjid%></font></th>    




    </table>   
    <%

        Statement st4 = con.createStatement();
        Statement st3 = con.createStatement();

        String qry4 = "select Month" + (monthfinding) + ",cumatten from subject_attendance_" + semester + "_" + year + " where subjectId='" + subjid + "'";
        String qry5 = "select StudentId,StudentName,month" + (monthfinding) + ",cumatten,percentage from " + subjid + "_Attendance_" + semester + "_" + year;
        ResultSet rs4 = st3.executeQuery(qry4);
        ResultSet rs5 = st4.executeQuery(qry5);
    %>
    <table border="0" style="color:blue;background-color:#CCFF99" cellspacing="5" cellpadding="0" width="97%">
        <tr>
            <td><center>Number of Hours Taught:</center></td>

    <%
        if (rs4.next()) {
    %>


    <td>Previous Total<input type="text" name="pa" id="pa" value="<%=rs4.getInt(2) - rs4.getInt(1)%>" readonly="readonly" size="5"/></td>
        <%} else {
        %>    
    <td>Previous Total<input type="text" name="pa" id="pa" value="0" readonly="readonly" size="5"/></td>
        <%                    }%>

    <td>Current Month<input type="text" name="ca" id="ca" value="<%=rs4.getInt(1)%>"  size="5" readonly="readonly"/></td>

    <td>Total<input type="text" name="pta" id="pta" value="<%=rs4.getInt(2)%>" readonly="readonly" size="5"/></td>
</tr>
</table>


</br> 
</br>
<table border="1" align="center" class="table">

    <th class="th">StudentID</th>
    <th class="th">Student Name</th>
    <th class="th"><%=find[monthfinding]%></th>
    <th class="th">Overall Percentage</th>

    <%while (rs5.next()) {
    %>

    <%
        if (Math.ceil(rs5.getFloat(5)) < 75) {
    %>
    <tr style="background-color:#F3F781">
        <td><%=rs5.getString(1)%></td>
        <td><%=rs5.getString(2)%></td>
        <td><%=rs5.getInt(3)%></td>
        <td><font><%=Math.ceil(rs5.getFloat(5))%></font></td>

        <%} else {
        %>
    <tr>
        <td class="td"><%=rs5.getString(1)%></td>
        <td class="td"><%=rs5.getString(2)%></td>
        <td class="td"><%=rs5.getInt(3)%></td>
        <td class="td"><%=Math.ceil(rs5.getFloat(5))%></td>
        <%}%>
    </tr>

    <%

        }
    %>

</table>&nbsp;&nbsp;   
<div align="center"> <input type="button" value="Print" id="p1" style=" color: black" class="noPrint" onclick="window.print();" /></div>
<br/>
<br/>
<table align="right" style="color:blue;background-color:#CCFFFF;">
    <tr>
        <td>Signature of the Faculty</td>
    </tr> 

    <tr>
        <td><%=fname%></td>
    </tr>

</table>
<%
    } catch (Exception e) {
        System.out.println("Caught the exception");
        out.println(e);
        //out.println("<h1><center>Data is not Available</center></h1>");
        e.printStackTrace();
    }finally{
        conn.closeConnection();
        con =null;
    }
%>

</body>
</html>