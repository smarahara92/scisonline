<%-- 
    Document   : projectRegistrationInterns1
--%>

<%@page import="java.sql.*"%>
<%@include file="programmeRetrieveBeans.jsp"%>
<%@include file="connectionBean.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    </head>
    <body>
    <%
        try {
            Connection con = conn.getConnectionObj();
            
            int p_id = 0, flag = 0;
            
            String[] ptid = request.getParameterValues("pid");              // Project Title
            String[] pgid = request.getParameterValues("pgname");           // ProgrammeName
            String[] streamYear = request.getParameterValues("streamYear"); // Year of joining
            String[] sid = request.getParameterValues("sid");               // Student ID
            String[] cid = request.getParameterValues("cid");               // Company Name
            String[] isid = request.getParameterValues("isid");             // Internal Supervisor
            String[] extsid = request.getParameterValues("exsid");          // External Supervisor
            
            int count = ptid.length;
            PreparedStatement pst = null;
            for (int i = 0; i < count; i++) {
                ptid[i] = ptid[i].trim();
                pgid[i] = pgid[i].trim();
                streamYear[i] = streamYear[i].trim();
                sid[i] = sid[i].trim();
                cid[i] = cid[i].trim();
                isid[i] = isid[i].trim();
                extsid[i] = extsid[i].trim();
                
                //checking for parameter which are coming with garbage data******
                if (ptid[i].equalsIgnoreCase("") || pgid[i].equalsIgnoreCase("Select Programme") || sid[i].equalsIgnoreCase("Select Student Id") || cid[i].equalsIgnoreCase("") || isid[i].equalsIgnoreCase("none") || extsid[i].equalsIgnoreCase("")) {
                    continue;
                }
                //out.println("---"+ptid[i]+":"+pgid[i]+":"+streamYear[i]+":"+sid[i]+":"+cid[i]+":"+isid[i]+":"+extsid[i]+"xxx");
                
                String programmeName = pgid[i].replace('-', '_');
                String streamName = scis.getStreamOfProgramme(programmeName).replace('-', '_');
                
                String table = programmeName + "_" + streamYear[i];
                String code = programmeName + "_" + "Project_" + "Student_" + streamYear[i];
                try {
                    con.setAutoCommit(false);
                    
                    //inserting project details into corresponding project master table*****
                    pst = con.prepareStatement("select * from " + code + " where StudentId=?");
                    pst.setString(1, sid[i]);
                    
                    ResultSet rs2 = pst.executeQuery();
                    if (rs2.next()) {
                        String sup = isid[i];
                        if (sup == null) {
                            sup = "none";
                        }
                        String sup1 = extsid[i];
                        if (sup1 == null) {
                            sup1 = "none";
                        }
                        pst = con.prepareStatement("insert ignore into " + streamName + "_Project" + "_" + streamYear[i] + " (ProjectTitle,SupervisorId1,SupervisorId2,SupervisorId3,Organization,Allocated) values(?,?,?,?,?,?)");
                        pst.setString(1, ptid[i]);
                        pst.setString(2, sup1);
                        pst.setString(3, sup);
                        pst.setString(4, "none");
                        pst.setString(5, cid[i]);
                        pst.setString(6, "yes");
                        pst.executeUpdate();

                        //updating student-project-master table with project id*****
                        pst = con.prepareStatement("select * from " + streamName + "_Project" + "_" + streamYear[i] + " where ProjectTitle=?");
                        pst.setString(1, ptid[i]);
                        ResultSet rs1 = pst.executeQuery();
                        while (rs1.next()) {
                            p_id = rs1.getInt(1);
                        }
                        pst = con.prepareStatement("update " + code + " set ProjectId ='" + p_id + "', Status = 'Allocated' where StudentId=?");
                        pst.setString(1, sid[i]);
                        pst.executeUpdate();
                        
                        //updating student master for p1grade as 'R' (it means project regirstration done to corresponding student)
                        pst = con.prepareStatement("update " + table + " set p1grade='R' where StudentId=?");
                        pst.setString(1, sid[i]);
                        pst.executeUpdate();
                        
                        rs1.close();
                    }
                    rs2.close();
                    con.commit();
                } catch(Exception e) {
                    System.out.println(e);
                    ++flag;
                    con.rollback();
                    out.println("Some internal error please try again...");
                    System.out.println("Transaction rollback!!!");
                }
            }
            if(flag == 0) {
                out.println("<h1><center>Internship Registrations Successfully Completed.</center><h1> ");
            }
            
            pst.close();
            conn.closeConnection();
            con = null;
        } catch (Exception ex) {
            System.out.println(ex);
        }
        scis.close();
%>
    </body>
</html>