<%-- 
    Document   : query_list_courseMNG
    Created on : 16 Mar, 2015, 11:47:30 AM
    Author     : nwlab
--%>

<jsp:forward page="query_list.jsp" >
    <jsp:param name="heading" value="Course Management Queries"/>
    
    <jsp:param name="queryLink" value="query_all_elective_list.jsp"/>
    <jsp:param name="queryTitle" value="List of all electives offered by the school"/>
    
    <jsp:param name="queryLink" value="query_session_dropdown.jsp?ID=1&RedirectPage=query_elective_list.jsp"/>
    <jsp:param name="queryTitle" value="List of all electives offered in a semester by the school"/>
    
    <jsp:param name="queryLink" value="query_session_dropdown.jsp?ID=2&RedirectPage=query_course_list.jsp"/>
    <jsp:param name="queryTitle" value="List of all courses offered in a semester by the school"/>
    
    <jsp:param name="queryLink" value="query_incomplete_ele_reg_list.jsp"/>
    <jsp:param name="queryTitle" value="List of all students whose course registration is not complete"/>

    <jsp:param name="queryLink" value="query_unallocated_core_list.jsp"/>
    <jsp:param name="queryTitle" value="List of all core courses for which faculty is not allocated"/>
    
    <jsp:param name="queryLink" value="query_subjects_dropdown.jsp?ID=5&RedirectPage=query_std_pair_sub.jsp"/>
    <jsp:param name="queryTitle" value="List of all common students for a pair of subjects"/>
    
    <jsp:param name="queryLink" value="query_session_sub_dropdown.jsp?ID=6&RedirectPage=query_view_sub_assessment.jsp"/>
    <jsp:param name="queryTitle" value="View assessment of a particular subject for a semester"/>
</jsp:forward>