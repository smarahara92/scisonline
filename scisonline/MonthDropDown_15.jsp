<%-- 
    Document   : MonthDropDown_15
    Created on : Apr 21, 2015, 10:54:17 AM
    Author     : richa
--%>

<%@page import="java.sql.ResultSet"%>
<%@include file="programmeRetrieveBeans.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <%
        String id = request.getParameter("id");
        String RedirectPage = request.getParameter("RedirectPage");
        System.out.println(id);
    %>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="js/jquery.min.js"></script>
        <script type="text/javascript" >
            $(document).ready(function($) {
               // alert(sub + <!%=RedirectPage%>);
                $('#sub<%=id%>').change(function(){
                    var sub = $(this).val();
                   // alert(sub);
                    if(sub !== "") {
                        $('#target1<%=id%>').load("<%=RedirectPage%>?month="+sub);
                    }
                });
            });
        </script>
    </head>
    <body bgcolor="E0FFFF">
     
        <form  id="form" name="form" method="POST" action="" target="act_area" > 
            <table align ="center">
                
                <tr>
                    <td>
                            <select id="sub<%=id%>" name="month<%=id%>">
                                <option style=" alignment-adjust: central" value = "">Select Month</option>
                                <%
                                String sem = scis.getLatestSemester();
                               if( sem.equalsIgnoreCase("Winter") ){%>
                                  <option value="1">January </option> 
                                   <option value="2">February </option> 
                                    <option value="3">March</option> 
                                     <option value="4">April </option> 
                             <%  }
                               else if( sem.equalsIgnoreCase("Monsoon") ){%>
                               <option value="1">July </option> 
                               <option value="2">August </option> 
                               <option value="3">September </option> 
                               <option value="4">October </option> 
                                           
                             <%  }
                                
                        //            rs1.close();
                                   scis.close();
                                %>
                            </select>
                        </td>
                
                        
                </tr>
            </table>
        </form>
        <div id="target1<%=id%>"></div>
    </body>
</html>
