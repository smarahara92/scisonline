<%-- 
    Document   : triggering.jsp
    Created on : May 8, 2013, 12:39:56 AM
    Author     : root
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <%
            String sname = request.getParameter("subjectname");
            String sid = request.getParameter("subjectid");
            String type = request.getParameter("type").trim();
            String year = request.getParameter("year");
    %>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" type="text/css" href="button.css">

        <script type="text/javascript">
            function checked1(a, b) {
                // alert(b);
                window.document.forms["frm"].action = "Selection.jsp?subjectname=" + a + "&subjectid=" + b + "";
                window.document.forms["frm"].submit();
            }
            function checked2() {
                document.forms.frm.submit();
            }

            function link1() {

                var type;

                if (document.getElementById('r2').checked) {
                    type = document.getElementById('r2').value;
                }
                if (document.getElementById('r3').checked) {
                    type = document.getElementById('r3').value;
                }
                if (document.getElementById('r4').checked) {
                    type = document.getElementById('r4').value;
                }
                
                if (type === "Mid-Term") {
                    document.frm.action = "projectFacultyAssessmentInt.jsp?pgname=<%=sname%>&year=<%=year%>";
                    document.frm.submit();
                } else if (type === "Final") {

                    document.frm.action = "projectFacultyAssessmentExt.jsp?pgname=<%=sname%>&year=<%=year%>";
                    document.frm.submit();
                } else if (type === "Status") {

                    document.frm.action = "projectFacultyAssessmentstatus.jsp?pgname=<%=sname%>&year=<%=year%>";
                    document.frm.submit();
                }

            }
        </script>   
    </head>
    <body onload="document.forms.frm.submit();">

        

        <%            if (type.equalsIgnoreCase("p") == true) {
        %><form name="frm" target="facultyaction" method="POST">
            <input type="hidden" id="pname" value="<%=sid%>">
            <table align="left">
                <tr>
                    <td>
                        <input type="radio" id="r2" name="r1" value="Mid-Term"  onClick="link1()">Mid-Term<br>
                        <input type="radio" id="r3" name="r1" value="Final"  onClick="link1()">Final<br>
                        <input type="radio" id="r4" name="r1" value="Status"  onClick="link1()">Status<br>
                    </td>
                </tr>


            </table>
        </form>
        <%
        } else {
        %>
        <form name="frm" action="Selection.jsp?subjectname=<%=sname%>&subjectid=<%=sid%>" target="facultyaction" method="POST">
            <input type="radio" name="selectmarks" value="Minor_1"  onClick="checked1('<%=sname%>', '<%=sid%>');">Minor1 Marks<br>
            <input type="radio" name="selectmarks" value="Minor_2" onClick="checked1('<%=sname%>', '<%=sid%>');">Minor2 Marks<br>
            <input type="radio" name="selectmarks" value="Minor_3" onClick="checked1('<%=sname%>', '<%=sid%>');">Minor3 Marks<br>
            <input type="radio" name="selectmarks" value="Major" onClick="checked1('<%=sname%>', '<%=sid%>');">Major Marks<br>
            <input type="radio" name="selectmarks" value="Internal_Major Marks" onClick="checked1('<%=sname%>', '<%=sid%>');">Semester Marks<br>

        </form>
        <%  }%>


    </body>
</html>
