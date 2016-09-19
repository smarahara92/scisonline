<%-- 
    Document   : projectFacultyModify
    Created on : 27 May, 2013, 7:02:01 AM
    Author     : varun
--%>
<%@include file="connectionBean.jsp"%>
<%@include file="programmeRetrieveBeans.jsp"%>
<%@page import="java.sql.ResultSet"%>
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
                            url: 'ajax_active_batch.jsp?programme='+programme,
                            success: function(output) {
                                $('#year').html(output);
                            },
                            error: function (xhr, ajaxOptions, thrownError) {
                                
                            }
                        });
                        //*/
                  //  }
                });
                $('#year').change(function(){
                    var programme = $('#pg').val();
                    //alert(programme);
                    var year = $(this).val();
                    if(programme === "MCA"){
                       // alert(programme);
                        window.document.forms["form"].action = "projectFacultyModifyMCA.jsp?pgname=" + programme + "&year=" + year;
                    }
                    else{
                        window.document.forms["form"].action = "projectFacultyModifyMtech.jsp?pgname=" + programme + "&year=" + year;
                    }
                    document.form.submit();
                });
            });
        </script>


    </head>
    <body bgcolor="E0FFFF">
        <form  id="form" name="form" method="POST" action="" target="act_area" >

            <form id="frm" id="frm">
                <table>
                    <tr>
                        &nbsp;&nbsp;
                        <td> &nbsp;
                            <select id="pg" name="pgname" onchange="" style=" width: 100%">
                                <option style=" alignment-adjust: central">Select Stream</option>
                                <%

                                    ResultSet rs1 = null;
                                    rs1 = scis.getStream("PhD");
                                    while (rs1.next()) {

                                %>

                                <option onclick="" value="<%=rs1.getString(1)%>"><%=rs1.getString(1)%></option>
                                <%

                                    } 
                                    
                                %>
                            </select>
                            </br></br>
                            <select id="year" name="year" style=" width: 100%">
                                <option value="">Select year of joining</option>
                        </select>
                        </td>


                    </tr>  
                    <%
                                    rs1.close();
                                    scis.close();
                    %>

                </table>
                &nbsp;&nbsp;&nbsp;
                <div align="center" style="color: red" id="errfn"></div>
            </form>

    </body>
</html>

