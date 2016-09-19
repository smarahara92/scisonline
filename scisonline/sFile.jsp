<%-- 
    Document   : sFile
--%>
<%@include file="checkValidity.jsp"%>
<%@page import="java.sql.*"%>
<%@page import="java.io.OutputStream"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.File"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    </head>
    <body onload="one();" bgcolor="#CCFFFF"> <%
        try {
            String pname = (String) session.getAttribute("pname_upload");
            String year = (String) session.getAttribute("year_upload");

            if(!(pname.equalsIgnoreCase("PhD"))){ %>
                <form action="Commonsfileuploadservlet1" enctype="multipart/form-data" method="POST" >
                    <input type="hidden" name="check" value="5" />
                    <table align="center" border="0" cellpadding="5" cellspacing="5">
                        <tr><th colspan="2"><h1>Upload Student File</h1></th></tr>
                        <tr>
                            <td><input type="button" name="text1" style="width:200px;" value="<%=pname%>"></td>
                            <td><input type="button" name="text2" id="year1" style="width:200px;" value="<%=year%>"></td>
                        </tr>
                        <tr></tr>
                        <tr><td colspan="2" align="center">
                                <input type="file" name="file1" />
                                <input type="Submit" value="Upload File"><br>
                            </td>
                        </tr>
                    </table>
                </form> <%
            } else if(pname.equalsIgnoreCase("PhD")){ %>
                <form action="Commonsfileuploadservlet1" enctype="multipart/form-data" method="POST" >
                    <input type="hidden" name="check" value="5" />
                    <table align="center" border="0" cellpadding="5" cellspacing="5">
                        <tr><th colspan="2"><h1>Upload Student File</h1></th></tr>
                        <tr>
                            <td><input type="button" name="text1" style="width:200px;" value="PhD"></td>
                            <td> <input type="button" name="text2" id="year1" style="width:200px;" value="<%=year%>"></td>
                        </tr>
                        <tr></tr>
                        <tr><td colspan="2" align="center">
                                <input type="file" name="file1" />
                                <input type="Submit" value="Upload File"><br>
                            </td>
                        </tr>
                    </table>
                </form> <%
            }
        } catch (Exception e) { %>
            <script type="text/javascript">
                alert("Add at least one programme");
            </script> <%
        } %>
    </body>
</html>