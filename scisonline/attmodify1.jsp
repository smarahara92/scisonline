<%-- 
    Document   : flinks
    Created on : Aug 30, 2011, 6:32:09 AM
    Author     : admin
--%>

<%@include file="checkValidity.jsp"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import ="javax.sql.*" %>
<%@page import="java.sql.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%
        String facultyname=request.getParameter("facultyname");
        System.out.println(facultyname);
        %>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script language="javascript">
            function display1()
  {
      if(document.form1.mySelect1.options[0].selected)
      document.form1.mySelect2.options.selectedIndex=(0);
  
  if(document.form1.mySelect1.options[1].selected)
      document.form1.mySelect2.options.selectedIndex=(1);
  
  if(document.form1.mySelect1.options[2].selected)
      document.form1.mySelect2.options.selectedIndex=(2);
  
  if(document.form1.mySelect1.options[3].selected)
      document.form1.mySelect2.options.selectedIndex=(3);
  
  if(document.form1.mySelect1.options[4].selected)
      document.form1.mySelect2.options.selectedIndex=(4);

  }
            </script>
        
    </head>
    <body onload="document.forms.form1.submit();">
        <%
       
String username=(String) session.getAttribute("user");
if(username==null) username="";
System.out.println("lax"+username);

       // String facultyname1=request.getParameter("facultyname");
       // System.out.println(facultyname1);
        try {
    Class.forName("com.mysql.jdbc.Driver").newInstance();
    System.out.println("driver connected");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/dcis_attendance_system", "root", "");
    System.out.println("database connected");
    String qry="create table temp(fid varchar(20))";
    String qry1="select ID,Faculty_Name from faculty_data where ID='"+username+"'";
    String qry2="select Code,subject_Name from subjecttable as a where a.Code in (select subjectid from subjectfaculty where facultyid1='"+username+"' or facultyid2='"+username+"');";
    Statement st1=con.createStatement();
    Statement st2=con.createStatement();
    ResultSet rs=st1.executeQuery(qry2);
    ResultSet rs1=st2.executeQuery(qry2);
    List subj=new ArrayList();
    int i=0;
    %>
    <%
    //writing usual code for checking
    int x=0;
    if (x==0)
               {
    %>
    <form name="form1" action="attmodify2.jsp" target="facultyaction" method="POST">
      <select align="left" valign="bottom" style="width:175px" name="subjectname" id="mySelect1" onchange="display1();"> 
  <%  while(rs.next())
               {
        
        System.out.println(""+rs.getString(1)+""+rs.getString(2));
               %>
               
                   
                       <option> <%=rs.getString(2)%> </option>
                       
     
   
               <%
               session.setAttribute("subj[i]",rs.getString(1));
               String username1=(String) session.getAttribute("subj[i]");
        System.out.println(username1);
               i++;
%>
               
               <%                         
    }
    %>
      </select>
      
      <select align="left" valign="bottom" style="display:none;" name="subjectid" id="mySelect2"> 
  <%  while(rs1.next())
               {
        
        System.out.println(""+rs1.getString(1)+""+rs1.getString(2));
               %>
               
                   
                       <option> <%=rs1.getString(1)%> </option>
                       
     
   
               <%
               session.setAttribute("subj[i]",rs1.getString(1));
               String username1=(String) session.getAttribute("subj[i]");
        System.out.println(username1);
               i++;
%>
               
               <%                         
    }
    %>
      </select>
    <input type="Submit" value="Go" onclick="">
    </form>
    <%   }
        }
       
       catch(Exception e)
           {
       e.printStackTrace();
   }
    
          %>
        
        <!--<a href="#" onclick="page();">View</a><div id="xyz"></div><br>-->
    </body>
</html>
