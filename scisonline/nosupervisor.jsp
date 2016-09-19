<%-- 
    Document   : nosupervisor
    Created on : 7 May, 2014, 10:12:10 AM
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
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style>
            .var_value
            {
                width: 50px;
                overflow: hidden;
            }

            .style30 {color: #c2000d}
            .style31 {color: white}
            .style32 {color: green}
            .heading
            {
                color: white;
                background-color: #c2000d;
            }
            .border
            {
                background-color: #c2000d;
            }
            .pos_fixed
            {
                position:fixed;
                bottom:0px;
                background-color: #CCFFFF;
                border-color: red;
            }
        </style>
    </head>
    <body>
 
        <%
            //out.println("srinu");
            Calendar now = Calendar.getInstance();
            System.out.println("Current date : " + (now.get(Calendar.MONTH) + 1)
                    + "-"
                    + now.get(Calendar.DATE)
                    + "-"
                    + now.get(Calendar.YEAR));
            int month = now.get(Calendar.MONTH) + 1;
            int cyear = now.get(Calendar.YEAR);
            if (month >= 1 && month <= 6) {
                cyear--;
            }
            Statement st1 = (Statement) con2.createStatement();
            Statement st2 = (Statement) con2.createStatement();
            Statement st_snam = (Statement) con2.createStatement();
            int flag = 0;
            try {
                ResultSet rs1 = st1.executeQuery("select * from PhD_" + cyear + "");
                
                while (rs1.next()) {
                    ResultSet rs_sname=st_snam.executeQuery("select * from  PhD_Student_info_"+cyear+" where StudentId='"+rs1.getString(1)+"'");
          rs_sname.next();
                    if (rs1.getString("supervisor1") == null && rs1.getString("supervisor2") == null && rs1.getString("supervisor3") == null) {
        %>           <table align="center" border="1">
                        <tr  bgcolor="#c2000d">
                            <td align="center" class="style31"><font size="4">Students With No Supervisor </font></td>
                        </tr>   
                    </table>
                    <br>

                <table border="1" cellspacing="5" cellpadding="5" style="color:blue;background-color:#CCFFFF;" align="center">
                <tr>
                    <th>Student ID</th>
                    <th>Student Name</th>
                </tr>
                <tr>
                    <td> <%=rs1.getString("StudentId")%></td>
                    <td><%=rs_sname.getString("StudentName")%></td>
                 </tr>
        <%
                        flag = 1;
                    }
                    rs_sname.close();
                }
                
                st1.close();
                st2.close();
                st_snam.close();
                rs1.close();
                con.close();
                con2.close();
                
            } catch (Exception e) {
                out.println(e);
               }
        %>
    </table>
    <%if (flag == 0) { %>
         <tr><td colspan=2> <h3 style="color: #c2000d" align="center">No student available to whom supervisor is not allocated</h3></td></tr>
    <%  }
    %>
    <table width="100%" class="pos_fixed">
        <tr>
            <td align="center" class="border"> <input  type="button" class="border" value="Print" id="p1" style="width: 50px; color: white; background-color: #6d77d9; border-color: red;" class="noPrint" onclick="window.print();" />
            </td>
        </tr>
    </table>
    </body>
</html>
