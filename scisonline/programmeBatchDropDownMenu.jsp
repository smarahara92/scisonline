<%-- 
    Document   : programmeBatchDropDownMenu
    Created on : Mar 30, 2015, 5:02:54 PM
    Author     : richa
--%>

<%@page import="java.sql.ResultSet"%>
<%@include file="programmeRetrieveBeans.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <%
        String id = request.getParameter("id");
        String RedirectPage = request.getParameter("RedirectPage");
        System.out.println(id);
    %>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="js/jquery.min.js"></script>
        <script type="text/javascript" >
            $(document).ready(function($) {
                
                              //  alert('pbg');
                $("#pgname<%=id%>").change(function() {
                    var programme = $('#pgname<%=id%>').val();
                    
                    if (programme === "none"){
                        
                    } else {
                        //Make AJAX request, using the selected value as the GET
                        
                        $.ajax({url: 'active_batch_programme.jsp?programme='+programme, success: function(output) {
                            $('#year<%=id%>').html(output);
                        },
                        error: function (xhr, ajaxOptions, thrownError) {

                        }});
                    }
                });
                
                $('#year<%=id%>').change(function(){
                    var pname = $('#pgname<%=id%>').val();
                    var pyear = $('#year<%=id%>').val();
                //    alert(pname+pyear);
                    $('#target1<%=id%>').load("<%=RedirectPage%>?pname="+pname+"&pyear="+pyear);
                });
            });
        </script>
    </head>
    <body bgcolor="E0FFFF">
     
        <form  id="form" name="form" method="POST" action="" target="act_area" > 
            <table align ="center">
                
                <tr>
                    <td>
                            <select class="prgBatch<%=id%>" id="pgname<%=id%>" name="pgname" style=" width: 100%">
                                <option style=" alignment-adjust: central" value = "none">Select Programme</option>
                                <%

                                    ResultSet rs1 = null;
                                    rs1 = scis.getProgramme(1, "PhD");
                                    while (rs1.next()) {

                                %>

                                <option onclick="to(this.value);" value="<%=rs1.getString(1)%>"><%=rs1.getString(1)%></option>
                                <%

                                    } 
                                %>
                            </select>
                        </td>
                
                        <td>
                            <select class="prgBatch<%=id%>" id="year<%=id%>" name="year" style=" width: 100%">
                               <option style=" alignment-adjust: central" value="none">Select Year</option>
                            </select>
                        </td>
                </tr>
            </table>
        </form>
        <div id="target1<%=id%>"></div>
    </body>
    <%
        scis.close();
    %>
</html>
