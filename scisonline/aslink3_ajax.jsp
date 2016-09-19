<%-- 
    Document   : aslink3_ajax
    Created on : Dec 15, 2013, 3:46:00 PM
    Author     : veeru
--%>
<%@page import="java.util.Calendar"%>
<%@ include file="dbconnection.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <% System.out.println("batch year");
            //Retrieving parameter from aslink3.jsp page***********

            String ProgrammeName = request.getParameter("ProgrammeName");
            String BatchYear = request.getParameter("BatchYear");
            ProgrammeName = ProgrammeName.replace('-', '_');
            Statement st1 = con.createStatement();
           
            /*
             ********************* Retrieving studnet id from student master table******************
             */
           try{
            ResultSet rs = st1.executeQuery("select * from " + ProgrammeName + "_" + BatchYear + "");

        %>

        <table>
            <tr>
                <td>
                    <select name="StudentId" id="Stdid" onchange="action1();">
                        <option>Select Student Id</option>
                        <%while (rs.next()) {%>
                        <option><%=rs.getString(1)%></option>
                        <%}%>
                    </select>
                </td>
            </tr>
        </table>
              <%} catch(Exception e){
              out.println(ProgrammeName+"-"+BatchYear+" data dose not exists.");
}%>      
    </body>
</html>
