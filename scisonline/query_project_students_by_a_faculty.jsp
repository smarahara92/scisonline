<%-- 
    Document   : query_project_students_by_a_faculty
    Created on : 30 Apr, 2015, 2:28:09 AM
    Author     : root
--%>

<%@page import = "java.sql.ResultSet"%>
<%@page import = "java.util.Hashtable"%>
<%@page import = "java.util.ArrayList"%>
<%@include file="programmeRetrieveBeans.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="./css/query_display_style.css">
    </head> <%
    String facId = request.getParameter("fac_id");
    String facName = scis.facultyName(facId);
    String programmeGroup = request.getParameter("stream");
    String year1str = request.getParameter("year1");
    String year2str = request.getParameter("year2");
    int year1 = Integer.parseInt(year1str);
    int year2 = Integer.parseInt(year2str);
    String title = "List of "+"<span style=\"color:blue;\">"+programmeGroup+"</span>"+" project students guided by "+"<span style=\"color:blue;\">"+facName+"</span>";
    String msg_emp = "No "+"<span style=\"color:blue;\">"+programmeGroup+"</span>"+" projects are guided by "+"<span style=\"color:blue;\">"+facName+"</span>";
    
    Hashtable student = new Hashtable();
    Hashtable project = new Hashtable();
        
    int len = 1, flag = 0;
    ResultSet rs2 = null;
    if(programmeGroup.equalsIgnoreCase("all")) {
        flag = 1;
        rs2 = scis.getStream("PhD");
        len = 3;
    } else {
        len = 1;
    }
    int i = 0;
    for(int j = 1; j <= len; ++j) {
        if(flag == 1) {
            if (rs2 != null && rs2.next()) {
                programmeGroup = rs2.getString(1).trim().replace('-', '_');
            } else {
                break;
            }
        }
        for(int year = year1; year <= year2; ++year) {
/*            ResultSet rs00 = scis.getProgramme(programmeGroup, 1);
            ArrayList<Integer> years = new ArrayList<Integer>();
            while(rs00 != null && rs00.next()) {
                String prg = rs00.getString(1).replace('-', '_');
                int y = year;
                int semNo = 1;
                while(true) {
                    int curriculumYear = scis.latestCurriculumYear(prg, y);
                    String q01 = "select count(*) from "+prg+"_"+curriculumYear+"_currrefer";
                    ResultSet rs01 = scis.executeQuery(q01);
                    int yearCount = 0;
                    if(rs01 != null && rs01.next()) {
                        yearCount = rs01.getInt(1) + 1;
                        yearCount = yearCount / 2;
                    }
                    if((y + yearCount) < year) {
                        System.out.println(y);
                        break;
                    }
                    String q02 = "select Semester from "+prg+"_"+curriculumYear+"_currrefer where Projects = 1";
                    ResultSet rs02 = scis.executeQuery(q02);
                    while(rs02 != null && rs02.next()) {
                        String pSem = rs02.getString(1);
                        int pSemNo = scis.romant2num(pSem);
                        if(pSemNo == semNo) {
                            years.add(y);
                            semNo = semNo + 2;
                            break;
                        }
                        ++semNo;
                        if(pSemNo == semNo) {
                            years.add(y);
                            ++semNo;
                            break;
                        }
                    }
                    --y;
                    //++semNo;
                }
            }
            for(int pyear : years) {//*/
            int pyear = year;//*/
                String query = "SELECT * FROM "+programmeGroup+"_Project_"+pyear+" WHERE SupervisorId1 = '"+facId+"' or SupervisorId2 = '"+facId+"' or SupervisorId3 = '"+facId+"'";

                ResultSet rs = null;

                rs = scis.executeQuery(query);
                if(rs == null) {
                    continue;
                }
                while(rs.next()) {
                    ResultSet rs0 = scis.getProgramme(programmeGroup, 1);
                    while(rs0.next()) {
                        String prg = rs0.getString(1).replace('-', '_');
                        int projectID = rs.getInt(1);
                        query = "SELECT StudentId FROM "+prg+"_Project_Student_"+pyear+" where ProjectId = "+projectID;
                        ResultSet rs1 = scis.executeQuery(query);
                        if(rs1 == null) {
                            continue;
                        }
                        while (rs1.next()) {
                            String sid = rs1.getString(1);
                            if(!student.containsValue(sid)) {
                                student.put(i, sid);
                                project.put(i, scis.getProjecttitle(programmeGroup, pyear, projectID));
                                ++i;
                            }
                        }
                    }
                }
//            }//*/
        }
    } %>
    <body> <%
    if(i > 0) { %>
        <h3 style="color:#c2000d" align="center"><%=title%></h3>
        <table align="center" border="1" class = "maintable">
            <col width="5%">
            <col width="15%">
            <col width="30%">
            <col width="50%">
            <tr>
                <th class="heading" align="center">S.no</th>
                <th class="heading" align="center">Student ID</th>
                <th class="heading" align="center">Student Name</th>
                <th class="heading" align="center">Project Title</th>
            </tr> <%
            for(int slno = 0; slno < i; ++slno) { %>
                <tr>
                    <th class="style30" ><%=slno+1%></th> <%
                    String studentID = (String) student.get(slno); %>                    
                    <td class = "cellpad"><%=studentID%></td>
                    <td class = "cellpad"><%=scis.studentName(studentID)%></td> <%
                    String projectTitle = (String) project.get(slno); %>                  
                    <td class = "cellpad"><%=projectTitle%></td>
                </tr> <%
            } %>
        </table>&nbsp; <%
    } else { %>
        <h3 style="color:#c2000d" align="center"><%=msg_emp%></h3> <%
    }
    scis.close(); %>
    </body>
</html>
