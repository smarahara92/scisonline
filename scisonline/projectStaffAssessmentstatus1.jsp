<%-- 
    Document   : projectStaffAssessmentstatus1
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.ArrayList" %>
<%@include file="programmeRetrieveBeans.jsp"%>
<%@include file="connectionBean.jsp"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    </head>
    <body bgcolor="E0FFFF"> <%
        PreparedStatement pst = null;
        String[] stid = request.getParameterValues("stid");      // Student ID
        String[] ptid = request.getParameterValues("ptitle");      // Project Title
        String[] status = request.getParameterValues("status");    // Project Marks

        String programmeName=scis.studentProgramme(stid[0]);
        programmeName=programmeName.replace('-', '_');
        int pyear = scis.studentBatchYear(stid[0]);
        System.out.println("table is:" +programmeName + pyear);

        Connection con = conn.getConnectionObj();
        int slno = 1;
        try {
                con.setAutoCommit(false);
                for (int i = 0; i < status.length; i++) {

                    if (ptid[i].equalsIgnoreCase(" ") || ptid[i].equalsIgnoreCase("")) {

                        continue;
                    }
                    status[i] = status[i].trim();
                    int flag = 1; // for degree award check
                    if (status[i] != "") {
                        //status 5 is for degree awarded
                        if(status[i].equals("5")) {
                            String table =programmeName+"_"+pyear;
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
                                        out.println(scis.subjectName(sub.get(s), programmeName, pyear)+", ");
                                    }
                                    out.println(scis.subjectName(sub.get(len-1), programmeName, pyear)+".<br/><br/>");
                                }
                            }
                            
                        }
                        if (flag == 1) {
                            pst = con.prepareStatement("update " + programmeName + "_Project_Student_" + pyear + " set Status="+status[i]+" where StudentId=?");
                            pst.setString(1, stid[i]);
                            pst.executeUpdate();
                        }
                    }
                    /*if (status[i] == "") {
                    } else if (status[i].equalsIgnoreCase("1")) {
                        pst = con.prepareStatement("update " + programmeName + "_Project_Student_" + pyear + " set Status=? where StudentId=?");
                        pst.setString(1, "Allocated");
                        pst.setString(2, stid[i]);
                        pst.executeUpdate();

                    } else if (status[i].equalsIgnoreCase("2")) {
                        pst = con.prepareStatement("update " + programmeName + "_Project_Student_" + pyear + " set Status=? where StudentId=?");
                        pst.setString(1, "Mid");
                        pst.setString(2, stid[i]);
                        pst.executeUpdate();

                    } else if (status[i].equalsIgnoreCase("3")) {
                        System.out.println("in report if-else");
                        pst = con.prepareStatement("update " + programmeName + "_Project_Student_" + pyear + " set Status=? where StudentId=?");
                        pst.setString(1, "report");
                        pst.setString(2, stid[i]);
                        pst.executeUpdate();

                    } else if (status[i].equalsIgnoreCase("4")) {
                        pst = con.prepareStatement("update " + programmeName + "_Project_Student_" + pyear + " set Status=? where StudentId=?");
                        pst.setString(1, "Viva");
                        pst.setString(2, stid[i]);
                        pst.executeUpdate();

                    } else if (status[i].equalsIgnoreCase("5")) {
                        String mastertable = programmeName +"_"+ pyear;
                        try {
                            pst = con.prepareStatement("update " + programmeName + "_Project_Student_" + pyear + " set Status=? where StudentId=?");
                            pst.setString(1, "DegreeAwarded");
                            pst.setString(2, stid[i]);
                            pst.executeUpdate();
                        }catch(Exception e) {
                            
                        }

                    } else if (status[i].equalsIgnoreCase("6")) {
                        pst = con.prepareStatement("update " + programmeName + "_Project_Student_" + pyear + " set Status=? where StudentId=?");
                        pst.setString(1, "extend");
                        pst.setString(2, stid[i]);
                        pst.executeUpdate();

                    }//*/

                } // For close
                con.commit();
            } catch (Exception e) {
                con.rollback();
                e.printStackTrace();
                System.out.println("Transaction rollback!!!");
            }                    
            //############################################# END ###################################################
            conn.closeConnection();
            con = null;
            scis.close();
        %>
        <h1><center>Project status successfully updated.</center><h1> 
    </body>
</html>