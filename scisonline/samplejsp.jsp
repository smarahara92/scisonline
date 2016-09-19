<%-- 
    Document   : samplejsp
    Created on : Mar 23, 2014, 11:27:21 AM
    Author     : veeru
--%>
<%@include file="checkValidity.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
       
        <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.2.6/jquery.min.js"></script>

        <link rel="stylesheet" type="text/css" href="jkoutlinemenu.css" />

        <script type="text/javascript" src="jkoutlinemenu.js">

        </script>

    </head>
    <body>
       <a href="#" id="designanchor">Web Design Links</a>
       
     

        <div id="mymenu1" class="outlinemenu">
            <ul>
                <li><a href="http://www.dynamicdrive.com/">JavaScript Kit</a></li>
                <li><a href="http://www.dynamicdrive.com/" >Dynamic Drive</a></li>
                <li><a href="http://www.dynamicdrive.com/style/" >CSS Library</a></li>
                <li><a href="http://www.javascriptkit.com/jsref/">JavaScript Reference</a></li>
                <li><a href="http://www.javascriptkit.com/domref/">DOM Reference</a></li>
                <li><a href="http://www.cssdrive.com">CSS Drive</a></li>
                <li><a href="http://www.codingforums.com/" style="border-bottom-width: 0">Coding Forums</a></li>		
            </ul>
        </div>

        <script type="text/javascript">
            jkoutlinemenu.definemenu("designanchor", "mymenu1", "mouseover", 180)
        </script>


    </body>
</html>
