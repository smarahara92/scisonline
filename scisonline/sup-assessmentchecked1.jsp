<%-- 
    Document   : sup-assessmentchecked1
    Created on : May 28, 2013, 7:39:13 AM
    Author     : root
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script type="text/javascript">


            function checked1(temp, a, b, c)
            {

                if (temp == 1)
                {
                    window.document.forms["frm"].action = "sup-assessment2.jsp?subjectname=" + a + "&subjectid=" + b + "";
                    window.document.forms["frm"].submit();
                }
                else if (temp == 2)
                {
                    window.document.forms["frm"].action = "sup-assessment4.jsp?subjectname=" + a + "&subjectid=" + b + "&fid=" + c + "";
                    window.document.forms["frm"].submit();
                }

            }
        </script>
    </head>
    <body onload="document.forms.frm.submit();">

        <%
            String sname = request.getParameter("subjectname");
            String subjectid = request.getParameter("subjectid");
            String fid = request.getParameter("fid");
            
        %>
        <form name="frm" action="sup-assessment2.jsp?subjectname=<%=sname%>&subjectid=<%=subjectid%>" target="facultyaction1" method="POST">
            <center>
                <input type="radio" name="selectstream" checked="yes"  onClick="checked1(1, '<%=sname%>', '<%=subjectid%>', '<%=fid%>');"><b>Update Marks&nbsp&nbsp
                    <input type="radio" name="selectstream"  onClick="checked1(2, '<%=sname%>', '<%=subjectid%>', '<%=fid%>');">View Marks&nbsp&nbsp

                    </center>
                    </form>
                    </body>
                    </html>
