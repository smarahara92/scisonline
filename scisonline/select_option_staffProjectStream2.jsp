
<%-- 
    Document   : select_option_staffProjectStream2.jsp
--%>

<%@page import="java.sql.*"%>
<%@include file="connectionBean.jsp"%>
<%@include file="programmeRetrieveBeans.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>

    <head>
        <style>
            <%--body {color:white}--%>
            .style11 {color :red}
            .style12 {color :white}
            .style13 {color :yellow}


        </style>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="table_css.css">
        <!--link rel="stylesheet" type="text/css" href="jquery.js"-->
        <script src="js/jquery.min.js"></script>
        <script type="text/javascript" >
            $(document).ready(function($) {
                var initial_target_html = '<option value="none">Select Student ID</option>'; //Initial prompt for target select
                $(".pgname").change(function() {
                    var id = this.id;
                    var programme = $('#'+id).val();
                    var target_id = 'std'+id;
                    //Display 'loading' status in the target select list
                    $('#'+target_id).html('<option value="">Loading...</option>');
                    if (programme === "none"){
                        $('#'+target_id).html(initial_target_html);
                    } else {
                        var streamYear = $('#streamYear').val();
                        //Make AJAX request, using the selected value as the GET
                        $.ajax({url: 'select_option_staffProjectStream2_ajax.jsp?programmeName='+programme+"&streamYear="+streamYear, success: function(output) {
                            $('#'+target_id).html(output);
                        },
                        error: function (xhr, ajaxOptions, thrownError) {
                            System.out.println(xhr.status + " "+ thrownError);
                            System.out.println(ajaxOptions);
                        }});
                    }
                });
            });
        </script>
        <script type="text/javascript">
            function link()
            {
                window.location.replace("projectRegistrationInterns2.jsp");
            }
            function fun4() {
                var select = document.getElementsByName("select");
                for (var i = 0; i < select.length; i++) {
                    var val = select[i].options[select[i].selectedIndex].value;
                    alert(val);
                }

            }

            //%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            function fun3(value, id) {
                if (value === "Select Student Id") {
                    if (document.getElementById(id).value === "Select Programme") {
                        document.getElementById(id).focus();

                        document.getElementById(id).style.color = '#CC0000';
                        alert("Select programme name.");

                    }
                }

            }  
            
            function disableEnterKey(e)
            {
                var key;
	 
                if(window.event)
	          key = window.event.keyCode;     //IE
                else
                  key = e.which;     //firefox
	 	
                if(key === 13)
	          return false;
                else
	          return true;
            }

        </script>
    </head>
    <body bgcolor="#CCFFFF">
        <form  id="form" method="POST" action="select_option_staffProjectStream3.jsp">
<%      try {
            String streamName = (String) session.getAttribute("projectStreamName");
            String pyear = (String) session.getAttribute("projectStreamYear");
            %>
            <input type="hidden" id = "streamYear" name = "streamYear" value="<%=pyear%>">
            <%
            streamName = streamName.replace('-', '_');
            
            Connection con = conn.getConnectionObj();
                    
            int flag = 0, id_count = 0;
            String fid = request.getParameter("fid");
            session.setAttribute("facid", fid);

            Statement st2 = con.createStatement();
            Statement st3 = con.createStatement();

            try {
                ResultSet rs1 = scis.facultyList();
                ResultSet rs2 = (ResultSet) st2.executeQuery("select * from  " + streamName + "_Project" + "_" + pyear + "  where Allocated='no'");
                //ResultSet rs3 = (ResultSet) st3.executeQuery("select count(*) from  " + streamName + "_Project" + "_" + pyear + "  where Allocated='no' and (SupervisorId1='" + fid + "' or SupervisorId2='" + fid + "'or SupervisorId3='" + fid + "' )");
                ResultSet rs4 = scis.getProgramme(streamName, 1);

                /*      if (rs3.next()) {
                            int rowCount = rs3.getInt(1);
                        }
                        int i = 0;*/

            %>
                <table align="center">
                    <caption><h2>Project List</h2></caption>
                    <th> Project Title </th>
                    <th> Programme Name </th>
                    <th>Student ID</th>
                <%
                    while (rs2.next()) {
                        if (fid.equals(rs2.getString(3)) || fid.equals(rs2.getString(4)) || fid.equals(rs2.getString(5))) {
                %>
                            <tr>
                            <%
                                flag = 1;
                                //ResultSet rs3=(ResultSet)st3.executeQuery("select * from  project"+"_"+"student"+"_"+"data where ProjectId='"+rs2.getString(1)+"'");

                            %>

                                <input type="text" value="<%=rs2.getString(1)%> " hidden readonly id="pid1" name="pid" size="3"  onKeyPress="return disableEnterKey(event)">
                                <td><input type="text" value="<%=rs2.getString(2)%>"  readonly id="pid1" name="pname" size="50"  onKeyPress="return disableEnterKey(event)"></td>
                                <td>
                                    <select id="<%=id_count%>" class="pgname" name="pgname">
                                        <option value="none">Select Programme</option>
                                        <%
                                        while (rs4.next()) {%>
                                            <option value="<%=rs4.getString(1)%>"><%=rs4.getString(1)%></option>
                                        <%
                                        }
                                        rs4.beforeFirst();
                                        %>
                                    </select>
                                </td>
                                <td>
                                    <select id="std<%=id_count%>" name="sid1"  onclick="fun3(this.value,<%=id_count%>);">
                                        <option value="none">Select Student ID</option>
                                    </select>
                                </td>
                            </tr>
                            <%
                            id_count++;
                        }
                    }
                    if (flag == 0) {%>
                        <script type="text/javascript" language="javascript">
                            link();
                        </script>
                        <%
                    }%>
                </table>&nbsp;&nbsp;
                <div align="center"><input type="submit" id ="xx" value="Submit" fun3(this.value,<%=id_count%>)/></td></div>
                <%
                rs1.close();
                rs2.close();
                //rs3.close();
                rs4.close();
            } catch (Exception ex) {%>
                <h2>Please register the Projects first.</h2>
                <%
                ex.printStackTrace();
            }
            String user = (String) session.getAttribute("user");
            %>
            <!--  Welcome <%=user%>-->
            <input type="hidden" name="streamName" id="streamId" value="<%=streamName%>">
        </form>
        <%
        st2.close();
        st3.close();
        conn.closeConnection();
        con = null;
        } catch (Exception ex) {
            out.println(ex);
        }           
        %>
    </body>
</html>



