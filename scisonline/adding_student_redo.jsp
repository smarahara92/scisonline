<%-- 
    Document   : adding_student_redo
    Created on : Aug 7, 2013, 9:10:15 PM
    Author     : veeru
--%>
<%@include file="checkValidity.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
    </head>
    <body>
        <form name="frm2" action="" method="post" >
            <table align='center'>
                
            </table>&nbsp;
            <table align='center' >
                <caption><h3>Adding data for M.Tech(cs)-2013</h3></caption>
                <tr>
                    <td border="1" > <input type="button" id="bold" name="r" value="Upload" onclick="javascript:window.location = 'sFile.jsp';"><b></b>&nbsp;
                        <input type="button" id="bold" name="r" value="Add" onclick="javascript:window.location = 'addingstudent.jsp';"><b></b></td>
                </tr>
            </table>
        </form>
    </body>
</html>
