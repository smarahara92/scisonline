<%-- 
    Document   : query_list_project
    Created on : 16 Mar, 2015, 11:48:59 AM
    Author     : nwlab
--%>
<jsp:forward page="query_list.jsp" > 
    <jsp:param name="heading" value="PhD Queries"/>
    
    <jsp:param name="queryLink" value="student_status_view.jsp"/>
    <jsp:param name="queryTitle" value="View status of students "/>
    
    <jsp:param name="queryLink" value="student_id_enter.jsp?ID=1&RdirectPage=fullrecordview.jsp"/>
    <jsp:param name="queryTitle" value="Complete academic record of a student"/>
    
    <jsp:param name="queryLink" value="latestdrc.jsp?ID=2&RdirectPage=drcview3.jsp"/>
    <jsp:param name="queryTitle" value="Latest DRC report of active students"/>
    
    <jsp:param name="queryLink" value="consecutive_drc_fails.jsp"/>
    <jsp:param name="queryTitle" value="List of students who have three consecutive unsatisfactory DRC status"/>
    
    <jsp:param name="queryLink" value="nosupervisor.jsp"/>
    <jsp:param name="queryTitle" value="List of students who have not been allocated supervisor"/>
    
    <jsp:param name="queryLink" value="nodrc.jsp"/>
    <jsp:param name="queryTitle" value="List of students who have not been allocated DRC"/>
    
    <jsp:param name="queryLink" value="electivelist.jsp"/>
    <jsp:param name="queryTitle" value="List of elective comprehensives"/>
    
    <jsp:param name="queryLink" value="corelist.jsp"/>
    <jsp:param name="queryTitle" value="List of core comprehensives"/>
    
    <jsp:param name="queryLink" value="PhD_extensionstudent.jsp"/>
    <jsp:param name="queryTitle" value="List of all students who are on extension"/>
    
    <jsp:param name="queryLink" value="PhD_deregisteredstudent.jsp"/>
    <jsp:param name="queryTitle" value="List of de-registered students"/>
    
    <jsp:param name="queryLink" value="PhD_reregisteredstudent.jsp"/>
    <jsp:param name="queryTitle" value="List of re-registered students"/>
    
    <jsp:param name="queryLink" value="PhD_registeredstudent.jsp"/>
    <jsp:param name="queryTitle" value="List of registered students"/>
     	 
    <jsp:param name="queryLink" value="PhD_studentype.jsp"/>
    <jsp:param name="queryTitle" value="Registration type of Phd Students"/>
    
    
    
</jsp:forward>

<%--<jsp:param name="queryLink" value="PhD_activestudents.jsp"/>
    <jsp:param name="queryTitle" value="List of PhD active students"/>--%>