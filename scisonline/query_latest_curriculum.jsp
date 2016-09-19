<%-- 
    Document   : query_latest_curriculum
    Created on : 18 Feb, 2015, 1:02:44 PM
    Author     : nwlab
--%>

<%@include file="programmeRetrieveBeans.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head> <%
        String prg = request.getParameter("programme");
        String year = request.getParameter("currYear"); %>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script type="text/javascript" >
            $(document).ready(function($) {
                $("#targetCurr").load("query_curr1.jsp?pname=<%=prg%>&year=<%=year%>");
                $("#currButton").click(function() {
                    var text = $(this).text();
                    if(text === "More") {
                        $("#targetCurr").load("query_curr0.jsp?pname=<%=prg%>&year=<%=year%>");
                        $(this).text("Less");
                    } else {
                        $("#targetCurr").load("query_curr1.jsp?pname=<%=prg%>&year=<%=year%>");
                        $(this).text("More");
                    }
                });
            });
        </script>
    </head>
    <body>
        <br/>
        <button id="currButton" class = "noPrint">More</button>
        <h3 style="color:#c2000d" align="center">Latest curriculum of <%=prg%> - <%=year%></h3>
        <div id="targetCurr"></div>
    </body> <%
    scis.close(); %>
</html>
