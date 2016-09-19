<%-- 
    Document   : addingstudent
--%>
<%@include file="checkValidity.jsp"%>
<%@ include file="connectionBean.jsp" %>
<%@page import="java.sql.*"%>
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
            function check() {
                window.document.forms["frm5"].action = "addingstudent1.jsp";
                document.frm5.submit();
            }
            function check2() {
                window.document.forms["frm5"].action = "addingstudentlink.jsp";
                document.frm5.submit();
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
                        document.getElementById("sna"+i).value = "";
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
                for (var i = 1; i <= jid; i++) {
                    var stuid = document.getElementById("sid" + i).value;
                    var stuname = document.getElementById("sna" + i).value;
                    if (stuid != "" && stuname === "") {
                        document.getElementById("sna" + i).style.backgroundColor = "#CCCC66";
                        document.getElementById("sna" + i).focus();
                        return false;
                    }
                    if (stuid != "" && stuname != "") {
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

        int i = 0, j = 1;
        Statement stt = con.createStatement();
        stt.executeUpdate("drop table if exists studentaddtemp");

        String pname = (String) session.getAttribute("pnamen");
        pname = pname.replace('-', '_');
        String year = (String) session.getAttribute("yearn");
        Statement st = con.createStatement();

        /*
         * Checking table exists or not...
         */

        DatabaseMetaData md = con.getMetaData();

        ResultSet rs = md.getTables(null, null, "" + pname + "_" + year + "", null);
        if (rs.next()) {
            i++;
        } %>
        <form name="frm5"   method="POST" onsubmit="return check5();">
            <table align="center" border="1" id="th1" >
                <caption><h4>Adding Students for <%=pname%>-<%=year%></h4></caption>
                &nbsp;
                <th class="heading" align="center" >Student Id</th>
                <th class="heading" align="center">Student Name</th> <%
                if (i == 0) {
                    for (j = 1; j < 30; j++) { %>
                        <tr id="tr1">
                            <td><input type="text" name="stdid"  id="sid<%=j%>" size="12" value=""  onKeyPress="return disableEnterKey(event);"> </td> 
                            <td><input type="text" name="stdname"  id="sna<%=j%>" value="" size="15" onKeyPress="return disableEnterKey(event);" > </td>
                        </tr>  <%
                    }
                } else {
                    ResultSet rs1 = st.executeQuery("select * from " + pname + "_" + year + "");
                    while (rs1.next()) {
                        j = 1; %>
                        <tr id="tr1">
                            <td><input type="text" name="stdid"  id="sid<%=j%>" size="12" value="<%=rs1.getString(1)%>" onKeyPress="return disableEnterKey(event);"> </td> 
                            <td><input type="text" name="stdname"  id="sna<%=j%>" value="<%=rs1.getString(2)%>" size="15" onKeyPress="return disableEnterKey(event);"> </td>
                        </tr> <%
                    }
                } %>
            </table>&nbsp;&nbsp;
            <input type="hidden" id="pgname" name="pname" value="<%=pname%>">
            <input type="hidden" name="pyear" value="<%=year%>">
            <input type="hidden" name="jvalue" id="jvalue" value="<%=j%>">

            <table class="pos_fixed" width="100%">
                <tr>
                    <td align="center">
                        <input type="submit" name="add" id="button" value="Next" onclick="check();">
                        <input type="submit" name="submit" value="Submit" onclick="check2();">
                    </td>
                </tr>                             
            </table>
        </form> <%
        conn.closeConnection();
        con = null; %>
    </body>
</html>
