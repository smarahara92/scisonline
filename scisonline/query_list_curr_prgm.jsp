<%-- 
    Document   : query_list_curr_prgm
    Created on : 16 Mar, 2015, 11:48:00 AM
    Author     : nwlab
--%>

<jsp:forward page="query_list.jsp" > 
    <jsp:param name="heading" value="Curriculum / Programme Queries"/>
    
    <jsp:param name="queryLink" value="query_prg_dropdown.jsp?ID=0&RedirectPage=query_latest_curriculum.jsp"/>
    <jsp:param name="queryTitle" value="Latest curriculum for a particular stream"/>
    
    <jsp:param name="queryLink" value="query_curr_last_modification.jsp"/>
    <jsp:param name="queryTitle" value="Last time the curriculum was modified for each programme"/>
    
    <jsp:param name="queryLink" value="query_prg_list.jsp"/>
    <jsp:param name="queryTitle" value="List of all programmes offered by the school"/>
</jsp:forward>