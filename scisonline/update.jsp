<%-- 
    Document   : update.jsp
    Created on : Aug 30, 2011, 6:36:01 AM
    Author     : admin
--%>
<%--<%@include file="checkValidity.jsp"%>--%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.sql.*"%>
<%--<%@include file="dbconnection.jsp"%>--%>
<%@include file="connectionBean.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%    int i = 1;
%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link href="button.css" rel="stylesheet" type="text/css">
        <style type="text/css">
            .style30 {color: black}
            .style31 {color: white}
            .style32 {color: green}
            .caption{
                font-weight: bold;
            }

            .th
            {
                color: white;
                background-color: #c2000d;
            }
            .heading1
            {
                color: white;
                background-color:#003399;
            }
            .td
            {
                border-collapse:collapse;
                border: 1px solid green;
                white-space:nowrap;
                background-color: #F5F5F5;
                padding: 4px;

            }
            .table
            {
                border-collapse:collapse;
                border: 1px solid green;
                white-space:nowrap;
                background-color: #F5F5F5;
                padding: 4px;

            }

            .td2
            {
                border-collapse:collapse;
                border: 1px solid green;
                white-space:nowrap;
                background-color: #F5F5F5;
                padding: 4px;
                color: #003399;
            }
            .td3
            {
                border-collapse:collapse;
                border: 1px solid green;
                white-space:nowrap;
                background-color: blue;
                padding: 4px;
            }



            @media print {

                .noPrint
                {
                    display:none;
                }
            }
        </style>
        <script>
             
             
             function disableEnterKey(e){
               var key ;
               if(window.event){
                   key= window.event.keycode;
               }
               else 
                   key = e.which;
               return(key != 13);
           }
            function dothis(temp)
            {
                var cmp1 = document.getElementById(temp).value;
                var cmp2 = document.frm.elements[7].value;
                cmp1 = cmp1.replace(/^\s+|\s+$/g, '');

                if (cmp1.length == 0)
                {
                    document.getElementById(temp).style.backgroundColor = '#FFFFFF';
                    document.getElementById(temp).value = '0';
                    document.getElementById(temp).style.color = 'black';
                    document.getElementById("xx").disabled = false;
                    return;
                }

                var i = 0, j = 0;
                for (i = 0; i < cmp1.length; i++)
                {
                    //alert(cmp1.charCodeAt(i));		
                    if (cmp1.charCodeAt(i) < 48 || cmp1.charCodeAt(i) > 57)
                    {
                        alert("invalid input");
                        document.getElementById(temp).style.backgroundColor = '#F4FA58';
                        document.getElementById(temp).style.color = 'red';
                        document.getElementById(temp).focus();
                        document.getElementById("xx").disabled = true;
                        return;
                    }
                }

                document.getElementById(temp).value = cmp1;
                cmp1 = parseInt(cmp1);
                cmp2 = parseInt(cmp2);
                if (cmp2 >= cmp1)
                {
                    document.getElementById(temp).style.backgroundColor = '#FFFFFF';
                    document.getElementById(temp).style.color = 'black';
                    document.getElementById(temp).focus();
                    document.getElementById("xx").disabled = false;

                }
                else
                if (cmp2 < cmp1)
                {
                    document.getElementById(temp).style.backgroundColor = '#F4FA58';
                    alert("Number of hours attended exceeds the number of hours taught");
                    document.getElementById(temp).style.color = 'red';

                    document.getElementById(temp).focus();
                    document.getElementById("xx").disabled = true;
                }
                else
                {
                    alert("Not a valid input");
                }

            }
            function pta()
            {
                var str3 = eval(document.frm.elements[6].value);
                var str4 = eval(document.frm.elements[7].value);
                var str5 = str3 + str4;
                document.frm.elements[8].value = str5;
                return;
            }




            function display()
            {



                var str1;
                var str2;
                var str;
                var str6;
                var i = 9;
                var j = 0;
                var str3 = eval(document.frm.elements[6].value);
                var str4 = eval(document.frm.elements[7].value);
                var str5 = str3 + str4;
                document.frm.elements[8].value = str5;
                while (document.frm.elements[i + 1].value)
                {

                    //document.write(" ");
                    str1 = eval(document.frm.elements[i].value);
                    str2 = eval(document.frm.elements[i + 1].value);
                    str = str1 + str2;
                    document.frm.elements[i + 2].value = str;
                    str6 = (str / str5) * 100;
                    document.frm.elements[i + 3].value = str6;
                    i = i + 4;
                }

            }


            function display1()
            {
                if (document.frm.mySelect.options[0].selected)
                    document.frm.mySelect1.options.selectedIndex = (0);
                if (document.frm.mySelect.options[1].selected)
                    document.frm.mySelect1.options.selectedIndex = (1);
                if (document.frm.mySelect.options[2].selected)
                    document.frm.mySelect1.options.selectedIndex = (2);
                if (document.frm.mySelect.options[3].selected)
                    document.frm.mySelect1.options.selectedIndex = (3);
                if (document.frm.mySelect.options[4].selected)
                    document.frm.mySelect1.options.selectedIndex = (4);
            }
            function display3() {
                var pratt = document.getElementById("pa").value;
                var curatt = document.getElementById("ca").value;
                var tot = parseInt(pratt) + parseInt(curatt);
                document.getElementById("pta").value = tot;



            }

            function display2() {
                var cmp1 = document.getElementById("ca").value;
                cmp1 = cmp1.replace(/^\s+|\s+$/g, '');


                document.getElementById("ca").style.backgroundColor = '#FFFFFF';

                document.getElementById("ca").style.color = 'black';
                document.getElementById("xx").disabled = false;

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
                        document.getElementById("xx").disabled = true;
                        return;
                    }
                }

                display3();

            }


            function disp() {

                //**************************************
                var flag3 = 0;
                var q = document.getElementById("ca").value;
                q = parseInt(q);
                var q1 = 0;


                var chks = document.getElementsByName('pq1'); //here rr[] is the name of the textbox

                for (var i = 0; i < chks.length; i++)

                {
                    document.getElementById(i).style.backgroundColor = '#FFFFFF';
                    document.getElementById(i).style.color = '#424242';


                    q1 = parseInt(chks[i].value);
                    if (q1 > q)
                    {
                        flag3++;

                        document.getElementById(i).style.color = 'red';
                        document.getElementById(i).style.backgroundColor = '#F4FA58';



                    }
                }


                if (flag3 > 0) {

                    alert("Number of hours attended exceeds the number of hours taught");

                    return false;
                } else {
                    return true;
                }

                //****************************************


            }
        </script>
    </head>
    <body>

        <%
            try {
                PreparedStatement pst = null;
                String year = request.getParameter("year");
                String from = request.getParameter("mySelect1");
                String sd = from.substring(0, 1);
                session.setAttribute("sd", sd);
                from = from.substring(1);
                String to = request.getParameter("mySelect2");
                to = to.substring(1);
                String semester = request.getParameter("semester");
                String subjectName = request.getParameter("subjname");
                String subjectId = request.getParameter("subjid");
                String pa = request.getParameter("pa");
                String ca = request.getParameter("ca");
                String pta = request.getParameter("pta");
                pa = pa.trim();
                ca = ca.trim();
                pta = pta.trim();
                String subjectid = (String) session.getAttribute("subjid");
                String sname = (String) session.getAttribute("subjname");

                String username = (String) session.getAttribute("facultyid");

                if (username == null) {
                    username = "";
                }
                System.out.println(username);

                try {

        %>
        <form action="demo.jsp" name="frm" onsubmit="return disp();" method="post">  
            <table border="0"  cellspacing="0" cellpadding="0" style="color:blue;background-color:#CCFFFF;" width="97%">
                <tr>
                    <th>Year<br/><input type="text" name="year" value="<%=year%>" size="10"  onKeyPress ="return disableEnterKey(event)" readonly="readonly" /></th>
                    <th>&nbsp;</th>
                    <th>From<br/><input type="text" name="mySelect" value="<%=from%>" size="10"  onKeyPress ="return disableEnterKey(event)" readonly="readonly"/></th>
                    <th>&nbsp;</th>

                    <th>To<br/><input type="text" name="mySelect1" value="<%=to%>" size="10"  onKeyPress ="return disableEnterKey(event)" readonly="readonly"/></th>
                    <th>&nbsp;</th>

                    <th>Semester<br/><input type="text" name="semester" value="<%=semester%>" size="10"  onKeyPress ="return disableEnterKey(event)" readonly="readonly" /></th>
                    <th>&nbsp;</th>

                    <th>Subject<br/><input type="text" name="subjname" value="<%=sname%>" size="25"  onKeyPress ="return disableEnterKey(event)" readonly="readonly" /></th>
                    <th>&nbsp;</th>
                    <th>Code<br/><input type="text" name="subjid" value="<%=subjectid%>" size="10"  onKeyPress ="return disableEnterKey(event)" readonly="readonly" /></th>
                </tr>
            </table>
            &nbsp;
            <%
                } catch (Exception e) {
                    e.printStackTrace();
                }

                boolean value = true;
                Connection con = conn.getConnectionObj();
                if (value) {
                    try {
                        pst = con.prepareStatement("select cumatten from subject_attendance_" + semester + "_" + year + " where subjectId=?");
                        pst.setString(1, subjectid);
                        //String qry4 = "select cumatten from subject_attendance_" + semester + "_" + year + " where subjectId='" + subjectid + "'";
                        // String qry5 = "select StudentId,StudentName,cumatten,percentage,month" + sd + " from " + subjectid + "_Attendance_" + semester + "_" + year;
                        ResultSet rs4 = pst.executeQuery();

                        pst = con.prepareStatement("select StudentId,StudentName,cumatten,percentage,month" + sd + " from " + subjectid + "_Attendance_" + semester + "_" + year);
                        ResultSet rs1 = pst.executeQuery();
                        int finding = 0;
                        while (rs1.next()) {
                            if (rs1.getInt(5) != 0) {
                                finding = 1;
                            }
                        }
                        rs1.beforeFirst();
            %>
            <table border="0" style="color:blue;background-color:#CCFF99" cellspacing="10" cellpadding="0" >
                <tr>
                    <td><center>Number of Hours<br/>taught:</center></td>
                <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                <%
                    while (rs4.next()) {
                %>
                <td>Previous Total<input type="text" id="pa" name="pa" value="<%=pa%>"  onKeyPress ="return disableEnterKey(event)" readonly="readonly" size="15"/></td>

                <%}%>
                <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                <td>Current Month<input type="text" id="ca" name="ca" value="<%=ca%>"  size="15"  onKeyPress ="return disableEnterKey(event)" onchange="display2();"></td>

                <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                <td>Total<input type="text" id="pta" name="pta" value="<%=Integer.parseInt(ca) + Integer.parseInt(pa)%>"  onKeyPress ="return disableEnterKey(event)" readonly="readonly" size="15"/></td>

                </tr>
            </table>
            &nbsp;
            <table border="1" cellspacing="0" cellpadding="0" align="center" class="table">

                <th  align ="center" class="th">S.No</th>
                <th  align ="center" class="th">Registration No.</th>
                <th  width="300" align ="center" class="th">Name of the Student</th>
                <th  align ="center" class="th">Attendance</th>
                    <%
                        session.setAttribute("preatt", pa);

                        String tot = Integer.toString(Integer.parseInt(ca) + Integer.parseInt(pa));
                        session.setAttribute("totatt", tot);
                        while (rs1.next()) {
                    %>
                <tr>
                    <td align="center"><%=i%></td>
                    <td><%=rs1.getString(1)%></td> 
                    <td><%=rs1.getString(2)%></td>
                    <%
                        if (rs1.getInt(5) == 0 && finding == 0) {   // attendance by default zero.

                    %>
                    <td><input type="text" name="pq1" id="<%=Integer.toString(i)%>"  value="0" size="5"  onKeyPress ="return disableEnterKey(event)" onchange="dothis(<%=Integer.toString(i)%>);"/></td>
                        <%} else {
                        %>
                    <td><input type="text" name="pq1" id="<%=Integer.toString(i)%>"  value="<%=rs1.getInt(5)%>" size="5"  onKeyPress ="return disableEnterKey(event)" onchange="dothis(<%=Integer.toString(i)%>);"/></td>
                        <%}%>
                </tr>
                <input type="hidden" name="pq" value="<%=rs1.getString(3)%>" size="" readonly="readonly" />
                <input type="hidden" name="pq2" value="0" size="" readonly="readonly" />
                <input type="hidden" name="pq3" value="<%=rs1.getString(4)%>" size="" readonly="readonly" />
                <%
                        i++;
                    }
                %>

            </table>
            &nbsp;
            <table align="center">
                <tr>
                    <td align="center">
                        <input type="submit" id="xx" name="submit" value="Update to database" width="200" onclick="display();" class="Button"/>
                    </td>
                </tr>
            </table>

        </form>
        <%
                       
                    } catch (Exception e) {
                        e.printStackTrace();
                    }finally{
                   conn.closeConnection();
                    con = null;
                   }
                    value = false;
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        %>

    </body>
</html>