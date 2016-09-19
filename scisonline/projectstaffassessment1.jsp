<%-- 
    Document   : projectstaffassessment1
    Created on : Mar 14, 2014, 12:09:11 PM
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
                if (id === "update")
                {

                    parent.act_area.location = "./BalankPage2.jsp";

                    parent.bottom.location = "./projectStaffAssessment1.jsp";

                }

                else if (id === "view")
                {

                    parent.act_area.location = "./BalankPage2.jsp";
                   
                    parent.bottom.location = "./projectStaffView1.jsp";




                } else if (id === "summary")
                {

                    parent.act_area.location = "./BalankPage2.jsp";

                    parent.bottom.location = "./projectStaffSummary1.jsp";
                } else if (id === "da")
                {

                    parent.act_area.location = "./BalankPage2.jsp";

                    parent.bottom.location = "./degree_awarded1.jsp";
                }


            }


        </script>   
    </head>
    <body>
        <form name="frm" target="bottom">
            <h3>Project:</h3>
            <table>
               
                <tr><td><input type="radio" name="update" id="update" value="Update"  onclick="link1(this.id);">Update</td></tr>
                <tr><td><input type="radio" name="update" id="view" value="View" onclick="link1(this.id);">View</td></tr>
                <tr><td><input type="radio" name="update" id="summary" value="Summary" onclick="link1(this.id);">Summary</td></tr>
                <tr><td><input type="radio" name="update" id="da" value="Summary" onclick="link1(this.id);">Degree Awarded</td></tr>
            </table>
    </body>
</html>
