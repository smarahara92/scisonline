<%-- 
    Document   : studentsummary
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSetMetaData"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Hashtable"%>
<%@include file ="connectionBean.jsp" %>
<%@include file="programmeRetrieveBeans.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="table_css.css"> </head>
    </head>
    <body>
<%      
        String role = (String) session.getAttribute("role");
        String studentId = "";
        if (role.equalsIgnoreCase("student") == true) {
            studentId = (String) session.getAttribute("user"); // mc12mi28
            studentId = scis.getStudentId(studentId);
        } else {
            studentId = request.getParameter("studentId");
        }
        
        String programmeName = scis.studentProgramme(studentId).replace('_', '-');
        int batchYear = scis.studentBatchYear(studentId);
        String studentName = scis.studentName(studentId);
        int curriculumYear = scis.latestCurriculumYear(programmeName, batchYear);
        ArrayList<String> sub = new ArrayList();
        Hashtable<String, String> htAlias = new Hashtable();
        Hashtable<String, String> htInternal = new Hashtable();
        Hashtable<String, String> htMajor = new Hashtable();
        Hashtable<String, Double> htSuppImpv = new Hashtable();
        Hashtable htGrade = new Hashtable();
        String projectCode = "";
        
        Connection con1 = conn1.getConnectionObj();
        Statement st = con1.createStatement();
        try {
            String table = programmeName.replace('-', '_') + "_"+batchYear;
            String qry = "select * from " + table + " where StudentId='" + studentId + "'";
            ResultSet rs = scis.executeQuery(qry);
            if(rs == null) {
                return;
            }
            if (rs.next()) {
                ResultSetMetaData rsmd = rs.getMetaData();
                int noOfColumns = rsmd.getColumnCount();
                int temp = (noOfColumns - 2) / 2; //need to mention number of columns in table
                int i = 0, m = 0;
                while (temp > 0) {
                    m = i + 3;
                    String grade = rs.getString(m + 1);
                    if (grade != null && (grade.equals("R") || grade.equals("RR") || grade.equals("A+") || grade.equals("A")
                        || grade.equals("B+") || grade.equals("B") || grade.equals("C") || grade.equals("D") || grade.equals("F"))) {
                        
                        String subCode = rs.getString(m); // subject code
                        sub.add(subCode);
                        String subCodeAlias = subCode; // subject code
                        String q1 = "select Alias, Type from " + programmeName.replace('-', '_') + "_" + curriculumYear + "_curriculum where SubCode='"+subCode+"'";
                        ResultSet rs1 = scis.executeQuery(q1);
                        if(rs1 == null) {
                            out.print("<center><h2>Some internal problem occured.</h2></center>");
                            return;
                        }
                        while (rs1.next()) {
                            if(rs1.getString(2).equalsIgnoreCase("P")) {
                                projectCode = subCode;
                                sub.remove(subCode);
                            } else if (rs1.getString(1) != null) {
                                subCodeAlias = rs1.getString(1);
                            }
                        }
                        htAlias.put(subCode, subCodeAlias);
                        if (grade.equals("R") || grade.equals("RR")) {
                            grade = "";
                        }
                        htGrade.put(subCode, grade);
                    }
                    i = i + 2;
                    --temp;
                }
            }
//            out.println(sub);
        } catch(Exception e) {
            System.out.println();
        }
        String query = "select name sem, substring(start, 1, 4) year from session order by start desc";
        ResultSet rs = scis.executeQuery(query);
        if(rs == null) {
            return;
        }
        Hashtable<String, String> htSub = new Hashtable();
        while(rs.next()){
            htSub.clear();
            int year = rs.getInt(2);
            if(year < batchYear) {
                break;
            }
            String sem = rs.getString(1);
            for(String s : sub) {
                if(htInternal.containsKey(s)) {
                    continue;
                }
                /*Reading assessment table starts*/
                String sAlias = htAlias.get(s);
                String table = sAlias + "_Assessment_"+sem+"_"+year;
                String q = "select InternalMarks, Major from "+table+" where StudentId = '"+studentId+"'";
                try {
                    ResultSet rs2 = st.executeQuery(q);
                    if(rs2.next()) {
                        htSub.put(sAlias, s);
                        String marks = rs2.getString(1);
                        if(marks == null) {
                            htInternal.put(s, "");
                        } else {
                            htInternal.put(s, marks);
                        }
                        marks = rs2.getString(2);
                        if(marks == null) {
                            htMajor.put(s, "");
                        } else {
                            htMajor.put(s, marks);
                        }
                    }
                } catch (Exception e) {
                }
                /*Reading assessment table ends*/
                /*Reading supplymentry table starts 1st approach*/
            /*    table = "supp_"+sem+"_"+year;
                q ="select * from "+table+" where StudentId = '"+studentId+"'";
                
                try {
                    //out.println(q+"<br/>");
                    ResultSet rs3 = scis.executeQuery(q);
                    ResultSetMetaData rsmd = rs3.getMetaData();
                    int noOfColumns = rsmd.getColumnCount();
                    int col = 2;
                    if(rs3.next()) {
                        String sCode = null;
                        do {
                            sCode = rs3.getString(col);
                            if(sAlias.equalsIgnoreCase(sCode)) {
                                htSuppImpv.put(s, rs3.getDouble(col + 1));
                                break;
                            }
                            col = col + 3;
                        } while(sCode != null || col < noOfColumns);
                    }
                } catch (Exception e) {
                }//*/
                /*Reading supplymentry table ends*/
            }
            /*Reading supplymentry table starts 2st approach*/
            String suppTable = "supp_"+sem+"_"+year;
            String qSupp ="select * from "+suppTable+" where StudentId = '"+studentId+"'";

            try {
                //out.println(q+"<br/>");
                ResultSet rs3 = scis.executeQuery(qSupp);
                ResultSetMetaData rsmd = rs3.getMetaData();
                int noOfColumns = rsmd.getColumnCount();
                int col = 2;
                if(rs3.next()) {
                    String sCode = null;
                    do {
                        sCode = rs3.getString(col);
                        if(htSub.containsKey(sCode)) {
                            htSuppImpv.put(htSub.get(sCode), rs3.getDouble(col + 1));
                            break;
                        }
                        col = col + 3;
                    } while(sCode != null || col < noOfColumns);
                }
            } catch (Exception e) {
            }//*/
            /*Reading supplymentry table ends*/
            /*Reading improvement table starts*/
            String table = "imp_"+sem+"_"+year;
            String q ="select * from "+table+" where StudentId = '"+studentId+"'";
            try {
                ResultSet rs3 = scis.executeQuery(q);
                ResultSetMetaData rsmd = rs3.getMetaData();
                int noOfColumns = rsmd.getColumnCount();
                int col = 2;
                if(rs3.next()) {
                    for(String s : sub) {
                        String sAlias = htAlias.get(s);
                        String sCode = null;
                        while(sCode != null || col < noOfColumns) {
                            sCode = rs3.getString(col);
                            if(sAlias.equalsIgnoreCase(sCode)) {
                                htSuppImpv.put(s, rs3.getDouble(col + 1));
                            }
                            col = col + 3;
                        }
                    }
                }
            } catch (Exception e) {
            }//*/
            /*Reading improvement table starts*/
        }
        if(projectCode != "") {
            sub.add(projectCode);
            String q4 = "select AverageMarks1, AverageMarks2 from "+programmeName.replace('-', '_')+"_Project_Student_"+batchYear+" where StudentId='"+studentId+"'";
            ResultSet rs4 = scis.executeQuery(q4);
            if(rs4 != null && rs4.next()) {
                if(rs4.getString(1) != null) {
                    htInternal.put(projectCode, rs4.getString(1));
                }
                if(rs4.getString(2) != null) {
                    htMajor.put(projectCode, rs4.getString(2));
                }
            }
        }
