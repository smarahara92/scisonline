<%-- 
    Document   : sup_registration2
    Created on : Feb 24, 2014, 6:50:48 PM
    Author     : veeru
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%--<%@ include file="dbconnection.jsp" %>--%>
<%@include file = "connectionBean.jsp" %>
<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.Calendar"%>
<!DOCTYPE html>
<html>
    <head>

        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>

        <style>
            .style30{width:150px;color:#000000}
            .style31 {color: white}
        </style>
        <script>

            function check() {

                //var id = document.getElementById("stid").value;
                document.getElementById("errfn").innerHTML="";
                try {
                    var stuid = document.getElementById("stid").value.toUpperCase();
                    var stuname = document.getElementById(stuid).value;
                    var stuindex = document.getElementById("i" + stuid).value;
                    window.document.forms["frm"].action = "sup_registration.jsp?studentid=" + stuid + "&stuname=" + stuname + "&count=" + stuindex; 
                } catch(err) {
                    alert("Enter a valid student ID");
                    window.document.forms["frm"].action = "BlankPage.jsp"
                }

            }

        </script>
    </head>
    <form name="frm"  method="POST" target="adminaction">
        <body bgcolor="#CCFFFF">


            <%
                Connection con = conn.getConnectionObj();
                try{
                HashMap hm = new HashMap();
                HashMap hm1 = new HashMap();
                Calendar now = Calendar.getInstance();

                int month = now.get(Calendar.MONTH) + 1;
                int cyear = now.get(Calendar.YEAR);

                String semester = "";
                int year2 = cyear;
                int year1 = year2;
                int studentsem1 = 0;

                Statement st1 = con.createStatement();
                Statement st2 = con.createStatement();
                Statement st3 = con.createStatement();
                Statement st4 = con.createStatement();
                Statement st5 = con.createStatement();
                Statement st6 = con.createStatement();
                Statement st7 = con.createStatement();
                Statement st8 = con.createStatement();

                if (month <= 6) {
                    semester = "Winter";
                    year2 = cyear - 1;
                    studentsem1 = 2;
                } else {
                    semester = "Monsoon";
                    year2 = cyear - 1;
                    studentsem1 = 1;
                }


                int curriculumYear = 0;
                int latestYear = 0;
                int batchYear = 0;
                String selectstream = null;
                String stream = null;
                ResultSet rs = null;
                ResultSet rs11 = null;
                ResultSet rs111 = null;
                ResultSet rs13 = null;
            %> 
        <center style=" font-weight: bold">Enter Student ID:</center>
            <table align="center">
               
                 <th></th>
                <%
                    int j = 0;
                    int studentsem = 0;


                    rs = st1.executeQuery("select Programme_name, Programme_group from programme_table where (Programme_status='1' and not Programme_name ='PhD')");

                    while (rs.next()) {
                        year1 = year2;
                        System.out.println(year1);
                        selectstream = rs.getString(1).replace('-', '_');
                        stream = rs.getString(2).replace('-', '_');
                        
                        System.out.println(selectstream);
                        //curriculum for programme.
                        int flag = 1;
                        int start = cyear;
                        ResultSet rs12 = (ResultSet) st2.executeQuery("select * from " + selectstream + "_curriculumversions order by Year desc");
                        while (rs12.next()) {
                            curriculumYear = rs12.getInt(1);
                            if (curriculumYear <= cyear && flag!=0 ) {

                                latestYear = curriculumYear;
                                flag = 0;
                                //break;
                            }
                            start = curriculumYear;
                        }

                        //getting batch year for project student
                        rs13 = (ResultSet) st3.executeQuery("select count(*) from " + selectstream + "_" + latestYear + "_currrefer");
                        rs13.next();
                        int rowsCount = rs13.getInt(1);
                        rowsCount = rowsCount / 2;// programme duration

                        int rowsCount1 = rowsCount - 1;
                        batchYear = cyear - rowsCount1;//batch year

                        //*************************************************************
                        j = 0;
                        int semcount = 0, l = 0;
            //            year1 = year1 -1;
                        while (j < rowsCount && start <= year1 ) {
                            ResultSet rs1 = null;

                            rs1 = st4.executeQuery("select * from " + selectstream + "_" + year1 + "");

                            if (l > 0) {
                                if (semester.equals("Moonson")) {

                                    studentsem = studentsem + 2;

                                } else {

                                    studentsem = studentsem + 2;

                                }

                            }

                            while (rs1.next()) {
                                System.out.println(rs1.getString(1));
                                ResultSetMetaData rsmd = rs1.getMetaData();
                                int noOfColumns = rsmd.getColumnCount();
                                int temp = (noOfColumns - 2) / 2;
                                int i = 0;
                                int count = 0;


                                while (temp > 0) {
                                    int m = i + 3;
                                    String F = "F";
                                    if (F.equals(rs1.getString(m + 1))) {
                                        rs11 = st5.executeQuery("select Alias from " + selectstream + "_" + latestYear + "_curriculum where SubCode='" + rs1.getString(m) + "'");
                                        String subjectname = rs1.getString(m);
                                        while (rs11.next()) {
                                            if (rs11.getString(1) != null) {
                                                subjectname = rs11.getString(1);
                                            }
                                        }

                                        if (hm.containsKey(rs1.getString(1)) == true) {
                                            String x = (String) hm1.get(rs1.getString(1));
                                            x = x + " ," + subjectname + "";

                                            hm1.put(rs1.getString(1), x);
                                        } else {

                                            hm.put(rs1.getString(1), rs1.getString(2));
                                            hm1.put(rs1.getString(1), subjectname);
                                        }

                                    }
                                    i = i + 2;
                                    temp--;
                                }

                            }

                            j++;
                            year1--;
                        }
                    }


                    st6.executeUpdate("create table if not exists supp_" + semester + "_" + cyear + "(studentId varchar(20),coursename1 varchar(20),Marks1 varchar(20),Grade1 varchar(20),"
                            + "                          coursename2 varchar(20),Marks2 varchar(20),Grade2 varchar(20)"
                            + "                          ,coursename3 varchar(20),Marks3 varchar(20),Grade3 varchar(20)"
                            + "                          ,coursename4 varchar(20),Marks4 varchar(20),Grade4 varchar(20)"
                            + "                          ,coursename5 varchar(20),Marks5 varchar(20),Grade5 varchar(20)"
                            + "                          ,coursename6 varchar(20),Marks6 varchar(20),Grade6 varchar(20)"
                            + "                          ,coursename7 varchar(20),Marks7 varchar(20),Grade7 varchar(20)"
                            + "                        ,primary key(studentId))");


                    //***********************************************************************************************************
                    Set set = hm.entrySet();
                    // Get an iterator
                    Iterator i = set.iterator();
                    // Display elements
                    int k = 0;
                %>
                <tr>
                    <td>
                        <input type="text" name="studname" id="stid" size = "12" onchange="check();"> 
                                            </td>
                    <%
                        k = 0;
                        Set set1 = hm.entrySet();
                        // Get an iterator
                        Iterator i1 = set.iterator();
                        while (i1.hasNext()) {
                            Map.Entry me = (Map.Entry) i1.next();
                    %> 
                <input type = "hidden" id = "<%= me.getKey() %>" value = "<%= me.getValue() %>">
                <input type = "hidden" id = "i<%= me.getKey() %>" value = "<%= k %>">

                <% k++;
                    }
                %>
                </tr>
            </table>
                <br><br>
                <div id="errfn" style=" color: red"></div>
        </body>
    </form>
</html>
<%}catch (Exception e) {
                out.println(e);
            } finally{
              conn.closeConnection();
              con = null;
        }
                        
  %>
