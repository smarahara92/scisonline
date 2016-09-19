<%-- 
    Document   : student_status_update1
    Created on : 30 Apr, 2014, 4:52:34 PM
    Author     : srinu
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.io.OutputStream"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.GregorianCalendar"%>
<%@page import="java.io.File"%>
<%@page import="java.util.Calendar"%>
<%@include file="dbconnection.jsp"%>   
<%@include file="university-school-info.jsp"%> 
<%@include file="id_parser.jsp"%> 
<%@include file="programmeRetrieveBeans.jsp"%> 
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style>
            .style30{width:150px;color:#000000}
            .style31 {color: white}
        </style>

        <style type="text/css">
            .pos_fixed
            {
                position:fixed;
                bottom:0px;
                background-color: #CCFFFF;
                border-color: red;
            }
            .head_pos
            {
                position:fixed;
                top:0px;
                background-color: #CCFFFF;
            }
            .menu_pos
            {
                position:fixed;
                top:105px;
                background-color: #CCFFFF;
            }
            .table_pos
            {
                top:200px;
            }
            .border
            {
                background-color: #c2000d;
            }
            .fix
            {   
                background-color: #c2000d;
            }

            td,table
            {
                white-space: nowrap;


            }
        </style>
    </head>
    <body>
        <%
            Calendar now = Calendar.getInstance();

            int month = now.get(Calendar.MONTH) + 1;
            int cyear = now.get(Calendar.YEAR);

            Statement st1 = con2.createStatement();
            Statement st2 = con2.createStatement();
            Statement st3 = con2.createStatement();
            Statement st4 = con2.createStatement();
            Statement st_snam=con2.createStatement(); 

            String totalstudents = request.getParameter("noofstudents");
            String id[] = request.getParameterValues("id");
            String status[] = request.getParameterValues("status");
        %>
    <center><b><%=UNIVERSITY_NAME%></b></center>
    <center><b><%=SCHOOL_NAME%></b></center>
    <center><b>Ph.D. Students status</b></center>
    </br></br>
    <table border="1" cellspacing="5" cellpadding="5" style="color:blue;background-color:#CCFFFF;" align="center">
        <tr>
            <th>Student ID</th>
            <th>Student Name</th>
            <th>Status</th>
        </tr>
        <%
            System.out.println("total students :" + totalstudents);
            int i;
            for (i = 0; i < Integer.parseInt(totalstudents); i++) {
                if (id[i].equals("none") != true) {
                    int BATCH_YEAR = Integer.parseInt(CENTURY + id[i].substring(SYEAR_PREFIX, EYEAR_PREFIX));
                    // get the name of student from coresponding master table.
                    st1.executeUpdate("update PhD_" + BATCH_YEAR + " set status='" + status[i] + "' where StudentId='" + id[i] + "'");
                    if(status[i].equalsIgnoreCase("G") || status[i].equalsIgnoreCase("C") || status[i].equalsIgnoreCase("L") ){
                        st3.executeUpdate("delete from active_students where  StudentId = '"+id[i]+"'");
                    }
                    ResultSet rs_sname=st_snam.executeQuery("select StudentName from  PhD_Student_info_"+BATCH_YEAR+" where StudentId='"+id[i]+"'");
                    ResultSet rs1 = scis.getstatus();
                    if (rs_sname.next()) {
        %>
                        <tr>
                            <td><%=id[i]%></td>
                            <td><%=rs_sname.getString(1)%></td>
                            <td>
        <%                      while(rs1.next()) {
                                    if(status[i].equalsIgnoreCase(rs1.getString(1))) {  %>
                                        <%=rs1.getString(2)%>
        <%                          } else {
                                    }
                            }
        %>                    
                            </td>
                        </tr>

        <%          } else {
        %>
                            <tr>
                                <td><%=id[i]%></td>
                                <td>Name not found</td>
                                <td><%=rs1.getString(2)%></td>
                            </tr>
        <%
                    }
                }
            }
            /**
             * ********************************************************************
             * Display the students and their status
             * *********************************************************************
            */
            try{
                st1.close();
                st2.close();
                st3.close();
                st4.close();
                st_snam.close();
                
            }
            catch(Exception e){
                System.out.println(e);
            }
            finally{
                con.close();
                con2.close();
            }

        %>



    </table>
    <table width="100%" class="pos_fixed">
        <tr>
            <td align="center" class="border"> <input  type="button" class="border" value="Print" id="p1" style="width: 50px; color: white; background-color: #6d77d9; border-color: red;" class="noPrint" onclick="window.print();" />
            </td>
        </tr>
    </table>
</body>
</html>
