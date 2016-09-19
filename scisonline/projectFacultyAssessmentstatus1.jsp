<%-- 
    Document   : projectFacultyAssessmentstatus1
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.ArrayList" %>
<%@include file="programmeRetrieveBeans.jsp"%>
<%@include file="connectionBean.jsp"%>
<%@include file="id_parser.jsp"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <script type="text/javascript">

            function link1()
            {
                alert("Please enter the marks of atleast 1 student");
                window.location.replace("projectFacultyAssessmentInt.jsp");
            }
        </script>    

    </head>
    <body bgcolor="E0FFFF">

        <%  PreparedStatement pst = null;
            Connection con = conn.getConnectionObj();
            ResultSet rss1 = null;
            String pgName = null;
            int i = 0;
            String[] stid = request.getParameterValues("stid");      // Student ID
            String[] ptid = request.getParameterValues("ptid");      // Project Title
            String[] status = request.getParameterValues("status");    // Project Marks
            int slno = 1;
            try {
                con.setAutoCommit(false);
                for (i = 0; i < status.length; i++) {

                    if (ptid[i].equalsIgnoreCase(" ") || ptid[i].equalsIgnoreCase("")) {
                        continue;
                    }
                    pgName = scis.studentProgramme(stid[i]);
                    int pyear = scis.studentBatchYear(stid[i]);
                    String code = pgName.replace('-', '_') + "_Project_Student_" + pyear;
                    
                    status[i] = status[i].trim();
                    int flag = 1; // for degree award check
                    if (status[i] != "") {
                        //status 5 is for degree awarded
                        if(status[i].equals("5")) {
                            String table =pgName.replace("-", "_")+"_"+pyear;
                            String query = "select * from "+table+" where StudentId='"+stid[i]+"'";
                            ResultSet rs = scis.executeQuery(query);
                            ResultSetMetaData rsmt = rs.getMetaData();
                            int column = rsmt.getColumnCount();
                            if(rs!= null && rs.next()) {
                                ArrayList<String> sub = new ArrayList();
                                for(int j = 4; j < column; j = j + 2){
                                    String grade = rs.getString(j);
                                    if(grade.equalsIgnoreCase("A+") ||
                                            grade.equalsIgnoreCase("A") ||
                                            grade.equalsIgnoreCase("B+") ||
                                            grade.equalsIgnoreCase("B") ||
                                            grade.equalsIgnoreCase("C") ||
                                            grade.equalsIgnoreCase("D")){
                                        
                                    } else {
                                        sub.add(rs.getString(j-1));
                                        flag = 0;
                                    }
                                }
                                if(flag == 0) {
                                    out.println(slno+". " + scis.studentName(stid[i]) + " not passed in the following subjects and cannot be awarded the degree:<br/>");
                                    ++slno;
                                    int len = sub.size();
                                    for(int s = 0; s < len-1; s++){
                                        out.println(scis.subjectName(sub.get(s), pgName, pyear)+", ");
                                    }
                                    out.println(scis.subjectName(sub.get(len-1), pgName, pyear)+".<br/><br/>");
                                }
                            }
                            
                        }
                        if (flag == 1) {
                            pst = con.prepareStatement("update " + pgName.replace("-", "_") + "_Project_Student_" + pyear + " set Status="+status[i]+" where StudentId=?");
                            pst.setString(1, stid[i]);
                            pst.executeUpdate();
                        }
                    }
                    
                    
                    
//                    if (status[i] == "") {
//                    } else if (status[i].equalsIgnoreCase("Allocated")) {
//
//                        pst = con.prepareStatement("update " + code + " set Status=? where StudentId=?");
//                        pst.setString(1, "Allocated");
//                        pst.setString(2, stid[i]);
//                        pst.executeUpdate();
//
//                    } else if (status[i].equalsIgnoreCase("Mid")) {
//
//                        pst = con.prepareStatement("update " + code + " set Status=? where StudentId=?");
//                        pst.setString(1, "Mid");
//                        pst.setString(2, stid[i]);
//                        pst.executeUpdate();
//
//                    } else if (status[i].equalsIgnoreCase("report")) {
//
//                        pst = con.prepareStatement("update " + code + " set Status=? where StudentId=?");
//                        pst.setString(1, "report");
//                        pst.setString(2, stid[i]);
//                        pst.executeUpdate();
//
//                    } else if (status[i].equalsIgnoreCase("Viva")) {
//
//                        pst = con.prepareStatement("update " + code + " set Status=? where StudentId=?");
//                        pst.setString(1, "Viva");
//                        pst.setString(2, stid[i]);
//                        pst.executeUpdate();
//
//                    } else if (status[i].equalsIgnoreCase("DegreeAwarded")) {
//
//                        pst = con.prepareStatement("update " + code + " set Status=? where StudentId=?");
//                        pst.setString(1, "DegreeAwarded");
//                        pst.setString(2, stid[i]);
//                        pst.executeUpdate();
//
//                    } else if (status[i].equalsIgnoreCase("extend")) {
//
//                        pst = con.prepareStatement("update " + code + " set Status=? where StudentId=?");
//                        pst.setString(1, "extend");
//                        pst.setString(2, stid[i]);
//                        pst.executeUpdate();
//
//                    }

                    //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                } // For close
                con.commit();
                out.println("<h1><center>Project status successfully updated.</center><h1>");
                System.out.println("Project status updation finished********");
                rss1.close();
                pst.close();
                scis.close();
                conn.closeConnection();
                con = null;
            } catch (Exception ex) {
                con.rollback();
                System.out.println("Transaction rollback!!!");
            } 
            
        %>

    </body>
</html>
