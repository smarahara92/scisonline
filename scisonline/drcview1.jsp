<%-- 
    Document   : drcview1
    Created on : Jun 13, 2013, 2:14:01 AM
    Author     : root
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.Calendar"%>
<%@include file="dbconnection.jsp"%> 
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script language="javascript">
            function find()
            {
                
                document.form1.submit();
            }
            </script>
    </head>
    <body>
        <%
         Calendar now = Calendar.getInstance();
           System.out.println("Current date : " + (now.get(Calendar.MONTH) + 1)
                        + "-"
                        + now.get(Calendar.DATE)
                        + "-"
                        + now.get(Calendar.YEAR));
           int month=now.get(Calendar.MONTH)+1;
           int cyear=now.get(Calendar.YEAR); 
          // System.out.println("lllll");
            if (month >= 1 && month <= 6) {
                cyear--;
            }
           
          Statement st1=con2.createStatement();
          Statement st2=con2.createStatement();
          Statement st3=con2.createStatement();
          
          String user=(String)session.getAttribute("user");
          ResultSet rs1=st1.executeQuery("select * from PhD_"+cyear+" where supervisor1='"+user+"' or supervisor2='"+user+"' or supervisor3='"+user+"'");
       %>  <form name="form1" action="drcview2.jsp" target="staffaction" method="POST">
       <center><b>Select Student :  </b><select  style="width:170px" name="studentid" onchange="find()">
              <option value="none">None</option> 
              <%
                 while(rs1.next())
                 {
              %><option value="<%=rs1.getString(1)%>"><%=rs1.getString(1)%></option><% 
                 }
              %>                           
             
          </select> </center> 
          <%
         
        %>
       </form>  
    </body>
</html>


