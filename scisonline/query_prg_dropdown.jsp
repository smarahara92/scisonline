<%-- 
    Document   : query_prg_dropdown
    Created on : 22 Apr, 2015, 2:44:20 PM
    Author     : nwlab
--%>

<%@include file="checkValidity.jsp" %>
<%@page import="java.sql.*"%>
<%@include file="programmeRetrieveBeans.jsp"%>
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
                $('#pgname<%=id%>').change(function(){
                    var programme = $('#pgname<%=id%>').val();
                    if(programme !== '') {
                        $.ajax({
                            url: 'ajax_curriculum_year_dropdown.jsp?programme='+programme,
                            success: function(output) {
                                $('#currYear<%=id%>').html(output);
                            }
                        });
                    }
                    $('#target<%=id%>').slideUp();
                });
                $('#currYear<%=id%>').change(function(){
                    var programme = $('#pgname<%=id%>').val();
                    var year = $('#currYear<%=id%>').val();
                    if(programme !== '' && year !== '') {
                        $('#target<%=id%>').load("<%=rdirectPage%>?programme="+programme+"&currYear="+year);
                        $('#target<%=id%>').slideDown();
                    } else {
                        $('#target<%=id%>').slideUp();
                    }
                });
            });
        </script>
    </head>
    <body>
        <center>
        <table>
            <tr>
                <select class="prgBatch<%=id%> noPrint" id="pgname<%=id%>" name="pgname<%=id%>">
                    <option value="">Select Programme</option> <%
                    ResultSet rs = scis.getProgramme(1);
                    while (rs.next()) { %>
                        <option value="<%=rs.getString(1)%>"><%=rs.getString(1)%></option> <%
                    } %>
                </select>&nbsp;
                <select class="prgBatch<%=id%> noPrint" id="currYear<%=id%>" name="currYear<%=id%>">
                    <option value="">Select Curriculum Year</option>
                </select>
            </tr>
        </table>
        </center>
        <div id="target<%=id%>"> </div>
    </body> <%
    rs.close();
    scis.close(); %>
</html>