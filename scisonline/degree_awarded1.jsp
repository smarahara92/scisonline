<%-- 
    Document   : degree_awarded1_link
    Created on : Jan 30, 2014, 6:29:20 PM
    Author     : veeru
--%>
<%@include file="checkValidity.jsp"%>
<%@page import="java.sql.*"%>
<%@include file="programmeRetrieveBeans.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script>
            function link1()
            {

                var pname = document.getElementById("pg").value;
                var pyear = document.getElementById("py").value;
                //alert(pyear);

                if (pname === "-Programme-")
                {
                    document.getElementById("errfn").innerHTML = "*Select Programme.";
                    parent.act_area.location = "./BalankPage2.jsp";

                    document.getElementById("pg").focus();
                } else {


                    document.getElementById("errfn").innerHTML = "";

                    parent.act_area.location = "./degree_awarded1_link.jsp?pgname=" + pname + "&pyear=" + pyear;

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
                    window.document.forms["forrm"].action = "degree_awarded1_link.jsp?pgname=" + programme + "&year=" + year;
                    document.forrm.submit();
                });
            });
        </script>
    </head>
    <body>
        <form  id="frmm" name="forrm" method="POST" target="act_area" >
            <h3> By Stream: </h3>  
            <table>
                <tr>
                        <select id="pg" name="r" style="width: 50%">
                            <option>Programme</option>
                            <%
                                ResultSet rs = null;
                               
                                rs = scis.getProgramme(1, "PhD");
                                while (rs.next()) {

                            %>

                            <option value="<%=rs.getString(1)%>" ><%=rs.getString(1)%></option>

                            <%}%>  
                        </select>    
                </tr>
                <br><br>
                <tr>
                        <select id="year" name="year" style="width: 50%">
                            <option value="">Select Year</option>
                        </select>
                </tr>
            </table>
        </form>
    </body>
</html>
