<%-- 
    Document   : query_list_facultyDB
    Created on : 16 Mar, 2015, 11:48:19 AM
    Author     : nwlab
--%>

<jsp:forward page="query_list.jsp" > 
    <jsp:param name="heading" value="Faculty Queries"/>
    
    <jsp:param name="queryLink" value="query_prg_fac_year_dropdown.jsp?ID=0&RedirectPage=query_project_students_by_a_faculty.jsp"/>
    <jsp:param name="queryTitle" value="List of project students guided by a faculty"/>
    
    <jsp:param name="queryLink" value="query_fac_year_dropdown.jsp?ID=3&RedirectPage=query_sub_taught_by_a_faculty.jsp"/>
    <jsp:param name="queryTitle" value="List of courses taught by a faculty during a specific period"/>
</jsp:forward>