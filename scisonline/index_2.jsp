
    <!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">


<%@page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<html>
    <head>
<style>
.style31 {color: #FF0000}
.style32 {color: blue}
</style>

<script language="javaScript" type="text/javascript" src="calendar.js"></script>
<link href="calendar.css" rel="stylesheet" type="text/css">
<script type=text/javascript>
//setTimeout(' document.location=document.location' ,60000);
</script>

<title>admin</title>
<!--<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1"> -->
<!--<meta name="GENERATOR" content="Rational® Application Developer for WebSphere® Software"> -->
</head>
<body>

<table width="70%" align="center" bgcolor="lightgrey">

	<tr>
		<td>
			<form action="http://localhost:9080/hcu_learners/admin/report_ondateincome.jsp">
      Enter the Date: <input type="text" name="date"><a href="#" onClick="setYears(1947, 2010);showCalender(this, 'date');">
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
    			<input type="submit" name="submit" value="submit">	
    		</form>
		</td>
	</tr>
</table>
</body>
</html>
