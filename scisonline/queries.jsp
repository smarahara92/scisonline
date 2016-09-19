<%-- 
    Document   : queries
    Created on : May 13, 2013, 4:12:00 PM
    Author     : root
--%>
<%@include file="checkValidity.jsp"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
<style>
.style30{width:150px;color:#000000}
.style31 {color: white}
</style>
        <script type="text/javascript">
            
            
            function checked1(a)
              {
                 // alert(a);
                   window.document.forms["frm"].action=a;
              window.document.forms["frm"].submit();
              }
        </script>
    </head>
    <body>
        
        <table align="center" border="1">
            <tr  bgcolor="#c2000d">
            	<td align="center" class="style31"><font size="6">List of Queries</font></td>
            </tr>
        </table>
        </br>
        </br>
   <form name="frm" action=""  method="POST">
   <input type="radio" name="selectstream"  onClick="checked1('requiredatt.jsp')"><b>Students with shortage of attendance<br>
   <input type="radio" name="selectstream"  onClick="checked1('backloginformation.jsp');"><b>Students with backlog/recourse</b><br>
   <input type="radio" name="selectstream"  onClick="checked1('students_readmitted.jsp');"><b>Students re-admitted</b><br>
   <input type="radio" name="selectstream" onClick="checked1('subject_students.jsp');"><b>Subject-Students list</b><br>
   <input type="radio" name="selectstream"  onClick="checked1('subjectFacultyDetails.jsp');"><b>Subject-Faculty list</b><br>
   <input type="radio" name="selectstream"  onClick="checked1('listofstudents_supp.jsp');"><b>List of students registered for supplementary</b><br>
   <input type="radio" name="selectstream"  onClick="checked1('listofstudents_imp.jsp');"><b>List of students registered for Improvement</b><br>     
   </form>  
    </body>
</html>
