<%-- 
    Document   : staffImprovementSupplementary1
    Created on : Apr 13, 2014, 2:16:30 PM
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

            function link1(id)
            {


                if (id === "view")
                {

                    parent.bottom.location = "./BalankPage2.jsp";
                    parent.adminaction.location = "./staffsupplyview.jsp";

                }

                else if (id === "sup")
                {

                    parent.adminaction.location = "./BalankPage2.jsp";

                    parent.bottom.location = "./sup_registration2.jsp";




                } else if (id === "imp")
                {

                    parent.bottom.location = "./BalankPage2.jsp";

                    parent.adminaction.location = "./imp_registration.jsp";
                }

            }


        </script>   
    </head>
    <body>
        <form name="frm" target="bottom">
            <h3 style="color: darkred">Supplementary/Improvement :</h3>
            <table>
                <tr><td><input type="radio" name="update" id="view" value="view" onclick="link1(this.id);">View</td></tr>
                <tr><td><input type="radio" name="update" id="sup" value="sup" onclick="link1(this.id);">Supplementary Registration</td></tr>
                <tr><td><input type="radio" name="update" id="imp" value="imp" onclick="link1(this.id);">Improvement Registration</td></tr>
            </table>
    </body>
</html>
