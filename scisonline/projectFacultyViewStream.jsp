<%-- 
    Document   : projectFacultyViewStream
--%>
<%@include file="programmeRetrieveBeans.jsp"%>
<%@page import="java.sql.*"%>
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
    <body bgcolor="#CCFFFF">


        <form  id="form">


            <% 
                Connection con = conn.getConnectionObj();
                String user = (String) session.getAttribute("user");    //user name
                String stream = (String) request.getParameter("pgname"); //stream name
                String pyear = request.getParameter("year");

                Statement st1 = con.createStatement();
                Statement st5 = con.createStatement();
                

                ResultSet rs = null;
                ResultSet rs11 = null;
                ResultSet rs33 = null;
                String studentName = "";

                try {
            %>

            <table align="center" border="1" >
                <caption><h2> List of Projects</h2></caption>
                <th>Project Title </th> 
                <th>Supervisor 2</th>
                <th>Supervisor 3</th>
                <th>Student ID </th>
                <th>Student Name </th>

                <%
                    //cheking every project-studnet-master table to retrive allocate project details
                    String programmeName = "";
                    rs33 = scis.getProgramme(stream, 1);//get all Programme according to stream and status
                    stream = stream.replace('-', '_');
                    while (rs33.next()) {

                        programmeName = rs33.getString(1);
                        programmeName = programmeName.replace('-', '_');
                        
                        // Creation of table to avoid raising of exception in case a project student data table is searched and no student is found in it.
                        rs = (ResultSet) st1.executeQuery("(select StudentId,ProjectTitle,SupervisorId1,SupervisorId2,SupervisorId3 from " + stream + "_Project_" + pyear + " as a, " + programmeName + "_Project_Student_" + pyear + " as b where a.ProjectId=b.ProjectId and (a.SupervisorId1='" + user + "' or a.SupervisorId2='" + user + "' or a.SupervisorId3='" + user + "')) ");
                        while (rs.next()) {
                            //--------------Modified-----------------
                            String supervisor1 = "", supervisor2 = "";
                            int fid1 = 0, fid2 = 0, fid3 = 0;
                            System.out.println(rs.getString(3));
                            if (user.equals(rs.getString(3))) {
                                fid1 = 1;
                                supervisor1 = rs.getString(4);
                                supervisor2 = rs.getString(5);
                            } else if (user.equals(rs.getString(4))) {
                                fid2 = 1;
                                supervisor1 = rs.getString(3);
                                supervisor2 = rs.getString(5);
                            } else if (user.equals(rs.getString(5))) {
                                fid3 = 1;
                                supervisor1 = rs.getString(3);
                                supervisor2 = rs.getString(4);
                            }

                            supervisor1 = scis.facultyName(supervisor1);
                            supervisor2 = scis.facultyName(supervisor2);
                            String studId = rs.getString(1);
                            studentName = scis.studentName(studId);


                %>
                <tr>
                    <td><%=rs.getString(2)%></td>
                    <%if (supervisor1 == null || supervisor1.equalsIgnoreCase("none") | supervisor1.equalsIgnoreCase("null")) {%>
                    <td>none</td> 
                    <%} else {%>
                    <td><%=supervisor1%></td>
                    <%}
                    %>

                    <%if (supervisor2 == null || supervisor2.equalsIgnoreCase("none") | supervisor2.equalsIgnoreCase("null")) {%>
                    <td>none</td> 
                    <%} else {%>
                    <td><%=supervisor2%></td>
                    <%}
                    %>
                    <td><%=rs.getString(1)%></td>
                    <td><%=studentName%></td> 


                </tr>
                <%

                        }

                    }

                    //retrieving project details from respective stream-project-master table.
                    rs11 = (ResultSet) st5.executeQuery("(select * from " + stream + "_Project_" + pyear + " as a where (a.SupervisorId1='" + user + "' or a.SupervisorId2='" + user + "' or a.SupervisorId3='" + user + "') and a.Allocated='no') ");

                    while (rs11.next()) {
                        String supervisor1 = "", supervisor2 = "";
                        int fid1 = 0, fid2 = 0, fid3 = 0;

                        if (user.equals(rs11.getString(3))) {
                            fid1 = 1;
                            supervisor1 = rs11.getString(4);
                            supervisor2 = rs11.getString(5);
                        } else if (user.equals(rs11.getString(4))) {
                            fid2 = 1;
                            supervisor1 = rs11.getString(3);
                            supervisor2 = rs11.getString(5);
                        } else if (user.equals(rs11.getString(5))) {
                            fid3 = 1;
                            supervisor1 = rs11.getString(3);
                            supervisor2 = rs11.getString(4);
                        }

                        supervisor1 = scis.facultyName(supervisor1);
                        supervisor2 = scis.facultyName(supervisor2);

                %>
                <tr style="background-color:#F3F781">
                    <td style=" background-color: #F3F781"><%=rs11.getString(2)%></td>
                    <%if (supervisor1 == null || supervisor1.equalsIgnoreCase("none") || supervisor1.equalsIgnoreCase("null")) {%>
                    <td style=" background-color: #F3F781">none</td> 
                    <%} else {%>
                    <td style=" background-color: #F3F781"><%=supervisor1%></td>
                    <%}
                    %>

                    <%if (supervisor2 == null || supervisor2.equalsIgnoreCase("none") | supervisor2.equalsIgnoreCase("null")) {%>
                    <td style=" background-color: #F3F781">none</td> 
                    <%} else {%>
                    <td style=" background-color: #F3F781"><%=supervisor2%></td>
                    <%}
                    %> 
                    <td style=" background-color: #F3F781"></td>
                    <td style=" background-color: #F3F781"></td>
                </tr>
                <%
                    }


                %> 
            </table>&nbsp;

            <%
                st1.close();
                st5.close();
                rs.close();
                rs11.close();
                rs33.close();
                }
                catch (Exception ex) {
                    ex.printStackTrace();
                }
                con = null;
                conn.closeConnection();
                scis.close();
            %>
            <!-- Welcome <%=user%> -->

        </form>

    </body>
</html>


