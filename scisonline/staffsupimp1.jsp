<%-- 
    Document   : staffsupimp1
    Created on : Apr 22, 2014, 2:50:33 PM
    Author     : veeru
--%>

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
               
                window.open("staffsupimp2.jsp", "act_area");

            }
            function open2()
            {
                parent.act_area.location = "./BalankPage2.jsp";
                window.open("staffsupimp3.jsp", "bottom");

            }
            function open3()
            {
                parent.act_area.location = "./BalankPage2.jsp";
                window.open("staffsupimp4.jsp", "bottom");

            }


        </script>
    </head>
    <body>

        <form name="supfrm" target="subdatabase" action="" method="post" >
            <table align="left">
                <caption><h3 style=" color: darkred">Supplementary/Improvement:</h3></caption>
                <th></th>
<!--                <tr><td><input type="radio" id="r" name="r" value="Delete Subject" onclick="open1();">View</td></tr>-->
                <tr><td><input type="radio" id="r" name="r" value="Upload" onclick="open2();">Student wise</td></tr>
                <tr><td><input type="radio" id="r" name="r" value="Add Subject" onclick="open3();">Subject wise</td></tr>
            </table>
        </form>

    </body>
</html>
