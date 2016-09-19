<%-- 
    Document   : project_unallocatedstudent1
    Created on : 12 Feb, 2015, 4:42:56 PM
    Author     : deep
--%>
<%@include file = "checkValidity.jsp" %>
<%@include file="connectionBean.jsp"%>
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
                $('#pg').change(function() {
                        var programme = $(this).val();
                        //Make AJAX request, using the selected value as the GET
                        $.ajax({
                            url: 'ajax_active_batch.jsp?programme='+programme,
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
                    var programme = $('#pg').val();
                    var year = $(this).val();
                    window.document.forms["forrm"].action = "project_unallocatedstudentlist.jsp?pgname=" + programme + "&year=" + year;
                    document.forrm.submit();
                });
            });
        </script>

    </head>
    <body>
        <form  id="frmm" name="forrm" method="POST" target="bottom" >
            <center>
            <table>
                <tr>
                            <select id="pg" name="r" onchange="";>
                                <option>Programme</option>
                                <%  //Connection con = conn.getConnectionObj();  
                                //Statement st = con.createStatement();
                                    ResultSet rs = scis.getStream("PhD");
                                    while (rs.next()) {
                                %>
                            <option value="<%=rs.getString(1)%>" onclick=""><%=rs.getString(1)%></option>

                            <%}%>
                            
                            </select>
                </tr>
                            &nbsp;&nbsp;
                <tr>        <select id="year" name="year";>
                                <option value="">Choose Year</option>
                            </select>
                    
                        
                </tr>
                <%
                   rs.close();
                   scis.close();
                %>
            </table>
                </center>
        </form>
    </body>
</html>
