<%-- 
    Document   : index_1
    Created on : Feb 14, 2012, 6:59:29 PM
    Author     : jagan
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
        <meta name="GENERATOR" content="RationalÂ® Application Developer for WebSphereÂ® Software">
        <title>JSP Page</title>
        <style>
.style31 {color: #FF0000}
.style32 {color: blue}
</style>
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
    </body>
</html>
