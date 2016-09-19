<%-- 
    Document   : projectStaffAssessmentCSExt1
    Created on : 1 May, 2013, 3:48:24 AM
    Author     : varun
--%>
<%@include file="programmeRetrieveBeans.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
                window.location.replace("projectStaffAssessmentCSInt.jsp");
                //history.back;
                //return;
            }
        </script>    

    </head>
    <body bgcolor="E0FFFF">

        <%            PreparedStatement pst = null;
            String programmeName = (String) session.getAttribute("stream");
            programmeName = programmeName.replace('-', '_');
            String Stream = (String) session.getAttribute("programmeName");
            Stream = Stream.replace('-', '_');
            String[] stid = request.getParameterValues("stid");      // Student ID
            String[] ptid = request.getParameterValues("ptitle");      // Project Title
            String[] marks = request.getParameterValues("marks");    // Project Marks
            int a =0;
            String studentId = stid[a];
            int pyear = scis.studentBatchYear(studentId);
            
            int upto = stid.length;
            int i, j, k = 0, check1 = 0, check2 = 0, check3 = 0;     // check used to see if a stream has any proj Studs or not.

            String grade = "";

            float avgMarksInternal = 0, totalMarks = 0;

            ResultSet rs1 = null;
            ResultSet rs2 = null;
            ResultSet rs4 = null;
            Connection con = conn.getConnectionObj();
            Connection con1 = conn1.getConnectionObj();

            try {
                con.setAutoCommit(false);
                con1.setAutoCommit(false);
                for (i = 0; i < upto; i++) {

                    if (ptid[i] == null) {

                        continue;
                    }
                    pst = con.prepareStatement("select AdvisorMarks2,PanelMarks2 from " + programmeName + "_Project_Student_" + pyear + " where StudentId=?");
                    pst.setString(1, stid[i]);
                    rs1 = pst.executeQuery();
                    while (rs1.next()) {

                        if ((rs1.getString(2) != null && marks[i].equalsIgnoreCase(""))) {

                            avgMarksInternal = rs1.getFloat(1) / 2;
                            pst = con.prepareStatement("update " + programmeName + "_Project_Student_" + pyear + " set PanelMarks2=? where StudentId=?");
                            pst.setString(1, null);
                            pst.setString(2, stid[i]);
                            pst.executeUpdate();
                            pst = con.prepareStatement("update " + programmeName + "_Project_Student_" + pyear + " set AverageMarks2=? where StudentId=?");
                            pst.setString(1, Float.toString(avgMarksInternal));
                            pst.setString(2, stid[i]);
                            pst.executeUpdate();

                        } else if (!marks[i].equalsIgnoreCase("")) {

                            avgMarksInternal = rs1.getFloat(1) + Float.parseFloat(marks[i]);// marks[i] is Staff Internal Marks or Panel Marks.
                            avgMarksInternal = avgMarksInternal / 2;
                            pst = con.prepareStatement("update " + programmeName + "_Project_Student_" + pyear + " set PanelMarks2=? where StudentId=?");
                            pst.setString(1, marks[i]);
                            pst.setString(2, stid[i]);
                            pst.executeUpdate();
                            pst = con.prepareStatement("update " + programmeName + "_Project_Student_" + pyear + " set AverageMarks2=? where StudentId=?");
                            pst.setString(1, Float.toString(avgMarksInternal));
                            pst.setString(2, stid[i]);
                            pst.executeUpdate();
                        }

                    }

                    // for Total Marks Updation
                    //***************
                    pst = con.prepareStatement("select AverageMarks1,AverageMarks2, PanelMarks2, AdvisorMarks2 from " + programmeName + "_Project_Student_" + pyear + " where StudentId=?");
                    pst.setString(1, stid[i]);
                    rs2 = pst.executeQuery();
                    while (rs2.next()) {
                        // If any of AvgMarks1 or AvgMarks2 is Null, then rs2.getFloat will take it as 0

                        totalMarks = (float)Math.ceil((double)(rs2.getFloat(1) + rs2.getFloat(2)));
                        pst = con.prepareStatement("update " + programmeName + "_Project_Student_" + pyear + " set TotalMarks=? where StudentId=?");
                        pst.setFloat(1, totalMarks);
                        pst.setString(2, stid[i]);
                        pst.executeUpdate();
                        
                        // ########################## Grade Updation ###############################
                        if (rs2.getString(1) != null && rs2.getString(2) != null && rs2.getString(3) != null  && rs2.getString(4) != null) {
                            pst = con1.prepareStatement("select * from " + Stream + "_grade_table Order By Marks DESC");

                            rs4 = pst.executeQuery();

                            while (rs4.next()) {
                                if (totalMarks >= rs4.getInt(2)) {
                                    grade = rs4.getString(1);
                                    System.out.println(grade + "gradeeeeeeeeee");
                                    break;
                                } else {
                                    grade = "F";
                                }
                            }
                            pst = con.prepareStatement("update " +programmeName.replace("-", "_")+"_Project_Student_" + pyear + " set Grade=? where StudentId=?");
                            pst.setString(1, grade);
                            pst.setString(2, stid[i]);
                            pst.executeUpdate();

                            pst = con.prepareStatement("update " + programmeName.replace("-", "_")+"_" + pyear + " set p1grade=? where StudentId=?");
                            pst.setString(1, grade);
                            pst.setString(2, stid[i]);
                            pst.executeUpdate();


                        }  // Main If block

                        //############################# Grade Close ##################################
                    }
                    //***************

                } // For close
                con.commit();
                con1.commit();
                out.println("<h1><center>Project Marks Successfully Updated.</center><h1> ");
                rs1.close();
                rs2.close();
                rs4.close();
                conn.closeConnection();
                con = null;
                conn1.closeConnection();
                con1 = null;
                scis.close();
                pst.close();
            } catch (Exception ex) {
                con.rollback();
                con1.rollback();

                ex.printStackTrace();
                System.out.println("Transaction rollback!!!");
            } 

        %>

    </body>
</html>

