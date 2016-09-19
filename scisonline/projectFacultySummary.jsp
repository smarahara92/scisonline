<%-- 
    Document   : projectFacultySummary
    Created on : 3 May, 2013, 8:56:51 AM
    Author     : varun
--%>

<%@include file="checkValidity.jsp"%>
<%@include file="connectionBean.jsp"%>
<%@include file="programmeRetrieveBeans.jsp"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" type="text/css" href="table_css.css">
        <script type="text/javascript">

            function AllocatedCheck()
            {
                alert("Some Students are not allocated Projects.");

            }

        </script>	
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body bgcolor="EOFFFF">
        <form  id="form" method="POST" onsubmit="" action="" >


            <%  Connection con = conn.getConnectionObj();

                int totalStud = 0;
                int projectStud = 0;
                String user = (String) session.getAttribute("user");
                System.out.println(user);
                Statement st1 = con.createStatement();
                Statement st2 = con.createStatement();
                Statement st3 = con.createStatement();
                Statement st4 = con.createStatement();
                Statement st5 = con.createStatement();
                Statement st6 = con.createStatement();
                Statement st7 = con.createStatement();
                Statement st8 = con.createStatement();
                Statement st9 = con.createStatement();
                Statement st99 = con.createStatement();

                String projectTable1 = null;
                String projectStudnetTable = null;

          //     ResultSet rs = null;
                ResultSet rs2 = null;
                ResultSet rss1 = null;
                ResultSet rsss1 = null;
                ResultSet rss2 = null;
                ResultSet rss3 = null;
                ResultSet rss4 = null;
                ResultSet rs11 = null;

                int curriculumYear = 0;
                int latestYear = 0;
                int streamYear = 0;%>


            <br>
            <table align="center" border="1">
                <caption><h2>Projects Summary</h2></caption>
                <tr>
                    <th>Student ID </th>
                    <th>Student Name </th>
                    <th>Project Title </th>
                    <th>Mid Term </th>
                    <th>Final </th>
                    <th>Total </th>
                    <th>Grade </th>

                </tr>     
                <%
                    //rs = scis.getStream("PhD");
                    //while (rs.next()) {
                        String prg = request.getParameter("pgname");
                        String pyear = request.getParameter("year");
                        

                        projectTable1 = prg.replace('-', '_') + "_Project_" + pyear;
                        System.out.println("Hello Deep" + projectTable1);
                        try {
                            rss1 = (ResultSet) st2.executeQuery("select * from " + projectTable1 + " where(SupervisorId1='" + user + "' or SupervisorId2='" + user + "' or SupervisorId3='" + user + "') and Allocated='yes' ");
                        } catch (Exception ex) {
                %>
                <center><h2>The Projects are not yet allocated.</h2></center>
                    <%
                            System.out.println(ex);
                           // ex.printStackTrace();
                            return;
                        }
                        rss2 = scis.getProgramme(prg.replace('-', '_'), 1);
                        while (rss1.next()) {
                            while (rss2.next()) {
                                projectStudnetTable = rss2.getString(1).replace('-', '_') + "_Project_Student_" + pyear;

                                rss3 = (ResultSet) st4.executeQuery("select * from " + projectStudnetTable + " where ProjectId='" + rss1.getString(1) + "'");
                                while (rss3.next()) {

                                    String studId = rss3.getString(1);
                                    String studentName = scis.studentName(studId);
                                    rsss1 = (ResultSet) st99.executeQuery("select * from " + projectStudnetTable + " where(PanelMarks1 IS NOT NULL and AdvisorMarks1 IS NOT NULL and PanelMarks2 IS NOT NULL and AdvisorMarks2 IS NOT NULL and  StudentId='" + studId + "')");

                                    // For Not Displaying assessment when Complete projects are not allcoated to students.
                                    // ----------- END  ------------
                                    try {

                                      
                                        String projectTitle = "";

                                        String projectMasterTable = prg.replace('-', '_') + "_Project_" + pyear;

                                        ResultSet rs3 = (ResultSet) st9.executeQuery("select ProjectTitle from " + projectMasterTable + " where ProjectId=" + rss1.getInt(1) + "");
                                        while (rs3.next()) {

                                            projectTitle = rs3.getString(1);
                                        }

                                        if (rss3.getString(3) == null || rss3.getString(6) == null) // Staff hasn't entered either Panel or External Marks for a Student.
                                        {

                    %>

                <tr >
                    <td><%=rss3.getString(1)%></td>
                    <td><%=studentName%></td> 
                    <td><%=projectTitle%></td> 
                    <%if (rss3.getString(5) != null) {%>
                    <td style="background-color:yellow"><%=rss3.getString(5)%></td> 
                    <%} else {%>  
                    <td></td> 
                    <% }
                    %>

                    <%if (rss3.getString(8) != null) {%>
                    <td><%=rss3.getString(8)%></td> 
                    <%} else {%>  
                    <td></td> 
                    <% }
                    %>

                    <%if (rss3.getString(9) != null) {%>
                    <td><%=rss3.getString(9)%></td> 
                    <%} else {%>  
                    <td></td> 
                    <% }
                    %>

                    <%
                        if (rsss1.next()) {
                            if (rsss1.getString(10) != null) {%>
                    <td><%=rsss1.getString(10)%></td> 
                    <%} else {%>  
                    <td></td> 
                    <% }
                    } else {
                    %>
                    <td></td>
                    <%
                        }
                    %>




                </tr>



                <%
                } // if close- Staff Checked
                else if (rss3.getString(4) == null || rss3.getString(7) == null) // Faculty hasn't entered either Advisor Marks1 or Advisor Marks2
                {%>
                <tr>
                    <td><%=prg%></td>
                    <td><%=studentName%></td> 
                    <td><%=projectTitle%></td> 

                    <%if (rss3.getString(5) != null) {%>
                    <td  style="background-color:red"><%=rss3.getString(5)%></td>                     <%} else {%>  
                    <td></td>                        <% }
                    %>

                    <%if (rss3.getString(8) != null) {%>
                    <td><%=rss3.getString(8)%></td> 
                    <%} else {%>  
                    <td></td>  
                    <% }
                    %>

                    <%if (rss3.getString(9) != null) {%>
                    <td><%=rss3.getString(9)%></td> 
                    <%} else {%>  
                    <td></td> 
                    <% }
                    %>

                    <%
                        if (rsss1.next()) {
                            if (rsss1.getString(10) != null) {%>
                    <td><%=rsss1.getString(10)%></td> 
                    <%} else {%>  
                    <td></td> 
                    <% }
                    } else {
                    %>
                    <td></td>
                    <%
                        }
                    %>
                </tr>


                <%} // if close- Faculty Checked  
                else if (rss3.getString(4) != null && rss3.getString(5) != null && rss3.getString(7) != null && rss3.getString(8) != null) // Every Marks Have been entered.
                {%>
                <tr>
                    <td><%=rss3.getString(1)%></td>
                    <td><%=studentName%></td> 
                    <td><%=projectTitle%></td> 

                    <%if (rss3.getString(5) != null) {%>
                    <td><%=rss3.getString(5)%></td>                      <%} else {%>  
                    <td></td>                         <% }
                    %>

                    <%if (rss3.getString(8) != null) {%>
                    <td><%=rss3.getString(8)%></td> 
                    <%} else {%>  
                    <td></td> 
                    <% }
                    %>

                    <%if (rss3.getString(9) != null) {%>
                    <td><%=rss3.getString(9)%></td> 
                    <%} else {%>  
                    <td></td> 
                    <% }
                    %>

                    <%
                        if (rsss1.next()) {
                            if (rsss1.getString(10) != null) {%>
                    <td><%=rsss1.getString(10)%></td> 
                    <%} else {%>  
                    <td></td> 
                    <% }
                    } else {
                    %>
                    <td></td>
                    <%
                        }
                    %>


                </tr>


                <%}      // if close- No fault from Faculty or Staff Side 

                    // End of While
                    if (projectStud != totalStud) {%>
                <script type="text/javascript" language="javascript">
                    AllocatedCheck();         // testing
                </script>   
                <%                                                       }
                                        rs3.close();
                                    } catch (Exception ex) {
                                        System.out.println(ex);
                                        ex.printStackTrace();
                                    }
                                }
                            }
                            rss2.beforeFirst();
                        }
                        rss1.beforeFirst();
                    // }
                    st1.close();
                    st2.close();
                    st3.close();
                    st4.close();
                    st5.close();
                    st6.close();
                    st7.close();
                    st8.close();
                    st9.close();
                    st99.close();
                    conn.closeConnection();
                    con=null;
                %> 
                <%--rs.close();
                    rs2.close();
                    rss1.close();
                    rsss1.close();
                    rss2.close();
                    rss3.close();
                    rss4.close();
                    rs11.close();--%>

            </table>
            <br><br>


            <div valign="top" align="center"> <h4> <font color="yellow"> Yellow </font> : Panel/External Marks not entered by Staff </h5>  </div> 
            <div> </div> 

            <div valign="top" align="center"> <h4> <font color="red"> Red </font> : Supervisor Marks not entered by Faculty  </h4>  </div> 



        </form>   

    </body>
</html>
