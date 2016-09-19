<%-- 
    Document   : projectTitleCheck_ajax
    Created on : Dec 20, 2013, 10:51:07 AM
    Author     : veeru
--%>
<%@page import="java.util.Calendar"%>
<%@ include file="dbconnection.jsp" %>
<%@include file="checkValidity.jsp"%>

<%
    //Retrieving parameter from projectRegistrationFacultyStream.jsp page***********
    System.out.println("im in ajax code dude........");
    int CurriculumYear = 0, check = 0;
    String projectTitle = request.getParameter("streamProject");
    System.out.println(projectTitle);
    String user = (String) session.getAttribute("user");
    String stream = (String) session.getAttribute("ProjectRegStream");
    stream = stream.replace('-', '_');
    Statement st1 = con.createStatement();
    Statement st2 = con.createStatement();
    //current date**********
    Calendar now = Calendar.getInstance();
    int month = now.get(Calendar.MONTH) + 1;
    int CurrentYear = now.get(Calendar.YEAR);
    if(month<=6)
    {
        CurrentYear=CurrentYear-1;
    }

    //Retrieving latest curriculum from **programme curriculum version table****
    ResultSet rs1 = (ResultSet) st1.executeQuery("select ProjectTitle from " + stream + "_project" + "_" + CurrentYear + " where ProjectTitle='" + projectTitle + "'");
    while (rs1.next()) {

        check++;
        break;
    }
   
       
        out.println(check);
   

%>
