<%-- 
    Document   : student_status_view
    Created on : 30 Apr, 2014, 7:53:13 PM
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
<%@include file="dbconnection.jsp"%>  
<%@include file="university-school-info.jsp"%> 
<%@include file="status_array.jsp"%>
<%@include file="id_parser.jsp"%>



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
       <center><b><%=UNIVERSITY_NAME%></b></center>
    <center><b><%=SCHOOL_NAME%></b></center>
    <center><b>Ph.D. students' status</b></center>
    </br></br>
    <table border="1" cellspacing="5" cellpadding="5" style="color:blue;background-color:#CCFFFF;" align="center">
        <tr>
            <th>Student ID</th>
            <th>Student Name</th>
            <th>Status</th>
        </tr>
        <%
           
          //***************************************************
            Statement st1 = con2.createStatement();
            Statement st2 = con2.createStatement();
            Statement st3 = con2.createStatement();
            Statement st_snam = con2.createStatement();
                // this is for current year students but we have to do it for all 12 back students.
            try {
                ResultSet rs = st1.executeQuery("select StudentId from active_students");
                while(rs.next()) {
                   String sid = rs.getString(1);
                   int batchYear = Integer.parseInt(CENTURY + sid.substring(SYEAR_PREFIX, EYEAR_PREFIX)); 
                   ResultSet rs1 = st2.executeQuery("select StudentId, status from  PhD_"+ batchYear +" where StudentId='"+rs.getString(1)+"'");
                   while (rs1.next()) {
                      ResultSet rs_sname = st_snam.executeQuery("select StudentName from  PhD_Student_info_" + batchYear + " where StudentId='" + rs1.getString(1) + "'");
                      rs_sname.next();
        %>             <tr>
                            <td><%=rs1.getString(1)%></td>
                            <td><%=rs_sname.getString(1)%></td>
                            <%  if (rs1.getString(2) != null) {%>
                                    <td><%=rs1.getString(2)%></td>
            <%                  } else {
            %>                      <td></td>
                        </tr><% }
                       rs_sname.close();
                }
                }
                
                
                    st1.close();
                    st2.close();
                    st3.close();
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
