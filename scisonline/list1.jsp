<%-- 
    Document   : list1
--%>
<%@include file="checkValidity.jsp"%>
<%@ include file="connectionBean.jsp" %>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import ="javax.sql.*" %>
<%@page import="java.sql.*" %>
<%@page import="java.util.Calendar"%>
<%@include file="programmeRetrieveBeans.jsp"%>
<%@page errorPage="error.jsp?msg=Application Generated an error!" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style>
            .style30 {width:300px}
        </style>
        <link rel="stylesheet" type="text/css" href="button.css">

        <script type="text/javascript">


            function checked()
            {
                parent.facultyaction.location = "./BalankPage2.jsp";
                var selectlist = document.getElementById("mySelect1");
                var type = selectlist.options[selectlist.selectedIndex].id;

                var subname = selectlist.options[selectlist.selectedIndex].text;

                if (subname === "Select Subject")
                {
                    parent.facultyaction.location = "./BalankPage2.jsp";
                    parent.triggering.location = "./BalankPage2.jsp";
                } else {
                    var value = selectlist.options[selectlist.selectedIndex].value;
                    if (type === "s") {
                        document.getElementById("year").style.visibility = "hidden";
                        window.document.forms["frm"].action = "triggering.jsp?subjectname=" + subname + "&subjectid=" + value + "&type=" + type;
                        document.frm.submit();
                    } else {
                        document.getElementById("year").style.visibility = "visible";
                        //window.document.forms["frm"].action = "triggering.jsp?subjectname=" + subname + "&subjectid=" + value + "&type=" + type;
                        window.document.forms["frm"].action = "BalankPage2.jsp";
                        document.frm.submit();
                    }

                }
            }
        </script>
        <script src="js/jquery.min.js"></script>
        <script type="text/javascript" >
            $(document).ready(function($) {
                $("#mySelect1").change(function() {
                    var id = $(this).children(":selected").attr("id");
                    if(id === 'p') {
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
                    }
                });
                $('#year').change(function(){
                    var programme = $('#mySelect1').val();
                    var year = $(this).val();
                    window.document.forms["frm"].action = "triggering.jsp?subjectname=" + programme + "&year=" + year + "&type= p";
                    document.frm.submit();
                    //parent.act_area.location = "projectRegistrationFacultyStream.jsp?stream="+programme+"&batch="+year;
                });
            });
        </script>
    </head>
    <body>
        <% //String csubj;
            String username = (String) session.getAttribute("user");
            if (username == null) {
                username = "";
            }
            System.out.println(username);

            Calendar now = Calendar.getInstance();

            System.out.println("Current date : " + (now.get(Calendar.MONTH) + 1)
                    + "-"
                    + now.get(Calendar.DATE)
                    + "-"
                    + now.get(Calendar.YEAR));
            int month = now.get(Calendar.MONTH) + 1;
            int year = now.get(Calendar.YEAR);
            String semester = "";
            if (month <= 6) {
                semester = "Winter";
            } else {
                semester = "Monsoon";
            }
               Connection con = conn.getConnectionObj();
            try {
                String qry2 = "select Code,subject_Name from subjecttable as a where a.Code in (select subjectid from subject_faculty_" + semester + "_" + year + " where facultyid1='" + username + "' or facultyid2='" + username + "');";

                Statement st = con.createStatement();
                ResultSet rs = st.executeQuery(qry2);
                ResultSet rs1 = scis.getStream("PhD");
                List subj = new ArrayList();
                //int i = 0;
        %>
        <form name="frm" target="triggering" method="POST">
            <select align="left" valign="bottom" style="width:100%" name="subjectname" id="mySelect1" onchange="checked();"> 
                <option id="s">Select Subject</option>
                <%  while (rs.next()) {
                    %> <option value="<%=rs.getString(1)%>" id="s" onclick="checked();"> <%=rs.getString(2)%> </option> <%

                    }
                    while (rs1.next()) {
                %> <option value="<%=rs1.getString(1)%>" id="p" onclick="checked();"><%=rs1.getString(1)%> Project</option> <%
                    }
                %>   
            </select><br/><br/>
            <select id="year" name="year" style=" width: 100%; visibility:hidden; ">
                <option value="">Choose Year</option>
            </select>

        </form>
        </br>
        <br>

        <!--<input type="Submit" value="Go">-->

        <%  rs.close();
            rs1.close();
            } catch (Exception e) {
                out.println(e);
            }finally{
                scis.close();
                conn.closeConnection();
                con = null ;
            }

        %>
    </body>
</html>
