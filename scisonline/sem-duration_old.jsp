<%-- 
    Document   : sem-duration_old
--%>
<%@include file="checkValidity.jsp"%>
<%@page import="java.io.OutputStream"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.File"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.Calendar"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <script language="javaScript" type="text/javascript" src="calendar.js"></script>
        <link href="calendar.css" rel="stylesheet" type="text/css">
        <style>
            .style30 {color: #c2000d}
            .style31 {color: white}
            .style32 {color: green}
            .heading {
                color: white;
                background-color: #c2000d;
            }
            .border {
                background-color: #c2000d;
            }
            .pos_fixed {
                position:fixed;
                bottom:0px;
                background-color: #CCFFFF;
                border-color: red;
            }
        </style>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script>
            function fun(){
<%
                String given_session =request.getParameter("current_session");
                String given_year = request.getParameter("year2");
                String status=request.getParameter("status");
                System.out.println("dev" + status);
                if(status!=null) {
                    if((status.equals("error1"))) {
%>
                        alert(" If same year  then start month should be less than end month OR If same year and same month then start date should be less than end" );
<%
                    } else if(status.equals("error2")) {
%>
                        alert(" End year must be greater than or equal to start." );
<%
                    } else if(status.equals("error3")) {
%>
                        alert(" Start and end dates should not be empty" );
<%
                    }
                }
%>
            }
        </script>
    </head>
    <body onload="fun()" bgcolor="#CCFFFF" >
        <table width="100%">
            <tr>
                <th colspan="5" class="style30" align="center"><font size="6">Semester-Duration</font></th>
            </tr>
        </table>
        <form action="sem-duration-stroing.jsp" name="frm1" method="post">
        <table align="center" border="1">
            <tr>
                <th class="heading" align="center">Session</th>
                <th class="heading" align="center">Start Date</th>
                <th class="heading" align="center">End Date</th>
            </tr>
        	<tr>
                    <td class="style30">
                        <select name="current_session">
                            <option value="<%=given_session%>" >  <%=given_session%> </option>
                        </select>
                    </td>
                    <td>                
                	<input type="text"  name="startdate" readonly="readonly">
                        <a href="#" onClick="setYears(<%=given_year%>,<%=given_year%>);showCalender(this, 'startdate');">
                            <img src="calender.png"></a>
      			<table id="calenderTable">
                            <tbody id="calenderTableHead">
                                <tr>
                                    <td colspan="4" align="center">
                                        <select onChange="showCalenderBody(createCalender(document.getElementById('selectYear').value,this.selectedIndex, false));" id="selectMonth">
                                            <option value="0">Jan</option>
                                            <option value="1">Feb</option>
                                            <option value="2">Mar</option>
                                            <option value="3">Apr</option>
                                            <option value="4">May</option>
                                            <option value="5">Jun</option>
                                            <option value="6">Jul</option>
                                            <option value="7">Aug</option>
                                            <option value="8">Sep</option>
                                            <option value="9">Oct</option>
                                            <option value="10">Nov</option>
                                            <option value="11">Dec</option>
                                        </select>
                                    </td>
                                    <td colspan="2" align="center">
                                        <select onChange="showCalenderBody(createCalender(this.value, document.getElementById('selectMonth').selectedIndex, false));" id="selectYear">
                                        </select>
                                    </td>
                                    <td align="center">
                                        <a href="#" onClick="closeCalender();"><font color="#003333" size="+1">X</font></a>
                                    </td>
                                </tr>
                            </tbody>
                            <tbody id="calenderTableDays">
                                <tr style="">
                                    <td>Sun</td><td>Mon</td><td>Tue</td><td>Wed</td><td>Thu</td><td>Fri</td><td>Sat</td>
                                </tr>
                            </tbody>
                            <tbody id="calender"></tbody>
                        </table>
                    </td>
                    <td>
                        <input type="text" name="enddate" readonly="readonly" >
                        <a href="#" onClick="setYears(<%=given_year%>, <%=given_year%>);showCalender(this, 'enddate');showDiv();">
                            <img src="calender.png"></a>
                    </td>
                </tr>
        </table>
        &nbsp;
        <center><input type="submit" name="btnSubmit" id="btnSubmit" value="SUBMIT"></center>
        <%-- i want to send the given_year to next page, by include it in this form as hidden ele. --%>
        <input type="hidden" name="given_year" value="<%=given_year%>">
        </form>
    </body>
</html>