%>
        <center>University of Hyderabad</center>
        <center>School of Computer and Information Sciences</center>
        <center>Assessment of the Student:<%=studentId%></center>
        <center><%=studentName%> &nbsp;&nbsp;<b>Stream:</b><%=programmeName%>&nbsp; &nbsp;<b>Batch:</b><%=batchYear%></center>

        <br>
        <table border="1" align="center">
            <col width="10%">
            <col width="40%">
            <col width="10%">
            <col width="12%">
            <col width="12%">
            <col width="8%">
            <col width="8%">
            <tr>
                <th>Subject ID</th>
                <th>Subject Name</th>
                <th>Internal Marks</th>
                <th>Major</th>
                <th>supplementary<br/>/ Improvement</th>
                <th>Total</th>
                <th>Grade</th>
            </tr><%
            for(String s : sub) {%>
                <tr>
                    <td><%=s%></td>
                    <td><%=scis.subjectName(htAlias.get(s))%></td><%
                    if(htInternal.get(s) == null) {
                        out.println("<td></td>");
                    } else {
                        out.println("<td>"+htInternal.get(s)+"</td>");
                    }
                    if(htMajor.get(s) == null) {
                        out.println("<td></td>");
                    } else {
                        out.println("<td>"+htMajor.get(s)+"</td>");
                    }
                    if(htSuppImpv.get(s) == null) {
                        out.println("<td></td>");
                    } else {
                        out.println("<td>"+htSuppImpv.get(s)+"</td>");
                    }
                    Double t = 0.0;
                    if(htInternal.get(s) != null && htInternal.get(s) != "") {
                        t = t + Double.parseDouble(htInternal.get(s));
                    }
                    if((htMajor.get(s) != null && htMajor.get(s) != "") && htSuppImpv.get(s) != null) {
                        t = t + Math.max(Double.parseDouble(htMajor.get(s)), htSuppImpv.get(s));
                    } else if((htMajor.get(s) != null && htMajor.get(s) != "")) {
                        System.out.println(htMajor.get(s));
                        t = t + Double.parseDouble(htMajor.get(s));
                    }
                    if((htMajor.get(s) == null || htMajor.get(s) == "") && htSuppImpv.get(s) == null && (htInternal.get(s) == null || htInternal.get(s) == "")) {
                        out.println("<td></td>");
                    } else {
                        out.println("<td>"+Math.round(t)+"</td>");
                    }%>
                    <td><%=htGrade.get(s)%></td>
                </tr><%
            }
            htSub.clear();
            sub.clear();
            htAlias.clear();
            htInternal.clear();
            htMajor.clear();
            htSuppImpv.clear();
            htGrade.clear();
            scis.close();
            conn1.closeConnection();%>
        </table>
        <br/><br/>
        <div align="center">
            <input type="button" value="Print" id="p1" class="noPrint" onclick="window.print();" />
        </div>
    </body>
</html>