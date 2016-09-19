<%-- 
    Document   : newbatch
    Created on : Dec 21, 2011, 10:42:40 PM
    Author     : jagan
--%>
<%@include file="checkValidity.jsp"%>
<%@page import ="javax.sql.*" %>
<%@page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        
        <script>
             function display1()
  {
      if(document.form1.mySelect.options[0].selected)
      document.form1.mySelect1.options.selectedIndex=(0);
  
  if(document.form1.mySelect.options[1].selected)
      document.form1.mySelect1.options.selectedIndex=(1);
  
  if(document.form1.mySelect.options[2].selected)
      document.form1.mySelect1.options.selectedIndex=(2);
  
  if(document.form1.mySelect.options[3].selected)
      document.form1.mySelect1.options.selectedIndex=(3);
  
  if(document.form1.mySelect.options[4].selected)
      document.form1.mySelect1.options.selectedIndex=(4);

  }
  
  function change()
  {
      document.forms.form1.submit();
  }
       

// here is your function

function findTheChecked(){
var radio_1 = window.document.form1.radio_1;
var radio_2 = window.document.form1.radio_2;

// the above locates the checkboxes

if(radio_1.checked == true){ //this finds which one is checked
radio_2.checked = false;
window.location.replace("browse.jsp"); // change that to the site
}else{
if(radio_2.checked == true){
radio_1.checked = false;
window.location.replace("update.jsp");// change that to the other
}
}
}

function checked1()
{
    window.document.forms["form1"].submit();
   /* var radio_1 = window.document.form1.radio_1;
var radio_2 = window.document.form1.radio_2;
   if(radio_1.checked == true){ //this finds which one is checked
radio_2.checked = false;

document.forms.form1.submit(); // change that to the site
}else{
if(radio_2.checked == true){
radio_1.checked = false;
document.forms.form2.submit();// change that to the other
}
}*/
}
function checked2()
{
    document.getElementById("text1").value=document.getElementById("mySelect").value;
    var str=document.getElementById("mySelect").value;
    var str2=document.getElementById("mySelect1").value;
    /*document.getElementById("semester1").value=document.getElementById("semester").value;
    document.getElementById("subjid1").value=document.getElementById("subjid").value;
    document.getElementById("subjname1").value=document.getElementById("subjname").value;
    document.getElementById("pa1").value=document.getElementById("pa").value;
    document.getElementById("ca1").value=document.getElementById("ca").value;
    document.getElementById("pta1").value=document.getElementById("pta").value;
    
    
    //document.getElementById("text2").value=document.getElementById("text1").value;*/
    window.document.forms["form2"].submit();
    
                document.getElementById("mySelect").value=str;
                document.getElementById("mySelect1").value=str2;
   
}
</script>
    </head>
    <body>
        
		
		<form action="Commonsfileuploadservlet" enctype="multipart/form-data" method="POST">
                    <input type="hidden" name="check" value="5" />
                    <table align="center" border="0" cellpadding="5" cellspacing="5">
                        <tr> <th colspan="2"> <p><h1>Upload Student File</h1></p> </th></tr>
                        <tr><td><select name="text1" style="width:200px;">
                        <option>MTech_CS</option>
                        <option>MTech_AI</option>
                        <option>MTech_IT</option>
                        <option>MCA</option>
                    </select> </td>
                        
                    <td> <select name="text2" style="width:200px;">
                        <option>2009</option>
                        <option>2010</option>
                        <option>2011</option>
                        <option>2012</option>
                        <option>2013</option>
                        
                        </select> </td> </tr>
                        <tr></tr>
                    <tr><td colspan="2" align="center"><input type="file" name="file1" />
			<input type="Submit" value="Upload File"><br></td></tr>
                    </table>
		</form>
    </body>
     <%
        String p1=(String)request.getAttribute("name1");
        String filename=(String)request.getAttribute("filename");
        if(p1!=null)
                       {
        System.out.println("this is p1"+p1);
               
        out.print("<center><h1>File Uploaded sucessfully:"+filename+"</h1></center>");
        out.println("<form action=\"newbatch.jsp\" enctype=\"multipart/form-data\" method=\"POST\">");
        out.println("<center><input type=\"Submit\" value=\"Next\"></center></form>");
        System.out.println("this is name1"+request.getAttribute("name1"));
        System.out.println("this is name2"+request.getAttribute("name2"));
        String name=request.getParameter("text1");
        System.out.println("data from servlet----->"+name);
            
       try {
    Class.forName("com.mysql.jdbc.Driver").newInstance();
    System.out.println("driver connected");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/dcis_attendance_system", "root", "");
    System.out.println("database connected");
    String qry1="select Faculty_Name from faculty_registration1";
    Statement st1=con.createStatement();
    ResultSet rs=st1.executeQuery(qry1);
    System.out.println("jagan");
     while(rs.next())
     {
%>
    <option> <%=rs.getString(1)%> </option>
    <%
    System.out.println(""+rs.getString(1));
       }
    con.close();
       }
       catch(Exception e)
           {
       //e.printStackTrace();
       
   }
    
               }
        %>
</html>
