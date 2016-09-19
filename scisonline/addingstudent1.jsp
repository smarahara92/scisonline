<%-- 
    Document   : addingstudent1
--%>

<%@page import="java.sql.*"%>
<%@include file="checkValidity.jsp"%>
<%@include file="connectionBean.jsp"%>   
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <style type="text/css">
            .style30 {color: black}
            .style31 {color: white}
            .style32 {color: green}
            .heading {
                color: white;
                background-color: #c2000d;
            }
        </style>
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
            function check3(a) {
                var id = a.id;
                var val1 = id.substring(3);
                var studentId = a.value;
                var pgname = document.getElementById("pgname").value;
                var jid = document.getElementById("jvalue").value;

                for (var i = 1; i <= jid - 1; i++) {
                    var stuid = document.getElementById("sid" + i).value;
                    if (stuid === "") {
                        document.getElementById("sna" + i).value = "";
                    }
                }
                for (var i = 1; i <= jid - 1; i++) {
                    var stuid = document.getElementById("sid" + i).value;
                    var stuname = document.getElementById("sna" + i).value;
                    if (stuid !== "" && stuname === "") {
                        if (val1 !== i) {
                            document.getElementById("sna" + i).style.backgroundColor = "#CCCC66";
                            document.getElementById(id).value = "";
                            document.getElementById("sna" + i).focus();
                            return;
                        }
                    }
                    if (val1 !== i) {
                        if (stuid === studentId && stuid !== "") {
                            document.getElementById("sid" + i).style.backgroundColor = "#CCCC66";
                            alert("Duplicate student Id");
                            document.getElementById(id).value = "";
                            document.getElementById(id).focus();
                            return;
                        }
                    }
                }
                for (var i = 1; i <= jid - 1; i++) {
                    document.getElementById("sid" + i).style.backgroundColor = "";
                    document.getElementById("sna" + i).style.backgroundColor = "";
                }

                var xmlhttp;
                if (window.XMLHttpRequest) {
                    // code for IE7+, Firefox, Chrome, Opera, Safari
                    xmlhttp = new XMLHttpRequest();
                } else {
                    // code for IE6, IE5   xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
                    xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
                }
                xmlhttp.onreadystatechange = function() {
                    if (xmlhttp.readyState === 4 && xmlhttp.status === 200) {
                        var x = xmlhttp.responseText;
                        if (x === 2) {
                            document.getElementById("sid" + val1).value = "";
                            document.getElementById("sid" + val1).focus();
                            document.getElementById("sid" + val1).style.backgroundColor = "#CCCC66";
                            alert("Invalid student Id for " + pgname);
                            return;
                        } else if (x === 3 || x === 5) {
                            document.getElementById("sid" + val1).value = "";
                            document.getElementById("sid" + val1).focus();
                            document.getElementById("sid" + val1).style.backgroundColor = "#CCCC66";
                            // alert("Invalid student Id");
                            return;
                        }
                    }
                };
                xmlhttp.open("GET", "addingstudent_ajax.jsp?stream=" + pgname + "&studentId=" + studentId, true);
                xmlhttp.send();
            }
            function check4(b) {
                var id = b.id;
                var val1 = id.substring(3);
                var stname = b.value;
                var jid = document.getElementById("jvalue").value;
                for (var i = 1; i <= jid - 1; i++) {
                    document.getElementById("sid" + i).style.backgroundColor = "";
                    document.getElementById("sna" + i).style.backgroundColor = "";
                }
                var stuid = document.getElementById("sid" + val1).value;
                if (stuid === "" && stname != "") {
                    document.getElementById("sid" + val1).style.backgroundColor = "#CCCC66";
                    document.getElementById("sna" + val1).value = "";
                    document.getElementById("sid" + val1).focus();
                }
                var regex = /^[a-zA-Z ]{2,100}$/;
                if (regex.test(stname)) {
                } else {
                    document.getElementById(id).style.backgroundColor = "#CCCC66";
                    document.getElementById(id).value = "";
                    document.getElementById(id).focus();
                    alert("Enter a valid name.");
                    return;
                }
            }
            function check5() {
                var jid = document.getElementById("jvalue").value;
                var flag = 0;
                for (var i = 1; i <= jid - 1; i++) {
                    var stuid = document.getElementById("sid" + i).value;
                    var stuname = document.getElementById("sna" + i).value;
                    if (stuid !== "" && stuname === "") {
                        document.getElementById("sna" + i).style.backgroundColor = "#CCCC66";
                        document.getElementById("sna" + i).focus();
                        return false;
                    }
                    if (stuid !== "" && stuname !== "") {
                        flag++;
                    }
                }
                if (flag > 0) {
                    return true;
                } else {
                    alert("Enter atleast one student datails.");
                    return false;
                }
            }
        </script>
    </head>
    <body> <%
        Connection con = conn.getConnectionObj();
        try {
            String[] stid = (String[]) request.getParameterValues("stdid");
            String[] stname = (String[]) request.getParameterValues("stdname");
            String pname = request.getParameter("pname");
            String pyear = request.getParameter("pyear");
            Statement st = con.createStatement();
            Statement st1 = con.createStatement();
            Statement st2 = con.createStatement();
            st.executeUpdate("drop table if exists studentaddtemp");
            st1.executeUpdate("create table if not exists studentaddtemp(stdid varchar(100),stdname varchar(200),primary key(stdid))");
            int i = 0;
            for (i = 0; i < stid.length; i++) {
                stid[i] = stid[i].trim().toUpperCase();
                stname[i] = stname[i].trim().toUpperCase();
                if (stid.equals("") || stid == null) {
                    continue;
                }
                st2.executeUpdate("insert ignore into studentaddtemp values('" + stid[i] + "','" + stname[i] + "')");
            } %>
            <form name="form33" action="addingstudentlink1.jsp"   method="POST">
                <table align="center" border="1" id="table1" >
                    <caption><h4>Adding Students for <%=pname%>-<%=pyear%></h4></caption>
                    <th class="heading" align="center" >Student Id</th>
                    <th class="heading" align="center">Student Name</th> <%
                    int j;
                    for (j = 1; j < 31; j++) { %>
                        <tr id="tr1">
                            <td><input type="text" name="stdid"  id="sid<%=j%>" size="12" value="" onKeyPress="return disableEnterKey(event);"> </td> 
                            <td><input type="text" name="stdname"  id="sna<%=j%>" value="" size="15" onKeyPress="return disableEnterKey(event);"> </td>
                        </tr> <%
                    } %>
                    <input type="hidden" id="pgname" name="pname" value="<%=pname%>">
                    <input type="hidden" name="jvalue" id="jvalue" value="<%=j%>">
                </table>&nbsp;&nbsp;
                <table class="pos_fixed" width="100%">
                    <tr><td align="center">
                            <input type="submit" name="submit" value="Submit" class="Button"></td>
                    </tr>                             
                </table>
            </form> <%
        } catch (Exception ex) {
            System.out.println(ex);
        }
        conn.closeConnection();
        con = null; %>
    </body>
</html>
