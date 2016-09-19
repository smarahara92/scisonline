<%-- 
    Document   : projectquery1
    Created on : 2 Mar, 2015, 3:42:05 PM
    Author     : deep
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script type="text/javascript" >
            function run_query(q) {
                //alert(q);
                
                switch(q) {
                    case "q1" : parent.act_area1.location = "project_unallocatedstudent.jsp";
                                break;
                    case "q2" : parent.act_area1.location ="project_panelmarksstudent.jsp"; 
                                break;
                    case "q3" : parent.act_area1.location = "project_supervisormarksstudent.jsp";
                                break;
                    case "q4" : parent.act_area1.location = "project_externalmarksstudent.jsp";
                                break;
                    case "q5" : parent.act_area1.location = "project_degreeawardedstudent.jsp";
                                break;
                    case "q6" : parent.act_area1.location = "project_degreenotawardedstudent.jsp";
                                break;
                    case "q7" : parent.act_area1.location = "project_internshiptudent.jsp";
                                break;
                    case "q8" : parent.act_area1.location = "project_supervisormajormarksstudent.jsp";
                                break;
                }
            }
        </script>
    </head>
    <body>
     
            <input type="radio" name="query" value="q1" onclick="run_query(this.value);">
                List of all students to whom project is not allocated<br/>
            <input type="radio" name="query" value="q2" onclick="run_query(this.value);">
                List of all students whose panel marks are not entered<br/>
            <input type="radio" name="query" value="q3" onclick="run_query(this.value);">
                List of all students whose mid-term supervisor marks are not entered<br/>
            <input type="radio" name="query" value="q4" onclick="run_query(this.value);">
                List of all students whose external/panel major marks are not entered<br/>
            <input type="radio" name="query" value="q5" onclick="run_query(this.value);">
                List of all students to whom degree is awarded.<br/>
            <input type="radio" name="query" value="q6" onclick="run_query(this.value);">
                List of all students to whom degree is not awarded<br/>
            <input type="radio" name="query" value="q7" onclick="run_query(this.value);">
                List of all students who are doing internship<br/>
            <input type="radio" name="query" value="q8" onclick="run_query(this.value);">
                 List of all students whose major supervisor marks are not entered<br/>
    </body>
</html>



