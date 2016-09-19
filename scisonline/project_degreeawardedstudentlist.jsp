<%-- 
    Document   : project_degreeawardedstudentlist
    Created on : 24 Feb, 2015, 12:35:41 PM
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
                String title = "List of project students from "+"<span style=\"color:blue;\">"+programmeName1 + " " + pyear +"</span>"+" to whom degree is awarded";
                String msg = "No student is awarded degree yet by the school in "+"<span style=\"color:blue;\">"+programmeName1 + " " + pyear +"</span>";
        
        %>
            
            <table align="center" border="1" class = "maintable">
            
            <%
                int i = 1;
                int flag = 0;
                while(rs1.next()){
                    String programmeName = (rs1.getString(1)).replace("-", "_");
                    String table = programmeName + "_Project_Student_" + pyear; 
                    String table1 = pgname + "_project_"+pyear;
                    String name;
                    try{
                        rs = (ResultSet)st.executeQuery("select StudentID, b.ProjectTitle, b.SupervisorId1, b.SupervisorId2, b.SupervisorId3 from " + table +" as a, " +table1+ " as b"+ " where a.ProjectId = b.ProjectId and a.Status = 'DegreeAwarded'");
                        if(flag == 0 && rs.next()){
            %>              <h3 style="color:#c2000d" align="center"><%=title%></h3>
                            <th class="heading" align="center">S.No.</th>
                            <th class="heading" align="center">Student ID</th> 
                            <th class="heading" align="center">Student Name</th> 
                            <th class="heading" align="center">Project Title</th>
                            <th class="heading" align="center">Supervisor(s) Name</th>
            <%              flag = 1;
                            rs.beforeFirst();
                        }
                        while(rs.next()){
                        name = scis.studentName(rs.getString(1));%>
                        <tr>
                            <th class="style30"><%=i%></th>
                            <td class = "cellpad"><%=rs.getString(1)%></td>
                            <td class = "cellpad"><%=name%></td>
                            <td class = "cellpad"><%=rs.getString(2)%></td>
                            <td class = "cellpad">
                               <% if(rs.getString(3) != null){ 
                                    String fName = scis.facultyName(rs.getString(3));
                                    if(fName != null){%>
                                        <%=fName%>
                                <%}
                               }else{ }
                                if(rs.getString(4) != null){
                                    String fName = scis.facultyName(rs.getString(4));
                                    if(fName != null){%>
                                        <%=fName%>
                                <%  }
                                }    
                                    else{%>
                                <%}
                                if(rs.getString(5) != null){
                                    String fName = scis.facultyName(rs.getString(5));
                                    if(fName != null){%>
                                        <%=fName%>
                                <%  }
                                }   else{%>
                                <%}
                                %>
                                
                            </td>
                        </tr>
                        <%  i++;
                        } 
                    }
                    catch(Exception e) {
                        System.out.println(e);
                            //out.println("<h1><center>Data is not found.</center><h1> ");
                    }
                    
                }
                if(flag == 0) { %>
                    <h3 style="color:#c2000d" align="center"><%=msg%></h3>
                <%            
                }
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
