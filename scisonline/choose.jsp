<%-- 
    Document   : choose
    Created on : Nov 4, 2011, 10:05:32 AM
    Author     : admin
--%>

<%@include file="checkValidity.jsp"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.*"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.SimpleDateFormat.*"%>
<%@page import="java.io.*"%>
<%@page import="java.text.ParseException.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.sql.*"%>
<%@include file="dbconnection.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        
        <script language="javaScript" type="text/javascript" src="calendar.js"></script>
        <link href="calendar.css" rel="stylesheet" type="text/css">
        <%            PreparedStatement pst = null;
            try {
                String subjectid = request.getParameter("subjectid");
                Calendar now = Calendar.getInstance();

                int month = now.get(Calendar.MONTH) + 1;
                int year = now.get(Calendar.YEAR);

                String semester = "";
                if (month == 7 || month == 8 || month == 9 || month == 10 || month == 11 || month == 12) {
                    semester = "Monsoon";
                } else if (month == 1 || month == 2 || month == 3 || month == 4 || month == 5 || month == 6) {
                    semester = "Winter";
                }

                Statement stat1 = con.createStatement();
                Statement stat2 = con.createStatement();
                Statement stat3 = con.createStatement();

                pst = con.prepareStatement("select * from subject_attendance_" + semester + "_" + year + " where subjectId=?");
                pst.setString(1, subjectid);
                ResultSet rs = pst.executeQuery();

                rs.next();
                int reusing = 1;
                int p = 1;


        %>      
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
           
        <script  type="text/javascript">
          
            function set()
            {
                //alert("laxman");

                var mon1 = document.getElementById("mySelect1").value;
                var mon = mon1.substring(0, 1);
                var total = 0;
                //alert(mon);
                if (mon == 1)
                {
                    document.getElementById("pa").value = 0;
                    var val = <%=rs.getInt(2)%>;
                    if( val > 0)
                    {
                        document.getElementById("ca").value = val;
                    }
                    else
                    {
                        document.getElementById("ca").value = "";
                    }
                }
                else if (mon == 2)
                {
                    document.getElementById("pa").value =<%=rs.getInt(2)%>;
                    var val = <%=rs.getInt(3)%>;
                     if( val > 0)
                    {
                        document.getElementById("ca").value = val;
                    }
                    else
                    {
                        document.getElementById("ca").value = "";
                    }
                }

                else if (mon == 3)
                {
                    document.getElementById("pa").value =<%=rs.getInt(2) + rs.getInt(3)%>;
                    var val = <%=rs.getInt(4)%>;
                     if( val > 0)
                    {
                        document.getElementById("ca").value = val;
                    }
                    else
                    {
                        document.getElementById("ca").value = "";
                    }
                    
                }

                else if (mon == 4)
                {
                    document.getElementById("pa").value =<%=rs.getInt(2) + rs.getInt(3) + rs.getInt(4)%>;
                    var val = <%=rs.getInt(5)%>;
                     if( val > 0)
                    {
                        document.getElementById("ca").value = val;
                    }
                    else
                    {
                        document.getElementById("ca").value = "";
                    }
                   
                }
                else if (mon == 5)
                {
                    document.getElementById("pa").value =<%=rs.getInt(2) + rs.getInt(3) + rs.getInt(4) + rs.getInt(5)%>;
                    var val = <%=rs.getInt(6)%>;
                     if( val > 0)
                    {
                        document.getElementById("ca").value = val;
                    }
                    else
                    {
                        document.getElementById("ca").value = "";
                    }
                }
            }
            function change()
            {

                document.forms.form1.submit();
            }

            function display1(a)
            {
                var mon = a.substring(0, 1);
                document.form1.mySelect2.options.selectedIndex = (mon);
                document.getElementById("ca").disabled = false;
                document.getElementById("ca").select();
                set();
            }
            function display2(a)
            {
                var mon = a.substring(0, 1);
                document.form1.mySelect1.options.selectedIndex = (mon);
                
                set();
                //alert(a);
            }
            // here is your function

            function findTheChecked() {
                var radio_1 = window.document.form1.radio_1;
                var radio_2 = window.document.form1.radio_2;
                alert("llll");
                // the above locates the checkboxes

                if (radio_1.checked == true) { //this finds which one is checked
                    radio_1.checked = false;
                    window.location.replace("browse.jsp"); // change that to the site
                } else {
                    
                    if (radio_2.checked == true) {
                        radio_2.checked = false;
                        window.location.replace("update.jsp");// change that to the other
                    }
                }
            }

            function checked1()
            {
                if (document.getElementById("ca").value > 0)
                {
                    //window.location.replace("browse.jsp");
                    window.document.forms["form1"].action = "browse.jsp";
                    window.document.forms["form1"].submit();

                }
                else
                {
                    window.document.getElementById("radio1").checked = false;
                    alert("Enter the number of hours taught this month");
                    document.getElementById("ca").focus();
                }


            }
            function checked2()
            {
                var a = document.getElementById("ca").value;
                if (a > 0)
                {

                    window.document.forms["form1"].action = "update.jsp";
                    window.document.forms["form1"].submit();
                }
                else
                {
                    window.document.getElementById("radio2").checked = false;
                    alert("Current Month Total Attendance is Invalid");
                    document.getElementById("ca").focus();
                }

            }

            function display2() {
                var cmp1 = document.getElementById("ca").value;
                cmp1 = cmp1.replace(/^\s+|\s+$/g, '');


                document.getElementById("ca").style.backgroundColor = '#FFFFFF';

                document.getElementById("ca").style.color = 'black';


                var i = 0, j = 0;
                for (i = 0; i < cmp1.length; i++)
                {
                    //alert(cmp1.charCodeAt(i));		
                    if (cmp1.charCodeAt(i) < 48 || cmp1.charCodeAt(i) > 57)
                    {
                        alert("invalid input");
                        document.getElementById("ca").style.backgroundColor = '#F4FA58';
                        document.getElementById("ca").style.color = 'red';
                        document.getElementById("ca").focus();
                        document.getElementById("pta").value = "";

                    }
                }



            }



        </script>

    </head>
    <body onload="set();">

        <input type="hidden" id="month" name="month" value="<%=month%>" size="10" readonly="readonly" />

        <%
            try {
                String sname = request.getParameter("subjectname");
                if (sname == null) {
                    sname = "";
                }

                String subjectname = "";


        %>
        <form id="form1" name="form1">


            <table  align="center" border="0" cellspacing="0" cellpadding="0" style="color:blue;background-color:#CCFFFF;" width="97%">
                <tr>
                    <td align="center">Year</td>
                    <td align="center">From</td>
                    <td align="center">To</td>
                    <td align="center">Semester</td>
                    <td align="center">Subject</td>
                    <td align="center">Code</td>
                </tr>
                <tr>
                    <td align="center"><input type="text" name="year" id="year" value="<%=year%>" size="10" readonly="readonly" /></td>
                        <%
                            Statement st30 = con.createStatement();
                            pst = con.prepareStatement("select * from session  where name=?");
                            pst.setString(1, semester);

                            ResultSet rs30 = pst.executeQuery();
                            String startdate = "";
                            String enddate = "";
                            int sm = 0, em = 0, sd = 0, ed = 0, gap = 0, find = 0;
                            while (rs30.next()) {
                                startdate = rs30.getDate(2).toString();
                                enddate = rs30.getDate(3).toString();

                                String table_year = (startdate.substring(0, 4));
                                String table_session = rs30.getString(1);

                                String session_year = table_session + table_year;
                                if (session_year.equalsIgnoreCase(semester + year)) {

                                    rs30.afterLast();
                                    find = 1;
                                }
                            }

                            if (find == 0) {
                                startdate = "";
                                enddate = "";
                            }
                            boolean isLeapYear;
                            isLeapYear = (year % 4 == 0);
                            isLeapYear = isLeapYear && (year % 100 != 0);
                            isLeapYear = isLeapYear || (year % 400 == 0);
                            String e = "28";
                            if (isLeapYear == true) {
                                e = "29";
                            }
                            String[] nameOfMonth = {"Jan", "Feb", "Mar", "Apr",
                                "May", "Jun", "Jul", "Aug", "Sep", "Oct",
                                "Nov", "Dec"};
                            String[] nameOfMonth1 = {"Jan31", "Feb" + e, "Mar31", "Apr30",
                                "May31", "Jun30", "Jul31", "Aug31", "Sep30", "Oct31",
                                "Nov30", "Dec31"};
                            sm = Integer.parseInt(startdate.substring(5, 7));
                            em = Integer.parseInt(enddate.substring(5, 7));

                            gap = em - sm;
                            if (gap < 0) {
                                gap = -gap;
                            }
                            sd = Integer.parseInt(startdate.substring(8));
                            ed = Integer.parseInt(enddate.substring(8));
                            if (ed - sd > 0) {
                                gap = gap + 1;
                            }
                            String startdate1 = nameOfMonth[sm - 1] + sd;
                            String enddate1 = nameOfMonth[em - 1] + ed;

                        %>
                    
                    <td align="center">
                        <select name="mySelect1" id="mySelect1" onchange="display1(this.value)">
                            <option>select</option>
                            <%  
                            int r = 1, l = sm;
                                while (r <= gap) {
                                    if (r == 1 || sd > 5) {
                            %> <option value=<%=Integer.toString(r) + nameOfMonth[l - 1] + sd%>><%=nameOfMonth[l - 1] + sd%></option><%
                            } else {
                            %> <option value=<%=Integer.toString(r) + nameOfMonth[l - 1] + "1"%>><%=nameOfMonth[l - 1] + "1"%></option><%
                                    }
                                    r++;
                                    l++;
                                }
                            %>
                        </select></td>
                    <td align="center"><select name="mySelect2" id="mySelect2" onChange="display2(this.value);">
                             <option>select</option>
                            <%
                                r = 1;
                                l = sm;
                                while (r <= gap) {
                                    if (r == gap) {%><option value=<%=r + nameOfMonth[em - 1] + ed%>><%=nameOfMonth[em - 1] + ed%><%} else {
                                        if (sd <= 5) {
                                %><option value=<%=r + nameOfMonth1[l - 1]%>><%=nameOfMonth1[l - 1]%></option><%
                                } else {
                            %>
                            <option value=<%=r + nameOfMonth[l] + (sd - 1)%>><%=nameOfMonth[l] + (sd - 1)%></option><%}
                                    }
                                    r++;
                                    l++;
                                }
                            %>          

                        </select></td>
                        
                    <td align="center"><input type="text" id="semester" name="semester" value="<%=semester%>" size="10" readonly="readonly" /></td>

                    <td align="center"><input type="text" name="subjname" id="subjname" value="<%=sname%>" size="28" readonly="readonly" /></td>  
                        <% session.setAttribute("subjname", sname);%>
                    <td align="center"><input type="text" name="subjid" id="subjid" value="<%=subjectid%>" size="10" readonly="readonly" /></td>    
                        <%  session.setAttribute("subjid", subjectid);%>


                </tr>
                <%

                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                %>
            </table>

            <br/>
            <%
                String day = "";

                pst = con.prepareStatement("select cumatten from subject_attendance_" + semester + "_" + year + " where subjectId=?");
                pst.setString(1, subjectid);
                ResultSet rs4 = pst.executeQuery();

                pst = con.prepareStatement("select StudentId,StudentName,cumatten,percentage from " + subjectid + "_Attendance_" + semester + "_" + year);
                ResultSet rs1 = pst.executeQuery();

                int total = 0;
                while (rs4.next()) {
                    total = rs4.getInt(1);
                }

            %>

            <table align="center" border="0" style="color:blue;background-color:#CCFF99" cellspacing="10" cellpadding="0" >
                <tr>
                    <td><center>Number of Hours<br/>Taught:</center></td>
                <td>&nbsp;</td>
                <td>Previous Total<input type="text" name="pa" id="pa" value="" readonly="readonly" size="15"/></td>
                <td>&nbsp;</td>
                <td>Current Month<input type="text" name="ca" id="ca" value=""  size="15" disabled="true" onkeydown="if (event.keyCode == 13) { checked2(); return false; } "/></td>
                <td>&nbsp;</td>
                <td><input type="hidden" name="pta" id="pta" value="" readonly="readonly" size="15"/></td>
                  
                </tr>
            </table>
            <% } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    if(pst !=null && con !=null)
                    {
                        pst.close();
                        con.close();
                    }
                }
            %>


            <br/>   
    <%--        <table align="center">
                <tr>
                    <td><input type="radio" name="radio_1"  id="radio2" onclick="checked2()"><b>Update Online</b></td>
                </tr>
            </table>
--%>
        </form>

    </body>

</html>