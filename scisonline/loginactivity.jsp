<%@include file="checkValidity.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8" 
        import="java.util.*, java.sql.*" %>
<%@page errorPage="error.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Loginactvity</title>
    </head>
    <body bgcolor="#CCFFFF">

        <%
        String msg="";
        String user =""+session.getAttribute("user");
        Connection conn = null;
	Class.forName("com.mysql.jdbc.Driver").newInstance();
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dcis_attendance_system","root", "");

    ResultSet rs = null;
    PreparedStatement ps=null;
    try{
    String sqlOption="SELECT lastlogin, ipaddress, agent FROM loginactivity where"
    +" userid=? ";
    ps=conn.prepareStatement(sqlOption);
    ps.setString(1,user);
    rs=ps.executeQuery(); 
	rs.next();
%>
<script>
	alert("Last successful login: <%=rs.getString(1)%>\nFrom: <%=rs.getString(2)%>\nAgent: <%=rs.getString(3)%>");
        
</script>
	
<%
    }catch(Exception e)
       {
      msg="Sorry ! Internal Server Error Occurred, Please Try later !";
      response.sendRedirect("error.jsp?msg="+msg);
      return;
   }%>
  </body>
</html>
