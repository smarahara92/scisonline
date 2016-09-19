<%-- 
    Document   : aslink6
    Created on : Dec 15, 2013, 1:00:54 PM
    Author     : veeru
--%>

<%@include file="checkValidity.jsp"%>
<%@page import="java.util.Calendar"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="dbconnection.jsp"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style>
            .style30 {color: #c2000d}
            .style31 {color: white}
            .style32 {color: green}
            .heading
            {
                color: white;
                background-color: #c2000d;
            }
            .border
            {
                background-color: #c2000d;
            }
            .pos_fixed
            {
                position:fixed;
                bottom:0px;
                background-color: #CCFFFF;
                border-color: red;
            }
            #bold{
                font-weight: bold;
            }
        </style>
        <script>

            function fun1() {

                var studentId = document.getElementById("st").value;

                if (document.getElementById("view").checked) {


                    parent.act_area1.location = "./Studentwise.jsp?studentId=" + studentId;

                }
            }

            function link1() {
                var studentId = document.getElementById("st").value;
               

                if (document.getElementById("view").checked) {


                    parent.act_area1.location = "./Studentwise.jsp?studentId=" + studentId;

                } else {

                    parent.act_area1.location = "./underdevelopment.jsp";

                }
            }

        </script>

    </head>
    <body onload="fun1();">

        <form name="form1" id="form1" method="POST">

            <table>
                <%                  String studentId = request.getParameter("studentId");

                %>

                <tr><td><input type="radio" name="update" id="view" value="View" onclick="link1(this.id);" checked="yes">View</td></tr>
                <tr><td><input type="radio" name="update" id="summary" value="Summary" onclick="link1(this.id);">Summary</td></tr>


            </table>
            <input type="hidden" id="st" name="studentId" value="<%=studentId%>">

        </form>

    </body>
</html>
