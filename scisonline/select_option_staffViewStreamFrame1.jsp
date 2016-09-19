<%-- 
    Document   : select_option_staffViewStreamFrame1
    Created on : 15 Jun, 2013, 5:14:19 PM
    Author     : varun
--%>
<%@include file="checkValidity.jsp"%>
<%@page import="java.sql.ResultSet"%>
<%@include file="programmeRetrieveBeans.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="js/jquery.min.js"></script>
        <script type="text/javascript" >
            $(document).ready(function($) {
                $('#p1').change(function() {
                        var programme = $(this).val();
                        //Make AJAX request, using the selected value as the GET
                        $.ajax({
                            url: 'active_batch_programme_project.jsp?programme='+programme,
                            success: function(output) {
                                $('#year').html(output);
                            },
                            error: function (xhr, ajaxOptions, thrownError) {
                                
                            }
                        });
                        //*/
                    //}
                });
                $('#year').change(function(){
                    var programme = $('#p1').val();
                    var year = $('#year').val();
                    if(programme !== "" && year !== "") {
                            window.document.forms["form"].action = "select_option_staffViewStreamwise.jsp?streamName=" + programme + "&year=" + year;
                            document.form.submit();
                    }
                });
            });
        </script>

    </head>
    <body bgcolor="E0FFFF">
        <form  id="form" name="form" method="POST"  target="act_area1" >
            <%
                
                ResultSet rs = scis.getProgramme(1, "PhD");

            %>
            <table>
                <tr>
                    <select class="trigger" id="p1" name="pgname" style=" width: 100%">
                         <option>Programme</option>
                         <%while (rs.next()) {%>
                               <option><%=rs.getString(1)%></option>
                         <%}
                           //rs.beforeFirst();
                         %>
                    </select>
                </tr>
                </br></br>
                <tr>
                    <select class="trigger" id="year" name="year" style=" width: 100%">
                         <option>Select year</option>
                    </select>
                </tr>
            </table>
            &nbsp;&nbsp;
            
            <%rs.close();
              scis.close();
            %>
        </form>
    </body>
</html>