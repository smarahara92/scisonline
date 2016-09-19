<%-- 
    Document   : select_option_staffProjectMCA1
--%>

<%@page import="java.sql.*"%>
<%@include file="connectionBean.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>

        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body bgcolor="#CCFFFF">

        <%      PreparedStatement pst = null;
            try {
                Connection con = conn.getConnectionObj();
           //     int pyear = year;
                
                String pid[] = request.getParameterValues("pid");  // Project Ids
                String studid[] = request.getParameterValues("sid1");  // Student Id 1
                String studid1[] = request.getParameterValues("sid2");  // Student Id 2
                String studid2[] = request.getParameterValues("sid3");  // Student Id 3
                String pyear = request.getParameter("streamYear");

                int k, l = 0, v = 0, i, m = 0, n = 0;
                String code = "";
                String table = "";

                String year2 = pyear;
                code = "MCA" + "_" + "Project_Student_" + pyear;
                table = "MCA" + "_" + year2;

                try {
                    con.setAutoCommit(false);
                    int flag = 0;
                    for (k = 0; k < studid.length && k < studid1.length && k < studid2.length; k++) {

                        //checking if two student field has same student id.....
                        if (studid[k].equalsIgnoreCase("Select Student Id") && studid1[k].equalsIgnoreCase("Select Student Id") && studid2[k].equalsIgnoreCase("Select Student Id")) {

                            l++;

                            if (studid1[k].equalsIgnoreCase("Select Student Id")) {
                                m++;
                            }
                            if (studid2[k].equalsIgnoreCase("Select Student Id")) {
                                n++;         // Counter for blank student ids.
                            }
                        } else {
                            v++;
                            pst = con.prepareStatement("select Allocated from MCA_Project" + "_" + pyear + " where ProjectId=?");
                            pst.setString(1, pid[k]);
                            ResultSet rss = pst.executeQuery();
                            String status = null;
                            if (rss.next()) {
                                status = rss.getString(1);
                            }
                            if (status.equalsIgnoreCase("no")) {
                                if (studid[k] != "Select Student Id") {

                                    pst = con.prepareStatement("update " + code + " set ProjectId='" + pid[k] + "' where StudentId=?");
                                    pst.setString(1, studid[k]);
                                    pst.executeUpdate();
                                    // Changing grade from NR to R in the corresponding Student Master Table.
                                    pst = con.prepareStatement("update " + table + " set p1grade='R' where StudentId=?");
                                    pst.setString(1, studid[k]);
                                    pst.executeUpdate();

                                    pst = con.prepareStatement("update " + code + " set Status='Allocated' where ProjectId=?");
                                    pst.setString(1, pid[k]);
                                    pst.executeUpdate();

                                }

                                if (studid1[k] != "Select Student Id") {

                                    pst = con.prepareStatement("update " + code + " set ProjectId='" + pid[k] + "' where StudentId=?");
                                    pst.setString(1, studid1[k]);
                                    pst.executeUpdate();
                                    // Changing grade from NR to R in the corresponding Student Master Table.
                                    pst = con.prepareStatement("update " + table + " set p1grade='R' where StudentId=?");
                                    pst.setString(1, studid1[k]);
                                    pst.executeUpdate();

                                    pst = con.prepareStatement("update " + code + " set Status='Allocated' where ProjectId=?");
                                    pst.setString(1, pid[k]);
                                    pst.executeUpdate();

                                }

                                if (studid2[k] != "Select Student Id") {

                                    pst = con.prepareStatement("update " + code + " set ProjectId='" + pid[k] + "' where StudentId=?");
                                    pst.setString(1, studid2[k]);
                                    pst.executeUpdate();
                                    // Changing grade from NR to R in the corresponding Student Master Table.
                                    pst = con.prepareStatement("update " + table + " set p1grade='R' where StudentId=?");
                                    pst.setString(1, studid2[k]);
                                    pst.executeUpdate();

                                    pst = con.prepareStatement("update " + code + " set Status='Allocated' where ProjectId=?");
                                    pst.setString(1, pid[k]);
                                    pst.executeUpdate();

                                }

                                pst = con.prepareStatement("update MCA_Project" + "_" + pyear + " set Allocated='yes' where ProjectId=?");
                                pst.setString(1, pid[k]);
                                pst.executeUpdate();
                            } else {
                                flag++;
                                out.println(" Allocation has not done for " + studid[k] + "" + studid1[k] + "" + studid2[k]);
                            }
                            rss.close();
                            pst.close();
                        }

                    }
                    con.commit();
                    if (flag == 0) {
                        out.println("<h2>Student Project Registration successfully completed.</h2>");
                    }
                } catch (Exception ex) {
                    con.rollback();
                    out.println("Some internal error please try again..");
                    System.out.println(ex);
                    System.out.println("Transaction rollback!!!");
                }
                conn.closeConnection();
              con = null;    
            } 
            catch (Exception ex) {
            }
            
        %> 
    </body>
</html>

