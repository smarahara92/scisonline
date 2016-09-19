<%-- 
    Document   : query_list_project
    Created on : 16 Mar, 2015, 11:48:59 AM
    Author     : nwlab
--%>
<jsp:forward page="query_list.jsp" > 
    <jsp:param name="heading" value="Project Queries"/>
    
    <jsp:param name="queryLink" value="programme_activeBatch.jsp?ID=0&RdirectPage=project_unallocatedstudentlist.jsp"/>
    <jsp:param name="queryTitle" value="List of all students to whom project is not allocated"/>
    
    <jsp:param name="queryLink" value="programme_activeBatch.jsp?ID=1&RdirectPage=project_panelmarksstudentlist.jsp"/>
    <jsp:param name="queryTitle" value="List of all students whose panel marks are not entered"/>
    
    <jsp:param name="queryLink" value="programme_activeBatch.jsp?ID=2&RdirectPage=project_supervisormarksstudentlist.jsp"/>
    <jsp:param name="queryTitle" value="List of all students whose mid-term supervisor marks are not entered"/>
    
    <jsp:param name="queryLink" value="programme_activeBatch.jsp?ID=3&RdirectPage=project_externalmarksstudentlist.jsp"/>
    <jsp:param name="queryTitle" value="List of all students whose external/panel major marks are not entered"/>
    
    <jsp:param name="queryLink" value="programme_activeBatch.jsp?ID=4&RdirectPage=project_supervisormajormarksstudentlist.jsp"/>
    <jsp:param name="queryTitle" value="List of all students whose major supervisor marks are not entered"/>
    
    <jsp:param name="queryLink" value="programme_activeBatch.jsp?ID=5&RdirectPage=project_internshipstudentlist.jsp"/>
    <jsp:param name="queryTitle" value="List of all students who are doing internship"/>
    
    <jsp:param name="queryLink" value="programme_activeBatch.jsp?ID=6&RdirectPage=project_degreenotawardedstudentlist.jsp"/>
    <jsp:param name="queryTitle" value="List of all students to whom degree is not awarded"/>
    
    <jsp:param name="queryLink" value="programme_activeBatch.jsp?ID=7&RdirectPage=project_degreeawardedstudentlist.jsp"/>
    <jsp:param name="queryTitle" value="List of all students to whom degree is awarded"/>
    
    <jsp:param name="queryLink" value="programme_activeBatch.jsp?ID=8&RdirectPage=project_reportnotsubmitstudentlist.jsp"/>
    <jsp:param name="queryTitle" value="List of all students whose reports are not submitted"/>
    
    <jsp:param name="queryLink" value="programme_activeBatch.jsp?ID=9&RdirectPage=project_reportsubmitstudentlist.jsp"/>
    <jsp:param name="queryTitle" value="List of all students whose reports are submitted"/>
    
    <jsp:param name="queryLink" value="programme_activeBatch.jsp?ID=10&RdirectPage=project_vivanotfinishedstudentlist.jsp"/>
    <jsp:param name="queryTitle" value="List of all students whose viva is not finished"/>
    
    <jsp:param name="queryLink" value="programme_activeBatch.jsp?ID=11&RdirectPage=project_vivafinishedstudentlist.jsp"/>
    <jsp:param name="queryTitle" value="List of all students whose viva is finished"/>
    
    <jsp:param name="queryLink" value="programme_activeBatch.jsp?ID=12&RdirectPage=project_extendedstudentlist.jsp"/>
    <jsp:param name="queryTitle" value="List of all students whose project is extended"/>
    
</jsp:forward>