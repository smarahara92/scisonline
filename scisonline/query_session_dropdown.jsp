<%-- 
    Document   : query_session_dropdown
    Created on : 8 Apr, 2015, 3:13:04 PM
    Author     : nwlab
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
                $('.sessYear<%=id%>').change(function(){
                    var sess = $('#session<%=id%>').val();
                    var year = $('#year<%=id%>').val();
                    if(sess !== '' && year !== '') {
                        $('#target<%=id%>').load("<%=rdirectPage%>?sess=" + sess + "&year=" + year);
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
                    <select class="sessYear<%=id%> noPrint" id="session<%=id%>" name="session<%=id%>">
                        <option value="" > Select Session </option>
<%
                            ResultSet rs = scis.semesterList(1);
                            while(rs.next()) {
%>
                                <option value="<%=rs.getString("SemesterName")%>" ><%=rs.getString("SemesterName")%></option>
<%                                
                            }
                            scis.close();
%>
                        
                    </select>
                    <select class="sessYear<%=id%> noPrint" id="year<%=id%>" name="year<%=id%>">
                        <option value="" >Select Year</option>
<%
                            int year1 = scis.getOldestYear();
                            scis.close();
                            int year2 = scis.getLatestYear();
                            scis.close();
                            for(int year = year2; year >= year1; --year) {
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
</html>
