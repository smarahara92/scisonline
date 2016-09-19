<%-- 
   Document   : sup_registration1
   Created on : Jul 3, 2013, 5:15:11 PM
   Author     : root
--%>
<%--<%@ include file="dbconnection.jsp" %>--%>
<%@include file = "connectionBean.jsp" %>
<%@page import="java.util.*"%>
<%@page import ="java.sql.* " %>
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

        <%
            Connection con = conn.getConnectionObj();
            try{
            String supp[] = request.getParameterValues("supp");
            String studentId = request.getParameter("studentid");
            String studentName = request.getParameter("studentname");
           
            ResultSet rs = null;
            Calendar now = Calendar.getInstance();

            int month = now.get(Calendar.MONTH) + 1;
            int cyear = now.get(Calendar.YEAR);
            String semester = "";

            if (month <= 6) {
                semester = "Monsoon";
                cyear = cyear-1;
            } else {
                semester = "Winter";
            }
            if (supp == null) {
        %>
        <script type="text/javascript" language="JavaScript">

            alert("choose atleast one student");
            window.location.replace("sup_registration.jsp");
        </script> 

        <%
                return;
            }

            //*********************************************
            Statement st10 = con.createStatement();
            Statement st1 = con.createStatement();
            Statement st2 = con.createStatement();
            Statement st3 = con.createStatement();
            st10.executeUpdate("create table if not exists supp_" + semester + "_" + cyear + "(studentId varchar(20),coursename1 varchar(20),Marks1 varchar(20),Grade1 varchar(20),"
                    + "                          coursename2 varchar(20),Marks2 varchar(20),Grade2 varchar(20)"
                    + "                          ,coursename3 varchar(20),Marks3 varchar(20),Grade3 varchar(20)"
                    + "                          ,coursename4 varchar(20),Marks4 varchar(20),Grade4 varchar(20)"
                    + "                          ,coursename5 varchar(20),Marks5 varchar(20),Grade5 varchar(20)"
                    + "                          ,coursename6 varchar(20),Marks6 varchar(20),Grade6 varchar(20)"
                    + "                          ,coursename7 varchar(20),Marks7 varchar(20),Grade7 varchar(20)"
                    + "                        ,primary key(studentId))");

            //************************************************

        %> 

    <center>
        <center><b>University of Hyderabad</b></center>
        <center><b>School of Computer and Information Sciences</b></center>
        <center><b>List of students  Registered for supplementary in <%=cyear%></b></center>
        </br>


        <table border="1" cellspacing="5" cellpadding="5" style="color:blue;background-color:#CCFFFF;" align="center">
            <tr>

                <th>Student ID</th>
                <th>Registered Subjects</th>
            </tr><%
                HashMap hm = new HashMap();


                int i = 0;
                for (i = 0; i < supp.length; i++) {


                    int flag = 0;
                    String sub = supp[i];
                    ResultSet rs5 = st3.executeQuery("select * from subjecttable where Code='" + sub + "'");
                    String subname = "";
                    if (rs5.next() == true) {
                        subname = rs5.getString(2);
                    }

                    //*******************************************************
                    rs = st1.executeQuery("select * from supp_" + semester + "_" + cyear + " where studentId='" + studentId + "'");
                    ResultSetMetaData rsmd = rs.getMetaData();
                    int noOfColumns = rsmd.getColumnCount();
                    noOfColumns = noOfColumns - 1;
                    if (rs.next() == true) {
                        int columns = 2;
                        while (columns < noOfColumns) {

                            String columvalue = rs.getString(columns);


                            if (rs.getString(columns) == null) {
                                String columnname = rsmd.getColumnName(columns);


                                st2.executeUpdate("update supp_" + semester + "_" + cyear + " set " + columnname + "='" + sub + "' where studentId='" + studentId + "'");
                                break;
                            }

                            if (columvalue.equalsIgnoreCase(sub) == true) {
                                flag=1;
                                break;
                            }

                            columns = columns + 3;
                        }
                    } else {
                        String columnname = rsmd.getColumnName(2);
                        st2.executeUpdate("insert ignore into supp_" + semester + "_" + cyear + "(studentId," + columnname + ") values('" + studentId + "','" + sub + "')");
                    }
                    //*******************************************************
                    //out.println(sid+"                 "+sub+"         "+noOfColumns);
                    if (flag == 1) {
                        continue;
                    }
                }
                Set set = hm.entrySet();
                // Get an iterator
                Iterator it = set.iterator();
                // Display elements
            %>

            <% rs.beforeFirst();
                while (rs.next()) {

            %>
            <tr>
                <td><%=rs.getString(1)%></td>
                <td><%=rs.getString(2)%></td>
            </tr>
            <%
                }

            %>

            </br>
            </br>
            <table align="center" cellspacing="20"><tr><td><div align="center">
                            <input type="button" value="Print" id="p1" style="width: 50px; color: white; background-color: #6d77d9; border-color: red;" class="noPrint" onclick="window.print();" />
                        </div>
                    </td>
            </table>
            </body>
            </html>
            <%
            }catch (Exception e) {
                out.println(e);
            } finally{
              conn.closeConnection();
              con = null;
        }
                %>
