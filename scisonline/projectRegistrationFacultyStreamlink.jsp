<%-- 
    Document   : projectRegistrationFacultyMCA1
--%>

<%@include file="programmeRetrieveBeans.jsp"%>
<%@page import="java.sql.*"%>
<%@include file="connectionBean.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>                                                                                                            

    </head>
    <body bgcolor="E0FFFF">
        <%           
            Connection con = conn.getConnectionObj();
            try {
                String user = (String) session.getAttribute("user"); //supervisor1
                String[] projectTitle = request.getParameterValues("prname"); //project titel
                String[] supervisorTwo = request.getParameterValues("sup2");   //supervisor2
                String[] supervisorThree = request.getParameterValues("sup3");  //supervisor3
                String stream = (String) session.getAttribute("ProjectRegStream"); //streamName
                String pyear = (String) session.getAttribute("StreamBatch"); //year of join
                
                //get all this parameter from projectRegistrationFacultyStream.jsp page
                Statement st1 = con.createStatement();
                Statement st3 = con.createStatement();
                Statement st7 = con.createStatement();
                ResultSet rs1 = null;
                
                String tableName = stream + "_Project_" + pyear; //project table Name
                st1.executeUpdate("create table if not exists " + tableName + "(ProjectId int(5) NOT NULL AUTO_INCREMENT,ProjectTitle varchar(200),SupervisorId1 varchar(20),SupervisorId2 varchar(200),SupervisorId3 varchar(200),Organization varchar(200),Allocated varchar(10),primary key(ProjectId))");
                
                int count = projectTitle.length;
           
                for (int i = 0; i < count; i++) {
                    if (projectTitle[i] == "" || user.equalsIgnoreCase("null")) {//here serverside validation for supervisor2 and 3 is not done because these are choice of faculty.
                        continue;
                    }
                    if (supervisorTwo[i] == supervisorThree[i]) {
        %>
                        <script type="text/javascript">
                            alert(" Supervisor2&3 cannot have same names.");
                        </script>
        <%          } else {
                        rs1 = (ResultSet) st3.executeQuery("select ProjectTitle from " + tableName + " where ProjectTitle='" + projectTitle[i] + "'");
                        if (rs1.next()) {
                            out.println(projectTitle[i] + ": <h4> Project already exists in Database.</h4>");
                            return;
                        } else {
                            if(!projectTitle[i].equals("")) {
                                st1.executeUpdate("insert ignore into  " + tableName + "(ProjectTitle,SupervisorId1,SupervisorId2,SupervisorId3,Organization,Allocated) values('" + projectTitle[i] + "', '" + user + "', '" + supervisorTwo[i] + "', '" + supervisorThree[i] + "', 'uoh','no')");
                            }
                        }
                    }
                }
                
                rs1=scis.getProgramme(stream, 1);//get all programme of stream
                while (rs1.next()) {
                    String prg = rs1.getString(1).replace('-', '_');
                    String code = prg + "_" + "Project_Student_" + pyear;
                    
                    st1.executeUpdate("create table if not exists " + code + "(StudentId varchar(10)NOT NULL,ProjectId int(5),PanelMarks1 varchar(6),AdvisorMarks1 varchar(6),AverageMarks1 varchar(6),PanelMarks2 varchar(6),AdvisorMarks2 varchar(6),AverageMarks2 varchar(6),TotalMarks varchar(6),Grade varchar(10),Status enum('Allocated','Mid','report','Viva','DegreeAwarded','extend'),primary key(StudentId))");
                    ResultSet rsst = st7.executeQuery("select StudentId from " + prg + "_" + pyear + "");
                    while (rsst.next()) {
                        st1.executeUpdate("insert ignore into " + code + " values('" + rsst.getString(1) + "',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)");
                    }
                    rsst.close();                    
                }
                
                out.println("<h3>***Project Registrations Successfully Completed***</h3>");
                st1.close();
                st3.close();
                st7.close();
                rs1.close();                
            } catch (Exception ex) {
                System.out.println(ex);
            }
            conn.closeConnection();
            con = null;
        %>
    </body>
</html>
