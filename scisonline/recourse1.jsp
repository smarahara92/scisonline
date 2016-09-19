<%-- 
    Document   : recourse
    Created on : Mar 14, 2012, 12:30:17 PM
    Author     : admin
--%>
<%@include file="checkValidity.jsp"%>
<%@page import="com.hcu.mysql.connection.ConnectionDemo1"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
            <style>
.style30 {color: red}
.style31 {color: white}
.style32 {color: green}
</style>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script>
            
        
        </script>
    </head>
    <body bgcolor="#CCFFFF">
        <%
        Statement st1=ConnectionDemo1.getStatementObj().createStatement();
        Statement st2=ConnectionDemo1.getStatementObj().createStatement();
        ResultSet rs=st1.executeQuery("select Code,Subject_Name from subjecttable as a,subjectfaculty as b where b.subjectid=a.Code order by Subject_Name");
        %>
        <form action="recourse2.jsp" method="POST" name="form1">
            <table align="center">
                <tr  bgcolor="#c2000d">
                    <td align="center" class="style31"><font size="6">Re-Course Registration</font></td>
                </tr>
            </table>
        <table align="center">
            
            <tr>
                <th>Student Id</th>
                <th>Student Name</th>
                <th>New Subject</th>
            </tr>
            <%int i=1;
            while(i<=10)
       {%>
            <tr>
                <td><input type="text" id="s<%=i%>" name="sid" value=""></td>
                <td><input type="text" id="sid<%=i%>" size="30" name="sname" value=""></td>
                <td>
                    <select name="newsubname">
                        <option value="none">none</option>
                        <%try
                                                                                              {
                            rs.beforeFirst();
                        
                        while(rs.next())
                                                       {%>
                        <option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option>
                        
                        <%}%>
                    </select>
                </td>
            </tr>
            <%
            
            }
            catch(Exception e)
               {
                e.printStackTrace();
}
                        i++;
}%>
            <tr ><td colspan="3" align="center"><input type="submit" name="submit" value="submit" onclick=""></td></tr>
        </table>
        </form>
            
    </body>
</html>
