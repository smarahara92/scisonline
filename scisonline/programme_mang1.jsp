<%-- 
    Document   : sub
    Created on : Jul 11, 2013, 1:46:46 PM
    Author     : veeru
--%>
<%@include file="checkValidity.jsp"%>
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
                document.prgmfrm.action = "programme_mang2.jsp";
                document.prgmfrm.submit();
            }
            function open2()
            {
                document.prgmfrm.action = "programm_mang_update.jsp";
                document.prgmfrm.submit();
            }
            function open3()
            {
                document.prgmfrm.action = "programme_mang_upload2.jsp";
                document.prgmfrm.submit();
            }
            function open4()
            {
                document.prgmfrm.action = "programme_delete.jsp";
                document.prgmfrm.submit();
            }
        </script>
    </head>
    <body class="body">
        <h3 class="style33"> Programme Management</h3>   <br><br>
        <form name="prgmfrm" target="subdatabase" action="" method="post" >
            <input type="radio" id="r1" name="r" value="View" onclick="open1();">View Curriculum<br>
            <input type="radio" id="r2" name="r" value="Upload" onclick="open2();" >Add Programme<br>
            <input type="radio" id="r3" name="r" value="Update Curriculum" onclick="open3();">Update Curriculum<br>
            <input type="radio" id="r4" name="r" value="Delete" onclick="open4();">Delete Programme<br>
            <input type="Submit" style="display:none;" value="submit" onclick="">
        </form>
    </body>
</html>
