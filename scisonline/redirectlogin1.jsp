<%-- 
    Document   : redirectlogin1
    Created on : Apr 10, 2014, 10:49:26 AM
    Author     : veeru
--%>
<%@include file="checkValidity.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="css/style.css" rel="stylesheet" type="text/css">
        <script type="text/javascript" src="js/jquery.min.js"></script>
        <script language="javascript" type="text/javascript" src="js/vpb_script.js"></script>
        <script>
            
            function onload1() {

                vpb_show_login_box();
               
            }
        </script>
    </head>
    <body onload="onload1();">

        <!-- Login Box Starts Here -->
        <div id="vpb_login_pop_up_box" class="vpb_signup_pop_up_box">
            <div align="left" style="font-family:Verdana, Geneva, sans-serif; font-size:16px; font-weight:bold;">Users Login Box</div><br clear="all">
            <div align="left" style="font-family:Verdana, Geneva, sans-serif; font-size:11px;">To exit this login box, click on the cancel button or outside this box..</div><br clear="all"><br clear="all">

            <div style="width:100px; padding-top:10px;margin-left:10px;float:left;" align="left">Your Username:</div>
            <div style="width:300px;float:left;" align="left"><input type="text" id="usernames" name="usernames" value="" class="vpb_textAreaBoxInputs"></div><br clear="all"><br clear="all">

            <div style="width:100px; padding-top:10px;margin-left:10px;float:left;" align="left">Your Password:</div>
            <div style="width:300px;float:left;" align="left"><input type="password" id="passs" name="passs" value="" class="vpb_textAreaBoxInputs"></div><br clear="all"><br clear="all">

            <div style="width:100px; padding-top:10px;margin-left:10px;float:left;" align="left">&nbsp;</div>
            <div style="width:300px;float:left;" align="left">

                <a href="javascript:void(0);" class="vpb_general_button" onClick="alert('Hello There!\n\n There is no functionality associated with the button you have just clicked. \n\nThis is just a demonstration of Pop-up Boxes and that\'s all.\n\nThanks.');">Login</a>

                <a href="javascript:void(0);" class="vpb_general_button" onClick="vpb_hide_popup_boxes();">Cancel</a>
            </div>

            <br clear="all"><br clear="all">
        </div>
        <!-- Login Box Ends Here -->

    </body>
</html>
