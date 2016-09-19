<%-- 
    Document   : projectStaffModifyMtech
    Created on : 18 Mar, 2013, 5:40:35 PM
    Author     : varun
--%>
<%@include file="checkValidity.jsp"%>
<%@include file="programmeRetrieveBeans.jsp"%>
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
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" type="text/css" href="table_css1.css">
        <script type="text/javascript">


            function loadXMLDoc4()
            {
                document.getElementById("sbt").disabled = "";
                var val;
                if (document.getElementById("rd1").checked)
                {

                    val = document.getElementById("rd1").value;
                }
                else if (document.getElementById("rd2").checked)
                {

                    val = document.getElementById("rd2").value;
                }
                if (document.getElementById("rd3").checked)
                {

                    val = document.getElementById("rd3").value;
                }
                var xmlhttp1;
                var studentId = document.getElementById("sid11").value;
                if (studentId !== "" && val !== "") {
                    var urls1 = "projectstaffprojectmodifyajax.jsp?selectedOption=" + val + "&studentId=" + studentId;
                    if (window.XMLHttpRequest)
                    {
                        xmlhttp1 = new XMLHttpRequest();
                    }
                    else
                    {
                        xmlhttp1 = new ActiveXObject("Microsoft.XMLHTTP");
                    }
                    xmlhttp1.onreadystatechange = function()
                    {
                        if (xmlhttp1.readyState === 4)
                        {
                            var resp = xmlhttp1.responseText;

                            if (resp == 1)
                            {
                                alert("The Projects are not yet allocated.");

                                return;
                            }
                            else if (resp == 2)
                            {
                                alert(studentId + " is already doing a project in University.");
                                document.getElementById("sbt").disabled = "true";
                                return;
                            }
                            else if (resp == 3)
                            {
                                alert(studentId + "is not assigned any project.");
                                document.getElementById("sbt").disabled = "true";
                                return;
                            }
                            else if (resp == 4)
                            {
                                alert(studentId + "is an Internship Student.");
                                document.getElementById("sbt").disabled = "true";
                                return;
                            }
                            else if (resp == 5)
                            {
                                alert("There are no Unallocated Projects currently.");
                                document.getElementById("sbt").disabled = "true";
                                return;

                            }

                        }
                    };
                    xmlhttp1.open("GET", urls1, true);
                    xmlhttp1.send();
                }
            }

            function loadXMLDoc2(pid2)
            {
                var ProgrammeName1 = document.getElementById(pid2).value;
                document.getElementById(pid2).style.color = "";
                document.getElementById("sid11").style.color = "";
                var xmlhttp1;

                var urls1 = "projectRegistrationInterns_ajax.jsp?programmeName=" + ProgrammeName1 + "&elementId=" + pid2;
                if (window.XMLHttpRequest)
                {
                    xmlhttp1 = new XMLHttpRequest();
                }
                else
                {
                    xmlhttp1 = new ActiveXObject("Microsoft.XMLHTTP");
                }
                xmlhttp1.onreadystatechange = function()
                {
                    if (xmlhttp1.readyState === 4)
                    {
                        //alert(xmlhttp1.responseText);
                        document.getElementById("std1" + pid2).innerHTML = xmlhttp1.responseText;
                    }
                };
                xmlhttp1.open("GET", urls1, true);
                xmlhttp1.send();
            }

            function loadXMLDoc3(val)
            {

                var xmlhttp1;
                document.getElementById("sbt").disabled = "";
                var urls1 = "projectRegistrationInterns_ajax2.jsp?studentId=" + val + "&check=2";
                if (window.XMLHttpRequest)
                {
                    xmlhttp1 = new XMLHttpRequest();
                }
                else
                {
                    xmlhttp1 = new ActiveXObject("Microsoft.XMLHTTP");
                }
                xmlhttp1.onreadystatechange = function()
                {
                    if (xmlhttp1.readyState === 4)
                    {
                        var resp = xmlhttp1.responseText;

                        if (resp == 1 && val!=="")
                        {
                            alert("Invalid student Id.");
                            document.getElementById("sid11").value = "";
                        }
                        else {
                            loadXMLDoc4();
                        }
                    }
                };
                xmlhttp1.open("GET", urls1, true);
                xmlhttp1.send();
            }

            function validate11()
            {
                var flag = 0;
                var val;
                if (document.getElementById("rd1").checked)
                {
                    flag++;
                    val = document.getElementById("rd1").value;
                }
                else if (document.getElementById("rd2").checked)
                {
                    flag++;
                    val = document.getElementById("rd2").value;
                }
                if (document.getElementById("rd3").checked)
                {
                    flag++;
                    val = document.getElementById("rd3").value;
                }

                var studentId = document.getElementById("sid11").value;


                if (studentId === "")
                {
                    alert("Please enter student ID.");
                    return false;
                } else if (flag == 0)
                {
                    alert("Please select modify option");
                    return false;
                } else {
                    if (val === "cs")
                    {
                        parent.act_area.location = "./projectStaffChangeSupervisor.jsp?studentId=" + studentId + "&r=" + val;
                    }
                    else if (val === "ni")
                    {
                        parent.act_area.location = "./projectStaffNewInternship.jsp?studentId=" + studentId + "&r=" + val;

                    }
                    else if (val === "rtuoh")
                    {
                        parent.act_area.location = "./projectStaffChangeSupervisor.jsp?studentId=" + studentId + "&r=" + val;
                    }
                    return true;
                }

            }
        </script>
    </head>
    <body bgcolor="#CCFFFF">


        <form  id="form" name="form1"  action="" onsubmit="return validate11();">

            <table align="center" >
                <caption style=" color: #c2000d;"><h2> Modify Project</h2></caption>
                <tr> 
                    
                    <td>
                        <input type="radio" name="r" id="rd1" value="cs" onclick="loadXMLDoc4();" class="Button">Change Supervisor&nbsp;&nbsp;
                    </td>
                    <td>
                        <input type="radio" name="r" id="rd2" value="ni" onclick="loadXMLDoc4();" class="Button">New Internship&nbsp;&nbsp;
                    </td>
                    <td>                
                        <input type="radio" name="r" id="rd3" value="rtuoh" onclick="loadXMLDoc4();" class="Button">Return from Internship&nbsp;&nbsp;
                    </td>
                    
                </tr>
                <tr><td><br></td></tr>
                <tr><td><br></td></tr>
            </table>
            
            <table align="center">
                
                <tr>
                    <td>
                        <p>Student ID:</>
                        <input type="text" name="studentId" value="" onchange="loadXMLDoc3(this.value);" id="sid11" size="10%"> </td>
                </tr>
            
            </table>
            
            &nbsp;&nbsp;&nbsp;<br>
            <div align="center"><input type="button" id="sbt" value="Submit" onclick="validate11();"</div>
        </form>

    </body>
</html>

