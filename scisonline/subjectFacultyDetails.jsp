<%-- 
    Document   : subjectFacultyDetails
    Created on : 18 Dec, 2012, 11:39:13 AM
    Author     : varun
--%>
<%@page import="com.hcu.mysql.connection.ConnectionDemo1"%>
<%@page import="java.sql.*"%>
<%@include file="dbconnection.jsp" %>
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
        <script>
            function p1()
            {
                document.getElementById("p1").style.display="none";
                window.print();
            }
</script>
    </head>
    <body>
        <%
            Statement st1 = ConnectionDemo1.getStatementObj().createStatement();
            Statement st2 = ConnectionDemo1.getStatementObj().createStatement();
            Statement st3 = ConnectionDemo1.getStatementObj().createStatement();
            Statement st4 = ConnectionDemo1.getStatementObj().createStatement();
            String query1 = "Select * from subjectfaculty"; 
            ResultSet rs1 =  st1.executeQuery(query1);
            String nam="";
            String id1="";
            String id2="";
            try
             {%>
                                        <form name="form" >
                                        <table align="center">
               
               <tr bgcolor="#c2000d">
                   <td align="center" class="style12"> <font size="6"> Faculty Subject Allocation List </font> </td>
               </tr>
           </table>
          <br><br>   
                                            
                                        <table border="1" width="50%" align="center">
                                        
                                        <th>Subject Name </th>
                                        <th>Faculty 1 </th>
                                        <th>Faculty 2 </th>
                                        
             <%   while(rs1.next())
                                       { %>
                                       <tr >
                                           
                                        <%
                                        String query2= "Select Subject_Name from subjecttable where Code='"+rs1.getString(1)+"'";
                                        ResultSet rs2= st2.executeQuery(query2);
                                        if(rs1.getString(2)==null)
                                              id1="";
                                        else
                                          {
                                           String query3= "Select Faculty_Name from faculty_data where ID='"+rs1.getString(2)+"'";
                                           ResultSet rs3= st3.executeQuery(query3);
                                           rs3.next();
                                               id1=rs3.getString(1);
                                           }
                                        
                                          if(rs1.getString(3)==null)
                                              id2="";
                                        else
                                          {
                                           String query4= "Select Faculty_Name from faculty_data where ID='"+rs1.getString(3)+"'";
                                           ResultSet rs4= st4.executeQuery(query4);
                                           rs4.next();
                                               id2=rs4.getString(1);
                                           }
                                           rs2.next();
                                        
                                        %>   
                                        <td align="center"><%=rs2.getString(1)%></td>
                                        <td align="center" ><%=id1%> <br></td>
                                        <td align="center" ><%=id2%> <br></td>
                                       </tr>
                                       <%}%> 
                                           
                                       </table>    
                                       </form> 
                                     
                    
                                       
                                       
                                      <% 
            }
            catch(Exception ex)
                               
            {
                ex.printStackTrace();
             }
            
                                       
         %>   
         <br><br>
        <div align="center">
    <input type="button" value="Print" id="p1" style="width: 50px; color: white; background-color: #6d77d9; border-color: red;" onclick="p1();" />
</div>
    </body>
</html>
