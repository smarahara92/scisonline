
<jsp:forward page="query_list.jsp" > 
     <jsp:param name="heading" value="Assessment Queries"/>
    <jsp:param name="queryLink" value="programmeBatchDropDownMenu.jsp?id=0&RedirectPage=Q_F_core3.jsp"/>
    <jsp:param name="queryTitle" value="List of all students who have backlogs in core subjects "/>
    
    <jsp:param name="queryLink" value="programmeBatchDropDownMenu.jsp?id=1&RedirectPage=Q_allF3_15.jsp"/>
    <jsp:param name="queryTitle" value="List of all students who have backlog in at least one subject "/>
   
    <jsp:param name="queryLink" value="Q_SupplRegistered_15.jsp"/>
    <jsp:param name="queryTitle" value="List of all students who are registered for supplementary "/>
    
     <jsp:param name="queryLink" value="Q_ImpRegistered_15.jsp"/>
    <jsp:param name="queryTitle" value="List of all students who are registered for improvement "/>
    
    <jsp:param name="queryLink" value="programmeBatchDropDownMenu.jsp?id=2&RedirectPage=Q_GetCgpa_15.jsp"/>
    <jsp:param name="queryTitle" value="List of CGPA of all students in descending order of a particular stream & batch "/>
    
    <jsp:param name="queryLink" value="Q_AssessmentNotInSupp_15.jsp"/>
    <jsp:param name="queryTitle" value="List of all supplementary subjects for which assessment has not been given by faculty"/>
   
   
</jsp:forward>
