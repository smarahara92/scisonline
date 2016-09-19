<%-- 
    Document   : projectFacultyAssessementInt1
    Created on : 29 Apr, 2013, 8:18:40 AM
    Author     : varun
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@include file="programmeRetrieveBeans.jsp"%>
<%@include file="connectionBean.jsp"%>
<!DOCTYPE html>
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

        <%            PreparedStatement pst = null;
            try {
                Connection con = conn.getConnectionObj();
                ResultSet rs1 = null;
                ResultSet rs2 = null;
                int flag1 = 0, flag2 = 0;
                                int i, j, k = 0;
                float avgMarksInternal = 0, totalMarks = 0;

                String grade = "";
                String[] stid = request.getParameterValues("stid");      // Student ID
                String[] sname = request.getParameterValues("sname");    // Student Name 
                String[] ptid = request.getParameterValues("ptid");      // Project Title
                String[] marks = request.getParameterValues("marks");    // Project Marks
                String table1 = null;
                int upto = stid.length;

                for (j = 0; j < upto; j++) {
                    if (marks[j] == "") {
                        k++;
                    }
                }

                if (upto == k) {
        %>
        <script type="text/javascript" language="javascript">
            // alert("hiii");
            link1();

        </script>    

        <% }
                try {

                    con.setAutoCommit(false);
                    for (i = 0; i < upto; i++) {

                        String branch = "";
                        String code = "";
                        int flag = 0;

                        branch = scis.studentProgramme(stid[i]);
                        int pyear = scis.studentBatchYear(stid[i]);
                        code = branch.replace('-', '_') + "_" + "Project_Student_" + pyear;
                        flag++;

                        //+++++++++++++++++++++++++++++++++++++++++++++++
                        // ################################### Other than mca ##################################
                        if (!branch.equalsIgnoreCase("mca")) {
                            // for AverageMarks 1 Updation

                            pst = con.prepareStatement("select PanelMarks1,AdvisorMarks1 from " + code + " where StudentId=?");
                            pst.setString(1, stid[i]);

                            rs1 = pst.executeQuery();
                            while (rs1.next()) {

                                if ((rs1.getString(2) != null && marks[i].equalsIgnoreCase(""))) {

                                    avgMarksInternal = rs1.getFloat(1) / 2;

                                    pst = con.prepareStatement("update " + code + " set AdvisorMarks1=? where StudentId=?");
                                    pst.setString(1, null);
                                    pst.setString(2, stid[i]);
                                    pst.executeUpdate();

                                    pst = con.prepareStatement("update " + code + " set AverageMarks1=? where StudentId=?");
                                    pst.setString(1, Float.toString(avgMarksInternal));
                                    pst.setString(2, stid[i]);
                                    pst.executeUpdate();

                                } else if (!marks[i].equalsIgnoreCase("")) {

                                    avgMarksInternal = rs1.getFloat(1) + Float.parseFloat(marks[i]);// marks[i] is Staff Internal Marks or Panel Marks.
                                    avgMarksInternal = avgMarksInternal / 2;

                                    pst = con.prepareStatement("update " + code + " set AdvisorMarks1=? where StudentId=?");
                                    pst.setString(1, marks[i]);
                                    pst.setString(2, stid[i]);
                                    pst.executeUpdate();
                                    pst = con.prepareStatement("update " + code + " set AverageMarks1=? where StudentId=?");
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
                                //totalMarks=totalMarks/2;

                                pst = con.prepareStatement("update " + code + " set TotalMarks=? where StudentId=?");
                                pst.setString(1, Float.toString(totalMarks));
                                pst.setString(2, stid[i]);
                                pst.executeUpdate();
                            }
                            //***************

                            pst = con.prepareStatement("select PanelMarks1, AdvisorMarks1 from " + code + " where StudentId=?");
                            pst.setString(1, stid[i]);
                            ResultSet rs11 = pst.executeQuery();

                            if (rs11.next()) {
                                if (rs11.getString(1) != null && rs11.getString(2) != null) {
                                    pst = con.prepareStatement("update " + code + " set Status=? where StudentId=?");
                                    pst.setString(1, "Mid");
                                    pst.setString(2, stid[i]);
                                    pst.executeUpdate();

                                } else if (rs11.getString(1) == null || rs11.getString(2) == null) {
                                    pst = con.prepareStatement("update " + code + " set Status=? where StudentId=?");
                                    pst.setString(1, "Allocated");
                                    pst.setString(2, stid[i]);
                                    pst.executeUpdate();

                                }

                            }
                            flag1++;
                            rs11.close();
                        } // If - Mtech Close
                        // ################################### END ####################################
                        // ################################### MCA ####################################
                        else if (branch.equalsIgnoreCase("mca")) {
                            // for AverageMarks 1 Updation
                            //*****************  
                            pst = con.prepareStatement("select PanelMarks1,AdvisorMarks1 from " + code + " where StudentId=?");
                            pst.setString(1, stid[i]);

                            rs1 = pst.executeQuery();
                            while (rs1.next()) {

                                if ((rs1.getString(2) != null && marks[i].equalsIgnoreCase(""))) {

                                    avgMarksInternal = rs1.getFloat(1) / 2;
                                    pst = con.prepareStatement("update " + code + " set AdvisorMarks1=? where StudentId=?");
                                    pst.setString(1, null);
                                    pst.setString(2, stid[i]);
                                    pst.executeUpdate();
                                    pst = con.prepareStatement("update " + code + " set AverageMarks1=? where StudentId=?");
                                    pst.setString(1, Float.toString(avgMarksInternal));
                                    pst.setString(2, stid[i]);

                                    pst.executeUpdate();

                                } else if (!marks[i].equalsIgnoreCase("")) {

                                    avgMarksInternal = rs1.getFloat(1) + Float.parseFloat(marks[i]);// marks[i] is Staff Internal Marks or Panel Marks.
                                    avgMarksInternal = avgMarksInternal / 2;
                                    pst = con.prepareStatement("update " + code + " set AdvisorMarks1=? where StudentId=?");
                                    pst.setString(1, marks[i]);
                                    pst.setString(2, stid[i]);
                                    pst.executeUpdate();
                                    pst = con.prepareStatement("update " + code + " set AverageMarks1=? where StudentId=?");
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

                                pst = con.prepareStatement("update " + code + " set TotalMarks=? where StudentId=?");
                                pst.setString(1, Float.toString(totalMarks));
                                pst.setString(2, stid[i]);
                                pst.executeUpdate();

                                // ########################## Grade Updation ###############################
                                if (rs2.getString(1) != null && rs2.getString(2) != null) {
                                    if (totalMarks >= 85 && totalMarks <= 100) {
                                        grade = "A+";
                                        pst = con.prepareStatement("update MCA_Project_Student_" + pyear + " set Grade=? where StudentId=?");
                                        pst.setString(1, grade);
                                        pst.setString(2, stid[i]);
                                        pst.executeUpdate();
                                    } else if (totalMarks >= 75 && totalMarks < 85) {
                                        grade = "A";
                                        pst = con.prepareStatement("update MCA_Project_Student_" + pyear + " set Grade=? where StudentId=?");
                                        pst.setString(1, grade);
                                        pst.setString(2, stid[i]);
                                        pst.executeUpdate();
                                    } else if (totalMarks >= 65 && totalMarks < 75) {
                                        grade = "B+";
                                        pst = con.prepareStatement("update MCA_Project_Student_" + pyear + " set Grade=? where StudentId=?");
                                        pst.setString(1, grade);
                                        pst.setString(2, stid[i]);
                                        pst.executeUpdate();
                                    } else if (totalMarks >= 60 && totalMarks < 65) {
                                        grade = "B";
                                        pst = con.prepareStatement("update MCA_Project_Student_" + pyear + " set Grade=? where StudentId=?");
                                        pst.setString(1, grade);
                                        pst.setString(2, stid[i]);
                                        pst.executeUpdate();
                                    } else if (totalMarks >= 55 && totalMarks < 60) {
                                        grade = "C";
                                        pst = con.prepareStatement("update MCA_Project_Student_" + pyear + " set Grade=? where StudentId=?");
                                        pst.setString(1, grade);
                                        pst.setString(2, stid[i]);
                                        pst.executeUpdate();
                                    } else if (totalMarks >= 50 && totalMarks < 55) {
                                        grade = "D";
                                        pst = con.prepareStatement("update MCA_Project_Student_" + pyear + " set Grade=? where StudentId=?");
                                        pst.setString(1, grade);
                                        pst.setString(2, stid[i]);
                                        pst.executeUpdate();
                                    } else if (totalMarks < 50) {
                                        grade = "F";
                                        pst = con.prepareStatement("update MCA_Project_Student_" + pyear + " set Grade=? where StudentId=?");
                                        pst.setString(1, grade);
                                        pst.setString(2, stid[i]);
                                        pst.executeUpdate();
                                    }

                                }  // Main If block

                                //############################# Grade Close ##################################
                            }
                            //***************

                            pst = con.prepareStatement("select PanelMarks1, AdvisorMarks1 from " + code + " where StudentId=?");
                            pst.setString(1, stid[i]);
                            ResultSet rs11 = pst.executeQuery();
                            if (rs11.next()) {
                                if (rs11.getString(1) != null && rs11.getString(2) != null) {
                                    pst = con.prepareStatement("update " + code + " set Status=? where StudentId=?");
                                    pst.setString(1, "Mid");
                                    pst.setString(2, stid[i]);
                                    pst.executeUpdate();

                                }
                            }
                            flag1++; 
                            rs11.close();
                        } 
                        
                        // If - MCA Close

                        // ################################### END ####################################		
                    } // For close
                    
                    con.commit();
                    flag2++;
                   
                } catch (Exception ex) {
                    con.rollback();
                    System.out.println(ex);
                    System.out.println("Transaction rollback!!!");
                } finally {
                    if (flag2 == 0) {
                        out.println("Some internal error please try again or contact to system admin...");
                    }
                    if (flag1 == upto && flag2 > 0) {
                        out.println("<h1><center>Project Marks Successfully Updated.</center><h1> ");
                    }
                }
                rs1.close();
                rs2.close();
                pst.close();
                scis.close();
                conn.closeConnection();
                con = null;
            } catch (Exception ex) {
                System.out.println(ex);
            }
        %>

    </body>
</html>
