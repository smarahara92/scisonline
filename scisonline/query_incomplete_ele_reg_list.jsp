<%-- 
    Document   : query_imcomplete_ele_reg_list
    Created on : 18 Feb, 2015, 1:06:43 PM
    Author     : nwlab
--%>

<%@page import = "java.sql.ResultSet"%>
<%@page import = "java.util.ArrayList"%>
<%@include file="programmeRetrieveBeans.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="./css/query_display_style.css">
    </head>
    <body><%
        String title = "List of students whose course registration is not complete";
        String msg_exp = "Some internal problem occured.";
        String msg_emp = "Course Registration is completed for all students";
        ArrayList StudentID = new ArrayList();
        ArrayList StudentName = new ArrayList();
        int index = 0;
        String sem = scis.getLatestSemester();
        String query = "select sname from "+sem+"_stream";
        ResultSet rs = scis.executeQuery(query);
        if(rs == null) {
            out.println("<h3 style=\"color:#c2000d\" align=\"center\">"+msg_exp+"</h3>");
            scis.close();
            return;
        }
        while(rs.next()) {
            String progBatch = rs.getString(1); //e.g, MCA-IV
            String semNum = progBatch.substring(progBatch.lastIndexOf('-') + 1);
            String programmeName = progBatch.substring(0, progBatch.lastIndexOf('-'));
            String programmeGroup = scis.getStreamOfProgramme(programmeName);
            int batchYear = scis.getBatch(programmeGroup, semNum);
            if(batchYear == 0) {
                continue;
            }
            int currYear = scis.latestCurriculumYear(programmeName, batchYear);
            if(currYear == 0) {
                continue;
            }
            
            int eleCount = 0;
            int opCoreCount = 0;
            int coreCount = 0;
            int labCount = 0;
            int semNumInt = scis.roman2num(semNum);
            String q1 = "select * from "+programmeName.replace('-', '_')+"_"+currYear+"_currrefer";
            ResultSet rs1 = scis.executeQuery(q1);
            if(rs1 == null) {
                out.println("<h3 style=\"color:#c2000d\" align=\"center\">"+msg_exp+"</h3>");
                scis.close();
                return;
            }
            while(rs1.next()) {
                if(scis.roman2num(rs1.getString("Semester")) <= semNumInt) {
                    eleCount = eleCount + rs1.getInt("Electives");
                    opCoreCount = opCoreCount + rs1.getInt("OptionalCore");
                    coreCount = coreCount + rs1.getInt("Cores");
                    labCount = labCount + rs1.getInt("Labs");
                }
            }
            
            String q2 = "select * from "+programmeName.replace('-', '_')+"_"+batchYear;
            ResultSet rs2 = scis.executeQuery(q2);
            if(rs2 == null) {
                out.println("<h3 style=\"color:#c2000d\" align=\"center\">"+msg_exp+"</h3>");
                scis.close();
                return;
            }
            int flag = 0, j = 1;
            while(rs2.next()) {
                flag = 0;
                //For core subjects
                for(int i = 1; i <= coreCount; ++i) {
                    if(rs2.getString("c"+i+"grade") == null || rs2.getString("c"+i+"grade").equalsIgnoreCase("NR")) {
                        StudentID.add(index, rs2.getString("StudentId"));
                        StudentName.add(index, rs2.getString("StudentName"));
                        ++index;
                        flag = 1;
                        break;
                    }
                }
                if(flag == 1) {
                    continue;
                }
                //For lab subjects
                for(int i = 1; i <= labCount; ++i) {
                    if(rs2.getString("l"+i+"grade") == null || rs2.getString("l"+i+"grade").equalsIgnoreCase("NR")) {
                        StudentID.add(index, rs2.getString("StudentId"));
                        StudentName.add(index, rs2.getString("StudentName"));
                        ++index;
                        flag = 1;
                        break;
                    }
                }
                if(flag == 1) {
                    continue;
                }
                //For elective subjects
                for(int i = 1; i <= eleCount; ++i) {
                    if(rs2.getString("e"+i+"grade") == null || rs2.getString("e"+i+"grade").equalsIgnoreCase("NR")) {
                        StudentID.add(index, rs2.getString("StudentId"));
                        StudentName.add(index, rs2.getString("StudentName"));
                        ++index;
                        flag = 1;
                        break;
                    }
                }
                if(flag == 1) {
                    continue;
                }
                //For optional core subjects
                for(int i = 1; i <= opCoreCount; ++i) {
                    if(rs2.getString("o"+i+"grade") == null || rs2.getString("o"+i+"grade").equalsIgnoreCase("NR")) {
                        StudentID.add(index, rs2.getString("StudentId"));
                        StudentName.add(index, rs2.getString("StudentName"));
                        ++index;
                        break;
                    }
                }
            }
        }
        if(index == 0) {
            out.println("<h3 style=\"color:#c2000d\" align=\"center\">"+msg_emp+"</h3>");
            scis.close();
            return;
        }
        %>
        <h3 style="color:#c2000d" align="center"><%=title%></h3>
        <table align="center" border="1" class = "maintable">
            <col width="10%">
            <col width="20%">
            <col width="80%">
            <tr>
                <th class="heading" align="center">S.no</th>
                <th class="heading" align="center">Student ID</th>
                <th class="heading" align="center">Student Name</th>
            </tr><%
            for(int i = 0; i < index; i++) {%>
                <tr>
                    <th class="style30" ><%=i+1%></th>
                    <td class = "cellpad"><%=StudentID.get(i)%></td>
                    <td class = "cellpad"><%=StudentName.get(i)%></td>
                </tr><%
            }
            scis.close();%>
        </table>&nbsp;
    </body>
</html>