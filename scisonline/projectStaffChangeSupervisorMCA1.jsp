<%-- 
    Document   : projectStaffChangeSupervisorMCA1
    Created on : 21 May, 2013, 4:54:47 PM
    Author     : varun
--%>

<%@include file="checkValidity.jsp"%>
<%@page import="java.sql.*"%>
<%@include file="connectionBean.jsp"%>
<%@include file="programmeRetrieveBeans.jsp"%>
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
        <link rel="stylesheet" href="table_css.css" type="text/css">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>

    <body>
        <%
             Connection con = conn.getConnectionObj();
             
            String newSupName = "";
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
            String pyear = request.getParameter("branchYear");
            String studentId = request.getParameter("StudId");
            System.out.println("student id is :" + studentId);
            String cBox = (String) session.getAttribute("Combo");   // To check if it is change sup or new internship.
            String newSupervisor = (String) session.getAttribute("newSupervisor");  // For printing of final Allocated projects list under this supervisor.
            Integer projIdOld = Integer.parseInt((String) session.getAttribute("ProjectIdOld")); // This old project id is actual Project id of student who is changing Supervisor.
            Integer projId = Integer.parseInt(request.getParameter("rb")); // New Project ID (Unallocated Project Id of Project.)
            ResultSet rs1 = (ResultSet) st1.executeQuery("select * from  MCA_Project" + "_" + pyear + " where ProjectId='" + projId + "'");
            // ResultSet rs2=(ResultSet)st2.executeQuery("select * from  MCA_project"+"_"+year+" where SupervisorId1='"+newSupervisor+"'  and Allocated='yes' "); 

            // ResultSet rs3 = (ResultSet)st5.executeQuery("  (select StudentId,ProjectTitle,SupervisorId1,SupervisorId2,SupervisorId3 from Mtech_project_"+year+" as a, MTech_CS_Project_"+year+" as b where a.ProjectId=b.ProjectId and (a.SupervisorId1='"+newSupervisor+"' or a.SupervisorId2='"+newSupervisor+"' or a.SupervisorId3='"+newSupervisor+"')) union all (select StudentId,ProjectTitle,SupervisorId1,SupervisorId2,SupervisorId3 from Mtech_project_"+year+" as a, MTech_IT_Project_"+year+" as c where a.ProjectId=c.ProjectId and (a.SupervisorId1='"+newSupervisor+"' or a.SupervisorId2='"+newSupervisor+"' or a.SupervisorId3='"+newSupervisor+"')) union all (select StudentId,ProjectTitle,SupervisorId1,SupervisorId2,SupervisorId3 from Mtech_project_"+year+" as a, MTech_AI_Project_"+year+" as d where a.ProjectId=d.ProjectId and (a.SupervisorId1='"+newSupervisor+"' or a.SupervisorId2='"+newSupervisor+"' or a.SupervisorId3='"+newSupervisor+"'))              ");
            ResultSet rs5 = (ResultSet) st7.executeQuery("select * from  faculty_data where ID='" + newSupervisor + "'  ");

            while (rs5.next()) {
                newSupName = rs5.getString(2);
            }
            rs5.beforeFirst();        // Because again have to write names for Supervisor 2 and 3.


            // %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%     

            // ################################## Change Supervisor #################################################   

            if ("cs".equals(cBox)) {
                try {

                    st2.executeUpdate("update  MCA_Project_Student_" + pyear + " as a set a.ProjectId='" + projId + "' where a.ProjectId='" + projIdOld + "'" + " and StudentId = '" + studentId + "'");

                    st3.executeUpdate("update MCA_Project" + "_" + pyear + " set Allocated='yes' where ProjectId='" + projId + "'");     // Allocating the new project.
                    st4.executeUpdate("update MCA_Project" + "_" + pyear + " set Allocated='no' where ProjectId='" + projIdOld + "'");   // Unallocating the old project.

        %>
            <table border="1" width="1000" align="center">
                <caption><h2 style=" color: #c2000d;">Allocated Project under Faculty <%=newSupName%> </h2></caption>
                <th>Student ID</th>    
                <th>Student Name</th>
                <th>Project Title</th>
                <th>Supervisor 1</th>
                <th>Supervisor 2</th>
                <th>Supervisor 3</th>

                <%
                    ResultSet rs3 = (ResultSet) st5.executeQuery("  select StudentId,ProjectTitle,SupervisorId1,SupervisorId2,SupervisorId3 from MCA_Project_" + pyear + " as a, MCA_Project_Student_" + pyear + " as b where a.ProjectId=b.ProjectId and (a.SupervisorId1='" + newSupervisor + "' or a.SupervisorId2='" + newSupervisor + "' or a.SupervisorId3='" + newSupervisor + "')    ");

                    while (rs3.next()) {

                        //%%%%%%%%%%%%%%%%%%%%%Student Name%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                        String supName2 = "";
                        String supName3 = "";
                        String name = "";
                        String table = "";
                        String studId = rs3.getString(1);

                        table = "MCA" + "_" + pyear;

                        String supid2 = rs3.getString(4);               // Iski Vajah se
                        String supid3 = rs3.getString(5);
                        ResultSet rs4 = (ResultSet) st6.executeQuery("select StudentName from " + table + " where StudentId='" + studId + "'");
                        ResultSet rs6 = (ResultSet) st8.executeQuery("select * from  faculty_data where ID='" + supid2 + "'  ");
                        ResultSet rs7 = (ResultSet) st9.executeQuery("select * from  faculty_data where ID='" + supid3 + "'  ");

                        while (rs4.next()) {
                            name = rs4.getString(1);     // Student Name
                        }


                        //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


                %>


                <tr >

                    <td><%=rs3.getString(1)%></td>
                    <td><%=name%></td> 
                    <td><%=rs3.getString(2)%> </td>
                    <td><%=newSupName%> </td>
                    <%if (rs3.getString(4) != null) {

                            while (rs6.next()) {
                                supName2 = rs6.getString(2);     // Supervisor Name 2
                            }
                    %>

                    <td><%=supName2%> </td>

                    <% } else {%>

                    <td> </td>

                    <%}%>

                    <%if (rs3.getString(5) != null) {
                            while (rs7.next()) {
                                supName3 = rs7.getString(2);     // Supervisor Name 3
                            }

                    %>

                    <td><%=supName3%> </td>

                    <% } else {%>

                    <td> </td>

                    <%}%>

                </tr>

                <%      rs4.close();
                        rs7.close();
                        rs6.close();
                    }%>            
            </table>
        </form>             

        <%          rs3.close();
                    
                    

                } catch (Exception ex) {
                    ex.printStackTrace();
                }

            }
            st1.close();
            st2.close();
            st3.close();
            st4.close();
            st5.close();
            st6.close();
            st7.close();
            st8.close();
            st9.close();
            st10.close();
            rs1.close();
            
            rs5.close();
            conn.closeConnection();
            con = null;
        %>          

    </body>
</html>
