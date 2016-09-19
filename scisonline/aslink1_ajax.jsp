<%-- 
    Document   : aslink1_ajax
    Created on : Dec 12, 2013, 10:41:17 AM
    Author     : veeru
--%>

<%@page import="java.util.Calendar"%>
<%@ include file="dbconnection.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    //Retrieving parameter from aslink1.jsp page***********
    int CurriculumYear = 0, LatestYear = 0;
    String pname1 = request.getParameter("pname");
    System.out.println(pname1);
    pname1 = pname1.replace('-', '_');
    Statement st1 = con.createStatement();
    Statement st2 = con.createStatement();
    //current date**********
    Calendar now = Calendar.getInstance();
    int month = now.get(Calendar.MONTH) + 1;
    int CurrentYear = now.get(Calendar.YEAR);
    //Retrieving latest curriculum from **programme curriculum version table****
    ResultSet rs10 = st2.executeQuery("select * from " + pname1 + "_curriculumversions order by Year desc");
    while (rs10.next()) {
        CurriculumYear = rs10.getInt(1);
        if (CurriculumYear <= CurrentYear) {

            LatestYear = CurriculumYear;
            System.out.println(LatestYear);
            break;
        }
    }

    //******************************************************************************

    System.out.println(LatestYear);

    ResultSet rs1 = st1.executeQuery("select count(*) from " + pname1 + "_" + LatestYear + "_currrefer");
    rs1.next();
    int RowsCount = rs1.getInt(1);

    System.out.println(RowsCount);
    int ProgrammeDuration = RowsCount / 2;

    out.println(ProgrammeDuration);


%>
