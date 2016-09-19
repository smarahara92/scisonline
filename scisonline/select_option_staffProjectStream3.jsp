<%-- 
    Document   : select_option_staffProjectStream3
--%>

<%@page import="java.sql.*"%>
<%@include file="connectionBean.jsp"%>
<%@include file="programmeRetrieveBeans.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    </head>
    <body bgcolor="#CCFFFF">
    <%
    try {
        String fid = (String)session.getAttribute("facid");
        Connection con = conn.getConnectionObj();
        String pid[] = request.getParameterValues("pid");  // Project Ids
        String pname[] = request.getParameterValues("pgname");  //Programme Name
        String studid[] = request.getParameterValues("sid1");  // Student Ids
        
        String streamName = (String) session.getAttribute("projectStreamName");
        streamName = streamName.replace('-', '_');
        String pyear = request.getParameter("streamYear");

//        out.println("***"+streamName + ":"+pyear+"***");
                
        PreparedStatement pst = null;
        int flag = 0;
                    
        for (int k = 0; k < studid.length; k++) {
  //          out.println("---"+pid[k] + ":"+pname[k]+":"+studid[k]+"xxx");
            pid[k] = pid[k].trim();
            pname[k] = pname[k].trim();
            studid[k] = studid[k].trim();
            System.out.println(studid[k] + " " + pname[k] + " " + pid[k]);
            System.out.println(studid[k].equalsIgnoreCase("Select Student ID"));
            System.out.println(pname[k].equalsIgnoreCase("Select Programme"));
            System.out.println(pid[k] == null);
            if (studid[k].equalsIgnoreCase("none") || pname[k].equalsIgnoreCase("none") || pid[k] == null) {
                flag = 1;
                continue;
            }
           
            String programmeName = pname[k].replace('-', '_');
            
            String code = programmeName + "_" + "Project_Student_" + pyear;
            String table1 = programmeName + "_" + pyear;
            
            if (studid[k] != "none") {
                con.setAutoCommit(false);
                try {
                    pst = con.prepareStatement("select Allocated from " + streamName + "_Project" + "_" + pyear + " where ProjectId=?");
                    pst.setString(1, pid[k]);
                    
                    ResultSet rs = pst.executeQuery();
                    String status = null;
                    
                    if (rs.next()) {
                        status = rs.getString(1);
                    }
                    if (status.equalsIgnoreCase("no")) {
                        pst = con.prepareStatement("update " + code + " set ProjectId='" + pid[k] + "' where StudentId=?");
                        pst.setString(1, studid[k]);
                        pst.executeUpdate();
                        
                        // Changing grade from NR to R in the corresponding Student Master Table.
                        pst = con.prepareStatement("update " + table1 + " set p1grade='R' where StudentId=?");
                        pst.setString(1, studid[k]);
                        pst.executeUpdate();
                        pst = con.prepareStatement("update " + streamName + "_Project" + "_" + pyear + " set Allocated='yes' where ProjectId=?");
                        pst.setString(1, pid[k]);
                        pst.executeUpdate();
                        pst.setString(1, pid[k]);
                        pst.executeUpdate();
                    } else {
                        flag = 1;
                        out.println("Allocation not done for " + studid[k]);
                    }
                    con.commit();
                } catch(Exception ex) {
                    con.rollback();
                    out.println("Some internal error please try again...");
                    //System.out.println(ex);
                    //System.out.println("Transaction rollback!!!");
                    return;
                }
                //  rs.close();
            }
        }
        if (flag == 0) {
            out.println("<h2>Project Allocation successfully completed.</h2>");
        } else {
            RequestDispatcher rd = request.getRequestDispatcher("select_option_staffProjectStream2.jsp?fid=" + fid);
            rd.forward(request, response);
        }
        pst.close();
        conn.closeConnection();
        con = null;
    } catch (Exception ex) {
        //System.out.println(ex);
    }
    
%>
    </body>
</html>
