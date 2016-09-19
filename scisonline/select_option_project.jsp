<%-- 
    Document   : projectRegistrationFacultySelect1
--%>

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
                var target_id = 'year';
                var initial_target_html = '<option style=" alignment-adjust: central" value="none">Select year of joining</option>'; //Initial prompt for target select
                
                $('#'+target_id).html(initial_target_html); //Give the target select the prompt option
                $("#pg").change(function() {
                    var programme = $('#pg').val();
                    
                    //Display 'loading' status in the target select list
                    $('#'+target_id).html('<option value="">Loading...</option>');
                    if (programme === "none"){
                        $('#'+target_id).html(initial_target_html);
                    } else {
                        //Make AJAX request, using the selected value as the GET
                        $.ajax({url: 'ajax_active_batch.jsp?programme='+programme, success: function(output) {
                            $('#'+target_id).html(output);
                        },
                        error: function (xhr, ajaxOptions, thrownError) {
                            System.out.println(xhr.status + " "+ thrownError);
                            System.out.println(ajaxOptions);
                        }});
                    }
                });
                $('#'+target_id).change(function(){
                    var programme = $('#pg').val();
                    var year = $('#year').val();
                    
                    
                    if (programme === "MCA") {
                        parent.act_area.location = "select_option_staffProjectMCA.jsp?stream="+programme+"&batch="+year;
                    } else {
                        parent.act_area.location = "select_option_staffProjectStreamFrame.jsp?stream="+programme+"&batch="+year;
                    }
                });
            });
        </script>
    </head>
    <body bgcolor="E0FFFF">
        <form  id="form" name="form" method="POST" action="" target="act_area" > 
            <table align="center">
                <tr> 
                        <td>
                            <select id="pg" name="pgname" style=" width: 100%">
                                <option style=" alignment-adjust: central" value = "none">Select Stream</option>
                                <%

                                    ResultSet rs1 = null;
                                    rs1 = scis.getStream("PhD");
                                    while (rs1.next()) {

                                %>

                                <option onclick="to(this.value);" value="<%=rs1.getString(1)%>"><%=rs1.getString(1)%></option>
                                <%

                                    } 
                                    rs1.close();
                                    scis.close();
                                %>
                            </select>
                        </td>
                        <td>&nbsp;</td>
                        
                        <td>
                            <select id="year" name="year" style=" width: 100%"></select>
                        </td>
                </tr>
            </table>
        </form>
    </body>
</html>
