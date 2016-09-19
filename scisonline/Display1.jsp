<%-- 
    Document   : Display
    Created on : 23 Feb, 2015, 8:26:24 PM
    Author     : richa
--%>

<%@page import ="java.sql.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" type="text/css" href="print.css" media="print" />
        <style type="text/css">
            @media print {

                .noPrint
                {
                    display:none;
                }
            }

        </style>
        <link rel="stylesheet" type="text/css" href="table_css.css">
        
  <table border="1" align = center ">
  <tr><th><font color='Red'>Student ID</font></th>
      <th><font color='Red'>Student NAME</font></th>
      <th><font color='Red' width = 60%>REMARKS</font></th>
  </tr>
    </head>
    <body>
        
        <%
             Connection con=null;
             Statement stmt2 = null;
             
             int i =3 ;
            int j =1;
           try{  
            Class.forName("com.mysql.jdbc.Driver");
           
                    con = DriverManager.getConnection
                ("jdbc:mysql://localhost/dcis_attendance_system","root","");
            Statement stmt =con.createStatement();
            ResultSet rs=stmt.executeQuery("select *  from  TEMP_ATTEN");
             ResultSetMetaData rsmd = rs.getMetaData();
        int noOfColumns = rsmd.getColumnCount();
            while(rs.next()){
                 String Id=rs.getString("student_id");
                 String Name=rs.getString("student_name");%>
                 <tr>
                <td><b><font color='#663300'><%=Id%></font></b></td>
                <td><b><font color='#663300'><%=Name%></font></b></td>
                <% 
                while(i<noOfColumns){
                %> 
                   <td><b><font color='#663300' width = 60% ><%=rs.getString(i)  %> :<%= (rs.getString(i+1))%></font></b></td>
                
                </tr>
                <% 
                 /*String c1 = rs.getString("c1");
                 String p1 =rs.getString("p1");
                 String c2 = rs.getString("c2");
                 String p2 =rs.getString("p2");
                 String c3 = rs.getString("c3");
                 String p3 =rs.getString("p3");
                 String c4 = rs.getString("c4");
                 String p4 =rs.getString("p4");
                 String c5 = rs.getString("c5");
                 String p5 =rs.getString("p5");
                 String c6 = rs.getString("c6");
                 String p6 =rs.getString("p6");
                 String c7 = rs.getString("c7");
                 String p7 =rs.getString("p7");
                 */
                  %>
               
                
                <%
                i++;
                }
                
               }
            
           }catch(Exception e){
               e.printStackTrace();
           }finally{
               con.close();
           }
                 %>
                 <div align="center">
        <input type="button" value="Print" id="p1" class="noPrint" onclick="window.print();" />
    </div>
                 </table>
                     </body>
                </html>
            
         
    </body>
</html>
