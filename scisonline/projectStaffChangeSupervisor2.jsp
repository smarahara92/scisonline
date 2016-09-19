<%-- 
    Document   : projectStaffChangeSupervisor2
    Created on : 9 Apr, 2013, 3:04:46 AM
    Author     : varun
--%>
<%@include file="checkValidity.jsp"%>
<%@page import="com.hcu.mysql.connection.ConnectionDemo1"%>
<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@include file="programmeRetrieveBeans.jsp"%>
<%@include file="connectionBean.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>

        <style>
            <%--body {color:white}--%>
            .style11 {color :red}
            .style12 {color :white}
            .style13 {color :yellow}


        </style>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" type="text/css" href="table_css.css">
    </head>


    <body bgcolor="E0FFFF">
        <%            Calendar now = Calendar.getInstance();
            int year = now.get(Calendar.YEAR);
            int month = now.get(Calendar.MONTH) + 1;
            int curYear = 0;
            String newSupName = "";
            Connection con = conn.getConnectionObj();
            
            Statement st1 = con.createStatement();
            Statement st2 = con.createStatement();
            Statement st3 = con.createStatement();
            Statement st4 = con.createStatement();
            Statement st5 = con.createStatement();
            Statement st6 = con.createStatement();
            Statement st7 = con.createStatement();
            Statement st8 = con.createStatement();
            Statement st9 = con.createStatement();
            Statement st10 = con.createStatement();
            String batchYear = (String) session.getAttribute("cpyear");
            String streamName = (String) session.getAttribute("cpstreamName");
            streamName = streamName.replace('-', '_');
            String programmeName = (String) session.getAttribute("cpprogrammeName");
            programmeName = programmeName.replace('-', '_');
            int pyear = year;
            String semester = null;
            if (streamName.equalsIgnoreCase("MCA") == true) {
                if (month <= 6) {
                    semester = "Winter";
                    pyear = year;
                } else {
                    semester = "Monsoon";
                    pyear = year - 1;
                }
            } else {
                if (month > 3) {
                    pyear = year;
                } else {
                    pyear = year - 1;
                }
            }

            String cBox = (String) session.getAttribute("Combo");//cs means change supervisor ; ni means new internship;rtuoh means return from internship
            String newSupervisor = (String) session.getAttribute("newSupervisor");//new supervisor name.
            Integer projIdOld = Integer.parseInt((String) session.getAttribute("ProjectIdOld")); // This old project id is actual Project id of student who is changing Supervisor.
            Integer projId = Integer.parseInt(request.getParameter("rb")); // New Project ID (Unallocated Project Id of Project.)

            String table1 = streamName + "_project_" + pyear;
            String table2 = programmeName + "_Project_Student_" + pyear;
            ResultSet rs3 = null;
            ResultSet rs4 = null;
            ResultSet rs6 = null;
            ResultSet rs7 = null;
            ResultSet rs8 = null;
            // ResultSet rs3 = (ResultSet)st5.executeQuery("  (select StudentId,ProjectTitle,SupervisorId1,SupervisorId2,SupervisorId3 from Mtech_project_"+year+" as a, MTech_CS_Project_"+year+" as b where a.ProjectId=b.ProjectId and (a.SupervisorId1='"+newSupervisor+"' or a.SupervisorId2='"+newSupervisor+"' or a.SupervisorId3='"+newSupervisor+"')) union all (select StudentId,ProjectTitle,SupervisorId1,SupervisorId2,SupervisorId3 from Mtech_project_"+year+" as a, MTech_IT_Project_"+year+" as c where a.ProjectId=c.ProjectId and (a.SupervisorId1='"+newSupervisor+"' or a.SupervisorId2='"+newSupervisor+"' or a.SupervisorId3='"+newSupervisor+"')) union all (select StudentId,ProjectTitle,SupervisorId1,SupervisorId2,SupervisorId3 from Mtech_project_"+year+" as a, MTech_AI_Project_"+year+" as d where a.ProjectId=d.ProjectId and (a.SupervisorId1='"+newSupervisor+"' or a.SupervisorId2='"+newSupervisor+"' or a.SupervisorId3='"+newSupervisor+"'))              ");

            newSupName = scis.facultyName(newSupervisor);

            // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%     
            // ################################## Change Supervisor #################################################   
            if ("cs".equals(cBox)) {
                try {
                    try {
                        con.setAutoCommit(false);
                        st2.executeUpdate("update  " + table2 + " as a set a.ProjectId='" + projId + "' where a.ProjectId='" + projIdOld + "' "); //or "
                        st3.executeUpdate("update " + table1 + " set Allocated='yes' where ProjectId='" + projId + "'");
                        st4.executeUpdate("update " + table1 + " set Allocated='no' where ProjectId='" + projIdOld + "'");
                        con.commit();
                    } catch (Exception ex) {
                        con.rollback();
                        out.println("Some internal error please try again...");
                        System.out.println(ex);
                        System.out.println("Transaction rollback!!!");
                    } finally {
                        con.setAutoCommit(true);
                    }
        %>
        <form name="form1"> 

            <table border="1" width="1000" align="center">
                <caption><h3>Allocated Projects under Faculty <%=newSupName%></h3></caption>
                <th>Student ID</th>    
                <th>Student Name</th>
                <th>Project Title</th>
                <th>Supervisor 1</th>
                <th>Supervisor 2</th>
                <th>Supervisor 3</th>


                <%
                    String table3 = "";
                    ResultSet rs1 = scis.getProgramme(streamName, 1);
                    while (rs1.next()) {

                        table3 = rs1.getString(1).replace('-', '_') + "_Project_Student_" + pyear;
                        rs3 = (ResultSet) st5.executeQuery("select StudentId,ProjectTitle,SupervisorId1,SupervisorId2,SupervisorId3 from " + table1 + " as a, " + table3 + " as b where a.ProjectId=b.ProjectId and (a.SupervisorId1='" + newSupervisor + "' or a.SupervisorId2='" + newSupervisor + "' or a.SupervisorId3='" + newSupervisor + "')");

                        while (rs3.next()) {

                            String supName1 = "";
                            String supName2 = "";
                            String supName3 = "";
                            String name = "";
                            String table = "";
                            String studId = rs3.getString(1);
                            table = rs1.getString(1).replace('-', '_') + "_" + batchYear;
                            String supid1 = rs3.getString(3);
                            String supid2 = rs3.getString(4);               // Iski Vajah se
                            String supid3 = rs3.getString(5);

                            if (supid1.equalsIgnoreCase("" + newSupervisor + "")) {
                                supName1 = scis.facultyName(supid1);
                                if (supName1 != null) {
                                    supName1 = supName1;
                                } else {

                                    supName1 = supid1;
                                }
                                supName2 = scis.facultyName(supid2);
                                if (supName2 != null) {
                                    supName2 = supName2;
                                } else {
                                    supName2 = supid2;
                                }
                                supName3 = scis.facultyName(supid3);
                                if (supName3 != null) {

                                } else {
                                    supName3 = supid3;
                                }
                            } else if (supid2.equalsIgnoreCase("" + newSupervisor + "")) {
                                supName1 = scis.facultyName(supid2);
                                if (supName1 != null) {

                                } else {
                                    supName1 = supid1;
                                }
                                supName2 = scis.facultyName(supid1);
                                if (supName2 != null) {

                                } else {
                                    supName2 = supid1;
                                }
                                supName3 = scis.facultyName(supid3);
                                if (supName3 != null) {

                                } else {
                                    supName3 = supid3;
                                }

                            } else {
                                supName1 = scis.facultyName(supid3);
                                if (supName1 != null) {

                                } else {
                                    supName1 = supid3;
                                }
                                supName2 = scis.facultyName(supid1);
                                if (supName2 != null) {

                                } else {
                                    supName2 = supid1;
                                }
                                supName3 = scis.facultyName(supid2);
                                if (supName3 != null) {

                                } else {
                                    supName3 = supid2;
                                }
                            }

                            name = scis.studentName(studId);     // Student Name

                            //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

                %>


                <tr >
                    <td><%=name%></td>     
                    <td><%=rs3.getString(1)%></td>
                    <td><%=rs3.getString(2)%> </td>
                    <td><%=supName1%> </td>
                    <td><%=supName2%> </td>
                    <td><%=supName3%> </td>



                </tr>

                <%}
                    }

                %>            
            </table>
        </form>             

        <%     rs1.close();
                } catch (Exception ex) {
                ex.printStackTrace();
            }

        } // #############################  Return from Internship#######################################     
        else if ("rtuoh".equals(cBox)) {
            try {
                try {
                    con.setAutoCommit(false);
                    st2.executeUpdate("update  " + table2 + " as a set a.ProjectId='" + projId + "' where a.ProjectId='" + projIdOld + "' "); //or "
                    st3.executeUpdate("update " + table1 + " set Allocated='yes' where ProjectId='" + projId + "'");
                    st4.executeUpdate("update " + table1 + " set Allocated='no' where ProjectId='" + projIdOld + "'");
                    con.commit();
                } catch (Exception ex) {
                    con.rollback();
                    out.println("Some internal error please try again...");
                    System.out.println(ex);
                    System.out.println("Transaction rollback!!!");
                } finally {
                    con.setAutoCommit(true);
                }
        %>        

        <form name="form1"> 

            <table border="1" width="1000" align="center">
                <caption><h3>Allocated Projects under Faculty <%=newSupName%> </h3></caption>
                <th>Student ID</th>    
                <th>Student Name</th>
                <th>Project Title</th>
                <th>Supervisor 1</th>
                <th>Supervisor 2</th>
                <th>Supervisor 3</th>


                <%
                    String table3 = "";
                    ResultSet rs2 = scis.getProgramme(streamName, 1);
                    while (rs2.next()) {

                        table3 = rs2.getString(1).replace('-', '_') + "_Project_Student_" + pyear;

                        rs3 = (ResultSet) st5.executeQuery(" select StudentId,ProjectTitle,SupervisorId1,SupervisorId2,SupervisorId3 from " + table1 + " as a, " + table3 + " as b where a.ProjectId=b.ProjectId and (a.SupervisorId1='" + newSupervisor + "' or a.SupervisorId2='" + newSupervisor + "' or a.SupervisorId3='" + newSupervisor + "')");

                        while (rs3.next()) {

                            //%%%%%%%%%%%%%%%%%%%%%Student Name%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                            String supName1 = "";
                            String supName2 = "";
                            String supName3 = "";
                            String name = "";
                            String table = "";
                            String studId = rs3.getString(1);

                            table = rs2.getString(1).replace('-', '_') + "_" + batchYear;

                            String supid1 = rs3.getString(3);
                            String supid2 = rs3.getString(4);               // Iski Vajah se
                            String supid3 = rs3.getString(5);

                            if (supid1.equalsIgnoreCase("" + newSupervisor + "")) {
                                supName1 = scis.facultyName(supid1);
                                if (supName1 != null) {
                                    supName1 = supName1;
                                } else {

                                    supName1 = supid1;
                                }
                                supName2 = scis.facultyName(supid2);
                                if (supName2 != null) {
                                    supName2 = supName2;
                                } else {
                                    supName2 = supid2;
                                }
                                supName3 = scis.facultyName(supid3);
                                if (supName3 != null) {

                                } else {
                                    supName3 = supid3;
                                }
                            } else if (supid2.equalsIgnoreCase("" + newSupervisor + "")) {
                                supName1 = scis.facultyName(supid2);
                                if (supName1 != null) {

                                } else {
                                    supName1 = supid1;
                                }
                                supName2 = scis.facultyName(supid1);
                                if (supName2 != null) {

                                } else {
                                    supName2 = supid1;
                                }
                                supName3 = scis.facultyName(supid3);
                                if (supName3 != null) {

                                } else {
                                    supName3 = supid3;
                                }

                            } else {
                                supName1 = scis.facultyName(supid3);
                                if (supName1 != null) {

                                } else {
                                    supName1 = supid3;
                                }
                                supName2 = scis.facultyName(supid1);
                                if (supName2 != null) {

                                } else {
                                    supName2 = supid1;
                                }
                                supName3 = scis.facultyName(supid2);
                                if (supName3 != null) {

                                } else {
                                    supName3 = supid2;
                                }
                            }

                            name = scis.studentName(studId);


                %>
                <tr >
                    <td><%=name%></td>     
                    <td><%=rs3.getString(1)%></td>
                    <td><%=rs3.getString(2)%> </td>
                    <td><%=supName1%> </td>
                    <td><%=supName2%> </td>
                    <td><%=supName3%> </td>

                </tr>

                <%}
                    }

                %>            
            </table>
        </form>             

        <%      rs2.close();
            } catch (Exception ex) {

                    ex.printStackTrace();
                }
            } // End of Else if

            st1.close() ; 
            st2.close() ;
            st3.close() ;
            st4.close() ;
            st5.close() ;
            st6.close() ;
            st7.close() ;
            st8.close() ;
            st9.close() ;
            st10.close() ;
            rs3.close();
            rs4.close();
            rs6.close();
            rs7.close();
            rs8.close();
           conn.closeConnection();
            con = null;
           
            
        %>  
    </body>
</html>