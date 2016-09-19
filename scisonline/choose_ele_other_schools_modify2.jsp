<%-- 
    Document   : chooose_ele_other_schools_modify2
--%>
<%@page import="java.util.HashMap"%>
<%@page import="java.io.OutputStream"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.io.FileInputStream"%>
<%@ page import="java.io.*"%>
<%@page import="java.io.File"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@page import="org.apache.poi.hssf.usermodel.HSSFWorkbook"%>
<%@page import="org.apache.poi.hssf.util.HSSFColor"%>
<%@page import="org.apache.poi.ss.usermodel.Workbook"%>
<%@page import="org.apache.poi.ss.usermodel.Font"%>
<%@ page import="org.apache.poi.ss.usermodel.CellStyle"%>
<%@ page import="org.apache.poi.ss.usermodel.IndexedColors"%>
<%@ page import="org.apache.poi.ss.usermodel.Sheet"%>
<%@ page import="org.apache.poi.ss.usermodel.Cell"%>
<%@ page import="org.apache.poi.ss.usermodel.Row"%>
<%@include file="connectionBean.jsp" %>
<%@include file="checkValidity.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <style type="text/css">

            @media print {

                .noPrint
                {
                    display:none;
                }
            }
        </style>


        <style>
            .style30 {color: red}
            .style31 {
                background-color: #c2000d;
                color: white}
            .style32 {color: green}
            .style44{

                background-color: #9FFF9D;
            }




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
            Connection con = conn.getConnectionObj();
            Connection con1 = conn1.getConnectionObj();
            
            Calendar cal = Calendar.getInstance();
            // int year = cal.get(Calendar.YEAR);
            int month = cal.get(Calendar.MONTH);
            // String given_session = "";
            String stream = "";
            // stream = (String) request.getParameter("stream");

            String student_id = request.getParameter("student_id");
            String given_session = request.getParameter("given_session");
            String given_year = request.getParameter("given_year");
            Statement st1 = (Statement) con.createStatement();
            Statement st2 = (Statement) con.createStatement();
            Statement st3 = (Statement) con.createStatement();
            Statement st2_con = (Statement) con.createStatement();
            Statement st3_con = (Statement) con.createStatement();
            Statement st4 = (Statement) con.createStatement();
            Statement st5 = (Statement) con.createStatement();
            Statement st12 = (Statement) con.createStatement();

            Statement st13 = (Statement) con1.createStatement();
            Statement st14 = (Statement) con1.createStatement();

        %>
        <form  action="choose_ele_other_schools_modify_stored.jsp" method="post">

            <h2 align="center" class="style30" > Modify Course Registration </h2>

            <table align="center" border="1"><!-- class="table_pos"-->

                <tr class="fix">

                    <td class="style31" align="center"><b>Student ID</b></td>

                    <td class="style31" align="center"><b>Course 1</b></td>
                    <td class="style31" align="center"><b>Course 2</b></td>
                    <td class="style31" align="center"><b>Course 3</b></td>
                    <td class="style31" align="center"><b>Course 4</b></td>
                    <td class="style31" align="center"><b>Grade Formula</b></td>

                </tr>

                <tr>
                    <td>
                        <select name="student_id" id="student" >



                            <option value="<%=student_id%>" selected="selected"><%=student_id%></option>
                        </select>
                    </td>

                    <%

                        ResultSet rs1_con = null;
                        ResultSet rs2_con = null;
                        rs1_con = (ResultSet) st2_con.executeQuery("select Distinct(Programme_group) from programme_table where (Programme_status='1' and not Programme_name ='PhD')");
                        rs2_con = (ResultSet) st3_con.executeQuery("select * from Other_schools");

                        ResultSet rs2 = (ResultSet) st1.executeQuery("select * from subjecttable order by Subject_Name");
                        int j = 1; // no of students set to one


