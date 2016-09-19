<%-- 
    Document   : query_fac_year_dropdown
    Created on : 13 Apr, 2015, 9:24:53 PM
    Author     : root
--%>

<%@page import="java.sql.ResultSet"%>
<%@include file="checkValidity.jsp" %>
<%@include file="programmeRetrieveBeans.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <%
        String id = request.getParameter("ID");
        String rdirectPage = request.getParameter("RedirectPage");
        %>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="js/jquery.min.js"></script>
        <script type="text/javascript" >
            $(document).ready(function($) {
                $('#year1<%=id%>').change(function(){
                    var index = $("#year1<%=id%> option:selected").index();
                    $('#year2<%=id%> option:disabled').attr('disabled', false);
                    if(index !== 0) {
                        var len = $('#year2<%=id%> option').length;
                        for(var i = 1; i<index;i++ ){
                        $('#year2<%=id%> option:eq('+i+')').attr('disabled', true);
                    }
                    }
                });
                
                $('#year2<%=id%>').change(function(){
                    var index = $("#year2<%=id%> option:selected").index();
                    $('#year1<%=id%> option:disabled').attr('disabled', false);
                    if(index !== 0) {
                        var len = $('#year1<%=id%> option').length;
                        for(var i = index+1; i<=len;i++ ){
                        $('#year1<%=id%> option:eq('+i+')').attr('disabled', true);
                    }
                    }
                });
                
                $('.facYear<%=id%>').change(function(){
                    var fac = $('#facId<%=id%>').val().trim();
                    var year1 = $('#year1<%=id%>').val().trim();
                    var year2 = $('#year2<%=id%>').val().trim();
                    if(fac !== '' && year1 !== '' && year2 !== '') {
                        $('#target<%=id%>').load("<%=rdirectPage%>?fac_id="+fac+"&year1="+year1+"&year2="+year2);
                        $('#target<%=id%>').slideDown();
                    } else {
                        $('#target<%=id%>').slideUp();
                    }
                });
            });
        </script>
    </head>
    <body>
        <table align="center" class="noPrint">
            <tr>
                <td>
                    <select class="facYear<%=id%> noPrint" id="facId<%=id%>" name="facId<%=id%>" >
                        <option value="" > Select Faculty </option>
<%
                        ResultSet rs = scis.facultyList();
                        while(rs.next()) {
%>
                                <option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option>
<%
                        }
%>
                    </select>
                    &nbsp;&nbsp;&nbsp;
                    From:&nbsp;
                    <select class="facYear<%=id%> noPrint" id="year1<%=id%>" name="year1<%=id%>">
                        <option value="" >Select Year</option>
<%
                            int year1 = scis.getOldestYear();
                            int year2 = scis.getLatestYear();
                            for(int year = year1; year <= year2; ++year) {
%>
                                <option value="<%=year%>" ><%=year%></option>
<%                                
                            }
%>
                    </select>
                    &nbsp;&nbsp;
                    To:&nbsp;
                    <select class="facYear<%=id%> noPrint" id="year2<%=id%>" name="year2<%=id%>">
                        <option value="" >Select Year</option>
<%
                            for(int year = year1; year <= year2; ++year) {
%>
                                <option value="<%=year%>" ><%=year%></option>
<%                                
                            }
%>
                    </select>
                </td>
            </tr>      
        </table>
        <div id="target<%=id%>"> </div>
    </body>
<%
    scis.close();
%>
</html>
