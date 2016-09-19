<%-- 
    Document   : project_internshipstudentlist
    Created on : 27 Feb, 2015, 10:26:01 AM
    Author     : deep
--%>
<%@include file="checkValidity.jsp"%>
<%@page import="java.sql.*"%>
<%@include file="connectionBean.jsp"%>
<%@include file="programmeRetrieveBeans.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
       <link rel="stylesheet" type="text/css" href="./css/query_display_style.css">
    </head>
    <body>
         <%
                String programmeName1 = request.getParameter("pgname");
                programmeName1 = programmeName1.replace('-', '_');
                String pgname = programmeName1;
                String pyear = request.getParameter("year");
                
                ResultSet rs = null;
                ResultSet rs1 = null;       
                rs1 = scis.getProgramme(programmeName1, 1);
                Connection con = conn.getConnectionObj();
                Statement st = con.createStatement();
                String title = "List of students from "+"<span style=\"color:blue;\">"+programmeName1 + " " + pyear +"</span>"+" who are doing internship";
                String msg = "No student is doing internship in "+"<span style=\"color:blue;\">"+programmeName1 + " " + pyear +"</span>";
        
        %>
      
            <!--h3 style="color:#c2000d" align="center">List of students who are doing internship</h3-->
            <table align="center" border="1" class = "maintable">
            <%
                int i = 1;
                int flag = 0;
                while(rs1.next()){
                    String programmeName = (rs1.getString(1)).replace("-", "_");
                    String table = programmeName + "_Project_Student_" + pyear; 
                    String table1 = pgname + "_Project_"+pyear;
                    String name;
                    try {
                        rs = (ResultSet)st.executeQuery("select StudentID, b.SupervisorId1, b.SupervisorId2, b.Organization from " + table +" as a, "+ table1 + " as b" + " where a.ProjectId = b.ProjectId and b.Organization<>'uoh'");
                        if(flag == 0 && rs.next()){
            %>          <h3 style="color:#c2000d" align="center"><%=title%></h3>
                        <th class="heading" align="center">S.No.</th>
                        <th class="heading" align="center">Student ID</th> 
                        <th class="heading" align="center">Student Name</th> 
                        <th class="heading" align="center">Internal Supervisor Name</th>
                        <th class="heading" align="center">External Supervisor Name</th>
                        <th class="heading" align="center">Organization Name</th>
                        <% flag = 1;
                           rs.beforeFirst();
                        }
                           while(rs.next()){
                           name = scis.studentName(rs.getString(1));%>
                           <tr>
                            <th class="style30" ><%=i%></th>
                            <td class = "cellpad"><%=rs.getString(1)%></td>
                            <td class = "cellpad"><%=name%></td>
                            <td class = "cellpad"><%if(rs.getString(3) != null){
                                String fName = scis.facultyName(rs.getString(3));
                                if(fName != null){
                               %>
                                    <%=fName%>
                           <%   }
                            }
                           %>
                            </td>
                            <td class = "cellpad"><%=rs.getString(2)%></td>
                            <td class = "cellpad"><%=rs.getString(4)%></td>
                        </tr>
                        <%  i++;
                    } %>
                   
                    <%}
                    catch(Exception e){
                        System.out.println(e);
                        
                        }%>
                                
                    
               <% }
                    if(flag == 0){%>
                            <h3><center>Data is not found.</center><h3>
                    <%  }
                    //rs.close();
                    rs1.close();
                    st.close();
                    scis.close();
                    conn.closeConnection();
                    con = null;
                %>
           </table>
    </body>
</html>
