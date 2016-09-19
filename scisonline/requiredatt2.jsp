<%-- 
    Document   : requiredatt2
    Created on : Apr 25, 2013, 11:23:02 AM
    Author     : root
--%>

<%@include file="checkValidity.jsp"%>
<%@page import ="javax.sql.*" %>
<%@page import="java.sql.*" %>

<%@page errorPage="error.jsp?msg=Application Generated an error!" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <script language="javascript">
            function display1()
  {
     var x=document.getElementById("mySelect1").selectedIndex;
     
      if(document.form1.mySelect1.options[x].selected)
      document.form1.mySelect2.options.selectedIndex=(x);
      
      //document.form1.submit();
  

  }
   
    function textcheck()
    {
        
        var Marks=document.getElementById("att").value;
        Marks=Marks.replace(/^\s+|\s+$/g,'');
        if(Marks.length==0)
                     {
                        document.getElementById("att").value=0;
                        document.getElementById("att").style.color='black';
                        
                        return false;
                     }
                     
         var i=0,j=0;
                for(i=0; i<Marks.length;i++)
			{	
                         //alert(cmp1.charCodeAt(i));		
			if (Marks.charCodeAt(i) <48 ||Marks.charCodeAt(i) >57)
			{			
			if(Marks.charCodeAt(i)!=46)
                         {
                             
                       // alert(Marks[i]);
                        alert("invalid input");
		
                        document.getElementById("att").style.color='red';
                      document.getElementById("att").focus();
                     
                      
			return false;                        
			}}
                        }
                        document.getElementById("att").value=Marks;
                  if(Marks>100||Marks<0)
                    {
                        alert("Please enter a value less than or equal to 100");
                        document.getElementById("att").style.color='red';
                      document.getElementById("att").focus();
                      
                      return false;
                    }
        document.getElementById("att").style.color='black';
    }
            </script>
    </head>
   <body>
        <%
       
String username=(String) session.getAttribute("facultyid");
if(username==null) username="";
System.out.println(username);

        String facultyname1=request.getParameter("facultyname");
        System.out.println(facultyname1);
        try {
    Class.forName("com.mysql.jdbc.Driver").newInstance();
    System.out.println("driver connected");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/dcis_attendance_system", "root", "");
    System.out.println("database connected");
    String qry="create table temp(fid varchar(20))";
    //String qry1="select ID from faculty_registration where Faculty_Name='"+username+"'";
   // String qry2="select Code,Subject_Name from subjecttable as a,subjectfaculty as b where a.Code=b.subjectid  order By Subject_Name";
  //  Statement st1=con.createStatement();
  //  Statement st2=con.createStatement();
   // ResultSet rs=st1.executeQuery(qry2);
    //ResultSet rs1=st2.executeQuery(qry2);
    //List subj=new ArrayList();
    int i=0;
    %>
    <%
    //writing usual code for checking
    int x=0;
    if (x==0)
               {
    %>
    <form name="form1" action="requiredatt3.jsp" target="adminaction" method="POST" onsubmit="return textcheck();">
      
    
     
      <b>Percentage less than :</b> <input type="text" style="width:30px;" id="att" name="att" value="75">
     </br>
    <input type="submit" id="xx" align="center" value="Go"  >
    </form>
    <%   }
        }
       
       catch(Exception e)
           {
       e.printStackTrace();
   }
    
          %>
          </body>
</html>
