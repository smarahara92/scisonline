<%-- 
    Document   : staffstream1
    Created on : Mar 14, 2014, 3:45:00 PM
    Author     : veeru
--%>

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

                    parent.staffaction.location = "./BalankPage2.jsp";

                    parent.bottom.location = "./aslink1.jsp";

                }

                else if (id === "summary")
                {

                    parent.staffaction.location = "./BalankPage2.jsp";

                    parent.bottom.location = "./aaslink1.jsp";
                }

            }


        </script>   
    </head>
    <body>
        <table>
            <caption><h3 style="color: darkred">Stream:</h3></caption>
            <tr><td><input type="radio" name="update" id="view" value="View" onclick="link1(this.id);">View</td></tr>
            <tr><td><input type="radio" name="update" id="summary" value="Summary" onclick="link1(this.id);">Summary</td></tr>
        </table>
    </body>
</html>
