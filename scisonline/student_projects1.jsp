<%-- 
    Document   : student_projects1
    Created on : Feb 17, 2014, 10:37:49 AM
    Author     : veeru
--%>

<%@page import="java.sql.*"%>
<%@include file="connectionBean.jsp"%>
<%@include file="programmeRetrieveBeans.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script type="text/javascript">

            function link()
            {
                var pgname = document.getElementById("p1").value;
               document.getElementById("errfn").innerHTML = "";
                if (pgname === "-- Programme --") {
                    parent.act_area2.location = "./BalankPage2.jsp";//to replace already opened page with blank page in frame act_area1.

                    document.getElementById("errfn").innerHTML = "*Select Programme name";
                    return false;
                } else {
                   
                    parent.act_area2.location = "./student_projects2.jsp?programmeName=" + pgname;
                }
            }


        </script>
        
        <script src="js/jquery.min.js"></script>
        <script type="text/javascript" >
            $(document).ready(function($) {
                $('#p1').change(function() {
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
                    var programme = $('#p1').val();
                    var year = $('#year').val();
                    if(programme !== "" && year !== "") {
                            window.document.forms["form"].action = "student_projects2.jsp?programmeName=" + programme + "&year=" + year;
                        }
                       
                        document.form.submit();
                });
            });
        </script>


    </head>
    <body bgcolor="E0FFFF">
        <form  id="form" name="form" method="POST"  target="act_area2" >
            <%  Connection con = conn.getConnectionObj();
                ResultSet rs = scis.getStream("PhD");
            %>
            <table>
                <tr>
                    <select id="p1" name="pgname" style=" width: 100%">
                        <option value="-- Programme --">Programme</option>
                        <%while (rs.next()) {%>
                            <option><%=rs.getString(1)%></option>
                        <%}
                        %>
                    </select>
                </tr>
                </br></br>
                <tr>
                    <select id = "year" name = "year" style=" width: 100%">
                        <option>Select Year</option>
                    </select>
                </tr>
                <%
                    rs.close();
                    scis.close();
                    conn.closeConnection();
                    con = null;
                 %>
            </table>
            &nbsp;&nbsp;
        </form>
    </body>

