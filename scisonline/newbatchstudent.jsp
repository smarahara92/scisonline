<%-- 
    Document   : newbatchstudent
--%>
<%@include file="checkValidity.jsp"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.util.Calendar"%>
<%@include file="programmeRetrieveBeans.jsp"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style>
            #bold{
                font-weight: bold;
            }
        </style>
        <script type="text/javascript" src="jquery.js"></script>  
        <script>

            function fun1() {

                i = 2007, j = 0;
                d = new Date();
                curr_year = d.getFullYear();
                curr_year1 = curr_year;
                while (curr_year1 >= i)
                {
                    document.getElementById('year1').options[j] = new Option((curr_year1), (curr_year1));
                    curr_year1--;
                    j++;

                }
            }

            function fun2() {

                if (document.getElementById("year1").value < curr_year) {
                    document.getElementById("uploadbtn").disabled = true;
                    document.getElementById("addbtn").disabled = true;
                } else {
                    document.getElementById("uploadbtn").disabled = false;
                    document.getElementById("addbtn").disabled = false;
                }
            }

            function open1() {
                var pgname = document.getElementById("stream").value;

                document.frm2.action = "studentadd_upload.jsp";
                document.frm2.submit();
            }

            function open2() {

                var pgname = document.getElementById("stream").value;
                var urls = "newbatchstudent_ajax.jsp?pgname=" + pgname;
                var xmlhttp;

                if (window.XMLHttpRequest)
                {
                    
                    xmlhttp = new XMLHttpRequest();
                }
                else
                {
                    xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
                }
                xmlhttp.onreadystatechange = function()
                {
                    if (xmlhttp.readyState === 4)
                    {
                        var ret = xmlhttp.responseText;
                        var pgname = document.getElementById("stream").value;
                        if (ret == 0)
                        {
                            alert(pgname + " programme deleted.");
                            return;
                        } else {
                            document.frm2.action = "studentadd_add.jsp";
                            document.frm2.submit();
                        }

                    }
                };

                xmlhttp.open("GET", urls, true);
                xmlhttp.send();



            }
            function open4() {
                var pgname = document.getElementById("stream").value;
                var urls = "newbatchstudent_ajax.jsp?pgname=" + pgname;
                var xmlhttp;

                if (window.XMLHttpRequest)
                {
                    xmlhttp = new XMLHttpRequest();
                }
                else
                {
                    xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
                }
                xmlhttp.onreadystatechange = function()
                {
                    if (xmlhttp.readyState === 4)
                    {
                        var ret = xmlhttp.responseText;
                        var pgname = document.getElementById("stream").value;
                        if (ret == 0)
                        {
                            alert(pgname + " programme deleted.");
                            return;
                        } else {
                            Upload();
                        }

                    }
                };

                xmlhttp.open("GET", urls, true);
                xmlhttp.send();

            }

            function open3() {
                document.frm2.action = "studentadd_view.jsp";
                document.frm2.submit();
            }

            function Upload()
            {
                var p = document.getElementById("stream").value;
                var y = document.getElementById("year1").value;
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
                        xmlDoc = $.parseXML(xml);
                        $xml = $(xmlDoc);
                        $title = $xml.find("body");
                        var test = $title.text();
                        if (test.contains("true"))
                        {

                            var r = confirm("Data already exist for this batch.Do you want to Redo?");
                            if (r === true) {

                                window.open("sFile.jsp", "_blank", "directories=no, status=no, menubar=no, scrollbars=yes, resizable=no,width=600, height=280,top=200,left=400");

                            }
                        } else {


                            window.open("sFile.jsp", "_blank", "directories=no, status=no, menubar=no, scrollbars=yes, resizable=no,width=600, height=280,top=200,left=400");


                        }
                    }
                };

                xmlhttp.open("GET", "studentadd_upload.jsp?stream=" + p + "&year1=" + y, true);
                xmlhttp.send();

            }


        </script>
    </head>
    <body onload="fun1();">
        <%            try {
                ResultSet rs1 =scis.getProgramme();
               
        %>
        <form name="frm2" method="POST" id="form1">
            <table align="center">
                <caption><h2>New Batch</h2></caption>
                <tr>
                    <td id="bold">
                        <select id="stream" name="streamname" style="width:200px;" >
                            <%while (rs1.next()) {%>
                            <option><%=rs1.getString(1)%></option>
                            <%}%>
                        </select> </td>
                    <td id="bold2"> <select name="year2" id="year1" style="width:200px;" onclick="fun2();">
                        </select> 
                    </td> 
                </tr>
                <tr>

                </tr>
                <tr>
                    <td colspan="2" align="center" id="bold">
                        <input type="button" id="uploadbtn" name="upload" value="Upload File"  onclick="open4();">&nbsp;
                        <input type="button"  id="addbtn" name="Add" value="Add"  onclick="open2();"/>&nbsp;
                        <input type="button" name="View" value="View" onclick="open3();">
                        <br>
                    </td>
                </tr>
            </table>

        </form>

        <%

        } catch (Exception e) {%>
        <script type="text/javascript">
            alert("Add at least one programme");
        </script> 
        <%  }

        %>
    </body>
</html>
</body>
</html>
