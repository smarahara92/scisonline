<%-- 
    Document   : deleteSubject
--%>

<%@include file="checkValidity.jsp"%>
<%@include file="connectionBean.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
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
        <title>Faculty Deletion</title>
        <script>

            function fun() {


                //******************checking for subject is registered or not

                var index = document.getElementById("sell").selectedIndex;
                var subid = document.getElementById("sell").options[index].value;
                var subname = document.getElementById("sell").options[index].id;


                var xmlhttp;
                if (window.XMLHttpRequest)
                {// code for IE7+, Firefox, Chrome, Opera, Safari
                    xmlhttp = new XMLHttpRequest();
                }
                else
                {// code for IE6, IE5   xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
                    xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
                }
                xmlhttp.onreadystatechange = function()
                {

                    if (xmlhttp.readyState === 4 && xmlhttp.status === 200)
                    {

                        var x = xmlhttp.responseText;
                        //if x ==1 meanse selected subject is offered as elective for current semester.
                        if (x == 1)
                        {
                            var r = confirm("This subject offered as a elective for current semester. Do you want to continue?");
                            if (r == true)
                            {
                                window.document.forms["form1"].action = "deleteSubjectLink.jsp?subid=" + subid + "&subname=" + subname;
                                document.form1.submit();
                            }
                            else
                            {

                            }
                        } else if (x == 2)
                        {
                            alert("This subject is not offered as a elective in current semester.");
//                            var r = confirm("Do you really want to delete this subject?");
//                            if (r == true)
//                            {
//                                window.document.forms["form1"].action = "deletesubjectlink2.jsp?subid=" + subid + "&subname=" + subname + "&code=2";
//                                document.form1.submit();
//                            }
//                            else
//                            {
//
//                            }
                        }
                    }
                };

                xmlhttp.open("GET", "deletesubject_ajax.jsp?subcode=" + subid);
                xmlhttp.send();

                //**********************************************************
            }
        </script>    
    </head>
    <body>
        <%
        Connection con = conn.getConnectionObj();
        
        try {
                Statement st1 = con.createStatement();
            // Statement st2=ConnectionDemo1.getStatementObj().createStatement();

                ResultSet rs = st1.executeQuery("select * from  subjecttable where type='E'");
                // ResultSet rs1=st2.executeQuery("select * from subject_data where semester='E' order by subjName");
        %>
        <form name="form1" method="POST" >
            <table align="center">
                <tr bgcolor="#c2000d">
                    <td align="center" class="style12"> <font size="6"> Delete Subject </font> </td>
                </tr>
            </table>
            <br><br>
            <table align="center">

                <tr>
                    <th>Subject</th>
                    <td> &nbsp;&nbsp;&nbsp;
                        <select id="sell" name="sel"> 
                            <option value="none">none</option>
                            <% while (rs.next()) {%>
                            <option value="<%=rs.getString(1)%>" id="<%=rs.getString(2)%>"><%=rs.getString(2)%> </option>
                            <%}%>
                        </select>
                    </td>

                    <td colspan="4" align="center">
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <input type="button" value="Delete" onclick="fun();">
                    </td>    
                </tr>
            </table>
        </form>
        <%
        } catch (Exception ex) {
        %>
        <script>


            window.open("Project_exceptions.jsp?check=6", "subdatabase");//here check =6 means error number (if condition number.)
        </script> 
        <%
            }
        
        conn.closeConnection();
        con = null;
        %>
    </body>
</html>
