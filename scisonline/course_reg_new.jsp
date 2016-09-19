<%-- 
    Document    :   course_reg_new
--%>
<%@include file="checkValidity.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Insert title here</title>
<%
        String given_session = request.getParameter("current_session");
        String given_year = request.getParameter("year2");
        //System.out.println("testing params here :"+given_session);
%>
    </head>
    <frameset cols="20%,*" target="main">
        <frame src="course_reg_select_new.jsp?given_session=<%=given_session%>&given_year=<%=given_year%>" name="left" noresize="noresize">
	<frame name="act_area">
    </frameset>
</html>
