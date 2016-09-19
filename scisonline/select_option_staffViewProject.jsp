<%-- 
    Document   : select_option_staffViewProject
    Created on : 9 Mar, 2013, 11:03:10 AM
    Author     : varun
--%>
<%@include file="checkValidity.jsp"%>
<%@page import="java.sql.ResultSet"%>
<%@include file="programmeRetrieveBeans.jsp"%>
<%
    String url = "http://172.16.88.50:8084/AttendanceSystem/";
%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <style>
            .style30 {color: #c2000d}
            .style31 {color: white}
            .style32 {color: green}
        </style>
        
        <script src="js/jquery.min.js"></script>
        <script type="text/javascript" >
            $(document).ready(function($) {
                $('#sel').change(function(){
                    var opt = $('#sel').val();
                });
                $('#sel1').change(function() {
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
                $('.trigger').change(function(){
                    var programme = $('#sel1').val();
                    var year = $('#year').val();
                    var opt = $('#sel').val();
                    if(programme !== "" && year !== "" && opt !== "") {
                        if(opt === "All") {
                            parent.act_area.document.location = "select_option_staffViewStream.jsp?streamName=" + programme + "&year=" + year +"&fid=" + opt;
                        }
                        else {
                            parent.act_area.document.location = "select_option_staffViewProjectMtech.jsp?streamName=" + programme + "&year=" + year +"&fid=" + opt;
                        }
                       
                        //document.form.submit();
                    }
                });
            });
        </script>

        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    </head>
    <body bgcolor="#CCFFFF">
        <%
            ResultSet rs = scis.facultyList();
            ResultSet rs1 =scis.getStream("PhD");
        %>
        <form  id="form" name="form" method="POST" onsubmit="" action="" target="act_area" >
            <table>
                <%try {%>    
                    <tr>
                        <select  class="trigger" id="sel" name="sel" onchange="" style=" width: 100%"> 
                            <option>Select Faculty name</option>
                            <option>All</option>
                            <% while (rs.next()) {
                            %> <option value="<%=rs.getString(1)%>" ><%=rs.getString(2)%> </option>
                            <%
                               }%>
                        </select>
                    </tr>
                    </br></br>

                    <tr>
                        <select id="sel1" name="sel1" onchange="" style=" width: 100%"> 
                            <option>Select Stream</option>
                            <% while (rs1.next()) {
                            %> <option><%=rs1.getString(1)%> </option>
                            <%
                                }%>
                         </select>
                    </tr></br></br>
                    <tr>        
                        <select class="trigger" id="year" name="year" style="width: 100%">
                            <option value="">Select Year</option>
                        </select>
                    </tr>
            </table>
            <%
                } catch (Exception ex) {
                    ex.printStackTrace();
                }
            %>
        </form>
    </body>
</html>