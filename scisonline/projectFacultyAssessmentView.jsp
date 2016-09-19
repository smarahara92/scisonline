<%-- 
    Document   : projectFacultyAssessmentView
    Created on : 26 May, 2013, 12:31:50 PM
    Author     : varun
--%>
<%@include file="connectionBean.jsp"%>
<%@page import="java.sql.*"%>
<%@include file="programmeRetrieveBeans.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>

        <script type="text/javascript">

            function link1()
            {

                var pname = document.getElementById("pg").value;
                if (pname === "-Programme-")
                {

                    parent.act_area.location = "./BalankPage2.jsp";
                    document.getElementById("errfn").innerHTML = "*Select Programme.";
                    document.getElementById("pg").focus();
                } else {

                    document.getElementById("errfn").innerHTML = "";

                    parent.act_area.location = "./projectFacultyAssessmentViewMtech.jsp?pgname=" + pname;

                }

            }
        </script>   
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
                    var year = $(this).val();
                    window.document.forms["form"].action = "projectFacultyAssessmentViewMtech.jsp?pgname=" + programme + "&year=" + year;
                    document.form.submit();
                });
            });
        </script>

        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body bgcolor="E0FFFF">
        <form  id="form" name="form" method="POST" action="" target="act_area" >

            <h3> Project View </h3>   <br>  
            <table>
                <select id="pg" name="r" style=" width: 100%">
                    <option>Programme</option>
                    <%
                        Connection con = conn.getConnectionObj();
                        ResultSet rs = null;
                        Statement st1 = con.createStatement();
                        rs = scis.getStream("PhD");
                         while (rs.next()) {
                    %>
                            <option><%=rs.getString(1)%></option>
                    <%  }
                    %>  
                </select>
                </br></br>
                <select id="year" name="year" style=" width: 100%">
                    <option value="">Select year of joining</option>
                </select>
            </table>

            <div id="errfn" style="color: red" align="left"></div>
            <%st1.close();
              rs.close();
              scis.close();
              con = null;
              conn.closeConnection();
            %>
        </form>
    </body>
</html>
