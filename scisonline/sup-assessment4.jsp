<%-- 
   Document   : supp-assessment2
   Created on : Jul 5, 2013, 12:37:01 PM
   Author     : root
--%>


<%--<%@ include file="dbconnection.jsp" %>--%>
<%@ include file="connectionBean.jsp" %>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import ="javax.sql.*" %>
<%@page import="java.sql.*" %>
<%@page import="java.util.Calendar"%>
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
    </head>
    <body>
                
        <form action="" name="frm" method="post"> 
            <%
                Connection con = conn.getConnectionObj();
                Connection con1 = conn1.getConnectionObj();
                
                String sname = request.getParameter("subjectname");
                String sid = request.getParameter("subjectid");
                String fid = request.getParameter("fid");
                System.out.println(sid);
                if (sid == null) {
                    out.println("<center><h2>faculty do not having any subjects</h2></center>");
                    return;
                }
                sid = sid.trim();
                
                Statement st20 = con.createStatement();
                ResultSet rs20 = st20.executeQuery("select * from subjecttable where Code='" + sid + "'");
                rs20.next();
                String credits = rs20.getString(3);
            %>
            <center><b>University of Hyderabad</b></center>
            <center><b>School of Computer and Information Sciences</b></center>
            <center><b><%=sname%> Subject Assessment</b></center>
            <table align="left" >
                <tr>
                    <td><b>               Course Code : <%=sid%></b></td>

                </tr>   
            </table>
            <table align="right" >
                <tr>
                    <td><b>No of Credits : <%=credits%>                     </b></td>

                </tr>   
            </table>
            </br></br>
            <table border="1" cellspacing="5" cellpadding="5" style="color:blue;background-color:#CCFFFF;" align="center">
                <tr>

                    <th>Student ID</th>
                    <th>Student Name</th>
                    <th>Internal</th>
                    <th>Major</th>
                    <th>Total</th>
                    <th>Grade</th>
                    <th>S/I</th>
                </tr>
                <%






                    //***************************************

                    Calendar now = Calendar.getInstance();

                    System.out.println("Current date : " + (now.get(Calendar.MONTH) + 1)
                            + "-"
                            + now.get(Calendar.DATE)
                            + "-"
                            + now.get(Calendar.YEAR));
                    int month = now.get(Calendar.MONTH) + 1;
                    int cyear = now.get(Calendar.YEAR);
                    String semester = "";
                    String supptable = "";
                    if (month <= 6) {
                         semester = "Monsoon";
                         cyear = cyear -1;
                    } else {
                       
                        semester = "Winter";
                    }



                    Statement st10 = con.createStatement();
                    st10.executeUpdate("create table if not exists imp_" + semester + "_" + cyear + "(studentId varchar(20),coursename1 varchar(20),Marks1 varchar(20),Grade1 varchar(20),"
                            + "                          coursename2 varchar(20),Marks2 varchar(20),Grade2 varchar(20)"
                            + "                          ,coursename3 varchar(20),Marks3 varchar(20),Grade3 varchar(20)"
                            + "                          ,coursename4 varchar(20),Marks4 varchar(20),Grade4 varchar(20)"
                            + "                          ,coursename5 varchar(20),Marks5 varchar(20),Grade5 varchar(20)"
                            + "                          ,coursename6 varchar(20),Marks6 varchar(20),Grade6 varchar(20)"
                            + "                        ,primary key(studentId))");
                    st10.executeUpdate("create table if not exists supp_" + semester + "_" + cyear + "(studentId varchar(20),coursename1 varchar(20),Marks1 varchar(20),Grade1 varchar(20),"
                            + "                          coursename2 varchar(20),Marks2 varchar(20),Grade2 varchar(20)"
                            + "                          ,coursename3 varchar(20),Marks3 varchar(20),Grade3 varchar(20)"
                            + "                          ,coursename4 varchar(20),Marks4 varchar(20),Grade4 varchar(20)"
                            + "                          ,coursename5 varchar(20),Marks5 varchar(20),Grade5 varchar(20)"
                            + "                          ,coursename6 varchar(20),Marks6 varchar(20),Grade6 varchar(20)"
                            + "                          ,coursename7 varchar(20),Marks7 varchar(20),Grade7 varchar(20)"
                            + "                        ,primary key(studentId))");
                    //***************************************
                    Statement st1 = con.createStatement();
                    Statement st2 = con1.createStatement();
                    Statement st3 = con.createStatement();
                    int howmanytimes = 0;
                    String supporimprove = "";
                    while (howmanytimes < 2) {
                        ResultSet rs = null;
                        if (howmanytimes == 0) {
                            supptable = "supp_" + semester + "_" + cyear;
                            supporimprove = "S";
                            rs = st1.executeQuery("select * from " + supptable + " where coursename1='" + sid + "' or coursename2='" + sid + "' or coursename3='" + sid + "' or coursename4='" + sid + "' or coursename5='" + sid + "' or coursename6='" + sid + "' or coursename7='" + sid + "'");
                        } else {
                            supptable = "imp_" + semester + "_" + cyear;
                            supporimprove = "I";
                            rs = st1.executeQuery("select * from " + supptable + " where coursename1='" + sid + "' or coursename2='" + sid + "' or coursename3='" + sid + "' or coursename4='" + sid + "' or coursename5='" + sid + "' or coursename6='" + sid + "'");
                        }

                        int i = 0;
                        while (rs.next()) {   //out.println(rs.getString(1));
                            String assessmenttable = "";
                            for( int i1 = 0;i1<3;i1++)
                            {
                                int year = cyear -i1;
                            if (semester.equals("Monsoon")) {
                                // assessmenttable="Assessment_Winter_"+cyear+"_"+sid;
                                assessmenttable = sid + "_Assessment_Monsoon_" + year + "";//change....................
                            } else {
                                //assessmenttable="Assessment_Monsoon_"+(cyear-1) +"_"+sid;
                                assessmenttable = sid + "_Assessment_Winter_" + year + "";//change....................
                            }
                            ResultSet rs2 = st2.executeQuery("select * from " + assessmenttable + " where StudentId='" + rs.getString(1) + "'");
                            if (rs2.next() == true) {
                %><tr>
                    <td><%=rs2.getString(1)%></td>  
                    <td><%=rs2.getString(2)%></td>
                    <td><%=rs2.getString(8)%></td>


                    <%
                        //**********************************************************************
                        ResultSet rs3 = st3.executeQuery("select * from " + supptable + " where studentId='" + rs.getString(1) + "'");
                        ResultSetMetaData rsmd = rs3.getMetaData();
                        int noOfColumns = rsmd.getColumnCount();
                        noOfColumns = noOfColumns - 1;
                        int columns = 2;
                        float marks = 0;
                        String Grade = "";
                        if (rs3.next() == true) {
                            while (columns < noOfColumns) {
                                if (sid.equals(rs3.getString(columns))) {
                                    if (rs3.getString(columns + 1) != null) {
                                        marks = Float.parseFloat(rs3.getString(columns + 1));
                                        Grade = rs3.getString(columns + 2);
                                    }
                                    break;
                                }
                                columns = columns + 3;
                            }
                        }

                        //**********************************************************************





                    %>


                    <td><%=marks%></td>
                    <td><%=marks + Float.parseFloat(rs2.getString(8))%></td>
                    <td><%=Grade%></td>
                    <td><%=supporimprove%></td>

                </tr>
                <%
                    break;
                            }
                            }
                            i++;
                        }


                        howmanytimes++;
                    }

                %>

            </table>
            </br>
            </br>

            <%
                String qry6 = "select Faculty_Name from faculty_data where ID='" + fid + "'";
                Statement st6 = con.createStatement();
                ResultSet rs6 = st6.executeQuery(qry6);
                rs6.next();
                String fname = rs6.getString(1);
                System.out.println(fname);

            %>
            <table border="0">
                <tr>
                    <td>S: supplementary</td></tr>
                <tr>   <td>I: Improvement</td></tr>


            </table>

            </br>
            </br>
            <table align="left" style="color:blue;background-color:#CCFFFF;">
                <tr>
                    <td><b>Name of the Faculty  :  </b><%=fname%></td>

                </tr>    
                <tr><td><b>Date  : <%=now.get(Calendar.DATE)
                        + "-"
                        + (now.get(Calendar.MONTH) + 1)
                        + "-"
                        + now.get(Calendar.YEAR)%> </b></td></tr>
            </table>
            <table align="right" style="color:blue;background-color:#CCFFFF;">
                <tr>
                    <td><b>Signature of the Faculty</b></td>
                </tr>    


            </table>
            </br>
            </br>
            </br>
            </br>
            <table align="center" style="color:blue;background-color:#CCFFFF;">
                <tr>
                    <td><b>Dean of the School</b></td>
                </tr>    


            </table>
            </br>
            </br>
            <center>                 
                <input type="button" value="Print" id="p1" style="width: 50px; color: white; background-color: #6d77d9; border-color: red;" class="noPrint" onclick="window.print();" />
        </form>
    </body>
</html>
