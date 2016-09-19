<%-- 
    Document   : electivelist
    Created on : 27 Apr, 2015, 1:31:33 PM
    Author     : deep
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
            Statement st1 = (Statement) con2.createStatement();
            int flag = 0;
            try {
                ResultSet rs1 = st1.executeQuery("select * from PhD_electives");
        %>          <table align="center" border="1">
                        <tr  bgcolor="#c2000d">
                            <td align="center" class="style31"><font size="4">List of elective comprehensives</font></td>
                        </tr>   
                    </table>
                    <br>

                    <table border="1" cellspacing="5" cellpadding="5" style="color:blue;background-color:#CCFFFF;" align="center">
                    <tr>
                        <th>Subject ID</th>
                        <th>Subject Name</th>
                    </tr>
        <%             while(rs1.next()) { 
        %>
                    <tr>
                        <td> <%=rs1.getString("subjectid")%></td>
                        <td><%=rs1.getString("subjectname")%></td>
                    </tr>
        <%            
                    flag = 1;
                }
                st1.close();
                rs1.close();
                con.close();
                con2.close();
                
            } catch (Exception e) {
                out.println(e);
               }
        %>
    </table>
    <%if (flag == 0) { %>
         <tr><td colspan=2> <h3 style="color: #c2000d" align="center">Does not have any elective</h3></td></tr>
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
