<%-- 
    Document   : projectFacultyView
--%>
<%@page import="java.sql.ResultSet"%>
<%@include file="programmeRetrieveBeans.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script type="text/javascript">

            function link1()
            {

                document.form.submit();

            }

        </script>
        <script src="js/jquery.min.js"></script>
        <script type="text/javascript" >
            $(document).ready(function($) {
                $("#mySelect1").change(function() {
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
                    var programme = $('#mySelect1').val();
                    var year = $(this).val();
                    window.document.forms["form"].action = "projectFacultyViewStream.jsp?pgname=" + programme + "&year=" + year;
                    document.form.submit();
                });
            });
        </script>


    </head>
    <body bgcolor="E0FFFF">
        <% ResultSet rs1 = scis.getStream("PhD");%>
        <form id = "form" name="form" target="act_area" method="POST">
            <select align="left" valign="bottom" style="width:100%" name="subjectname" id="mySelect1"> 
                <option id="s">Select Stream</option>
                <%  while (rs1.next()) {
                    %> <option value="<%=rs1.getString(1)%>" > <%=rs1.getString(1)%> </option> <%

                    }
                %>
                    
            </select><br/><br/>
            <select id="year" name="year" style=" width: 100%;">
                <option value="">Choose Year</option>
            </select>

        </form>
         <% rs1.close();
            scis.close();
         %>
        
    </body>
</html>
