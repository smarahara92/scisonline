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
        <script  type="text/javascript">
            function ValidateValues1(credits, temp)
            {
                //alert(credits);
                var Marks = document.getElementById(temp).value;

                Marks = Marks.replace(/^\s+|\s+$/g, '');

                if (Marks.length == 2)
                {
                    var cap = Marks.toUpperCase();
                    if (cap == "AB")
                    {
                        document.getElementById(temp).value = cap;
                        document.getElementById(temp).style.color = 'black';
                        document.getElementById("xx").disabled = false;
                        return;
                    }
                }
                if (Marks.length == 0)
                {


                    document.getElementById(temp).value = 0;
                    document.getElementById(temp).style.color = 'black';
                    document.getElementById("xx").disabled = false;
                    return;
                }
                var i = 0, j = 0;
                for (i = 0; i < Marks.length; i++)
                {
                    //alert(cmp1.charCodeAt(i));		
                    if (Marks.charCodeAt(i) < 48 || Marks.charCodeAt(i) > 57)
                    {
                        if (Marks.charCodeAt(i) != 46)
                        {

                            // alert(Marks[i]);
                            alert("invalid input");

                            document.getElementById(temp).style.color = 'red';
                            document.getElementById(temp).focus();
                            document.getElementById("xx").disabled = true;

                            return;
                        }
                    }
                }
                document.getElementById(temp).value = Marks;
                if ((Marks > 60 || Marks < 0) && credits > 2)
                {
                    alert("Please enter a value less than or equal to 60");
                    document.getElementById(temp).style.color = 'red';
                    document.getElementById(temp).focus();
                    document.getElementById("xx").disabled = true;
                }
                else if ((Marks > 40 || Marks < 0) && credits <= 2)
                {
                    alert("Please enter a value less than or equal to 40");
                    document.getElementById(temp).style.color = 'red';
                    document.getElementById(temp).focus();
                    document.getElementById("xx").disabled = true;
                }
                else
                {
                    document.getElementById(temp).style.color = 'black';

                    document.getElementById("xx").disabled = false;
                }
            }
        </script>
    </head>
    <body> 
           
        <form action="sup-assessment3.jsp" name="frm" method="post"> 
            <%
                Connection con =conn.getConnectionObj();
                Connection con1 = conn1.getConnectionObj();
                String sname = request.getParameter("subjectname");
                String sid = request.getParameter("subjectid");
                Statement st25 = con.createStatement();
                ResultSet rs25 = st25.executeQuery("select * from subjecttable where Code='" + sid + "'");
                rs25.next();
                String credits = rs25.getString(3);
                System.out.println(sid);
                if (sid == null) {
                    out.println("<center><h2>faculty do not having any subjects</h2></center>");
                    return;
                }
                sid = sid.trim();
            %>
            <table align="center" border="0"  cellspacing="0" cellpadding="0" style="color:blue;background-color:#CCFFFF;" width="80%"> 
                <tr>                             
                    <th>Subject<br/><input type="text" name="subjname" id="subjname" class="style30" value="<%=sname%>" size="25" readonly="readonly" />  

                    </th><th>Code<br/><input type="text" name="subjid" id="subjid" value="<%=sid%>" size="10" readonly="readonly" />    

                    </th>

                </tr>
            </table>
            </br></br>
            <table border="1" cellspacing="5" cellpadding="5" style="color:blue;background-color:#CCFFFF;" align="center">
                <tr>

                    <th>Student ID</th>
                    <th>Student Name</th>
                    <th>Internal</th>
                    <th>Major</th>
                    <th>Oldgrade</th>
                    <th>Supplementary/Improvement</th>
                </tr>
                <%

                    //***************************************
                    try{
                    Calendar now = Calendar.getInstance();

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

                    System.out.println(semester);

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
                            System.out.println("helllooo");
                            rs = st1.executeQuery("select * from " + supptable + " where coursename1='" + sid + "' or coursename2='" + sid + "' or coursename3='" + sid + "' or coursename4='" + sid + "' or coursename5='" + sid + "' or coursename6='" + sid + "'");
                        }

                        int i = 0;
                        while (rs.next()) {   //out.println(rs.getString(1));
                            String assessmenttable = "";
                            System.out.println( rs.getString(1) + "name");
                            for( int i1 = 0;i1<3;i1++)
                            {
                                int year = cyear -i1;
                            if (semester.equals("Monsoon")) {
                                // assessmenttable="Assessment_Winter_"+cyear+"_"+sid;
                                assessmenttable = sid + "_Assessment_Monsoon_" + year + "";//change....................
                            } else {
                                //assessmenttable="Assessment_Monsoon_"+(cyear-1) +"_"+sid;
                                assessmenttable =  sid + "_Assessment_Winter_" + year + "";//change....................
                            }
                          
                          
                            ResultSet rs2 = st2.executeQuery("select * from " + assessmenttable + " where StudentId='" + rs.getString(1) + "'");
                            if (rs2.next() == true) {
                                System.out.println(rs2.getString(1)+"hello");
                %><tr>
                    <td><%=rs2.getString(1)%></td>  
                    <td><%=rs2.getString(2)%></td>
                    <td><%=rs2.getString(8)%></td>
                <input type="hidden" name="sid" value="<%=rs2.getString(1)%>">
                <input type="hidden" name="sname" value="<%=rs2.getString(2)%>">
                <input type="hidden" name="internal" value="<%=rs2.getString(8)%>">
                <input type="hidden" name="supporimprove" value="<%=supporimprove%>">
                <input type="hidden" name="subjid1" value="<%=sid%>">
                <%  if (rs2.getString(6) != null) {


                %>
                <TD><%=rs2.getString(6)%></TD>
                <input type="hidden" name="regular" value="<%=rs2.getString(6)%>">
                <%
                } else {
                %>

                <TD><%=0%></TD>
                <input type="hidden" name="regular" value="<%=0%>">
                <%
                    }
                %>
                <td><%=rs2.getString(7)%></td>
                <%
                    //**********************************************************************
                    ResultSet rs3 = st3.executeQuery("select * from " + supptable + " where studentId='" + rs.getString(1) + "'");
                    ResultSetMetaData rsmd = rs3.getMetaData();
                    int noOfColumns = rsmd.getColumnCount();
                    noOfColumns = noOfColumns - 1;
                    int columns = 2;
                    float marks = 0;
                    if (rs3.next() == true) {
                        while (columns < noOfColumns) {
                            System.out.println(sid+" sup2 " + rs3.getString(columns) );
                            if (sid.equals(rs3.getString(columns))) {
                                if (rs3.getString(columns + 1) != null) {
                                    marks = Float.parseFloat(rs3.getString(columns + 1));
                                }
                                break;
                            }
                            columns = columns + 1;
                        }
                    }

                    //**********************************************************************





                %>

                <%  if (marks != 0) {


                %>
                <TD><input type="text" name="supp" id="<%=Integer.toString(i)%>" value="<%=marks%>" onchange="ValidateValues1(<%=credits%>,<%=Integer.toString(i)%>);"  ></TD>
                    <%
                    } else {
                    %>

                <TD><input type="text" name="supp" id="<%=Integer.toString(i)%>" value="0" onchange="ValidateValues1(<%=credits%>,<%=Integer.toString(i)%>);"  ></TD>
                    <%
                        }
                    %>



                </tr>
                <%
                       break;
                            }
                            
                            }
                             i++;
                        }
                            howmanytimes++;
                        }


                       
                    }
                    catch( Exception e)
                            {
                                
                            }finally{
                                conn.closeConnection();
                                conn1.closeConnection();
                                con = null ;
                                con1 = null;
                            }

                %>

            </table>
            </br>
            </br>
            <center>                 
                <input type="submit" id="xx" align="center" value="Save"  > </center> 
        </form>
    </body>
</html>
