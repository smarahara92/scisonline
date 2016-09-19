<%-- 
    Document   : query_prg_fac_year_dropdown.jsp
    Created on : 30 Apr, 2015, 2:36:29 AM
    Author     : root
--%>

<%@page import="java.sql.ResultSet"%>
<%@include file="checkValidity.jsp" %>
<%@include file="programmeRetrieveBeans.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head> <%
        String id = request.getParameter("ID");
        String rdirectPage = request.getParameter("RedirectPage");
        int year1 = scis.getOldestYear();
        int year2 = scis.getLatestYear(); %>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="js/jquery.min.js"></script>
        <script type="text/javascript" >
            $(document).ready(function($) {
                $('#year1<%=id%>').change(function(){
                    var index = $("#year1<%=id%> option:selected").index();
                    $('#year2<%=id%> option:disabled').attr('disabled', false);
                    for(var i = 0; i<index;i++ ) {
                        $('#year2<%=id%> option:eq('+i+')').attr('disabled', true);
                    }
                });
                
                $('#year2<%=id%>').change(function(){
                    var index = $("#year2<%=id%> option:selected").index();
                    $('#year1<%=id%> option:disabled').attr('disabled', false);
                    var len = $('#year1<%=id%> option').length;
                    for(var i = index+1; i<=len;i++ ){
                        $('#year1<%=id%> option:eq('+i+')').attr('disabled', true);
                    }
                });
                
                $('.facYear<%=id%>').change(function(){
                    var fac = $('#facId<%=id%>').val().trim();
                    var year1 = $('#year1<%=id%>').val().trim();
                    var year2 = $('#year2<%=id%>').val().trim();
                    var stream = $('#stream<%=id%>').val().trim();
                    if(stream !== '' && fac !== '' && year1 !== '' && year2 !== '') {
                        $('#target<%=id%>').load("<%=rdirectPage%>?stream="+stream+"&fac_id="+fac+"&year1="+year1+"&year2="+year2);
                        $('#target<%=id%>').slideDown();
                    } else {
                        $('#target<%=id%>').slideUp();
                    }
                });
            });
        </script>
    </head>
    <body>
        <table align="center" class="noPrint" width="100%">
            <tr>
                <td> 
                    <select class="facYear<%=id%> noPrint" id="stream<%=id%>" name="stream<%=id%>" style="width:22%;">
                        <option value="" > Select Programme </option>
                        <option value="all" > All Programme </option> <%
                        ResultSet rs0 = scis.getStream("PhD");
                        while(rs0 != null && rs0.next()) { 
                        String prg = rs0.getString(1).replace('_', '-'); %>
                            <option value="<%=prg%>"><%=prg%></option> <%
                        } %>
                    </select>&nbsp;
                    <select class="facYear<%=id%> noPrint" id="facId<%=id%>" name="facId<%=id%>" style="width:30%;">
                        <option value="" > Select Faculty </option> <%
                        ResultSet rs = scis.facultyList();
                        while(rs != null && rs.next()) { %>
                                <option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option> <%
                        } %>
                    </select>&nbsp;&nbsp;
                    From:&nbsp;
                    <select class="facYear<%=id%> noPrint" id="year1<%=id%>" name="year1<%=id%>" style="width:15%;"> <%
                        for(int year = year1; year <= year2; ++year) { %>
                            <option value="<%=year%>" ><%=year%> batch</option> <%                                
                        } %>
                    </select>&nbsp;&nbsp;
                    To:&nbsp;
                    <select class="facYear<%=id%> noPrint" id="year2<%=id%>" name="year2<%=id%>" style="width:15%;"> <%
                        for(int year = year1; year < year2; ++year) { %>
                            <option value="<%=year%>" ><%=year%> batch</option> <%                                
                        } %>
                        <option value="<%=year2%>" selected><%=year2%> batch</option>
                    </select>
                </td>
            </tr>      
        </table>
        <div id="target<%=id%>"> </div>
    </body> <%
    scis.close(); %>
</html>
