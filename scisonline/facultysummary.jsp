<%-- 
    Document   : facultysummary
    Created on : Apr 7, 2014, 9:48:27 AM
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
                parent.bottom.location = "./BalankPage2.jsp";

                window.open("facultysummary1.jsp", "bottom");

            }
            function open2()
            {
                parent.act_area.location = "./BalankPage2.jsp";
                window.open("Internalmarks1.jsp", "bottom");

            }
           


        </script>
    </head>
    <body>

        <form name="supfrm" target="act_area" action="" method="post" >
            <table align="left">
                <caption><h3 style=" color: darkred">Summary:</h3></caption>
                <th></th>
                <tr><td><input type="radio" id="r" name="r" value="Delete Subject" onclick="open1();">Project Summary</td></tr>
                <tr><td><input type="radio" id="r" name="r" value="Add Subject" onclick="open2();">Subject Summary</td></tr>
            </table>
        </form>

    </body>
</html>
