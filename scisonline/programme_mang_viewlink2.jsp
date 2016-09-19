<%-- 
    Document   : programme_mang_viewlink2
    Created on : Nov 2, 2013, 6:12:12 PM
    Author     : veeru
--%>

<%@include file="checkValidity.jsp"%>
<%@ include file="dbconnection.jsp" %>
<%@page import="java.sql.Statement"%>
<%@page import="java.util.Calendar"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style type="text/css">
            .style30 {color: black}
            .style31 {color: white}
            .style32 {color: green}

            #div1
            {

                width:100%;
            }
            .heading
            {
                color: white;
                background-color: #c2000d;
            }
            td,table
            {
                border-collapse:collapse;
                border: 1px solid green;
                white-space:nowrap;
                background-color: #F5F5F5;
                padding: 4px;
            }


        </style>
    </head>
    <body>
        <form>
            <%                try {

                    //retrieving year and pname from programme_mang_view.jsp page
                    String year = request.getParameter("year");
                    String pname = request.getParameter("pname");
                    Statement st = null;
                    Statement st1 = null;
                    Statement st3 = null;
                    Statement st4 = null;
                    Statement st5 = null;

                    try {// Statements creation with checking of dabase connection.

                        st = con2.createStatement();
                        st1 = con2.createStatement();
                        st3 = con2.createStatement();
                        st4 = con2.createStatement();
                        st5 = con2.createStatement();

                    } catch (Exception ex) {//Internal database connection error. Error number:8

                        System.out.println(ex);
            %>
            <script>


                window.open("Project_exceptions.jsp?check=8", "subdatabase");//here check =6 means error number (if condition number.)
            </script>
            <%
                    return;
                }

                ResultSet rs1 = null;
                ResultSet rs2 = null;
                ResultSet rs3 = null;
                ResultSet rs4 = null;
                ResultSet rs5 = null;
                ResultSet rs10 = null;

                pname = pname.replace('-', '_');
                String stream3 = pname.replace('_', '-');
                int curriculumYear = 0, latestYear = 0;
                int v, count = 0, count2 = 0;

                /*
                 * view by yearwise
                 */
                if (!year.equals("All")) {
                    try {

                        int year1 = Integer.parseInt(year);

                        try {
                            rs10 = st4.executeQuery("select * from " + pname + "_curriculumversions order by Year desc");

                        } catch (Exception ex) {//curriculum version not exits.
            %>
            <script>


                window.open("Project_exceptions.jsp?check=7", "subdatabase");//here check =6 means error number (if condition number.)
            </script> 
            <%
                    System.out.println(ex);
                    return;
                }

                while (rs10.next()) {
                    curriculumYear = rs10.getInt(1);
                    if (curriculumYear <= year1) {

                        latestYear = curriculumYear;
                        System.out.println(latestYear);
                        break;
                    }
                }

                try {
                    rs1 = st.executeQuery("select * from " + pname + "_" + latestYear + "_curriculum");

                } catch (Exception ex) {//curriculum table is  not exits.
            %>
            <script>


                window.open("Project_exceptions.jsp?check=9", "subdatabase");//here check =6 means error number (if condition number.)
            </script> 
            <%
                    System.out.println(ex);
                    return;
                }

                rs2 = st1.executeQuery("SELECT COUNT(*) FROM " + pname + "_" + latestYear + "_curriculum");

                rs2.next();
                count = rs2.getInt(1);

                ResultSetMetaData metadata = rs1.getMetaData();
                int columnCount = metadata.getColumnCount();
            %>

            <div id="div1">
                <table border="1" align="center">
                    <caption class="style30"><h3><%=stream3%>-<%=latestYear%>-curriculum</h3></caption>


                    <th class="heading">Course Id</th>
                    <th class="heading">Course Name</th>
                        <%int i = 0;

                            while (rs1.next()) {
                                if (count > i) {

                        %>
                    <tr>
                        <%for (v = 1; v <= columnCount; v++) {
                                if (v == 2) {
                        %>
                        <td><%=rs1.getString(v)%></td>
                        <%} else {%>
                        <td><%=rs1.getString(v)%></td>
                        <%  }
                            }%>
                    </tr>
                    <% i++;

                            }
                        }%> 
                </table>
            </div>


            <% } catch (Exception e) {

                    }

                }

                /*
                 *view all 
                 */
                if (year.equals("All")) {

                    try {
                        String pgrm1;

                        try {
                            rs3 = st3.executeQuery("select * from " + pname + "_curriculumversions");//retrieving curriculum names from curriculum versions table

                        } catch (Exception ex) {//curriculum table is  not exits.
            %>
            <script>


                window.open("Project_exceptions.jsp?check=7", "subdatabase");//here check =6 means error number (if condition number.)
            </script> 
            <%
                    System.out.println(ex);
                    return;
                }

                while (rs3.next()) { //while loop for all curriculums in curriculum versions table
                    String pgrm = rs3.getString(2);
                    pgrm1 = pgrm.replace('_', '-');
            %>
            <div id="div1">
                <table align="center" border="1" >
                    <caption class="style30"><h3><%=pgrm1%></h3></caption>

                    <%

                        try {
                            rs5 = st4.executeQuery("SELECT COUNT(*) FROM " + pgrm + "");//get #records in curriculum

                        } catch (Exception ex) {//curriculum table is  not exits.
                    %>
                    <script>


                        window.open("Project_exceptions.jsp?check=7", "subdatabase");//here check =6 means error number (if condition number.)
                    </script> 
                    <%
                            System.out.println(ex);
                            return;
                        }

                        rs5.next();
                        count2 = rs5.getInt(1);//count2 assigned with #records in curriculum table

                        rs4 = st5.executeQuery("select * from " + pgrm + "");
                        ResultSetMetaData metadata = rs4.getMetaData();
                        int count1 = metadata.getColumnCount();//get #columns in curriculum
                                    /*
                         * table columns as heading for table.
                         */
                    %>
                    <th class="heading">Course Id</th>
                    <th class="heading">Course Name</th>


                    <% int j = 0;
                        while (rs4.next()) {//loop upto all records in curriulum
                            if (count2 > j) {//checking to not allow last null row from curriculum table
                    %>
                    <tr>
                        <%for (v = 1; v <= count1; v++) {%>


                        <td><%=rs4.getString(v)%></td>


                        <%}%>

                    </tr>
                    <%
                                j++;
                            }

                        }
                        rs4.beforeFirst();
                    %> 
                </table> 
            </div>


            <% }

            } catch (Exception e) {
                System.out.println(e);
            %>
            <script>


                window.open("Project_exceptions.jsp?check=7", "subdatabase");//here check =6 means error number (if condition number.)
            </script> 
            <%return;
                    }
                }
                
                rs1.close();
                rs2.close();
                rs3.close();
                rs4.close();
                rs5.close();
                rs10.close();
                st.close();
                st1.close();
                st3.close();
                st4.close();
                st5.close();
                
            } catch (Exception ex) {
                System.out.println(ex);
            %>
            <script>


                window.open("Project_exceptions.jsp?check=7", "subdatabase");//here check =6 means error number (if condition number.)
            </script> 
            <%return;
                }
            %>
        </form> 
        <%
        try {
            con.close();
            con1.close();
            con2.close();
        } catch(Exception e) {
            System.out.println(e);
        } finally {
            con.close();
            con1.close();
            con2.close();
        }
%>      
    </body>
</html>
