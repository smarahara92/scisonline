<%-- 
    Document   : choose_ele_other_schools_stored
--%>

<%@include file="checkValidity.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="connectionBean.jsp"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
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
                top:300px;
            }
            .border
            {
                background-color: #c2000d;
            }
            .fix
            {   
                background-color: #c2000d;
                color: white;
            }
        </style>
    </head>
    <body>
        <%
            Connection con = conn.getConnectionObj();
            Connection con2 = conn2.getConnectionObj();
            
            String student_id = "";
            String elective_code = "";
            String grade_formula = "";
            String student_index = "sid";
            String column_index = "select";
            String given_session = request.getParameter("given_session");
            String given_year = request.getParameter("given_year");
            String  student_name="";
            Statement st1 = (Statement) con.createStatement();
            Statement st2 = (Statement) con.createStatement();
            Statement st3 = (Statement) con.createStatement();
            Statement st4 = (Statement) con.createStatement();
            Statement st5 = (Statement) con.createStatement();


            Statement st13 = (Statement) con2.createStatement();
            Statement st14 = (Statement) con2.createStatement();

            //st1.executeUpdate("drop table if exists Other_Schools_" + given_session + "_" + given_year);
            st1.executeUpdate("create table if not exists Other_Schools_" + given_session + "_" + given_year + "(StudentID varchar(20),Name varchar(40),Elective1 varchar(20),E1_Grade varchar(20),Elective2 varchar(20),E2_Grade varchar(20),Elective3 varchar(20),E3_Grade varchar(20),Elective4 varchar(20),E4_Grade varchar(20),Grade_Formula varchar(40),primary key(StudentID))");

            // logic for finding number of cols in attendance tables

        Statement st30 = (Statement) con.createStatement();
        ResultSet rs30 = (ResultSet) st30.executeQuery("select *  from session where name ='"+given_session+"'");
        String startdate = "";
        String enddate = "";
        String columns = "";
        int stm = 0, em = 0, sd = 0, ed = 0, finding = 0, gap = 0;

        while(rs30.next()) {
                                finding = 1;
                                
                                startdate = rs30.getDate(2).toString();
                                enddate = rs30.getDate(3).toString();
                                String table_year=(startdate.substring(0, 4));
                                String table_session=rs30.getString(1);
                                
                                String session_year=table_session+table_year;
                                System.out.println("table "+session_year+" given "+given_session+given_year);
                                if(session_year.equalsIgnoreCase(given_session+given_year))
                                {
                                    System.out.println("matched");
                                    rs30.afterLast();
                                stm = Integer.parseInt(startdate.substring(5, 7));
                                em = Integer.parseInt(enddate.substring(5, 7));
                                sd = Integer.parseInt(startdate.substring(8));
                                ed = Integer.parseInt(enddate.substring(8));
                                //System.out.println("lllllllllllllllllllllllllllllllllll"+stm+"  "+em);
                                gap = em - stm;
                                if (gap < 0) {
                                    gap = -gap;
                                }
                                int e = 1;
                                while (e <= gap) {
                                    columns = columns + "Month" + e + " int(20),";
                                    e++;
                                }
                                if (ed - sd > 0) {
                                    columns = columns + "Month" + e + " int(20),";
                                }
                                System.out.println(columns);
                                                }
                            }
            

        %>

        <table align="center" border="1">
            <tr class="fix">

                <td class="style31" align="center"><b>Student ID</b></td>
                <td class="style31" align="center"><b>Name</b></td>
                <td class="style31" align="center"><b>Course 1</b></td>
                <td class="style31" align="center"><b>Course 2</b></td>
                <td class="style31" align="center"><b>Course 3</b></td>
                <td class="style31" align="center"><b>Course 4</b></td>
                <td class="style31" align="center"><b>Grade Formula</b></td>

            </tr>
            <%
                for (int j = 1; j <= 10; j++) {

                    student_id = request.getParameter(student_index + Integer.toString(j));
                     student_name = request.getParameter("sname" + Integer.toString(j));

                    if (student_id != null && student_id.equals("") == false && (student_id.equalsIgnoreCase("--Enter Student Id--") == false)) {
                        //System.out.println("student " + j + " :" + student_id);
                        //(StudentId , StudentName) values('" + rs.getString(1) + "','" + rs.getString(2) + "')");
                        st2.executeUpdate("insert ignore into Other_Schools_" + given_session + "_" + given_year + "(StudentID,Name) values('" + student_id + "' , '"+student_name+"' )");
                        // st12.executeUpdate("insert into " + sub + "_Attendance_" + given_session + "_" + given_year + " (StudentId , StudentName) values('" + rs.getString(1) + "','" + rs.getString(2) + "')");

            %>
            <tr>
                <td>
                    <%=student_id%>  
                </td> 
                <td>
                    <%=student_name%>  
                </td> 

                <%
                    for (int i = 1; i <= 4; i++) {
                        String elective = "Elective" + i;
                        String En_Grade = "E" + i + "_Grade";
                        //System.out.println("sss column " +i+ " electiven "+elective+ "  grade "+En_Grade);
                        elective_code = request.getParameter(column_index + Integer.toString(j) + Integer.toString(i));
                        if (elective_code.equalsIgnoreCase("none") == false) {
                            st2.executeUpdate("update  Other_Schools_" + given_session + "_" + given_year + " set " + elective + "='" + elective_code + "' ," + En_Grade + "='R' where StudentID='" + student_id + "' ");
                            // st4.executeUpdate("update " + stream_table + " set  p1grade = 'R'   where StudentId='" + rs.getString(1) + "'");

/// attendance , assessment tables creation , sending student list to respective tables.
                            st3.executeUpdate("create table if not exists " + elective_code + "_Attendance_" + given_session + "_" + given_year + "(StudentId varchar(20) not null,StudentName varchar(50)," + columns + "cumatten int(20),percentage float,primary key(StudentId))");
                            st13.executeUpdate("create table if not exists " + elective_code + "_Assessment_" + given_session + "_" + given_year + "(StudentId varchar(20) not null,StudentName varchar(50),Minor_1 varchar(5),Minor_2 varchar(5),Minor_3 varchar(5),Major varchar(5),Final varchar(5),InternalMarks varchar(5),TotalMarks varchar(5),primary key(StudentId))");

                            /// sending students to the respective attendance, assessment tables of electives.
                            st4.executeUpdate("insert ignore into " + elective_code + "_Attendance_" + given_session + "_" + given_year + " (StudentId , StudentName) values('" +student_id + "','" + student_name + "')");
                            st14.executeUpdate("insert ignore into " + elective_code + "_Assessment_" + given_session + "_" + given_year + " (StudentId , StudentName) values('" + student_id + "','" + student_name + "')");


                        
                        //System.out.println("column " + i + ": " + elective_code);
                     ResultSet rs_cname= st5.executeQuery(" select Subject_Name from subjecttable where Code='"+elective_code+"'");
                     rs_cname.next();   
                %>
                <td>
                    <%=rs_cname.getString(1)
                    %>  
                </td> 

                <%
                        }else{%>
                    
                        <td>
                    <%=elective_code
                    %>  
                </td> 
                        <%}
                    }
                    grade_formula = request.getParameter("select" + j);
                    st2.executeUpdate("update  Other_Schools_" + given_session + "_" + given_year + " set Grade_Formula='" + grade_formula + "' where StudentID='" + student_id + "' ");

                   // System.out.println("grade : " + grade_formula);
                %>
                <td>
                    <%=grade_formula%>  
                </td> 

                <%


                    }%>
            </tr>
            <%

                }


                System.out.println(given_session + " - " + given_year);
            %>
        </table>
        <%
                conn.closeConnection();
                con = null;
                conn2.closeConnection();
                con2 = null;
        %>
    </body>
</html>
