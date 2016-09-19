<%-- 
    Document   : projectRegistrationFacultyMCA
    Created on : 13 May, 2013, 4:52:06 AM
    Author     : varun
--%>
<%@include file="checkValidity.jsp"%>
<%@page import="com.hcu.mysql.connection.ConnectionDemo1"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>

<%@include file="dbconnection.jsp"%>
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
        <title>JSP Page</title>
        <script type="text/javascript">

            function check()
            {
                var i = 0;
                var c = 6;
                while (i < 6)
                {
                    //if(document.getElementById("pid1"+i).value=="" || document.getElementById("sid1"+i).value=="none" || document.getElementById("sid2"+i).value=="none" )
                    if (document.getElementById("pid1" + i).value == "")
                    {
                        c--;
                    }


                    if (document.getElementById("pid1" + i).value == "" && document.getElementById("sid1" + i).value != "none" && document.getElementById("sid2" + i).value != "none")
                    {
                        alert("Project Title is Empty .");
                        document.getElementById("pid1" + i).focus();
                        return false;
                    }

                    if (document.getElementById("sid1" + i).value == document.getElementById("sid2" + i).value && document.getElementById("sid1" + i).value != "none" && document.getElementById("sid2" + i).value != "none")
                    {
                        alert("2 Supervisors cannot have the same name.");
                        document.getElementById("sid1" + i).focus();
                        return false;
                    }
                    i++;

                }
                if (c == 0)
                {
                    alert("Please enter the details of atleast one Student.");

                    return false;
                }
                // alert ("hai");



                return true;

            }

            function make_blank(p)
            {
                var i, p1;
                var proj = "pid1" + p;
                if (document.getElementById(proj).value != "Enter-Project-Title")
                {

                }
                else {
                    document.getElementById(proj).value == "";
                }
                for (i = 0; i < 6; i++)
                {
                    p1 = i;
                    if (p1 == p)
                    {

                    }
                    else
                    {
                        if (document.getElementById("pid1" + p1).value == "")
                            ;
                        document.getElementById("pid1" + p1).value == "Enter-Project-Title";
                    }
                }


            }

        </script>
    </head>
    <body bgcolor="#CCFFFF">


        <form  id="form" method="POST" onsubmit="return check()" action="projectRegistrationFacultyMCA1.jsp">
            <table align="center">
                <tr bgcolor="#c2000d">
                    <td align="center" class="style12"> <font size="6"> Projects List </font> </td>
                </tr> 
            </table>     

            <br>
            <table align="center" >
                <tr>
                    <th>Project Title </th> 
                    <th>Supervisor 2</th>
                    <th>Supervisor 3</th>

                </tr>

                <%
                    int i = 0;
                    Statement st1 = con.createStatement();
                    Statement st2 = con.createStatement();
                    Statement st3 = con.createStatement();
                    ResultSet rs = st1.executeQuery("select * from  faculty_data order By Faculty_Name");
                    while (i < 6) {%>
                <tr>
                    <td>&nbsp;<input type="text" id="pid1<%=Integer.toString(i)%>"  name="pid1<%=Integer.toString(i)%>"  size="50"></td>

                    <td>&nbsp;<select id="sid1<%=Integer.toString(i)%>" name="sid1<%=Integer.toString(i)%>"> 
                            <option value="none">none</option>
                            <% while (rs.next()) {%>

                            <option value="<%=rs.getString(1)%>"> <%=rs.getString(2)%> </option>
                            <%}
                                rs.beforeFirst();%>
                        </select></td>
                    <td>&nbsp;<select id="sid2<%=Integer.toString(i)%>" name="sid2<%=Integer.toString(i)%>"> 
                            <option value="none">none</option>
                            <% while (rs.next()) {%>
                            <option value="<%=rs.getString(1)%>"> <%=rs.getString(2)%> </option>
                            <%}
                                rs.beforeFirst();%>
                        </select></td>


                </tr>
                <%
                        i++;
                    }%> 

                <tr>
                    <td colspan="8" align="center"><input type="submit" value="submit"/></td>

                </tr>
            </table>


        </form>

    </body>
</html>

