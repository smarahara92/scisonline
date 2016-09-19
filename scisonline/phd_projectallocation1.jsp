<%-- 
    Document   : phd_projectallocation1
    Created on : Jun 3, 2013, 8:51:28 PM
    Author     : root
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
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
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
            //***************************************************
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

            //*****************************************************
            Statement st1 = con2.createStatement();
            Statement st_snam = con2.createStatement();
            
            String totalstudents = request.getParameter("noofstudents");
            String id[] = request.getParameterValues("id");
            // String title[]=request.getParameterValues("title");
            String type[] = request.getParameterValues("type");
            String sid1[] = request.getParameterValues("sid1");
            String sid2[] = request.getParameterValues("sid2");
            String sid3[] = request.getParameterValues("sid3");
            String org[] = request.getParameterValues("org");
            String esp[] = request.getParameterValues("esp");
            int i = 0, j = 0;
            for (i = 0; i < Integer.parseInt(totalstudents); i++) {
                if (sid1[i].equals("none") != true) {
                    if (type[i].equals("PT") || type[i].equals("FT")) {
                        st1.executeUpdate("update PhD_" + cyear + " set supervisor1='" + sid1[i] + "',ft_pt_ex='" + type[i] + "',organization='uoh',externalsup=null where StudentId='" + id[i] + "'");
                        //System.out.println(sid2[j]);
                        if (sid2[j].equals("none")) {
                            st1.executeUpdate("update PhD_" + cyear + " set supervisor2=null where StudentId='" + id[i] + "'");
                        } else {
                            st1.executeUpdate("update PhD_" + cyear + " set supervisor2='" + sid2[j] + "' where StudentId='" + id[i] + "'");
                        }
                        if (sid3[j].equals("none")) {
                            st1.executeUpdate("update PhD_" + cyear + " set supervisor3=null where StudentId='" + id[i] + "'");
                        } else {
                            st1.executeUpdate("update PhD_" + cyear + " set supervisor3='" + sid3[j] + "' where StudentId='" + id[i] + "'");
                        }
                        j++;
                    } else if (type[i].equals("EX")) {
                        st1.executeUpdate("update PhD_" + cyear + " set supervisor1='" + sid1[i] + "',ft_pt_ex='" + type[i] + "',organization='" + org[i] + "',externalsup='" + esp[i] + "' where StudentId='" + id[i] + "'");
                        st1.executeUpdate("update PhD_" + cyear + " set supervisor2=null where StudentId='" + id[i] + "'");
                        st1.executeUpdate("update PhD_" + cyear + " set supervisor3=null where StudentId='" + id[i] + "'");
                    }
                    // srinivas commenting about adding Status = A, after atleast one supervisor is allocated.
                   // st1.executeUpdate("update PhD_" + cyear + " set status='A' where StudentId='" + id[i] + "'");
                } else {
                    // no supervisor allocated
                    st1.executeUpdate("update PhD_" + cyear + " set supervisor1=null,supervisor2=null,supervisor3=null,ft_pt_ex=null,organization=null,externalsup=null where StudentId='" + id[i] + "'");
                    j++;
                }
            }
            Statement st2 = con2.createStatement();
            ResultSet rs1 = st2.executeQuery("select * from PhD_" + cyear + "");
        %>
    <center><b><%=UNIVERSITY_NAME%></b></center>
    <center><b><%=SCHOOL_NAME%></b></center>
    <center><b>Ph.D. Registration students list</b></center>
    </br></br>
    <table border="1" cellspacing="5" cellpadding="5" style="color:blue;background-color:#CCFFFF;" align="center">

        <tr>
            <th>Student ID</th>
            <th>Student Name</th>
            <th>Registration Type</th>
            <th>Supervisor1</th>
            <th>Supervisor2</th>
            <th>Supervisor3</th>
            <th>Organization</th>
            <th>Ext supervisor</th>
        </tr>
        <%
            Statement st20 = con.createStatement();
            while (rs1.next()) {
                ResultSet rs_sname = st_snam.executeQuery("select * from  PhD_Student_info_" + cyear + " where StudentId='" + rs1.getString(1) + "'");
                rs_sname.next();
        %><tr>
            <td><%=rs1.getString(1)%></td>
            <td><%=rs_sname.getString(2)%></td>
            <%  if (rs1.getString("ft_pt_ex") != null) {%><td><%=rs1.getString("ft_pt_ex")%></td><%} else {%><td></td><%}
            %>
            <%  if (rs1.getString("supervisor1") != null) {
                    ResultSet rs2 = st20.executeQuery("select * from faculty_data where ID='" + rs1.getString("supervisor1") + "'");
                    rs2.next();
            %><td><%=rs2.getString(2)%></td><%
                    } else {%><td></td><%}
            %>
            <%  if (rs1.getString("supervisor2") != null) {
                    ResultSet rs2 = st20.executeQuery("select * from faculty_data where ID='" + rs1.getString("supervisor2") + "'");
                    rs2.next();
            %><td><%=rs2.getString(2)%></td><%
                    } else {%><td></td><%}
            %>
            <%  if (rs1.getString("supervisor3") != null) {
                    ResultSet rs2 = st20.executeQuery("select * from faculty_data where ID='" + rs1.getString("supervisor3") + "'");
                    rs2.next();
            %><td><%=rs2.getString(2)%></td><%
                    } else {%><td></td><%}
            %>
            <%  if (rs1.getString("organization") != null) {%><td><%=rs1.getString("organization")%></td><%} else {%><td></td><%}
            %>
            <%  if (rs1.getString("externalsup") != null) {%><td><%=rs1.getString("externalsup")%></td><%} else {%><td></td><%}
            %>
        </tr>
        <%
                rs_sname = null;
            }
            try{
                st1.close();
                st_snam.close();
                st20.close();
                st2.close();
                rs1 = null;
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
