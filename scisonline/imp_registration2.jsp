<%-- 
    Document   : imp_registration2
    Created on : May 20, 2013, 3:59:54 AM
    Author     : root
--%>
<%@include file="checkValidity.jsp"%>

<%@page import="java.util.EmptyStackException"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="dbconnection.jsp" %>
<%@ include file="id_parser.jsp" %>
<%@page import="java.util.Calendar"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script language="javascript">
            function display(total, id)
            {
                //alert(id);
                var i = 1;
                for (i = 1; i <= total; i++)
                {
                    var x = document.getElementById("sub" + i).value;
                    for (j = i + 1; j <= total; j++)
                    {
                        var y = document.getElementById("sub" + j).value;
                        if (x != "none" && y != "none" && x == y)
                        {
                            alert("select any other subject");
                            document.getElementById(id).value = "none";
                            return;
                        }
                    }
                }
            }

            function find(temp)
            {

                var i = 1;
                var j = 0;
                for (i = 1; i <= temp; i++)
                {

                    var x = document.getElementById("sub" + i).value;
                    if (x == "none")
                    {
                        j++;
                    }
                }
                if (j == temp)
                {
                    alert("select atleast one subject");
                    return false;
                }
            }
        </script>
    </head>
    <body>

        <%
            System.out.println("=======================================================");
            Statement st1 = con.createStatement();
            Statement st2 = con.createStatement();
            Statement st3 = con.createStatement();
            Statement st4 = con.createStatement();
            Statement st5 = con.createStatement();
            Statement st6 = con.createStatement();

            String sid = request.getParameter("sid");

            System.out.println(sid);

            int flag2 = 0;
            sid = sid.trim();
            sid = sid.toUpperCase();
            String stream = null;
            String streamtable = null;
            String PROGRAMME_NAME = null;
            String BATCH_YEAR = null;
            String studentName = null;
            try {
                PROGRAMME_NAME = sid.substring(SPRGM_PREFIX, EPRGM_PREFIX);
                BATCH_YEAR = sid.substring(SYEAR_PREFIX, EYEAR_PREFIX);
                ResultSet rs = st6.executeQuery("select Programme_name from programme_table where Programme_code='" + PROGRAMME_NAME + "'");
                if (rs.next()) {
                    stream = rs.getString(1).replace('-', '_');
                } else {
        %>
        <script>
            alert("Invalid student Id.");
        </script>
        <% return;
            }
        } catch (Exception e) {
        %>
        <script>
            alert("Invalid student Id.");
        </script>
        <% return;
            }
            System.out.println(stream);
            System.out.println(PROGRAMME_NAME);
            System.out.println(BATCH_YEAR);
            Calendar now = Calendar.getInstance();

            int month = now.get(Calendar.MONTH) + 1;
            int cyear = now.get(Calendar.YEAR);

            String semester = "";
            String semester1 = "";
            String syear = "20" + BATCH_YEAR;
            System.out.println(syear);
            int curriculumYear = 0;
            int latestYear = 0;


            //****************************************************


            //*****************************************************
            int studentsem = 0;

            try {
                int i = 0, flag = 0;;
                while (i < 2) {
                    streamtable = stream + "_" + syear;
                    System.out.println(streamtable);
                    ResultSet rs1 = st1.executeQuery("select * from " + streamtable + " where StudentId='" + sid + "'");
                    if (rs1.next()) {
                        System.out.println(syear + "===================================================");
                        flag = 1;
                        studentName = rs1.getString(2);
                        break;
                    } else {
                        syear = Integer.toString(Integer.parseInt(syear) + 1);
                        i++;
                    }
                }
                System.out.println(syear + "===================================================");
                if (flag == 0) {
                    throw new Exception();
                }
		int pyear = cyear;
                if (month <= 6) {
                    semester = "Winter";
                    semester1 = "Monsoon";
                    cyear = cyear-1;

                } else {
                    semester = "Monsoon";
                    semester1 = "Winter";
                    
                }

                if (semester.equals("Monsoon")) {

                    int k = pyear - Integer.parseInt(syear);
                    if (k == 0) {
                        studentsem = 1;
                    } else if (k == 1) {
                        studentsem = 3;
                    } else if (k == 2) {
                        studentsem = 5;
                    } else if (k == 3) {
                        studentsem = 7;
                    } else if (k == 4) {
                        studentsem = 9;
                    } else if (k == 5) {
                        studentsem = 11;
                    } else if (k == 6) {
                        studentsem = 13;
                    } else if (k == 7) {
                        studentsem = 15;
                    } else if (k == 8) {
                        studentsem = 17;
                    }
                } else {

                    int k = pyear - Integer.parseInt(syear);
                    if (k == 1) {
                        studentsem = 2;
                    } else if (k == 2) {
                        studentsem = 4;
                    } else if (k == 3) {
                        studentsem = 6;
                    } else if (k == 4) {
                        studentsem = 8;
                    } else if (k == 5) {
                        studentsem = 10;
                    } else if (k == 6) {
                        studentsem = 12;
                    } else if (k == 7) {
                        studentsem = 14;
                    } else if (k == 8) {
                        studentsem = 16;
                    } else if (k == 9) {
                        studentsem = 18;
                    }


                }
                System.out.println(studentsem);
                System.out.println(syear);
        %>
        <form name="frm" action="imp_registration3.jsp" onsubmit="return find('<%=studentsem - 1%>')">
            <table align="center">
                <tr>
                    <td><input type="text" value="<%=sid%>" readonly="yes"/></td>&nbsp;&nbsp;&nbsp;&nbsp;<td><input type="text" value="<%=studentName%>" readonly="yes"></td>
                    <td></td>
                </tr>
            </table>

            <%
                if (studentsem == 1) {
                    throw new EmptyStackException();
                } else {
                    //*************************************************************
%></br><center>

                <%
                    streamtable = stream + "_" + syear;
                    //*****************************************************************************
                    Statement st10 = con.createStatement();

                    st10.executeUpdate("create table if not exists imp_" + semester1 + "_" + cyear + "(studentId varchar(20),coursename1 varchar(20),Marks1 varchar(20),Grade1 varchar(20),"
                            + "                          coursename2 varchar(20),Marks2 varchar(20),Grade2 varchar(20)"
                            + "                          ,coursename3 varchar(20),Marks3 varchar(20),Grade3 varchar(20)"
                            + "                          ,coursename4 varchar(20),Marks4 varchar(20),Grade4 varchar(20)"
                            + "                          ,coursename5 varchar(20),Marks5 varchar(20),Grade5 varchar(20)"
                            + "                          ,coursename6 varchar(20),Marks6 varchar(20),Grade6 varchar(20)"
                            + "                        ,primary key(studentId))");



                    //*****************************************************************************
                    // out.println(stream+"    "+studentsem);

                    //***************************************************************************
                    int flag1 = 0;
                    String checked = "notexist";
                    Statement st11 = con.createStatement();
                    ResultSet rs11 = st11.executeQuery("select * from imp_" + semester1 + "_" + cyear + " where studentId='" + sid + "'");
                    ResultSetMetaData rsmd1 = rs11.getMetaData();
                    int noOfColumns1 = rsmd1.getColumnCount();
                    System.out.println(noOfColumns1 + "--------------------------------------");

                    if (rs11.next() == true) {
                        flag1 = 1;
                    }

                    //**************************************************************************
                    int find = 1;
                    int imp = 2;
                %>
                <input type="hidden" name="studentid" value="<%=sid%>">
                <input type="hidden" name="noofsub"  value="<%=studentsem - 1%>">

                <%
                    int studentsem1 = studentsem;
                    while (find <= 4 && imp < noOfColumns1 - 1) {
                        //*******************************************
                        // System.out.println(imp);
                        if (studentsem1 > 1) {

                            if (flag1 == 1 && rs11.getString(imp) != null) {

                                checked = rs11.getString(imp);
                            }
                %> <b>Improvement <%=find%> :</b>
                <select name="sub" id="sub<%=find%>" onchange="display('<%=studentsem - 1%>', this.id);">
                    <option value="none">none</option>
                    <%
                        ResultSet rs2 = st2.executeQuery("select * from " + streamtable + " where StudentId='" + sid + "'");
                        ResultSetMetaData rsmd = rs2.getMetaData();
                        int noOfColumns = rsmd.getColumnCount();


                        ResultSet rs3 = st3.executeQuery("select * from subject_faculty_" + semester1 + "_" + cyear + "");
                        
                                    ResultSet rs12 = (ResultSet) st5.executeQuery("select * from " + stream + "_curriculumversions order by Year desc");
                                    while (rs12.next()) {
                                        curriculumYear = rs12.getInt(1);
                                        int batchyear = Integer.parseInt(syear);
                                        if (curriculumYear <= batchyear) {

                                            latestYear = curriculumYear;

                                            break;
                                        }
                                    }
                        while (rs3.next()) {
                            int k = 3;
                             Statement stmt = con.createStatement();
                              Statement stmt1 = con.createStatement();
                             ResultSet rs31 = stmt.executeQuery("select SubCode from " + stream + "_" + latestYear + "_curriculum where Alias='" + rs3.getString(1) + "'");
                             String name = "";
                             int flag3=1;
                             if( rs31.next() == true)
                             {
                                 name = rs31.getString(1);
                             }
                             
                             if(!name.equals(""))
                             {
                                 System.out.println( name + " helloo");
                                 String query="select * from subject_faculty_" + semester1 + "_" + cyear + " where subjectid='" + rs31.getString(1)+ "'";
                                 System.out.println(query);
                             ResultSet rs32 = (ResultSet)stmt1.executeQuery(query);
                             if( rs32.next()== true)
                             {
                                 System.out.println("hjfgvJK");
                                flag3=0;
                             }
                             }
                              System.out.println("flag"+ flag3 );
                            rs2.next();
                            while (k < noOfColumns &&flag3!=0) {

                                if ((rs3.getString(1).equals(rs2.getString(k)) ||name.equals(rs2.getString(k))) && "F".equals(rs2.getString(k + 1))) {
                                //    throw new IllegalStateException();
                                } else if ((rs3.getString(1).equals(rs2.getString(k)) ||name.equals(rs2.getString(k))) && "NR".equals(rs2.getString(k + 1)) != true && "A+".equals(rs2.getString(k + 1)) != true) {

                                    String subjid = rs2.getString(k);
                                    String subname = "";
                                    //to know latest curriculum.


                                    ResultSet rs4 = st4.executeQuery("select * from " + stream + "_" + latestYear + "_curriculum where SubCode='" + rs2.getString(k) + "'");

                                    if (rs4.next() == true) {
                                        subjid = rs4.getString("Alias");
                                        if(subjid == null) {
                                            subjid = rs4.getString("SubCode");
                                        }
                                        /*if (rs4.getString(1) != null) {
                                            subjid = rs4.getString(1);
                                        }*/
                                    }

                                    ResultSet rs5 = st5.executeQuery("select * from subjecttable where Code='" + subjid + "'");
                                    if (rs5.next() == true) {
                                        subname = rs5.getString(2);
                                    }

                                    if (checked.equals("notexist") || checked.equals(subjid) != true) {
                    %><option value="<%=subjid%>"><%=subname%></option><%
                    } else {
                    %><option value="<%=subjid%>" selected><%=subname%></option><%
                                    }


                                }
                                k = k + 2;
                            }
                            rs2.beforeFirst();

                        }
                        %></select>
                </br>
                </br>
                <%
                    find++;
                    imp = imp + 3;
                    checked = "notexist";
                    //********************************
                } else {

                    if (flag1 == 1 && rs11.getString(imp) != null) {

                        checked = rs11.getString(imp);
                    }
                %> <b>Improvement <%=find%> :</b>
                <select name="sub" id="sub<%=find%>" onchange="display('<%=studentsem - 1%>', this.id);" disabled="yes">
                    <option value="none">none</option>
                    <%
                        ResultSet rs2 = st2.executeQuery("select * from " + streamtable + " where StudentId='" + sid + "'");
                        ResultSetMetaData rsmd = rs2.getMetaData();
                        int noOfColumns = rsmd.getColumnCount();


                        ResultSet rs3 = st3.executeQuery("select * from subject_faculty_" + semester1 + "_" + cyear + "");

                        while (rs3.next()) {
                            int k = 3;

                            rs2.next();
                            while (k < noOfColumns) {

                                if (rs3.getString(1).equals(rs2.getString(k)) && "F".equals(rs2.getString(k + 1))) {
                                 //   throw new IllegalStateException();
                                    System.out.println(rs3.getString(1)+"Helloooooooooo");
                                } else if (rs3.getString(1).equals(rs2.getString(k)) && "NR".equals(rs2.getString(k + 1)) != true && "A+".equals(rs2.getString(k + 1)) != true) {

                                    String subjid = rs2.getString(k);
                                    String subname = "";
                                    //to know latest curriculum.

                                    ResultSet rs12 = (ResultSet) st5.executeQuery("select * from " + stream + "_curriculumversions order by Year desc");
                                    while (rs12.next()) {
                                        curriculumYear = rs12.getInt(1);
                                        if (curriculumYear <= cyear) {

                                            latestYear = curriculumYear;

                                            break;
                                        }
                                    }

                                    ResultSet rs4 = st4.executeQuery("select * from " + stream + "_" + latestYear + "_curriculum where SubCode='" + rs2.getString(k) + "'");

                                    if (rs4.next() == true) {
                                        subjid = rs4.getString("Alias");
                                        if(subjid == null) {
                                            subjid = rs4.getString("SubCode");
                                        }
                                        /*if (rs4.getString(1) != null) {
                                            subjid = rs4.getString(1);
                                        }*/
                                    }

                                    ResultSet rs5 = st5.executeQuery("select * from subjecttable where Code='" + subjid + "'");
                                    if (rs5.next() == true) {
                                        subname = rs5.getString(2);
                                    }

                                    if (checked.equals("notexist") || checked.equals(subjid) != true) {
                    %><option value="<%=subjid%>"><%=subname%></option><%
                    } else {
                    %><option value="<%=subjid%>" selected><%=subname%></option><%
                                    }


                                }
                                k = k + 2;
                            }
                            rs2.beforeFirst();

                        }
                        %></select>
                </br>
                </br>
                <%
                                    find++;
                                    imp = imp + 3;
                                    checked = "notexist";
                                }
                                studentsem1--;
                            }

                            //************************************************************
                        }
                        flag2 = 1;
                    } catch (IllegalStateException ex) {
                        out.println("<center><h2>Not eligible for improvement</h2></center>");
                        String fwdpage = "notelgible.jsp";
                        response.sendRedirect(fwdpage);
                    } catch (EmptyStackException ex) {
                        out.println("<center><h2>Student Currently in First sem</h2></center>");
                    } catch (Exception e) {
                        out.println("<center><h2>Data not Found</h2></center>");
                    }
                    if (flag2 == 1) {
                %>
                <input type="submit" name="submit" value="submit">
                <%                    }
                %>



                </form>
            </center> 
    </body>
</html>