// Take previous taken courses to modify, and disply in dropdown box
                        //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$
                        //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$                                          

                        for (int i = 1; i <= 4; i++) {

                            ResultSet rs1 = (ResultSet) st2.executeQuery("select Elective" + i + " from Other_Schools_" + given_session + "_" + given_year + " where StudentID='" + student_id + "'");
                            if (rs1.next()) {
                    %>
                    <td>
                        <select name="select<%=Integer.toString(j)%><%=Integer.toString(i)%>" id="select<%=Integer.toString(j)%><%=Integer.toString(i)%>" onchange="duplicate(<%=Integer.toString(i)%>);" style="width:150px;" >
                            <option value="none">none</option>
                            <%
                                while (rs2.next()) {
                                    if (rs2.getString(1).equalsIgnoreCase(rs1.getString(1))) {
                            %>

                            <option value="<%=rs2.getString(1)%>" selected="selected">   <%=rs2.getString(2)%></option>


                            <%
                            } else {

                            %>

                            <option value="<%=rs2.getString(1)%>" >   <%=rs2.getString(2)%></option>


                            <%



                                    }

                                }
                                rs2.beforeFirst();
                            %>

                        </select>
                    </td>    
                    <%
                    } else {
                    %>

                    <td>
                        <select name="select<%=Integer.toString(j)%><%=Integer.toString(i)%>" id="select<%=Integer.toString(j)%><%=Integer.toString(i)%>" onchange="duplicate(<%=Integer.toString(i)%>);" style="width:150px;" >
                            <option selected="selected" value="none">none</option>
                            <%
                                while (rs2.next()) {
                            %>

                            <option value="<%=rs2.getString(1)%>" >   <%=rs2.getString(2)%></option>


                            <% }
                                rs2.beforeFirst();
                            %>
                        </select>
                    </td> 
                    <%
                            }
                        }


                        // take the previous choosen grade formula, and display it in drop down box
                        //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$44
                        //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$44
                        ResultSet rs_grade = (ResultSet) st3.executeQuery("select Grade_Formula from Other_Schools_" + given_session + "_" + given_year + " where StudentID='" + student_id + "'");
                        if (rs_grade.next()) {
                    %>
                    <td>
                        <select name="select<%=Integer.toString(j)%>" id="select<%=Integer.toString(j)%>"  style="width:150px;">

                            <option value="none" >--choose--</option>

                            <%



                                while (rs1_con.next()) {
                                    if (rs_grade.getString(1).equalsIgnoreCase(rs1_con.getString(1))) {
                            %>

                            <option value="<%=rs1_con.getString(1)%>" selected="selected" ><%=rs1_con.getString(1)%></option>

                            <%
                            } else {

                            %>

                            <option value="<%=rs1_con.getString(1)%>"><%=rs1_con.getString(1)%></option>

                            <%
                                    }



                                }


                                while (rs2_con.next()) {
                                    if (rs_grade.getString(1).equalsIgnoreCase(rs2_con.getString(1))) {
                            %>

                            <option value="<%=rs2_con.getString(1)%>" selected="selected" ><%=rs2_con.getString(1)%></option>

                            <%} else {
                            %>

                            <option value="<%=rs2_con.getString(1)%>" ><%=rs2_con.getString(1)%></option>

                            <%
                                    }

                                }



                            %>
                        </select>
                        <%} else {
                        %>
                        <select name="select<%=Integer.toString(j)%>" id="select<%=Integer.toString(j)%>" style="width:150px;">

                            <option value="none" >--choose--</option>

                            <%while (rs1_con.next()) {

                            %>

                            <option ><%=rs1_con.getString(1)%></option>

                            <%
                                }


                                while (rs2_con.next()) {
                            %>

                            <option ><%=rs2_con.getString(1)%></option>

                            <%

                                }



                            %>
                        </select>

                        <%   }


                        %>
                    </td>
                </tr> 
            </table>  

            <table>
                <tr><td>&nbsp;</td></tr>
                <tr><td>&nbsp;</td></tr>
                <tr><td>&nbsp;</td></tr>


            </table>

            <script>
        
            </script>
            <input type="hidden" name="given_session" value="<%=given_session%>">
            <input type="hidden" name="given_year" value="<%=given_year%>"> 

            <table width="100%" class="pos_fixed">
                <tr>

                    <td align="center" class="border"><input type="submit" name="submit" value="SUBMIT" ></td>

                </tr>
            </table>

        </form>
        <script>
            function duplicate(col)
            { 
                
                var select="select1"+col;
                //var student_id=document.getElementById(stu).value ;
                var sub_code=document.getElementById(select).value;
                for(var i=1;i<=4;i++){
                 
                    if(col==i) continue;
                    var select2="select1"+i;
                    var get_sub_code=document.getElementById(select2).value;
                    if(sub_code==get_sub_code){
                        document.getElementById(select).value="none";
                    }
                
                }  
                    
            }
        </script>
        <%
            conn.closeConnection();
            con = null;
            conn1.closeConnection();
            con1 = null;
        %>
    </body>
</html>
