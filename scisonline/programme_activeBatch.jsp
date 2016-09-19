<%-- 
    Document   : programme_activeBatch
    Created on : 6 Apr, 2015, 11:34:24 PM
    Author     : deep
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
        String rdirectPage = request.getParameter("RdirectPage");
        %>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="js/jquery.min.js"></script>
        <script type="text/javascript" >
            $(document).ready(function($) {
                $('#pgname<%=id%>').change(function() {
                    var programme = $(this).val();
                    //Make AJAX request, using the selected value as the GET
                    $.ajax({
                        url: 'ajax_active_batch.jsp?programme='+programme,
                        success: function(output) {
                            $('#year<%=id%>').html(output);
                        }
                    });
                    $('#target<%=id%>').slideUp();
                });
                
                $('#year<%=id%>').change(function(){
                    //alert("<%=rdirectPage%>");
                    var programme = $('#pgname<%=id%>').val();
                    var year = $('#year<%=id%>').val();
                    if(programme !== "" && year !== "") { 
                        $('#target<%=id%>').load("<%=rdirectPage%>?pgname=" + programme + "&year=" + year);
                        $('#target<%=id%>').slideDown();
                    }
                });//*/
            });
        </script>
    </head>
    <body>
        <center>
        <table>
            <tr>
                <select class="prgBatch<%=id%> noPrint" id="pgname<%=id%>" name="pgname<%=id%>">
                    <option value="">Programme</option>
                    <%
                        ResultSet rs = scis.getStream("PhD");
                            while (rs.next()) {%>
                                <option value="<%=rs.getString(1)%>"><%=rs.getString(1)%></option>

                    <%}%>
                            
                </select>
            </tr>&nbsp;&nbsp;
            <tr>
                <select class="prgBatch<%=id%> noPrint" id="year<%=id%>" name="year<%=id%>">
                    <option value="">select Year</option>
                </select>
            </tr>
            <%
            rs.close();
            scis.close_phd();
            %>
        </table>
        </center>
        <div id="target<%=id%>"> </div>
    </body>
</html>
