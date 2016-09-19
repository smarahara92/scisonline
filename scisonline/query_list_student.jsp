<%-- 
    Document   : query_list_student
    Created on : 16 Mar, 2015, 11:49:39 AM
    Author     : nwlab
--%>
<jsp:forward page="query_list.jsp" > 
     <jsp:param name="heading" value="Student Database Queries"/>
 <jsp:param name="queryLink" value="StudentDbMenu.jsp?id=1&RedirectPage=StudentDb.jsp"/>
    <jsp:param name="queryTitle" value="List of all subjects that a student have failed "/>
   
</jsp:forward>