<%-- 
    Document   : improvementview1
    Created on : Apr 3, 2014, 3:10:31 PM
    Author     : veeru
--%>
<%@include file="checkValidity.jsp"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script type="text/javascript">


            history.forward();
            function open1()
            {
                parent.act_area.location = "./BalankPage2.jsp";
                parent.bottom.location = "./BalankPage2.jsp";
                window.open("improvementview.jsp", "act_area");

            }
            function open2()
            {
                parent.act_area.location = "./BalankPage2.jsp";
                window.open("improvementview2.jsp", "bottom");

            }
            function open3()
            {
                parent.act_area.location = "./BalankPage2.jsp";
                window.open("improvementview3.jsp", "bottom");

            }
        </script>
    </head>
    <body>

        <form name="impfrm" target="subdatabase" action="" method="post" >
            <table align="left">
                <caption><h3 style=" color: darkred">Improvement:</h3></caption>
                <th></th>
                <tr><td><input type="radio" id="r" name="r" value="Delete Subject" onclick="open1();">View</td></tr>
                <tr><td><input type="radio" id="r" name="r" value="Upload" onclick="open2();">Student wise</td></tr>
                <tr><td><input type="radio" id="r" name="r" value="Add Subject" onclick="open3();">Subject wise</td></tr>
            </table>
        </form>

    </body>
</html>
