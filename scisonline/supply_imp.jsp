<%-- 
    Document   : supply_imp
    Created on : Mar 10, 2014, 10:39:42 AM
    Author     : veeru
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <style>
            .style30 {color: black}
            .style31 {color: white}
            .style32 {color: green}
            .style33 {color: #c2000d}
            .heading
            {
                color: white;
                background-color: #c2000d;
            }
            .border
            {
                background-color: #c2000d;
            }
            .body
            {
                background-color:#EOFFFF; 
            }
            .pos_fixed
            {
                position:fixed;
                bottom:0px;
                background-color: #CCFFFF;
                border-color: red;
            }
        </style>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title> JSP Page</title>
        <script type="text/javascript">
            history.forward();
            function open1()
            {
                document.prgmfrm.action = "supplyview.jsp";
                document.prgmfrm.submit();
            }
            function open2()
            {
                document.prgmfrm.action = "improvementview.jsp";
                document.prgmfrm.submit();
            }
            
        </script>
    </head>
    <body class="body">
        <h3 class="style33"> Supplementary& <br>Improvement</h3>   <br><br>
        <form name="prgmfrm" target="admin1" action="" method="post" >
            <input type="radio" id="r1" name="r" value="View" onclick="open1();">Supplementary<br>
            <input type="radio" id="r2" name="r" value="Upload" onclick="open2();" >Improvement<br>
            
        </form>
    </body>
</html>
