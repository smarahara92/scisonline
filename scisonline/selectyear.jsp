<%-- 
    Document   : selectyear
    Created on : 18 May, 2014, 4:31:01 PM
    Author     : srinu
--%>
<%@page import="java.util.Calendar"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.sql.*"%>
<%@ include file="dbconnection.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page errorPage="error.jsp?msg=Application Generated an error!" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="jquery-1.10.2.min.js"></script> 
        <title>JSP Page</title>
        
        
    </head>
    <body>
        <form id="form1" name="form1" action="studentinfo.jsp" target="addstd" method="POST">     
            <br>

            <table align="center" border="0"  cellspacing="0" cellpadding="0" style="color:blue;background-color:#CCFFFF;">
               
                <tr align="center" >
                    
                    <td>
                        Select Year :
                    </td>
                    
                    <td>
                        <select name="year"  id="year1" onchange="send();">

                            <option value="none">Select</option> 
                    <%
                        Calendar now = Calendar.getInstance();
                        int month = now.get(Calendar.MONTH) + 1;
                        int year = now.get(Calendar.YEAR);
                        int syear = 2008;
                        for (; syear<=year; year--) {
                    %>
                    
                    <option value="<%=year%>">
                    
                        <%=year%>
                   
                    </option>

                    <%
                    }%>
                </select>
                 </td>
                </tr>
            </table>
        </form>
    
    <script>
 
 
             $( "#year1 option" ).click(function() {  
                var year=$("#year1").val(); 
               if(year!=="none"){
               document.form1.submit();
           }
           else{
               alert("choose year");
           }
       });
     </script>
     </body>
     
</html>
