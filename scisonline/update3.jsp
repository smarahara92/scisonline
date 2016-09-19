<%-- 
    Document   : update3
    Created on : Feb 9, 2012, 6:49:55 PM
    Author     : jagan
--%>
<%@include file="checkValidity.jsp"%>
<%@page import="java.io.File"%>
<%@page import="java.sql.*"%>
<%--<%@include file="dbconnection.jsp"%> --%>
<%@include file="connectionBean.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style type="text/css">

            @media print {

                .noPrint
                {
                    display:none;
                }
            }
        </style>
        
        <link rel="stylesheet" type="text/css" href="table_css1.css"> </head>
    </head>
    <body>
        <%            
        
            PreparedStatement pst = null;
            Connection con = conn.getConnectionObj();
            try{
            String year = request.getParameter("year");
            String semester = request.getParameter("semester");
            String pa = request.getParameter("pa1");
            String ca = request.getParameter("ca1");
            int tch = Integer.parseInt(pa) + Integer.parseInt(ca);
            String subjectId = (String) session.getAttribute("subjid");
            String subjectName = (String) session.getAttribute("subjname");
            String sd = (String) session.getAttribute("sd");
            String username = (String) session.getAttribute("facultyid");

            if (username == null) {
                username = "";
            }
            String from = request.getParameter("mySelect");
            String to = request.getParameter("mySelect1");
           
                String saveFile = (String) session.getAttribute("filename");
                pst = con.prepareStatement("drop table if exists temp1");
                pst.executeUpdate();             
                pst = con.prepareStatement("select StudentId,StudentName,month" + sd + ",percentage from " + subjectId + "_Attendance_" + semester + "_" + year + "");
                ResultSet rs1 = pst.executeQuery();
                pst = con.prepareStatement("select cumatten from subject_attendance_" + semester + "_" + year + " where subjectId='" + subjectId + "'");
                ResultSet rs26 = pst.executeQuery();                
              
        %>
        <table align="center" border="0"  cellspacing="5" cellpadding="0" style="color:blue;background-color:#CCFFFF;" width="100%">
            
                <th>Year<br/><input type="text" name="year" value="<%=year%>" size="6" readonly="readonly" /></th>
                <th>From<br/><input type="text" name="from" value="<%=from%>" size="6"  readonly="readonly"/></th>

                <th>To<br/><input type="text" name="to" value="<%=to%>" size="6" readonly="readonly" /></th>
                <th>Semester<br/><input type="text" name="semester" value="<%=semester%>" size="10" readonly="readonly" /></th>

                <th>Subject<br/><input type="text" name="subjname" value="<%=subjectName%>" size="25" readonly="readonly" />                    
                </th>

                <th>Code<br/><input type="text" name="subjid" value="<%=subjectId%>" size="6" readonly="readonly" />                            

                <th>Total Classes<br/><input type="text" name="ca" value="<%=ca%>" size="6" readonly="readonly" />                            
                </th>
           
        </table> 
        &nbsp;&nbsp;
        <table border="1" align="center" class="table">
            <th  align ="center" class="th">Student Id </th>
            <th  width="300" align ="center" class="th">Student Name</th>
            <th   align ="center" class="th">Attended Classes</th>
            <th   align ="center" class="th">Percentage</th>
                <%
                    rs26.next();
                    while (rs1.next()) {
                        float f = (float) rs1.getInt(3) / Integer.parseInt(ca);
                        f = f * 100;
                %>
            <tr>
                <td class="td"><%=rs1.getString(1)%> </td>
                <td class="td"><%=rs1.getString(2)%></td>
                <td class="td"><%=rs1.getInt(3)%></td>
                <td class="td"><%=Math.ceil(f)%></td>
            </tr>
            <%
                    }
                } catch (Exception e) {
                    if(con !=null && pst !=null){
                        pst.close();
                        con.close();
                    }
                }
            finally{
                conn.closeConnection();
                con = null ;
            }
            %>
        </table>
        &nbsp;&nbsp;
        <div align="center">
            <input type="button" value="Print" id="p1" class="noPrint" onclick="window.print();" />
        </div>

    </body>
</html>
