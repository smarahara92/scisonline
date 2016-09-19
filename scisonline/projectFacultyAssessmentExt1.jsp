<%-- 
    Document   : projectFacultyAssessementInt1
    Created on : 29 Apr, 2013, 8:18:40 AM
    Author     : varun
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="programmeRetrieveBeans.jsp"%>
<%@page import="java.sql.*"%>
<%@include file="connectionBean.jsp"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <script type="text/javascript">

            function link1()
            {
                alert("Please enter the marks of atleast 1 student");
                window.history.back();
            }
        </script>    

    </head>
    <body bgcolor="E0FFFF">

        <%   PreparedStatement pst = null;
            int flag1 = 0, upto = 0, flag2 = 0;
            try {

                ResultSet rs1 = null;
                ResultSet rs2 = null;
                Connection con = conn.getConnectionObj();
                Connection con1 = conn1.getConnectionObj();
                int i, j, k= 0;
                float avgMarksInternal = 0, totalMarks = 0;
                String grade = "";
                String[] stid = request.getParameterValues("stid");      // Student ID
                String[] sname = request.getParameterValues("sname");    // Student Name 
                String[] ptid = request.getParameterValues("ptid");      // Project Title
                String[] marks = request.getParameterValues("marks");    // Project Marks
                String table1 = null;
                upto = stid.length;

                for (j = 0; j < upto; j++) {
                    if (marks[j] == "") {
                        k++;
                    }
                }

                if (upto == k) {
        %>
        <script type="text/javascript" language="javascript">
            link1();
        </script>    
        <% }
                try {
                    con.setAutoCommit(false);
                    String branch = "";
                    String code = "";
                    for (i = 0; i < upto; i++) {
                       String studentName = scis.studentName(stid[i]);
                        if (studentName != null) {
                            branch = scis.studentProgramme(stid[i]);
                            int pyear = scis.studentBatchYear(stid[i]);
                            code = branch.replace('-', '_') + "_" + "Project_Student_" + pyear;
                            //+++++++++++++++++++++++++++++++++++++++++++++++
                            // ################################### Other than mca ##################################
                            if (!branch.equalsIgnoreCase("mca")) {
                                // try {

                                pst = con.prepareStatement("select PanelMarks2,AdvisorMarks2, PanelMarks2, AdvisorMarks2 from " + code + " where StudentId=?");
                                pst.setString(1, stid[i]);
                                rs1 = pst.executeQuery();
                                while (rs1.next()) {
                                    if ((rs1.getString(2) != null && marks[i].equalsIgnoreCase(""))) {
                                        avgMarksInternal = rs1.getFloat(1) / 2;
                                        pst = con.prepareStatement("update " + code + " set AdvisorMarks2=NULL where StudentId=?");
                                        pst.setString(1, stid[i]);
                                        pst.executeUpdate();
                                        pst = con.prepareStatement("update " + code + " set AverageMarks2=? where StudentId=?");
                                        pst.setString(1, Float.toString(avgMarksInternal));
                                        pst.setString(2, stid[i]);
                                        pst.executeUpdate();

                                    } else if (!marks[i].equalsIgnoreCase("")) {

                                        avgMarksInternal = rs1.getFloat(1) + Float.parseFloat(marks[i]);// marks[i] is Staff Internal Marks or Panel Marks.
                                        avgMarksInternal = avgMarksInternal / 2;
                                        pst = con.prepareStatement("update " + code + " set AdvisorMarks2=? where StudentId=?");
                                        pst.setString(1, marks[i]);
                                        pst.setString(2, stid[i]);
                                        pst.executeUpdate();
                                        pst = con.prepareStatement("update " + code + " set AverageMarks2=? where StudentId=?");
                                        pst.setString(1, Float.toString(avgMarksInternal));
                                        pst.setString(2, stid[i]);
                                        pst.executeUpdate();

                                    }

                                }
                                        //*****************

                                // for Total Marks Updation  
                                //***************
                                pst = con.prepareStatement("select AverageMarks1,AverageMarks2 from " + code + " where StudentId=?");
                                pst.setString(1, stid[i]);
                                rs2 = pst.executeQuery();
                                while (rs2.next()) {

                                    totalMarks = rs2.getFloat(1) + rs2.getFloat(2);
                                    //totalMarks = totalMarks / 2;
                                    pst = con.prepareStatement("update " + code + " set TotalMarks=? where StudentId=?");
                                    pst.setString(1, Float.toString(totalMarks));
                                    pst.setString(2, stid[i]);
                                    pst.executeUpdate();
                                }
                                flag1++;
                                
                                // ########################## Grade Updation ###############################
                                    if (rs2.getString(1) != null && rs2.getString(2) != null && rs2.getString(3) != null  && rs2.getString(4) != null) {
                                        String Stream = scis.getStreamOfProgramme(branch);
                                        pst = con1.prepareStatement("select * from " + Stream + "_grade_table Order By Marks DESC");

                                        ResultSet rs4 = pst.executeQuery();

                                        while (rs4.next()) {
                                            if (totalMarks >= rs4.getInt(2)) {
                                                grade = rs4.getString(1);
                                                System.out.println(grade + "gradeeeeeeeeee");
                                                break;
                                            } else {
                                                grade = "F";
                                            }
                                        }
                                        pst = con.prepareStatement("update " +branch.replace("-", "_")+"_Project_Student_" + pyear + " set Grade=? where StudentId=?");
                                        pst.setString(1, grade);
                                        pst.setString(2, stid[i]);
                                        pst.executeUpdate();
                                        
                                        pst = con.prepareStatement("update " + branch.replace("-", "_")+"_" + pyear + " set p1grade=? where StudentId=?");
                                        pst.setString(1, grade);
                                        pst.setString(2, stid[i]);
                                        pst.executeUpdate();
                                       

                                    }  // Main If block

                                    //############################# Grade Close ##################################
                                
                                
                                //                      } // If - Mtech Close
                                // ################################### END ####################################
                                // ################################### MCA ####################################
                            } else if (branch.equalsIgnoreCase("mca")) {

                                pst = con.prepareStatement("select PanelMarks2 from " + code + " where StudentId=?");
                                pst.setString(1, stid[i]);
                                rs1 = pst.executeQuery();
                                while (rs1.next()) {

                                    if ((rs1.getString(1) != null && marks[i].equalsIgnoreCase(""))) {

                                        avgMarksInternal = rs1.getFloat(1) / 2;
                                        pst = con.prepareStatement("update " + code + " set AdvisorMarks2=? where StudentId=?");
                                        pst.setString(1, null);
                                        pst.setString(2, stid[i]);
                                        pst.executeUpdate();
                                        pst = con.prepareStatement("update " + code + " set AverageMarks2=? where StudentId=?");
                                        pst.setString(1, Float.toString(avgMarksInternal));
                                        pst.setString(2, stid[i]);
                                        pst.executeUpdate();

                                    } else if (!marks[i].equalsIgnoreCase("")) {

                                        avgMarksInternal = rs1.getFloat(1) + Float.parseFloat(marks[i]);// marks[i] is Staff Internal Marks or Panel Marks.
                                        avgMarksInternal = avgMarksInternal / 2;

                                        pst = con.prepareStatement("update " + code + " set AdvisorMarks2=? where StudentId=?");
                                        pst.setString(1, marks[i]);
                                        pst.setString(2, stid[i]);
                                        pst.executeUpdate();
                                        pst = con.prepareStatement("update " + code + " set AverageMarks2=? where StudentId=?");
                                        pst.setString(1, Float.toString(avgMarksInternal));
                                        pst.setString(2, stid[i]);
                                        pst.executeUpdate();

                                    }
                                }
                                        //*****************

                                // for Total Marks Updation  
                                //***************
                                pst = con.prepareStatement("select AverageMarks1,AverageMarks2, PanelMarks2, AdvisorMarks2 from " + code + " where StudentId=?");
                                pst.setString(1, stid[i]);
                                rs2 = pst.executeQuery();
                                while (rs2.next()) {

                                    totalMarks = rs2.getFloat(1) + rs2.getFloat(2);
                                    pst = con.prepareStatement("update " + code + " set TotalMarks=? where StudentId=?");
                                    pst.setString(1, Float.toString(totalMarks));
                                    pst.setString(2, stid[i]);
                                    pst.executeUpdate();

                                    // ########################## Grade Updation ###############################
                                    if (rs2.getString(1) != null && rs2.getString(2) != null && rs2.getString(3) != null  && rs2.getString(4) != null) {
                                        String Stream = scis.getStreamOfProgramme(branch);
                                        pst = con1.prepareStatement("select * from " + Stream + "_grade_table Order By Marks DESC");

                                        ResultSet rs4 = pst.executeQuery();

                                        while (rs4.next()) {
                                            if (totalMarks >= rs4.getInt(2)) {
                                                grade = rs4.getString(1);
                                                System.out.println(grade + "gradeeeeeeeeee");
                                                break;
                                            } else {
                                                grade = "F";
                                            }
                                        }
                                        pst = con.prepareStatement("update " +branch.replace("-", "_")+"_Project_Student_" + pyear + " set Grade=? where StudentId=?");
                                        pst.setString(1, grade);
                                        pst.setString(2, stid[i]);
                                        pst.executeUpdate();
                                        
                                        pst = con.prepareStatement("update " + branch.replace("-", "_")+"_" + pyear + " set p1grade=? where StudentId=?");
                                        pst.setString(1, grade);
                                        pst.setString(2, stid[i]);
                                        pst.executeUpdate();
                                       

                                    }  // Main If block

                                    //############################# Grade Close ##################################
                                }
                                flag1++;
                            }       // If - MCA Close
                        }
                    }
                    con.commit();
                    flag2++;
                } catch (Exception ex) {
                    con.rollback();
                    ex.printStackTrace();
                    System.out.println(ex);
                    System.out.println("Transacetion rollback!!!");
                }
                rs1.close();
                rs2.close();
                conn.closeConnection();
                con.close();
                scis.close();
                pst.close();
            } catch (Exception ex) {
                System.out.println(ex);
            } finally {
                
                if(flag2==0)
                {
                    out.println("Some internal error please try again or contact to system admin...");
                }
                if (flag1 == upto && flag2 > 0) {
                    out.println("<h1><center>Project Marks Successfully Updated.</center><h1>");
                }
                
            }
        %>

    </body>
</html>
