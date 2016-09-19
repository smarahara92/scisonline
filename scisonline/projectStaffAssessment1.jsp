<%-- 
    Document   : projectStaffAssessment1
    Created on : 29 Apr, 2013, 2:33:30 PM
    Author     : varun
--%>
<%@include file = "checkValidity.jsp" %>
<%@include file="connectionBean.jsp"%>
<%@page import="java.sql.*"%>
<%@include file="programmeRetrieveBeans.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <script src="js/jquery.min.js"></script>
        <script type="text/javascript" >
            $(document).ready(function($) {
                $('#sel').change(function(){
                    var opt = $('#sel').val();
                });
                $('#pg').change(function() {
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
                $('.trigger').change(function(){
                    var programme = $('#pg').val();
                    var year = $('#year').val();
                    var opt = $('#sel').val();
                    //alert(programme + year + opt);
                    if(programme !== "" && year !== "" && opt !== "") {
                        if(opt === "int") {
                            window.document.forms["form"].action = "projectStaffAssessmentCSInt.jsp?pgname=" + programme + "&year=" + year;
                        }
                        else if(opt === "ext") {
                            window.document.forms["form"].action = "projectStaffAssessmentCSExt.jsp?pgname=" + programme + "&year=" + year;
                        }
                        if(opt === "status") {
                            window.document.forms["form"].action = "projectStaffAssessmentstatus.jsp?pgname=" + programme + "&year=" + year;
                        }
                        document.form.submit();
                    }
                });
            });
        </script>

        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <form  id="form" name="form" method="POST" action="" target="act_area" >

            <h3> By Stream: </h3><br>  
            <table>
                <tr>  
                        <select class="trigger" id="sel" name="sel" onchange=""; style="width: 50%">
                            <option value="" onclick=";">None</option>
                            <option value="int" onclick=""> Mid Term</option>
                            <option value="ext" onclick=""> Final</option>
                            <option value="status" onclick=""> Status</option>
                        </select>
                <br><br>
                </tr>
                <tr>
                        <select id="pg" name="r" style="width: 50%">
                            <option value="">Programme</option>
                            <%  Connection con = conn.getConnectionObj();  
                                Statement st = con.createStatement();
                                ResultSet rs = scis.getProgramme(1, "PhD");
                                while (rs.next()) {

                            %>
                            <option value="<%=rs.getString(1)%>" onclick=""><%=rs.getString(1)%></option>

                            <%}%>
                        </select>
                <br><br>
                </tr>
                <tr>        <select class="trigger" id="year" name="year" style="width: 50%">
                                <option value="">Select Year</option>
                            </select>
                 </tr>
                            <%  st.close();
                                rs.close();
                                scis.close();
                                conn.closeConnection();
                                con.close();
                            %>                        
            <br><br>
            <div id="errfn" style="color: red"></div>
            </table>
        </form>
    </body>
</html>