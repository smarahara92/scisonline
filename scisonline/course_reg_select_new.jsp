<%-- 
    Document   : course_reg_select_new
--%>
<%@include file="checkValidity.jsp"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@include file="connectionBean.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%    String url = "";      %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <style>
            .style30 {color: #c2000d}
            .style31 {color: white}
            .style32 {color: green}
            .style33{color:white}
        </style>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script language="javaScript" type="text/javascript" src="calendar.js"></script>
        <script src="jquery-1.10.2.min.js"></script> 
        <title>Insert title here</title>
    </head>
    <body bgcolor="#CCFFFF"   onload="test()">
<%
        Connection con = conn.getConnectionObj();
        Calendar cal = Calendar.getInstance();
        // int year = cal.get(Calendar.YEAR);
        int month = cal.get(Calendar.MONTH);

        String stream = "";
        stream = (String) request.getParameter("stream");
        String given_session = request.getParameter("given_session");
        String given_year = request.getParameter("given_year");
        
        String s = "";
        int i = 0;
        
        Statement st1 = (Statement) con.createStatement();
%>
        <table>
            <tr>
                <td><font color="#c2000d"><b>Select Stream </b></font></td>
                <td>
                    <select name="stream" id="stream" >
<%
                        ResultSet rs2 = (ResultSet) st1.executeQuery("select * from " + given_session + "_stream where electives='yes'");
                        
                        if (stream == null || stream == "") {
%>
                            <option value="" selected="selected">--choose--</option>
                            <option value="Other" >Other</option>
<%
                            while (rs2.next()) {
%>
                                <option value="<%=rs2.getString(1)%>"><%=rs2.getString(1)%></option>
<%
                            }
                        } else {
%>
                            <option value="">--choose--</option>
                            <option value="Other" >Other</option>
<%
                            while (rs2.next()) {
                                //if(stream!=null)
                                if (stream.equals(rs2.getString(1))) {
%>
                                    <option value="<%=rs2.getString(1)%>" selected="selected"><%=rs2.getString(1)%></option>
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
        ResultSet rs = null;
        if (!(stream == null) && !(stream.equalsIgnoreCase("Other"))) {
            stream = stream.replace('-', '_');
            rs = (ResultSet) st1.executeQuery("select Code, Subject_Name , " + stream + " from subjecttable as a," + given_year + "_" + given_session + "_elective as b where a.Code=b.course_name and b." + stream + "!=0");
%>
            <table>
                <tr><td>&nbsp;</td></tr>
                <tr>
                    <td><font color="#c2000d"><b>Elective List for <%=stream.replace('_', ' ')%></b></font></td>
                </tr>
            </table>
            <table border="1">
                <th align="left" style="font-size:12px;  background-color:blue;color:white ">Subject Name</th>
                <th align="left" style="font-size:12px;  background-color:blue;color:white">Total</th>
                <th align="left" style="font-size:12px;  background-color:blue;color:white" >Over</th>
<%
                int id_val = 1;
                while (rs.next()) {
                    String limit_val1 = "limit1" + id_val;
                    String limit_val2 = "limit2" + id_val;
                    String limit_val3 = "limit3" + id_val;
%>
                    <tr>
                        <td align="left" style="font-size:12px" id= "<%=limit_val1%>"><b> <%=rs.getString(2)%></b></td>
                        <td align="left" style="font-size:12px" id= "<%=limit_val2%>"><b><%=rs.getString(3)%></td>
                        <td align="left" style="font-size:12px" id= "<%=limit_val3%>"> </td>
                    </tr>
<%
                    id_val++;
                }
%>
            </table>
<%
        }
%>
        </br></br>
      
    </body>
    <script type="text/javascript">
        var stream = "Other";
        stream = document.getElementById("stream").value;
        var arr = new Array();
        var arr2 = new Array();
        var arr2names = new Array();
<%
        Statement st7 = con.createStatement();
        // ResultSet rs_course1 = (ResultSet) st7.executeQuery("select course_name, pre_req_1, pre_req_2, pre_req_grade1, pre_req_grade2 , " + stream + " from elective_table where " + stream + "!=0");
        ResultSet rs_course1 = (ResultSet) st7.executeQuery("select course_name, " + stream + " from " + given_year + "_" + given_session + "_elective where " + stream + "!=0");
        while (rs_course1.next()) {
            String code = rs_course1.getString(1);
            String limit = rs_course1.getString(2);
            //System.out.println(code + " limit :" + limit);
%>
            //add key-value pair to hashmap
            arr["<%=code%>"] =<%=limit%>;
            arr2["<%=code%>"] = 0;
            //arr2_names[]         
<%
        }
%>

        $("#stream").change(function() {
            var stream = document.getElementById("stream").value;
            var myurl = "<%=url%>";
            if (stream !== null) {
                if (stream === "")
                    alert("Please choose 'stream'...!");
                else if (stream === "Other") {
                    parent.left.location = "./course_reg_select_new.jsp?given_session=<%=given_session%>&given_year=<%=given_year%> ";
                    //stream = stream.replace('-', '_');
                    parent.act_area.location = "./choose_ele_other_schools.jsp?stream=Other&given_session=<%=given_session%>&given_year=<%=given_year%> ";
                } else {   //stream = stream.replace('-', '_');
                    parent.left.location = "./course_reg_select_new.jsp?stream=" + stream + "&given_session=<%=given_session%>&given_year=<%=given_year%> ";
                    //stream = stream.replace('-', '_');
                    parent.act_area.location = "./choose_ele.jsp?stream=" + stream + "&given_session=<%=given_session%>&given_year=<%=given_year%> ";
                }
            }
        });

        function test() {
            // alert("on load function");
            var code_limits = sessionStorage.getItem("code_limits");
            var old_stream = sessionStorage.getItem("old_stream");
            var send_ele_count = sessionStorage.getItem("send_ele_count");
//            alert("code limit : " + code_limits + ", old stream : " + old_stream + ", send ele count : " + send_ele_count);
<%
            String get_stream = request.getParameter("stream");
            if (get_stream != null) {
                get_stream = get_stream.replace("-", "_");
            }
%>
            var get_stream = "<%=get_stream%>";
            
            // if null dont execute.
            //alert("old vs new "+old_stream+" vs "+get_stream);
            if (!(get_stream === "null") && !(old_stream.localeCompare(get_stream))) {
                // get list of ele and limits from coresponding page, and slipt them into code coresponding limit.
                var parameters = code_limits.substring(1).split("&");
//                  alert("all ele , limits :"+parameters);

                var val = 0;
                //alert("no of ele s"+send_ele_count);
                for (var i = 0; i < send_ele_count; i++) {
                    var limit_val3 = "";
                    var limit_val1 = "";
                    var limit_val2 = "";
                    val = i + 1;
                    limit_val1 = limit_val1.concat("limit1", val);
                    limit_val2 = limit_val2.concat("limit2", val);
                    limit_val3 = limit_val3.concat("limit3", val);
                    // alert(limit_val);
                    // ="limit"+
                    var code_limit = parameters[i].split(":");
                    var code_r = unescape(code_limit[0]);
                    // contains code
                    code_r = code_r.trim();
                    var ele_r = unescape(code_limit[1]); // contains corresponding limit.
                    // alert(code_r+" "+arr[code_r]+" left :"+ele_r);

                    //alert(arr[code_r] +"sri"+code_r+"vas" );
                    if (arr[code_r] === ele_r) {
                        document.getElementById(limit_val3).innerHTML = ele_r;
                        document.getElementById(limit_val1).style.color = "red";
                        document.getElementById(limit_val2).style.color = "red";
                        document.getElementById(limit_val3).style.color = "red";
                    }
                    else {
                        document.getElementById(limit_val3).innerHTML = ele_r;
                    }
                }

            }
        }
    </script>
<%
        conn.closeConnection();
        con = null;
%>  
</html>