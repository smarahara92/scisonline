<%-- 
    Document   : programmeBatchDropDownMenu
    Created on : Mar 30, 2015, 5:02:54 PM
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
                        $('#target1<%=id%>').load("<%=RedirectPage%>?subjectid="+sub);
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
                            <select id="sub<%=id%>" name="sub<%=id%>">
                                <option style=" alignment-adjust: central" value = "">Select Subject</option>
                                <%
                                String sem = scis.getLatestSemester();
                                int year = scis.getLatestYear();
                                ResultSet rs1 = scis.subjectList(sem, year);
                                    while (rs1.next()) {

                                %>

                                <option value="<%=rs1.getString(1)%>"><%=rs1.getString(2)%></option>
                                <%

                                    } 
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
