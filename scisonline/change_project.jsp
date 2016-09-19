<%-- 
    Document   : change_project
    Created on : 21 Feb, 2013, 2:06:22 PM
    Author     : varun
--%>

<%@include file="checkValidity.jsp"%>
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
        <script type="text/javascript">
            function validate()
            {
                var fromField=document.getElementById("fname").value;
                var toField=document.getElementById("tname").value;
               if(fromField!=toField && fromField!="sel" && toField!="sel"){
                         alert("OK");
		  	
			return true;
		}
              
              else 
                  alert("Plz recheck the fields");
                  //alert("Plz recheck the fields");
              
            	return false;
                  
            }   
          
        </script>
    </head>
    <body bgcolor="#CCFFFF">
        
        
        <form  id="form" method="POST" onsubmit="return validate()" action="change_project1.jsp">
            <table align="center">
                 <tr bgcolor="#c2000d">
                   <td align="center" class="style12"> <font size="6"> Change Project </font> </td>
               </tr> 
            </table>     
           
            <br>
            <table align="center" >
            <tr>
                <th>Student Id</th>     
                
                    
                    
            </tr>
           
            <% 
            int i=0;
            while(i<6)
                               {%>
            <tr>
                <td>&nbsp;<input type="text" id="sid" name="sid<%=Integer.toString(i)%>" size="10"></td>    
               
                    
                   
                    
                    
                
            </tr>
           <%
                 i++;
           }%> 
            
                     <tr>
                         <td colspan="8" align="center"><input type="submit" value="submit"/></td>
                         
                     </tr>
        </table>
            <%String user= (String)session.getAttribute("user");%>
            <!--  Welcome <%=user%>-->
        
        </form>

    </body>
</html>

