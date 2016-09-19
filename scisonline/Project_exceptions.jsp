<%-- 
    Document   : Project_exceptions
    Created on : Apr 14, 2014, 5:26:55 PM
    Author     : veeru
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style>
            table
            {
                border-collapse:collapse;
            }
            table, td, th
            {
                border:1px darkblack;
            }
        </style>
    </head>
    <body>
        <!--
        =======
        to access this page...
        <script>
        
        
                    window.open("Project_exceptions.jsp?check=6", "subdatabase");//here check =6 means error number (if condition number.)
                </script> 
        ==========
        -->
        <table align="center" border="1">
            <tr align="center">
                <%try {
                        String check = request.getParameter("check");
                        if (check.equalsIgnoreCase("1")) {
                %>
                <td style=" color:  darkred; font-size: 15px"><p>There are currently no Projects allocated to this student.!</p></td>
                <%
                } else if (check.equalsIgnoreCase("2")) {
                %>
                <td style=" color:  darkred; font-size: 15px"><p>There are currently no unallocated Projects!</p></td>

                <%
                } else if (check.equalsIgnoreCase("3")) {
                %>
                <td style=" color:  darkred; font-size: 15px"><p>Supplementary/Improvement registration has not done for this subject.</p></td>

                <%
                } else if (check.equalsIgnoreCase("4")) {
                %>
                <td style=" color:  darkred; font-size: 15px"><p>No Supplementary/Improvement subjects found for this student.</p></td>

                <%
                } else if (check.equalsIgnoreCase("5")) {
                %>
                <td style=" color:  darkred; font-size: 15px"><p>Project is not allocated.</p></td>

                <%
                } else if (check.equalsIgnoreCase("6")) {
                %>
                <td style=" color:  darkred; font-size: 15px"><p> Errno:6  Some internal error occurred. Please contact system administrator.</p></td>

                <%
                } else if (check.equalsIgnoreCase("7")) {
                %>
                <td style=" color:  darkred; font-size: 15px"><p>Some internal error occurred. Please contact to system administrator.</p></td>

                <%
                } else if (check.equalsIgnoreCase("8")) {//database conection error...
                %>
                <td style=" color:  darkred; font-size: 15px"><p> Errno:8  Some internal  error occurred. Please contact to system administrator.</p></td>

                <%
                        }else if (check.equalsIgnoreCase("9")) {//database conection error...
                %>
                <td style=" color:  darkred; font-size: 15px"><p> Curriculum does not exists..</p></td>

                <%
                        }else if (check.equalsIgnoreCase("10")) {//database conection error...
                %>
                <td style=" color:  darkred; font-size: 15px"><p> No projects found.</p></td>

                <%
                        }
                    } catch (Exception e) {
                    }
                %>
            </tr>
        </table>
    </body>
</html>
