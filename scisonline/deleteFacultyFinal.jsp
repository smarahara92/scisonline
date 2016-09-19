<%-- 
    Document   : deleteFacultyFinal
--%>

<%@include file="checkValidity.jsp"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>

<%@include file="connectionBean.jsp"%>
<%@include file="id_parser.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
        
        Connection con = conn.getConnectionObj();
        Connection con2 = conn2.getConnectionObj();
        
        Statement st1 = con.createStatement();
            Statement st2 = con.createStatement();
            Statement st3 = con.createStatement();
            Statement st4 = con.createStatement();
            Statement st5 = con.createStatement();
            Statement st6 = con.createStatement();
            Statement st7 = con.createStatement();
            Statement st8 = con.createStatement();
            Statement st9 = con.createStatement();
            Statement st10 = con.createStatement();
            Statement st11 = con.createStatement();
            Statement st12 = con.createStatement();
            Statement st13 = con.createStatement();
            Statement st14 = con.createStatement();
            Statement st15 = con2.createStatement();
            Statement st16 = con2.createStatement();
            Statement st17 = con2.createStatement();
            Statement st18 = con.createStatement();

            Calendar now = Calendar.getInstance();
            int year = now.get(Calendar.YEAR);
            int year3 = year;
            int month = now.get(Calendar.MONTH);
            String semester = "";
            if (month <= 6) {
                semester = "Winter";
                year3 = year3 - 1;
            } else {

                semester = "Monsoon";

            }

            String programmeName = null;
            String streamName = null;
            String oldfaculty = (String) session.getAttribute("oldfaculty");

            //transactions are handled
            // -----------------------Handling of Reassigned Subjects----------------------------------
            try {
                con.setAutoCommit(false);
                con2.setAutoCommit(false);
                ResultSet rs1 = (ResultSet) st1.executeQuery("select * from  Temp_Reassign_Subject_" + year + " ");
                while (rs1.next()) {
                    // Core + Reassign(only)
                    if (rs1.getString("Core").equals("yes")) {
                        String find = null;
                        ResultSet rs3 = st2.executeQuery("select * from subject_faculty_" + semester + "_" + year + " where facultyid1='" + rs1.getString(2) + "' and subjectid='" + rs1.getString(1) + "'");
                        while (rs3.next()) {
                            find = "facultyid1";
                        }
                        ResultSet rs4 = st3.executeQuery("select * from subject_faculty_" + semester + "_" + year + " where facultyid2='" + rs1.getString(2) + "' and subjectid='" + rs1.getString(1) + "'");
                        while (rs4.next()) {
                            find = "facultyid2";
                        }
                        st18.executeUpdate("UPDATE subject_faculty_" + semester + "_" + year + " SET " + find + "='" + rs1.getString(3) + "' where subjectid='" + rs1.getString(1) + "'");

                    }

                    // Elective + Drop 
                    if (rs1.getString("Core").equals("no") && rs1.getString("Reassign").equals("no")) {

                        //---------- Modified ---------------------------
                        String newfac2 = null;

                        // the subject from the subject-faculty list coz a different faculty can also be teaching the same subject.
                        int noFac1 = 0, noFac2 = 0;                // To check if a subject is taught by multiple faculties or not.
                        String find = "";
                        ResultSet rs2 = st4.executeQuery("select * from subject_faculty_" + semester + "_" + year + " where facultyid1='" + rs1.getString(2) + "' and subjectid='" + rs1.getString(1) + "'");
                        while (rs2.next()) {
                            noFac1 = 1;
                            find = "facultyid1";
                        }

                        ResultSet rs3 = st5.executeQuery("select * from subject_faculty_" + semester + "_" + year + " where facultyid2='" + rs1.getString(2) + "' and subjectid='" + rs1.getString(1) + "'");
                        while (rs3.next()) {
                            noFac2 = 1;
                            find = "facultyid2";
                        }

                        if ((noFac1 == 0 && noFac2 == 1) || (noFac1 == 1 && noFac2 == 0)) {

                            st18.executeUpdate("delete from subject_faculty_" + semester + "_" + year + " where subjectid='" + rs1.getString(1) + "'");

                        }
                        st18.executeUpdate("UPDATE subject_faculty_" + semester + "_" + year + " SET " + find + "='" + null + "' where subjectid='" + rs1.getString(1) + "'");

                    }

                    // Elective + Reassign
                    if (rs1.getString("Core").equals("no") && rs1.getString("Reassign").equals("yes")) {

                        String find = "";
                        ResultSet rs3 = st6.executeQuery("select * from subject_faculty_" + semester + "_" + year + " where facultyid1='" + rs1.getString(2) + "' and subjectid='" + rs1.getString(1) + "'");
                        while (rs3.next()) {
                            find = "facultyid1";
                        }
                        ResultSet rs4 = st7.executeQuery("select * from subject_faculty_" + semester + "_" + year + " where facultyid2='" + rs1.getString(2) + "' and subjectid='" + rs1.getString(1) + "'");
                        while (rs4.next()) {
                            find = "facultyid2";
                        }
                        st18.executeUpdate("UPDATE subject_faculty_" + semester + "_" + year + " SET " + find + "='" + rs1.getString(3) + "' where subjectid='" + rs1.getString(1) + "'");

                        //raises exception
                    }
                }               // Close of Result set of Temp_Reassign_Subject

                // ------------------------End-------------------------
                // -----------------------Handling of Reassigned Project Students----------------------------------
                ResultSet rs2 = (ResultSet) st8.executeQuery("select * from  Temp_Reassign_Mtech_MCA_Student_" + year + " ");//here Mtech/MCa are just table name it will not effect any generic feature.
                while (rs2.next()) {
                    //oldFacultyId=rs2.getString(2);	
                    String masterProjectTable = "";
                    String code = "";
                    String studID = rs2.getString(1);

                    String PROGRAMME_NAME = studID.substring(SPRGM_PREFIX, EPRGM_PREFIX);
                    ResultSet rs22 = (ResultSet) st9.executeQuery("select Programme_name,Programme_group from  programme_table where Programme_code='" + PROGRAMME_NAME + "' ");
                    if (rs22.next()) {
                        programmeName = rs22.getString(1).replace('-', '_');
                        streamName = rs22.getString(2).replace('-', '_');
                    }
                    if (rs2.getString("Internship").equals("no")) // No Co-Supervisor case
                    {
                        if (rs2.getString("NewFacId").equals("null")) // Change Project selected
                        {
                            // ----------------- name -------------------------

                            masterProjectTable = streamName + "_project_" + year3;
                            code = programmeName + "_" + "Project_Student" + year3;

                            //----------------- end ---------------------------
                            st10.executeUpdate("update  " + code + "  set ProjectId='" + rs2.getString("NewProjectId") + "' where ProjectId='" + rs2.getString("OldProjectId") + "' ");
                            // ------

                            // Checking if the supervisor to be changed is Sup1 or Sup2 or Sup3
                            // Handling the case when Single supervisor is present and change project is selected --> Setting the deleted supervisor to null..
                            ResultSet rs3 = (ResultSet) st11.executeQuery("select * from  " + masterProjectTable + " ");
                            while (rs3.next()) {
                                if (oldfaculty.equals(rs3.getString("SupervisorId1"))) {
                                    st10.executeUpdate("update " + masterProjectTable + " set SupervisorId1=" + null + " where SupervisorId1='" + oldfaculty + "'");
                                } else if (oldfaculty.equals(rs3.getString("SupervisorId2"))) {
                                    st10.executeUpdate("update " + masterProjectTable + " set SupervisorId2=" + null + " where SupervisorId2='" + oldfaculty + "'");
                                } else if (oldfaculty.equals(rs3.getString("SupervisorId3"))) {
                                    st10.executeUpdate("update " + masterProjectTable + " set SupervisorId3=" + null + " where SupervisorId3='" + oldfaculty + "'");
                                }
                            }
                            // ------								
                            st10.executeUpdate("update " + masterProjectTable + " set Allocated='yes' where ProjectId='" + rs2.getString("NewProjectId") + "'");
                            st10.executeUpdate("update " + masterProjectTable + " set Allocated='no' where ProjectId='" + rs2.getString("OldProjectId") + "'");

                            //----------------
                        } else if (rs2.getString("NewProjectId").equals("null")) // Change Supervisor selected
                        {

                            // ----------------- name -------------------------
                            masterProjectTable = streamName + "_project_" + year3;
                            code = programmeName + "_" + "Project_Student" + year3;

                            //----------------- end ---------------------------
                            // --------
                            ResultSet rs3 = (ResultSet) st12.executeQuery("select * from  " + masterProjectTable + " where ProjectId='" + rs2.getString("OldProjectId") + "' ");
                            while (rs3.next()) {
                                // Checking if the supervisor to be changed is Sup1 or Sup2 or Sup3
                                if (rs2.getString("OldFacId").equals(rs3.getString("SupervisorId1"))) {
                                    st10.executeUpdate("update " + masterProjectTable + " set SupervisorId1='" + rs2.getString("NewFacId") + "' where ProjectId='" + rs2.getString("OldProjectId") + "'");
                                } else if (rs2.getString("OldFacId").equals(rs3.getString("SupervisorId2"))) {
                                    st10.executeUpdate("update " + masterProjectTable + " set SupervisorId2='" + rs2.getString("NewFacId") + "' where ProjectId='" + rs2.getString("OldProjectId") + "'");
                                } else if (rs2.getString("OldFacId").equals(rs3.getString("SupervisorId3"))) {
                                    st10.executeUpdate("update " + masterProjectTable + " set SupervisorId3='" + rs2.getString("NewFacId") + "' where ProjectId='" + rs2.getString("OldProjectId") + "'");
                                }

                            }
                            // ----------	

                        }

                    } else if (rs2.getString("Internship").equals("yes")) // Internship case
                    {
                        st10.executeUpdate("update " + streamName + "_project_" + year3 + " set SupervisorId2='" + rs2.getString("NewFacId") + "' where ProjectId='" + rs2.getString("OldProjectId") + "'");

                    }

                }          // Close of Result set of Temp_Reassign_Mtech_MCA_Student

                // ----------------- For Co-Supervisors Present case.. Putting the Deleted Supervisor field to Null ----------
                // ----Mtech ----
                ResultSet rs222 = (ResultSet) st13.executeQuery("select Distinct(Programme_group) from  programme_table");
                while (rs222.next()) {
                    String streamName1 = rs222.getString(1).replace('-', '_');
                    ResultSet rs3 = (ResultSet) st14.executeQuery("select * from  " + streamName + "_project_" + year3 + " ");

                    while (rs3.next()) {
                        int noOfSup = 0;

                        // Deleting only if Number of Supervisors are more than or equal to 2..	
                        if (rs3.getString(3) != null) {
                            noOfSup++;
                        }
                        if (rs3.getString(4) != null) {
                            noOfSup++;
                        }
                        if (rs3.getString(5) != null) {
                            noOfSup++;
                        }

                        if (noOfSup >= 2) {
                            // Checking if the supervisor to be changed is Sup1 or Sup2 or Sup3
                            if (oldfaculty.equals(rs3.getString("SupervisorId1"))) {
                                st10.executeUpdate("update " + streamName1 + "_project_" + year3 + " set SupervisorId1=" + null + " where SupervisorId1='" + oldfaculty + "'");
                            } else if (oldfaculty.equals(rs3.getString("SupervisorId2"))) {
                                st10.executeUpdate("update " + streamName1 + "_project_" + year3 + " set SupervisorId2=" + null + " where SupervisorId2='" + oldfaculty + "'");
                            } else if (oldfaculty.equals(rs3.getString("SupervisorId3"))) {
                                st10.executeUpdate("update " + streamName1 + "_project_" + year3 + " set SupervisorId3=" + null + " where SupervisorId3='" + oldfaculty + "'");
                            }

                        }
                    }
                }

                // ----------	
                // -----------------------Handling of Reassigned PhD Students ----------------------------------
                ResultSet rs5 = (ResultSet) st15.executeQuery("select * from  Temp_Reassign_PhD_Student_" + year3 + " ");
                while (rs5.next()) {
                    ResultSet rs6 = (ResultSet) st16.executeQuery("select * from  PhD_" + year3 + " where StudentId='" + rs5.getString(1) + "' ");
                    rs6.next();
                    if (oldfaculty.equals(rs6.getString("supervisor1"))) {
                        st17.executeUpdate("update  PhD_" + year3 + " set supervisor1='" + rs5.getString("NewFacId") + "' where supervisor1='" + oldfaculty + "'");
                    } else if (oldfaculty.equals(rs6.getString("supervisor2"))) {
                        st17.executeUpdate("update  PhD_" + year3 + " set supervisor2='" + rs5.getString("NewFacId") + "' where supervisor2='" + oldfaculty + "'");
                    }

                }

                // ------------------------End-------------------------
                // Deleting all the temporary tables used during delete faculty process
                st10.executeUpdate("DELETE FROM Temp_Reassign_PhD_Student_" + year + " ");
                st11.executeUpdate("DELETE FROM Temp_Reassign_Mtech_MCA_Student_" + year + " ");
                st12.executeUpdate("DELETE FROM Temp_Reassign_Subject_" + year + " ");
                st18.executeUpdate("delete from faculty_data where ID='" + oldfaculty + "'");

                con.commit();
                con2.commit();
                out.println("<h2><center>Faculty Successfully Deleted.</center</h2>");

            } catch (SQLException e) {
                if (con != null) {
                    con.rollback();
                    System.out.println("Connection1 rollback...");
                }
                if (con2 != null) {
                    con.rollback();
                    System.out.println("Connection2 rollback...");
                }

                e.printStackTrace();
            } finally {
                if (con != null && !con.isClosed()) {
                    con.close();
                }
                if (con2 != null && !con2.isClosed()) {
                    con2.close();
                }
            }

        %>
        <%
          conn.closeConnection();
          con = null;
          conn2.closeConnection();
          con2 = null;
        %>
    </body>
</html>
