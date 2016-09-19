<%-- 
    Document   : date
    Created on : Jun 9, 2013, 11:13:58 PM
    Author     : root
--%>

<%@include file="checkValidity.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <html>
    <head>
<script language="javaScript" type="text/javascript" src="calendar.js"></script>
<link href="calendar.css" rel="stylesheet" type="text/css">
<style>
.style30 {color: #c2000d}
.style31 {color: white}
.style32 {color: green}
.heading
{
color: white;
background-color: #c2000d;
}
.border
{
background-color: #c2000d;
}
.pos_fixed
{
position:fixed;
bottom:0px;
background-color: #CCFFFF;
border-color: red;
}
</style>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
</head>
    <body>
       
                 
                	<input type="text"  name="startdate" readonly="readonly"><a href="#" onClick="setYears(2010, 2020);showCalender(this, 'startdate');">
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
                
    </body>
</html>
