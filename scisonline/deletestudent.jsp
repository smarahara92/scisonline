<%-- 
    Document   : deletestudent
--%>

<%@include file="checkValidity.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>

        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>

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
            function make_blank(sid)
            {
                for(var k=1;k<11;k++){
                    document.getElementById("d"+k).innerHTML = "";
                }
                var stu = "s" + sid;

                if (document.getElementById(stu).value != "---Enter Student Id---")
                {

                }
                else
                {
                    document.getElementById(stu).value = "";
                }
                var i = 0;
                for (i = 1; i <= 10; i++)
                {
                    var stu1 = "s" + i;
                    if (i == sid)
                        ;
                    else
                    {
                        if (document.getElementById(stu1).value == "")
                        {
                            document.getElementById(stu1).value = "---Enter Student Id---";
                        }
                    }
                }


            }
            function validId(temp)
            {
                var id = document.getElementById("s" + temp).value;
                //alert(id);
                var emailRegEx = /[0-9][0-9]+(MC|mc)+(MT|mt|MB|mb|MI|mi|MC|mc)+[0-9][0-9]/;

                if (id.search(emailRegEx) == -1 || id.length > 8)
                {

                    alert("please enter valid StudentId");
                    var stu1 = "s" + temp;
                    document.getElementById(stu1).value = "---Enter Student Id---";
                    document.getElementById(stu1).focus();

                }

            }

            function check1()
            {
                var i = 1;
                var c = 10;
                while (i <= 10)
                {
                    if (document.getElementById("s" + i).value == "" || document.getElementById("s" + i).value == "---Enter Student Id---")
                        c--;
                    i++;
                }
                if (c == 0)
                {
                    alert("Atleast one Student Id is not given");

                    return false;
                }
                else
                    return true;

            }

            //ajax code


            function check(d)
            {
                //this function is to check student id in database. and validating student id.

                var id = d;
                var id_val=id.substring(1);
                
                var stuid = document.getElementById(id).value;

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


                           
                            document.getElementById(id).focus();
                            document.getElementById(id).value = "---Enter Student Id---";
                            document.getElementById("d"+id_val).innerHTML = "Student Id does not exist.";
                            
                            return false;
                        } else if (x == 5) {
                            document.getElementById(id).value = "---Enter Student Id---";
                            document.getElementById(id).focus();
                           document.getElementById("d"+id_val).innerHTML = "Invalid student Id";
                        }

                    }
                };

                xmlhttp.open("GET", "deletestudent_ajax.jsp?stuid=" + stuid, true);
                xmlhttp.send();

            }


        </script>

    </head>
    <body bgcolor="#CCFFFF">
        <form action="deletestudentlink.jsp" method="get" name="form1" onsubmit="return check1();">

            <table align="center" width="50%">
                
                <tr>
                    <td align="center"><h3>DELETE STUDENTS</h3></td>
                </tr>
                <th align="center">Student Id</th>
                <th align="center">&nbsp;&nbsp;</th>
                

                <%
                    int i = 1;
                    while (i <= 10) {
                %>

                <tr>
                    <td align="center"><input type="text" id="s<%=i%>" name="sid" value="---Enter Student Id---" onKeyPress="return disableEnterKey(event);" onclick="make_blank(<%=i%>);" onchange="check(this.id);"/></td>
                    <td align="center" width="35%"><div id="d<%=i%>" style=" color: red;"></div> </td>
                </tr>

                <%
                        i++;
                    }%>
                    <tr>
                        <td align="center">&nbsp;</br>&nbsp;<input type="submit" name="submit" value="submit"></td>
                    </tr>
                    
            </table>  
            
        </form>      
    </body>
</html>
