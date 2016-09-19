<%-- 
    Document   : index
    Created on : Aug 9, 2012, 2:58:51 PM
    Author     : varun
--%>

<%@include file="programmeRetrieveBeans.jsp" %>
<%@include file="checkValidity.jsp"%>
<%@page import="java.sql.ResultSet"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>

    <head>
        <style>
            <%--body {color:white}--%>
            .style11 {color :red}
            .style12 {color :white}
            .style13 {color :yellow}


        </style>
        <link rel="stylesheet" type="text/css" href="table_css.css">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script type="text/javascript">
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

            function check1(a)
            {
                var val = a.id;



                var val1 = val.substring(3);
                var sstuid = document.getElementById("cid" + val1).value;

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
                        if (x == 5) {
                            alert("Invalid studentId.");
                            document.getElementById("cid" + val1).value = "";
                            return;
                        } else if (x == 3) {
                            alert("Invalid studentId.");
                            document.getElementById("cid" + val1).value = "";
                            return;
                        } else if(x==4){

                            alert("Student Id does not exist.");
                            document.getElementById("cid" + val1).value = "";
                            return;
                        }
                        document.getElementById("fpg" + val1).innerHTML = xmlhttp.responseText;
                    }

                };

                xmlhttp.open("GET", "sliding_ajax11.jsp?stuid=" + sstuid + "&id=" + val1, true);
                xmlhttp.send();


                var proname = document.getElementById("cid" + val1).value;

               for (var i = 0; i < 9; i++)
                {
                    document.getElementById("cid" + i).style.backgroundColor = "";
                    document.getElementById("fpg" + i).style.color = "";
                    document.getElementById("tpg" + i).style.color = "";
                    document.getElementById("nid" + i).style.backgroundColor = "";
                }
      }

       function check3(c)
            {

                var val = c.id;

                var val1 = val.substring(3);
                var fromField = document.getElementById("fpg" + val1).value;
                var toField = document.getElementById("tpg" + val1).value;
                for (var i = 0; i < 9; i++)
                {
                    document.getElementById("cid" + i).style.backgroundColor = "";
                    document.getElementById("fpg" + i).style.color = "";
                    document.getElementById("tpg" + i).style.color = "";
                    document.getElementById("nid" + i).style.backgroundColor = "";
                }

                //*****************************************************

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


                        if (x == 2) {

                            document.getElementById("tpg" + val1).focus();
                            document.getElementById("tpg" + val1).value = "-Programme-";
                            alert("Sliding is not possible in between different streams.");
                            return false;

                        }



                    }

                };

                xmlhttp.open("GET", "sliding_ajax2.jsp?stream1=" + fromField + "&stream2=" + toField, true);
                xmlhttp.send();


                //***********************************************************


                // document.getElementById("nid" + val1).disabled = "";
                document.getElementById("nid" + val1).focus();

                var fromField1 = document.getElementById("fpg" + val1).value;
                var toField1 = document.getElementById("tpg" + val1).value;

                if (fromField1 !== "-Programme-" && toField1 !== "-Programme-" && (fromField1 === toField1))
                {
                    alert("Same programme name.");
                    document.getElementById("tpg" + val1).value = "-Programme-";
                    return;
                }

            }
            function check4(d)
            {
                var val = d.id;
                var val1 = val.substring(3);

                //********************************************
                var curid1 = document.getElementById("cid" + val1).value;
                var newid1 = document.getElementById("nid" + val1).value;

                var pgname = document.getElementById("fpg" + val1).value;
                var pgname1 = document.getElementById("tpg" + val1).value;
              
                for (var i = 0; i < 9; i++)
                {
                    document.getElementById("cid" + i).style.backgroundColor = "";
                    document.getElementById("fpg" + i).style.color = "";
                    document.getElementById("tpg" + i).style.color = "";
                    document.getElementById("nid" + i).style.backgroundColor = "";
                }
                if (pgname1 === "-Programme-")
                {
                    alert("select Programme.");
                    document.getElementById("tpg" + val1).focus();
                }


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

                        if (x == 1) {

                            document.getElementById("nid" + val1).value = "";


                            document.getElementById("nid" + val1).focus();
                            alert("Student Id all ready exists in database.");
                            return false;

                        } else if (x == 2) {


                            document.getElementById("nid" + val1).value = "";


                            document.getElementById("nid" + val1).focus();

                            alert("Invalid student Id for " + pgname1);
                            return false;

                        } else if (x == 3) {


                            document.getElementById("nid" + val1).value = "";


                            document.getElementById("nid" + val1).focus();

                            //   alert("Invalid student Id.");
                            return false;
                        } else if (x == 5) {


                            document.getElementById("nid" + val1).value = "";


                            document.getElementById("nid" + val1).focus();
                            // alert("Invalid student Id.");
                            return false;

                        }


                    }

                };

                xmlhttp.open("GET", "sliding_ajax1.jsp?stream=" + pgname1 + "&stuid=" + newid1, true);
                xmlhttp.send();

                return true;

            }


            function check() {


                var today = new Date();
                var dd = today.getDate();
                var mm = today.getMonth() + 1;
                var yyyy = today.getFullYear();
                //alert(yyyy);
                if (mm >= 6) {
                    alert("Sliding not possible in current semester.");
                    parent.first.location = "./slindingError.jsp"
                }


            }
            function check5()
            {
                var test = 0;
                for (var i = 0; i < 9; i++)
                {
                    var curid1 = document.getElementById("cid" + i).value;
                    if (curid1 !== "")
                    {
                        test++;
                    }
                }
                if (test == 0)
                {

                    alert("Enter attlist one student details.");
                    return false;
                }

                for (var i = 0; i < 9; i++)
                {
                    var curid = document.getElementById("cid" + i).value;
                    var fromField = document.getElementById("fpg" + i).value;
                    var toField = document.getElementById("tpg" + i).value;
                    var newid = document.getElementById("nid" + i).value;

                    if (curid === "" && (fromField !== "-Programme-" || toField !== "-Programme-" || newid !== ""))
                    {
                        alert("Enter current Id.");
                        document.getElementById("cid" + i).style.backgroundColor = "#CCCC66";
                        document.getElementById("cid" + i).focus();

                        return false;
                    }

                    if (curid !== "" && (fromField !== "-Programme-" && toField === "-Programme-"))
                    {
                        alert("Select programme name.");

                        document.getElementById("tpg" + i).style.color = "red";
                        document.getElementById("tpg" + i).focus();

                        return false;

                    }

                    if (curid !== "" && (fromField !== "-Programme-" && toField !== "-Programme-" && newid === ""))
                    {
                        alert("Enter new Id.");

                        document.getElementById("nid" + i).style.backgroundColor = "#CCCC66";
                        document.getElementById("tpg" + i).focus();

                        return false;

                    }
                }

            }

            function check7(val1)
            {
                var flag = 0;
                var curid1 = document.getElementById("cid" + val1).value;

                var pgname = document.getElementById("fpg" + val1).value;


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

                        if (x == 1) {
                            flag++;

                            document.getElementById("fpg" + val1).value = "-Programme-";

                            document.getElementById("fpg" + val1).disabled = "yes";
                            document.getElementById("cid" + val1).focus();
                            alert("Student Id does not exists in database.");
                            return false;

                        } else if (x == 2) {
                            flag++;

                            document.getElementById("fpg" + val1).value = "-Programme-";
                            document.getElementById("fpg" + val1).focus();


                            alert("Invalid student Id for " + pgname);
                            return false;

                        } else if (x == 3) {
                            flag++;

                            document.getElementById("fpg" + val1).value = "-Programme-";

                            //  document.getElementById("fpg" + val1).disabled = "yes";
                            // document.getElementById("tpg" + val1).disabled = "yes";
                            document.getElementById("cid" + val1).focus();
                            //   alert("Invalid student Id.");
                            return false;
                        } else if (x == 5) {


                            document.getElementById("fpg" + val1).value = "-Programme-";

                            // document.getElementById("fpg" + val1).disabled = "yes";
                            document.getElementById("cid" + val1).focus();
                            // alert("Invalid student Id.");
                            return false;

                        }
                    }

                };

                xmlhttp.open("GET", "sliding_ajax.jsp?stream=" + pgname + "&stuid=" + curid1, true);
                xmlhttp.send();

                return true;
            }

        </script>
    </head>
    <body bgcolor="#CCFFFF"  onsubmit="return check5();">

        <form  id="form" method="POST" onsubmit="return validate();"  action="SlidingLink.jsp">

            <table align="center">
                <caption><h2>Stream Sliding</h2></caption>

                <th>Current Id </th> 
                <th>From</th> 
                <th>To</th> 
                <th>New Id</th>

                <%                    int i = 0;

                    while (i < 10) {%>
                <tr>
                    <td>
                        <input type="text" id="cid<%=i%>" name="cid" onchange="check1(this);" onKeyPress="return disableEnterKey(event);">
                    </td>

                    <td id="td<%=i%>">
                        <select id="fpg<%=i%>" name="fname" onchange="check2(this)">
                            <option value="-Programme-">-Programme-</option>
                            <%
                                ResultSet rs = scis.executeQuery("select Programme_name from programme_table where (Programme_status='1' and not Programme_name ='PhD')");
                                while (rs.next()) {

                            %>
                            <option value="<%=rs.getString(1)%>"><%=rs.getString(1)%></option>

                            <%}%>    
                    </td>


                    <td>
                        <select id="tpg<%=i%>" name="tname" onchange="check3(this);">
                            <option value="-Programme-">-Programme-</option>
                            <%
                                rs = scis.executeQuery("select Programme_name from programme_table where (Programme_status='1' and not Programme_name ='PhD')");
                                while (rs.next()) {
                            %>
                            <option value="<%=rs.getString(1)%>"><%=rs.getString(1)%></option>

                            <%}%>    
                    </td>
                    <td>
                        <input type="text" id="nid<%=i%>" name="nid" onchange="check4(this);" onKeyPress="return disableEnterKey(event);">
                    </td>

                </tr>
                <%
                        i++;
                    }%> 

            </table><br>
            <div align="center"><input type="submit" value="submit" class="Button"/></div>

        </form>

    </body>
    <%
    scis.close();
    %>
</html>

