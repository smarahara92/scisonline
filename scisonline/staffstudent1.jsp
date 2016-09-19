<%-- 
    Document   : staffstudent1
    Created on : Mar 14, 2014, 3:09:24 PM
    Author     : veeru
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script type="text/javascript">

            function link1()
            {

                var stuid = document.getElementById("st").value;
              
                if (stuid === "") {
                    parent.bottom1.location = "./BalankPage2.jsp";
                     parent.act_area1.location = "./BalankPage2.jsp";
                    document.getElementById("errfn").innerHTML = "Enter Student Id.";
                    return false;
                } else {
                    
                    document.getElementById("errfn").innerHTML = "";

                    parent.act_area1.location = "./BalankPage2.jsp";

                    parent.bottom1.location = "./aslink6.jsp?studentId="+stuid;
                    return true;

                }

            }


        </script>   
    </head>
    <body>
        <form name="frm" target="bottom1" action="aslink6.jsp" onsubmit=" return link1();">
            <table>
                <caption><h3 style="color: darkred">Student Id :</h3></caption>
                <tr>

                    <td>
                        <input type="text" value="" id="st" name="studentId" size="12" onchange="link1();">
                    </td>
                </tr>

            </table>
            <br>
            <div id="errfn" style="color: darkred"></div>
        </form>
    </body>
</html>
