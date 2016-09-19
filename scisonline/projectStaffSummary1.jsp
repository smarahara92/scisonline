<%-- 
    Document   : ProjectStaffSummary1
    Created on : 2 May, 2013, 5:39:10 AM
    Author     : varun
--%>
<%@include file="checkValidity.jsp"%>
<%--@include file="connectionBean.jsp"--%> 
<%@page import="java.sql.*"%>
<%@include file="programmeRetrieveBeans.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="js/jquery.min.js"></script>
        <script type="text/javascript" >
            $(document).ready(function($) {
                $("#pg").change(function() {    
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
                    
                });
                $('#year').change(function(){
                    var programme = $('#pg').val();
                    var year = $(this).val();
                    window.document.forms["form"].action = "projectStaffSummaryCS.jsp?pgname=" + programme + "&year=" + year;
                    document.form.submit();
                });
            });
        </script>


    </head>
    <body>
        <form  id="form" name="form" method="POST" action="" target="act_area" >
            <h3> By Stream: </h3> 
            <table align="center">
                <tr>  
                        <select id="pg" name="r" style="width: 50%">
                            <option>Programme</option>
                            <%
                                ResultSet rs = scis.getProgramme(1, "PhD");
                                while (rs.next()) {
                            %>
                            %>
                            <option value="<%=rs.getString(1)%>"><%=rs.getString(1)%></option>
                            <%}%> 
                        </select>
                </tr>
                 </br></br>
                <tr>
                         <select id="year" name="year" style="width: 50%">
                            <option value="">Select Year</option>
                        </select>
                </tr>
                    

            </table>

            <div id="errfn" align="left" style="color: red"></div>
            <br>  
            <table>
                <tr> 
                    <td valign="top"> <h4> <font color="yellow"> Yellow </font> </h4>  </td> 
                    <td><h5> : Panel/External Marks not entered by Staff </h5> </td> 
                </tr>
                <tr> 
                    <td valign="top"> <h4> <font color="red"> Red </font> </h4>  </td> 
                    <td><h5> : Supervisor Marks not entered by Faculty </h5> </td> 
                </tr>
                <% 
                   rs.close(); 
                   scis.close();
                %>
            </table> 
        </form>
    </body>
</html>
