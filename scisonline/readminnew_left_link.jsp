<%-- 
    Document   : readminnew_left_link
    Created on : 27 Jan, 2015, 3:38:37 PM
    Author     : nwlab
--%>

<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.ResultSetMetaData"%>
<%@page import="java.util.Calendar"%>
<%@include file="connectionBean.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
    <head>
        <style>
            .style30 {color: #c2000d}
            .style31 {color: white}
            .style32 {color: green}
        </style>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script language="javaScript" type="text/javascript" src="calendar.js"></script>
        <script src="jquery-1.10.2.min.js"></script> 
    </head>
    <body bgcolor="#CCFFFF">
        <% System.out.println( "start of the page********************************************************** dev");%>
<%
        Connection con = conn.getConnectionObj();
        

        //********************************
        Calendar now = Calendar.getInstance();
        int month = now.get(Calendar.MONTH) + 1;
        int cyear = now.get(Calendar.YEAR);

        int year = cyear;

        String semester = "";
        String sem = "", year3 = "", syear = "";

        Statement st1 = con.createStatement();
        Statement st4 = con.createStatement();
        Statement st5 = con.createStatement();
        Statement st7 = con.createStatement();

        int studentsem = 0;
        int studentsem1 = 0;
        
        if (month <= 6) {
            semester = "Winter";
            year = year - 1;
            studentsem1 = 2;
        } else {
            semester = "Monsoon";
            studentsem1 = 1;
        }
        
        int curriculumYear = 0;
        int latestYear = 0;
        int semcount1 = 0;
        ResultSet rs = null;
        String selectstream = null;
        String stream = null;
        String batch = null;
        int k = 0;
        int backCount = 0;

        stream = (String) request.getParameter("stream");
        batch = (String) request.getParameter("batch");
%>


        <table>
            <tr><td><b>Programme : </b></td></tr>
            <tr><td>
                    <select name="stream" id="stream" >
<%
                      //  Statement st1 = (Statement) con.createStatement();
                        ResultSet rs2 = st1.executeQuery("select Programme_name, Programme_group from programme_table where (Programme_status='1' and not Programme_name ='PhD')");
                        if (stream == null || stream == "") {
%>
                            <option value="" selected="selected">--choose--</option>
<%
                            while (rs2.next()) {
%>
                                <option value="<%=rs2.getString(1)%>"><%=rs2.getString(1)%></option>
<%
                            }
                        } else {
%>
                            <option value="">--choose--</option>
<%
                            while (rs2.next()) {
                                if (stream.equals(rs2.getString(1))) {
%>
                                    <option value="<%=rs2.getString(1)%>"  selected="selected"><%=rs2.getString(1)%></option>
<%
                                } else {
%>
                                    <option value="<%=rs2.getString(1)%>"><%=rs2.getString(1)%></option>  
<%
                                }
                            }
                        }
%>
                    </select>
                </td>
            </tr>
        </table>
<%
        if (!(stream == null)) {
%>
        <table>
            <tr><td><b>Batch : </b></td></tr>
            <tr><td>
                    <select name="batch" id="batch" >
<%
                        Statement st_batch = (Statement) con.createStatement();
                        ResultSet rs_batch = st_batch.executeQuery("select yearofjoin from active_batches where pgid = ( select Programme_group from programme_table where  Programme_status='1' and not Programme_name ='PhD' and Programme_name = '"+ stream +"')");
                        if (batch == null || batch == "") {
%>
                            <option value="" selected="selected">--choose--</option>
<%
                            while (rs_batch.next()) {
%>
                                <option value="<%=rs_batch.getString(1)%>"><%=rs_batch.getString(1)%></option>
<%
                            }
                        } else {
%>
                            <option value="">--choose--</option>
<%
                            while (rs_batch.next()) {
                                if (batch.equals(rs_batch.getString(1))) {
%>
                                    <option value="<%=rs_batch.getString(1)%>"  selected="selected"><%=rs_batch.getString(1)%></option>
<%
                                } else {
%>
                                    <option value="<%=rs_batch.getString(1)%>"><%=rs_batch.getString(1)%></option>  
<%
                                }
                            }
                        }
%>
                    </select>
                </td>
            </tr>
        </table>
<%     }
        //Fetch Student Roll numbers
        if (!(stream == null) && !(batch == null)) {
%>
        <form name="frm" id="frm"  method="POST"  target="facultyaction" >
            <table>
                <tr><td><b>Student ID : </b></td></tr>
                <tr><td>
                        <select name="student" id="student">
                            <option value="">--choose--</option>
                            <%//***********************************************************************************%>
<%                          
System.out.println( "start of fetching roll numbers****************************************************** dev");                                   
            
                    selectstream = stream.replace('-', '_');            
System.out.println("stream " + stream + " " + selectstream);

                    //*************************************************************
                    int j = 0;
                    studentsem = studentsem1;
                    studentsem = studentsem - 1;

                    if (studentsem == 1||studentsem == 0) {
                        sem = "I";
                    } else if (studentsem == 2) {
                        sem = "II";
                    } else if (studentsem == 3) {
                        sem = "III";
                    } else if (studentsem == 4) {
                        sem = "IV";
                    } else if (studentsem == 5) {
                        sem = "V";
                    } else if (studentsem == 6) {
                        sem = "VI";
                    } else if (studentsem == 7) {
                        sem = "VII";
                    } else if (studentsem == 8) {
                        sem = "VIII";
                    } else if (studentsem == 9) {
                        sem = "IX";
                    } else if (studentsem == 10) {
                        sem = "X";
                    } else if (studentsem == 11) {
                        sem = "XI";
                    } else if (studentsem == 12) {
                        sem = "XII";
                    } else if (studentsem == 13) {
                        sem = "XIII";
                    } else if (studentsem == 14) {
                        sem = "XIV";
                    } else if (studentsem == 15) {
                        sem = "XV";
                    } else if (studentsem == 16) {
                        sem = "XVI";
                    }

                    //To know latest curriculum for particular batch of programme.
                    ResultSet rs13 = (ResultSet) st7.executeQuery("select * from " + selectstream + "_curriculumversions order by Year desc");
                    while (rs13.next()) {
                        curriculumYear = rs13.getInt(1);
                        if (curriculumYear <= Integer.parseInt(batch)) {
                            latestYear = curriculumYear;
                            break;
                        }
                    }

System.out.println("Semester : " + sem);
                    semcount1 = studentsem;
                    int totalsubjectsinsem = 0;
                    ResultSet rs15 = st4.executeQuery("select * from " + selectstream + "_" + latestYear + "_currrefer where Semester='" + sem + "'");
                    while (rs15.next()) {
                        totalsubjectsinsem = totalsubjectsinsem + (rs15.getInt(2) + rs15.getInt(3) + rs15.getInt(4));
                        totalsubjectsinsem = (totalsubjectsinsem / 2);
                    }
                    
                    ResultSet rs1 = null;
                    rs1 = st1.executeQuery("select * from " + selectstream + "_" + batch + "");
                    
                    ResultSetMetaData rsmd = rs1.getMetaData();
                    int noOfColumns = rsmd.getColumnCount();
                    System.out.println("column : " + noOfColumns);
                        
                    while (rs1.next()) {
                        int temp = (noOfColumns - 2) / 2;
                        int i = 0;
                        int count = 0, count1 = temp;
                        int fail = 0;
                        
                        while (count1 > 0) {
                            int m = i + 3;  //subject index in database
                            if ("F".equals(rs1.getString(m + 1))) {
                                count++;
                            }
                            i = i + 2;
                            count1--;
                        }
                        
                        if (count > totalsubjectsinsem && count != 0) {
//                            System.out.println(selectstream +" "+rs1.getString(1)+" "+count+" "+totalsubjectsinsem);
%>
                            <option value = "<%=rs1.getString(1)%>"><%=rs1.getString(1)%></option>
                            <option hidden id = "<%=rs1.getString(1)%>" value = "<%=count%>"></option>
            
<%
                            k++;
                        }
                    }
%>                          
                            <%//***********************************************************************************%>
                            
                        </select>
                    </td>
                </tr>
            </table>
        </form>
<%
        }
        //Fetching ends here
%>
    </body>
    <script type="text/javascript">
        $( "#stream" ).change(function() { 
            var stream = document.getElementById("stream").value;
            if(stream!==null) {
                if(stream==="")
                    alert("Please choose 'Programme'...!");
                else {
                    parent.readmin_left.location="readminnew_left_link.jsp?stream="+stream;
                }
            }
        });
        
        $( "#batch" ).change(function() { 
            var batch = document.getElementById("batch").value;
            var stream = document.getElementById("stream").value;
            if(batch!==null) {
                if(batch==="")
                    alert("Please choose 'Batch'...!");
                else if(stream ==="") {
                    alert("Please choose 'Programme'...!");
                } else {
                    parent.readmin_left.location="readminnew_left_link.jsp?stream="+stream+"&batch="+batch;
                }
            }
        });
        
        $( "#student" ).change(function() {
            var studentId = document.getElementById("student").value;
            var pname = document.getElementById("stream").value;
            var batch = document.getElementById("batch").value;
            if(studentId!==null) {
                if(studentId==="")
                    alert("Please choose 'Student ID'...!");
                else if(pname ==="") {
                    alert("Please choose 'Programme'...!");
                } else if(batch ==="") {
                    alert("Please choose 'Batch'...!");
                } else { 
                    var count = document.getElementById(studentId).value;
                    window.document.forms["frm"].action = "readminnew2.jsp?batchYear=" + batch + "&studentId=" + studentId + "&pgname=" + pname + "&count=" + count;
                    document.frm.submit();
                }
            }
        });
        
    </script>
<%
        conn.closeConnection();
        con = null;
%>
</html>