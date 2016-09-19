<%-- 
    Document   : studentsubject1
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script type="text/javascript">
            function link1(id) {
                if (id === "view") {
                    parent.studentaction.location = "./studentMarks.jsp";
                } else if (id === "dv") {
                    parent.studentaction.location = "./studentsummary.jsp";
                } else if (id === "sum") {
                    parent.studentaction.location = "./Studentwise.jsp";
                }
            }
        </script>   
    </head>
    <body>
        <table>
            <caption><h3 style="color: darkred">Subject:</h3></caption>
            <!--<tr><td><input type="radio" name="update" id="view" value="View" onclick="link1(this.id);">View</td></tr>-->
            <tr><td><input type="radio" name="update" id="dv" value="dv" onclick="link1(this.id);">View</td></tr>
            <tr><td><input type="radio" name="update" id="sum" value="Summary" onclick="link1(this.id);">Summary</td></tr>
        </table>
    </body>
</html>
