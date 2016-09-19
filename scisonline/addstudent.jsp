<%-- 
    Document   : addstudent
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@include file="checkValidity.jsp"%>
<%@include file="connectionBean.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <link rel="stylesheet" type="text/css" href="table_css.css">
        <script type="text/javascript" src="jquery.js"></script>  
        <SCRIPT type="text/javascript">
            window.history.forward();
            function noBack() {
                window.history.forward();
            }
        </SCRIPT>
        <script>
            function disableEnterKey(e) {
                var key;
                if(window.event)
                    key = window.event.keyCode;     //IE
                else
                    key = e.which;     //firefox
                if(key === 13)
                    return false;
                else
                    return true;
            }
            function check1(a) {
                
                var num = a.id;
                var num1 = num.substring(2);
                var stuid = document.getElementById("si" + num1).value;
                document.getElementById("pg" + num1).value = "-Programme-";
                document.getElementById("pg" + num1).disabled = "";
                if (stuid !== "") {
                    var xmlhttp;
                    if (window.XMLHttpRequest)
                    {// code for IE7+, Firefox, Chrome, Opera, Safari
                        xmlhttp = new XMLHttpRequest();
                    }
                    else
                    {// code for IE6, IE5   xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
                        xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
                    }
                    xmlhttp.onreadystatechange = function()
                    {
                        if (xmlhttp.readyState === 4 && xmlhttp.status === 200)
                        {

                            var x = xmlhttp.responseText;
                            var xml = x;

                            if (x == 4) {
                                document.getElementById("sn" + num1).value = "";
                                document.getElementById("si" + num1).value = "";
                                document.getElementById("pg" + num1).value = "-Programme-";
                               alert("Student Id already exists in database.");
                                return;
                            } else if (x == 5 || x == 3) {
                                document.getElementById("sn" + num1).value = "";
                                document.getElementById("si" + num1).value = "";
                                document.getElementById("pg" + num1).value = "-Programme-";
                                alert("Invalid student Id.");
                                return;
                            } else {
                                document.getElementById("pg" + num1).innerHTML = x;
                                //document.getElementById("pg" + num1).disabled = "yes";

                            }

                        }
                    };

                    xmlhttp.open("GET", "addingstudent1_ajax.jsp?stuid=" + stuid + "&id=" + num1, true);
                    xmlhttp.send();
                }
                
                var cond1 = document.getElementById("si" + num1).value;

                for (var i = 0; i < 10; i++) {

                    var stuid = document.getElementById("si" + i).value;
                    if (stuid === "") {
                     
                    }
                    document.getElementById("si" + i).style.color = "";
                    document.getElementById("si" + i).style.backgroundColor = "";
                    document.getElementById("sn" + i).style.backgroundColor = "";
                    document.getElementById("pg" + i).style.backgroundColor = "";
                }


                document.getElementById("sn" + num1).disabled = "";
                document.getElementById("sn" + num1).focus();

 
                var cstid = document.getElementById("si" + num1).value;

                for (var i = 0; i < 10; i++)
                {

                    var vstid = document.getElementById("si" + i).value;

                    if (cstid === vstid && num1 != i && cstid !== "")
                    {

                        alert("Duplicate student Id.");
                        document.getElementById("si" + i).style.color = "red";
                        document.getElementById("si" + num1).value = "";

                        return;
                    }


                }
               
            }

            function check2(b) {

                var num = b.id;
                var num1 = num.substring(2);
                document.getElementById("pg" + num1).focus();

                for (var i = 0; i < 10; i++) {


                    var stuid = document.getElementById("si" + i).value;
                    document.getElementById("si" + i).style.color = "";
                    document.getElementById("si" + i).style.backgroundColor = "";
                    document.getElementById("sn" + i).style.backgroundColor = "";
                    document.getElementById("pg" + i).style.backgroundColor = "";
                }
            }

            function check4()
            {

                var count = 0;
                for (var i = 0; i < 10; i++)
                {
                    var stid = document.getElementById("si" + i).value;
                    var stname = document.getElementById("sn" + i).value;
                    var pgname = document.getElementById("pg" + i).value;

                    if (stid !== "" && stname !== "" && pgname !== "-Programme-")
                    {

                        count++;
                    }

                    if (stid === "" && (stname !== "" || pgname !== "-Programme-"))
                    {

                        alert("Enter student Id.");
                        document.getElementById("si" + i).style.backgroundColor = "#CCCC66";

                        document.getElementById("si" + i).focus();


                        return false;
                    }
                    if (stname === "" && (stid !== "" || pgname !== "-Programme-"))
                    {

                        alert("Enter student Name.");
                        document.getElementById("sn" + i).focus();

                        document.getElementById("sn" + i).style.backgroundColor = "#CCCC66";
                        return false;
                    }
                    if (pgname === "-Programme-" && stid !== "" && stname !== "")
                    {

                        document.getElementById("pg" + i).focus();
                        document.getElementById("pg" + i).style.backgroundColor = "#CCCC66";

                        alert("Select programme name.");

                        return false;
                    }

                }
                if (count == 0)
                {
                    alert("Add attlist one student details.");
                    return false;
                }

            }
            
        </script>

    </head>
    <body bgcolor="#CCFFFF">
<%
        Connection con = conn.getConnectionObj();
%>
        <form action="addstudentlink.jsp" method="POST" name="form1" onsubmit="return check4();">

            <table align="center" border="1">

                <caption><h2>ADD STUDENTS</h2></caption>
                <th>Student Id</th>
                <th>Student Name</th>
                <th>Branch</th>

                <%                    int j = 0;
                    for (int i = 0; i < 10; i++) {

                %>
                <tr>
                    <td><input type="text" id="si<%=j%>"  name="sid"  onKeyPress="return disableEnterKey(event);" onchange="check1(this);"></td>
                    <td><input type="text" id="sn<%=j%>" name="sname" onKeyPress="return disableEnterKey(event);" onchange="check2(this);"></td>
                    <td>
                        <select id="pg<%=j%>" name="pg">
                            <option value="-Programme-">-Programme-</option>
                            <%
                                ResultSet rs = null;
                                Statement st1 = con.createStatement();
                                rs = st1.executeQuery("select Programme_name from programme_table where (Programme_status='1' and not Programme_name ='PhD')");
                                while (rs.next()) {
                            %>
                            <option value="<%=rs.getString(1)%>"><%=rs.getString(1)%></option>

                            <%}%>    
                    </td>
                </tr>
                <%
                        j++;
                    }
                %>
            </table>
           
            <br> 
            <div align="center"><input type="submit" name="submit" value="submit" class="Button"  onclick="funn();"></div>

        </form>
<%
        conn.closeConnection();
        con = null;
%>
    </body>
</html>
