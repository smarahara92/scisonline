<%-- 
    Document   : changepassword
    Created on : Jan 17, 2013, 1:47:22 PM
    Author     : root
--%>

<%@include file="checkValidity.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8" 
        import="java.util.*,javax.naming.*,javax.naming.directory.*,javax.naming.ldap.*, java.sql.*" %>
<%@include file="conf.jsp" %>
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
            function validate()
            {
                var oldpassword=document.getElementById("oldpassword").value;
                var newpassword=document.getElementById("newpassword").value;
                 var repassword=document.getElementById("repassword").value;
               if(oldpassword==""){
                  alert("Please Enter oldpassword");
			document.forms["frm"].user.focus();
                        document.frm.action="changepassword.jsp";
			return false;
		}
              else if(newpassword==""){
                  alert("Please Enter NewPassword");
			document.frm.action="changepassword.jsp";
			return false;
		}
                 else if(repassword==""){
                  alert("Please Enter retype Password");
			document.frm.action="changepassword.jsp";
			return false;
		}
              else 
                {
                    document.frm.action="changepasswordlink.jsp";
            	return true;
                } 
            }   
          
        </script>
    </head>
    <body bgcolor="#CCFFFF" onload="document.forms['frm'].user.focus();">
        <form action="" method="POST" name="frm" id="frm" onsubmit="return validate()">
    <center>
        <table align="center">
               
               <tr bgcolor="#c2000d">
                   <td align="center" class="style12"> <font size="6"> Change Password </font> </td>
               </tr>
           </table></br>
        <table border="0"> 
            
            <tr><td><b>Old Password : </b></td>
        <td><input type="password" name="oldpassword" value="" id="oldpassword" size="25" /></br></br></td></tr>
         <tr><td><b>New Password : </b></td>
            <td><input type="password" name="newpassword" value="" id="newpassword" size="25" /></br></br></td></tr>
<tr><td><b>Retype New Password : </b></td>
            <td><input type="password" name="repassword" value="" id="repassword" size="25" /></td></tr>
        </table>  </br>
            <input type="submit" value="change" name="submit" />
    </center>  
    
        </form>   
    </body>
</html>
