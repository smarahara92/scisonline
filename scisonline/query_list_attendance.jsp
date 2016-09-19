
<jsp:forward page="query_list.jsp" > 
     <jsp:param name="heading" value="Attendance Queries"/>
    <jsp:param name="queryLink" value="programmeBatchDropDownMenu.jsp?id=0&RedirectPage=Demo.jsp"/>
    <jsp:param name="queryTitle" value="List of students who have less than 75% attendance in a particular batch and stream "/>
    
    <jsp:param name="queryLink" value="SubjectDropDown_15.jsp?id=2&RedirectPage=Q_Subjectwise_AttenFINAL_15.jsp"/>
    <jsp:param name="queryTitle" value="List of student who have less than 75% attendance in a particular subject"/>
    
    <jsp:param name="queryLink" value="MonthDropDown_15.jsp?id=3&RedirectPage=Q_Patfinal_15.jsp"/>
    <jsp:param name="queryTitle" value="List of all subjects for which attendance has not been  given for a particular month "/>
    
    <jsp:param name="queryLink" value="programmeBatchDropDownMenu.jsp?id=4&RedirectPage=Q_AggregateShortAttendance_15.jsp"/>
    <jsp:param name="queryTitle" value="List of all students who has aggregate attendance is less than 75%  across all subjects "/>
    
</jsp:forward>