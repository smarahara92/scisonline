<%-- 
    Document   : projectStaffModify
    Created on : 19 May, 2013, 7:06:35 PM
    Author     : varun
--%>
<%@include file="checkValidity.jsp"%>
<%@page import="java.sql.ResultSet"%>
<%@include file="programmeRetrieveBeans.jsp"%>
<%    String url = "http://172.16.88.50:8084/AttendanceSystem/";
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
        <script type="text/javascript">
            function loadXMLDoc2(val)
            {
                var xmlhttp1;
                var urls1 = "projectRegistrationInterns_ajax2.jsp?streamName=" + val + "&check=1";
                if (window.XMLHttpRequest)
                {
                    xmlhttp1 = new XMLHttpRequest();
                }
                else
                {
                    xmlhttp1 = new ActiveXObject("Microsoft.XMLHTTP");
                }
                xmlhttp1.onreadystatechange = function()
                {
                    if (xmlhttp1.readyState === 4)
                    {
                    }
                };
                xmlhttp1.open("GET", urls1, true);
                xmlhttp1.send();
            }

            function to(q)
            {
                loadXMLDoc2(q);
                if (q === "--Select Stream--") {

                    document.getElementById("errfn").innerHTML = "*Select Stream name.";
                    parent.act_area.location = "./BalankPage2.jsp";
                } else if (q === "mca" || q === "MCA") {
                    document.getElementById("errfn").innerHTML = "";
                    parent.act_area.location = "./projectStaffModifyMCA.jsp?branch=" + q;
                }
                else {
                    document.getElementById("errfn").innerHTML = "";
                    parent.act_area.location = "./projectStaffModifyMtech.jsp?branch=" + q;

                }

            }

        </script>
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
                    var year = $('#year').val();
                    if(programme !== "" && year !== "") {
                        if(programme === "MCA"){
                            parent.act_area.document.location = "projectStaffModifyMCA.jsp?programmeName=" + programme + "&year=" + year;
                        }else{
                          parent.act_area.document.location = "projectStaffModifyMtech.jsp?programmeName=" + programme + "&year=" + year;
                      }
                    }
                });
            });
        </script>
    </head>
    <body>
        <form id="frm" name="form">
            <table>
                <tr>
                    <select id="pg" name="pgname" style=" width:100%">
                        <option style=" alignment-adjust: central">Select Stream</option>
                        <%
                            ResultSet rs1 = null;
                            rs1 = scis.getStream("PhD");
                            while (rs1.next()) {
                        %>
                                <option  value="<%=rs1.getString(1)%>"><%=rs1.getString(1)%></option>
                        <%
                            }  
                            rs1.close();
                        %>
                        </select>
                </tr>   
                </br></br>
                <tr>
                    <select id = "year" name="year" style=" width:100%">
                        <option>Select Year</option>
                    </select>
                </tr>
            </table>

            &nbsp;&nbsp;&nbsp;
        </form>
    </body>
</html>