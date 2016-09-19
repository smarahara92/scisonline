<%-- 
    Document   : query_subjects_dropdown
    Created on : 8 Apr, 2015, 4:46:12 PM
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
        int year = scis.getLatestYear();
        scis.close();
        String sess = scis.getLatestSemester();
        scis.close();

        String id = request.getParameter("ID");
        String redirectPage = request.getParameter("RedirectPage");

        if(id == null || redirectPage == null) {
            out.println("Some internal problem occured...");
            return;
        }
        
        ResultSet rs = scis.subjectList(sess, year);
        
        %>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="js/jquery.min.js"></script>
        <script type="text/javascript" >
            $(document).ready(function($) {
                $('#sub1<%=id%>').change(function(){
                    var index = $("#sub1<%=id%> option:selected").index();
                    $('#sub2<%=id%> option:disabled').attr('disabled', false);
                    if(index !== 0) {
                        $('#sub2<%=id%> option:eq('+index+')').attr('disabled', true);
                    }
                });
                $('#sub2<%=id%>').change(function(){
                    var index = $("#sub2<%=id%> option:selected").index();
                    $('#sub1<%=id%> option:disabled').attr('disabled', false);
                    if(index !== 0) {
                        $('#sub1<%=id%> option:eq('+index+')').attr('disabled', true);
                    }
                });
                $('.subjects<%=id%>').change(function(){
                    var sub1 = $('#sub1<%=id%>').val();
                    var sub2 = $('#sub2<%=id%>').val();
                    if(sub1 !== '' && sub2 !== '') {
                        $('#target<%=id%>').load("<%=redirectPage%>?sess=<%=sess%>&year=<%=year%>&sub1="+sub1+"&sub2="+sub2);
                    }
                });
            });
        </script>
    </head>
    <body>
        <table align="center" class="noPrint">
            <tr>
                <td>
                    <select class="subjects<%=id%> noPrint" id="sub1<%=id%>" name="sub1<%=id%>">
                        <option value="" > Select Subject 1 </option>
<%
                        while(rs.next()) {
%>
                                <option value="<%=rs.getString(1)%>" ><%=rs.getString(2)%></option>
<%
                        }
                        rs.beforeFirst();
%>
                        
                    </select>
                </td>
                <td>
                    <select class="subjects<%=id%> noPrint" id="sub2<%=id%>" name="sub2<%=id%>">
                        <option value="" > Select Subject 2 </option>
<%
                        while(rs.next()) {
%>
                            <option value="<%=rs.getString(1)%>" ><%=rs.getString(2)%></option>
<%
                        }
                        scis.close();
%>
                    </select>
                </td>
            </tr>      
        </table>
        <div id="target<%=id%>"> </div>
    </body>
</html>