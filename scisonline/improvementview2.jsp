<%-- 
    Document   : improvementview2
    Created on : Apr 3, 2014, 3:10:43 PM
    Author     : veeru
--%>
<%@include file="checkValidity.jsp"%>

<%@page import="java.util.Calendar"%>
<%@page import ="java.sql.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="connectionBean.jsp"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>

        <script>

            function fun1() {

                var stuid = document.getElementById("st").value;
                             
                if (stuid === "") {
                    parent.act_area.location = "./BalankPage2.jsp";
                     parent.act_area.location = "./BalankPage2.jsp";
                    document.getElementById("errfn").innerHTML = "Enter Student Id.";
                    return false;
                } else {
                    
                    document.getElementById("errfn").innerHTML = "";

                    parent.act_area.location = "./BalankPage2.jsp";

                    parent.act_area.location = "./improvementview4.jsp?studentId="+stuid;
                    return true;

                }


            }

        </script>

    </head>
    <body>

        <form name="form1" id="form1" action="improvementview4.jsp" target="act_area" onsubmit="return fun1();" method="POST">

            <table>
                <caption><h3 style=" color: darkred">Student Id :</h3></caption>
                <tr>
                    <td>

                        <input type="text" value="" id="st" name="studentId" size="12" onchange="fun1();">
                    </td>


                </tr>

            </table>

            <br>

            <div id="errfn" align="center" style=" color: red"></div>

        </form>

    </body>
</html>

