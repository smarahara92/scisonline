<%-- 
    Document   : Q_ShortAtten_SnB2_15
    Created on : Mar 18, 2015, 11:34:10 AM
    Author     : richa
--%>

<%@include file="checkValidity.jsp" %>
<%@page import="java.sql.*"%>
<%@include file="programmeRetrieveBeans.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script type="text/javascript" >
            function to(q)
            {
                //var pgname = document.getElementById("idd" + id).value;
                //alert(q);
                  parent.bottom.location= "project_unallocatedstudentlist.jsp?pgname=" + q;
            }
        </script>
    </head>
    <body>
        <form  id="frmm" name="forrm" method="POST" target="bottom" >
            <%
                ResultSet rs = null;
                int i = 1;
                rs = scis.getStream("PhD");%>
                <center><%
                while (rs.next()) {

             %> 
            <input type="radio" name="stream" id ="streamnam<%=i%>" value="<%=rs.getString(1)%>" onclick="to(this.value);"><%=rs.getString(1)%>  &nbsp;&nbsp;&nbsp;&nbsp;
               
                <%  i++;}%>
               </center>
                    
        </form>
    </body>
</html>

