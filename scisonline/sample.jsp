<%-- 
    Document   : newjsp1111111
    Created on : Aug 25, 2012, 11:04:49 AM
    Author     : veeru
--%>
<%@include file="checkValidity.jsp"%>
<%@ include file="dbconnection.jsp" %>
<%@page import="java.sql.Statement"%>
<%@page import="java.util.Calendar"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
       
        <title> JSP Page</title>
        
        
        <style>
.style30 {color: #c2000d}
.style31 {color: white}
.style32 {color: green}
.heading
{
color: white;
background-color: #c2000d;
}
.border
{
background-color: #c2000d;
}
.pos_fixed
{
position:fixed;
bottom:0px;
background-color: #CCFFFF;
border-color: red;
}
#bold{
 font-weight: bold;
}
</style>

<script>

   function add_col()
   {
   var num_box = document.getElementById("num_text").value;
   if(num_box)
   {
   for(var i=0; i<num_box; i++)
   {


   var tableName1 = document.getElementById("uTable");

   var newTR1 = document.getElementById("tr1");

   var newName1 = document.createElement("TD");

   newName1.innerHTML = "<input type='text'  name='site' id='site' value='cell value'>";

   var newTR2 = document.getElementById("tr2");

   var newPhone1 = document.createElement("TD");

   newPhone1.innerHTML = "<input type='text'  name='cell' id='cell' value='site value'>";


   newTR1.appendChild(newName1);

   newTR2.appendChild(newPhone1);

   tableName1.appendChild(newTR1);
   tableName1.appendChild(newTR2);


    document.form1.reset()



    }

   }

   }
   </script>


    <form name="form1" id="form1" method="post">

        <p>
          <input type="text" name="num_text" id="num_text"/>
          <input type="button" name="Submit" value="INPUT" onclick="add_col();" />
        </p>
        <p>&nbsp;</p>
        <table  id="uTable"width="183" border="0">
          <tr id="tr1">
            <td>Name</td>

          </tr>
          <tr id="tr2">
            <td>Phone</td>

          </tr>

      </table>
        <input type="submit" name="Submit2" value="Insert"  />
    </form>
        
</html>

